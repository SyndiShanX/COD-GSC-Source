/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_interaction.gsc
***********************************************/

function coop_interaction_pregame() {
  thread assign_trigger_on_player_spawned();
}

function init() {
  if(!scripts\engine\utility::flag_exist("init_interaction_done")) {
    scripts\engine\utility::flag_init("init_interaction_done");
  }

  if(scripts\engine\utility::flag_exist("init_spawn_volumes_done")) {
    scripts\engine\utility::flag_wait("init_spawn_volumes_done");
  }

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  level.interactions = [];
  level.interaction_hintstrings = [];
  level.all_interaction_structs = scripts\engine\utility::getStructArray("interaction", "targetname");
  level.current_interaction_structs = level.all_interaction_structs;
  level.weapon_hint_func = &default_weapon_hint_func;
  thread interaction_sound_monitor();

  if(isDefined(level.gametype_interaction_func)) {
    [[level.gametype_interaction_func]]();
  }

  if(isDefined(level.deployable_box_interaction)) {
    [[level.deployable_box_interaction]]();
  }

  if(isDefined(level.map_interaction_func)) {
    [[level.map_interaction_func]]();
  }

  if(isDefined(level.weapon_upgrade_interaction)) {
    [[level.weapon_upgrade_interaction]]();
  }

  if(isDefined(level.init_personal_ent_zones)) {
    level[[level.init_personal_ent_zones]]();
  }

  foreach(var_1 in level.current_interaction_structs) {
    var_1.in_array = 1;

    if(!isDefined(var_1.angles)) {
      var_1.angles = (0, 0, 0);
    }

    var_1.targetmodels = [];

    if(!isDefined(var_1.script_parameters)) {
      var_1.script_parameters = "default";
    }

    if(var_1.script_parameters == "requires_power") {
      var_1.requires_power = 1;
      var_1.powered_on = 0;
      var_1.power_area = get_area_for_power(var_1);
    } else {
      var_1.requires_power = 0;
      var_1.powered_on = 0;
    }

    if(isDefined(level.interactions[var_1.script_noteworthy]) && istrue(level.interactions[var_1.script_noteworthy].is_p_ent)) {
      scripts\cp\coop_personal_ents::addtopersonalinteractionlist(var_1);
    }
  }

  if(getdvarint("scr_skip_interaction_dtg", 0) == 0) {
    thread drop_interaction_structs_to_ground();
  }

  var_3 = getarraykeys(level.interactions);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(isDefined(level.interactions[var_3[var_4]].init_func)) {
      var_5 = scripts\engine\utility::getStructArray(var_3[var_4], "script_noteworthy");
      level thread[[level.interactions[var_3[var_4]].init_func]](var_5);
    }
  }

  foreach(var_1 in level.current_interaction_structs) {
    if(isDefined(level.interactions[var_1.script_noteworthy]) && isDefined(level.interactions[var_1.script_noteworthy].useduration)) {
      var_1.useduration = level.interactions[var_1.script_noteworthy].useduration;
    } else {
      var_1.useduration = "duration_short";
    }

    if(isDefined(var_1.script_modelname)) {
      if(isDefined(var_1.target)) {
        var_7 = scripts\engine\utility::getStructArray(var_1.target, "targetname");

        foreach(var_9 in var_7) {
          if(!isDefined(var_9.script_noteworthy) || tolower(var_9.script_noteworthy) != "scenenode" && tolower(var_9.script_noteworthy) != "manual_script_model") {
            thread spawninteractionmodel(var_1, var_9);
          }
        }

        continue;
      }

      if(isDefined(var_1.script_noteworthy) && tolower(var_1.script_noteworthy) != "scenenode") {
        thread spawninteractionmodel(var_1, var_1);
      }
    }
  }

  scripts\engine\utility::flag_set("init_interaction_done");

  foreach(var_13 in level.players) {
    var_14 = var_13 getcurrentweapon();

    if(isDefined(level.wave_num) && isDefined(var_14)) {
      self.waveswithweapons = [level.wave_num][createheadicon(var_14)];
    }
  }
}

function drop_interaction_structs_to_ground() {
  if(!scripts\engine\utility::flag_exist("wall_buy_setup_done")) {
    scripts\engine\utility::flag_init("wall_buy_setup_done");
  }

  if(!scripts\engine\utility::flag("wall_buy_setup_done")) {
    scripts\engine\utility::flag_wait("wall_buy_setup_done");
  }

  foreach(var_1 in level.all_interaction_structs) {
    if(isDefined(var_1.groupname) && var_1.groupname == "locOverride") {
      continue;
    }

    var_2 = scripts\engine\utility::drop_to_ground(var_1.origin, 10, -200);
    var_1.origin = var_2 + (0, 0, 1);
  }
}

function get_area_for_power(var_0) {
  var_1 = getEntArray("spawn_volume", "targetname");

  foreach(var_3 in var_1) {
    if(ispointinvolume(var_0.origin, var_3)) {
      if(isDefined(var_3.basename)) {
        return var_3.basename;
      }
    }
  }

  return undefined;
}

function get_adjacent_volumes_from_volume() {
  if(isDefined(level.adjacent_volumes[self.basename])) {
    var_0 = [];

    foreach(var_2 in level.adjacent_volumes[self.basename]) {
      var_0 = level.spawn_volume_names[var_2];
    }

    return var_0;
  }

  return [];
}

function is_in_adjacent_volume(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!isDefined(var_0.adjacent_volumes)) {
    return false;
  }

  foreach(var_2 in var_0.adjacent_volumes) {
    if(!var_2.active) {
      continue;
    }

    if(self istouching(var_2)) {
      return true;
    }
  }

  return false;
}

function release_interaction_ent(var_0) {
  var_0 waittill("disconnect");
  self.in_use = 0;
  self notify("interaction_ent_released");
}

function assign_trigger_on_player_spawned() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_0);
    var_0.interaction_trigger = get_player_interaction_trigger(var_0);

    if(!isDefined(var_0.interaction_trigger)) {
      iprintlnbold("NO TRIGGER FOUND!");
    }

    reset_interaction_triggers();
    var_0.last_interaction_point = undefined;
    var_0.interaction_trigger makeunusable();
    thread release_player_interaction_trigger();
    thread player_interaction_monitor();
    thread player_interaction_weapon_switch_monitor();
  }
}

function player_interaction_weapon_switch_monitor() {
  self endon("disconnect");
  self endon("death");

  for(;;) {
    scripts\engine\utility::ref_143a6("weapon_switch_started", "weapon_change", "weaponchange");
    self.last_interaction_point = undefined;
    self.resetguidedinteraction = 1;
    self notify("stop_interaction_logic");
  }
}

function get_player_interaction_trigger() {
  if(isDefined(self.interaction_trigger)) {
    return self.interaction_trigger;
  }

  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0.in_use = 1;
  var_0 thread scripts\cp\utility::deleteonplayerdeathdisconnect(self);
  return var_0;
}

function release_player_interaction_trigger() {
  var_0 = self.interaction_trigger;
  scripts\engine\utility::ref_143a5("death", "disconnect");
  var_0.in_use = 0;
}

function registerinteraction(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;

  if(!isDefined(var_5)) {
    var_5 = "duration_short";
  }

  var_11 = spawnStruct();
  var_11.script_noteworthy = var_0;
  var_11.hint_func = var_1;
  var_11.spend_type = var_7;
  var_11.tutorial = var_8;
  var_11.activation_func = var_2;
  var_11.enabled = 1;
  var_11.disabledguidedinteractions = 1;
  var_11.cost = 0;
  var_11.requires_power = var_9;
  var_11.init_func = var_3;
  var_11.can_use_override_func = undefined;
  var_11.noactivation = var_4;
  var_11.useduration = var_5;
  var_11.is_p_ent = var_6;
  level.interactions[var_0] = var_11;
  var_12 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");
  add_interaction_structs_to_interaction_arrays(var_12);

  if(isDefined(var_3)) {
    if(scripts\engine\utility::flag_exist("interactions_initialized") && scripts\engine\utility::flag("interactions_initialized")) {
      level thread[[var_3]](var_12);

      if(istrue(var_6)) {
        foreach(var_11 in var_12) {
          scripts\cp\coop_personal_ents::addtopersonalinteractionlist(var_11);
        }

        return;
      }

      return;
    }

    return;
  }
}

function add_interaction_structs_to_interaction_arrays(var_0) {
  level.current_interaction_structs = scripts\engine\utility::array_combine(level.current_interaction_structs, var_0);
  level.current_interaction_structs = scripts\engine\utility::array_remove_duplicates(level.current_interaction_structs);
}

function interactionhasactivation(var_0) {
  return istrue(level.interactions[var_0.script_noteworthy].noactivation);
}

function register_interaction(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  registerinteraction(var_0, var_3, var_4, var_7, var_9, var_10);
}

function reset_interaction_triggers() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.interaction_trigger)) {
      hide_interaction_trigger_from_others(var_1);
    }
  }
}

function hide_interaction_trigger_from_others(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      var_0.interaction_trigger enableplayeruse(var_0);
      continue;
    }

    var_0.interaction_trigger disableplayeruse(var_2);
  }
}

function wherethehellami(var_0, var_1) {
  for(;;) {
    thread scripts\engine\utility::draw_capsule(var_1.origin, 12, 12, var_1.angles, (1, 1, 0), 0, 1);
    wait 0.05;
  }
}

function ref_11e94() {
  return isDefined(self.last_interaction_point);
}

function trial_juggernauts_to_spawn(var_0) {
  return self.last_interaction_point != var_0;
}

function player_interaction_monitor() {
  self notify("player_interaction_monitor");
  self endon("player_interaction_monitor");
  self endon("disconnect");
  self endon("death");

  if(scripts\engine\utility::flag_exist("init_interaction_done")) {
    scripts\engine\utility::flag_wait("init_interaction_done");
  } else {
    while(!isDefined(level.current_interaction_structs)) {
      wait 1;
    }
  }

  if(isDefined(level.player_interaction_monitor)) {
    self thread[[level.player_interaction_monitor]]();
    return;
  }
}

function flash_inventory() {
  self endon("window_trap_placed");
  self endon("death");

  if(!isDefined(self.next_inventory_flash)) {
    self.next_inventory_flash = gettime() + 2500;
  } else if(gettime() < self.next_inventory_flash) {
    return;
  }

  self.next_inventory_flash = gettime() + 2500;
  wait 1.5;
}

function can_use_interaction(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(istrue(self.iscarrying)) {
    return false;
  }

  if(istrue(var_0.disabled) || !scripts\cp\utility::areinteractionsenabled() || self isinphase()) {
    return false;
  }

  if(istrue(var_0.awaitingpent)) {
    return false;
  }

  if(self secondaryoffhandbuttonPressed() || self isthrowinggrenade() || self fragButtonPressed()) {
    return false;
  }

  if(!self isonground()) {
    return false;
  }

  if(!isDefined(var_0.script_noteworthy)) {
    thread debugremoveinteractionandsendmessage(var_0, "interaction_struct Struct at: " + var_0.origin + " does not have a .script_noteworthy defined.");
    return false;
  }

  if(!isDefined(level.interactions[var_0.script_noteworthy])) {
    thread debugremoveinteractionandsendmessage(var_0, "interaction_struct Struct at: " + var_0.origin + " with .script_noteworthy: " + var_0.script_noteworthy + " has not been registered as an interaction_struct");
    return false;
  }

  return true;
}

function debugremoveinteractionandsendmessage(var_0, var_1) {}

function reset_interaction() {
  self endon("disconnect");
  wait 0.2;
  self.interaction_trigger makeunusable();
  self.last_interaction_point = undefined;
}

function set_interaction_point(var_0, var_1) {
  if(istrue(self.interaction_trigger.disableinteraction)) {
    return;
  }

  self notify("set_interaction_point");
  self.interaction_trigger dontinterpolate();
  self.last_interaction_point = var_0;
  var_2 = self getEye();
  self.interaction_trigger.origin = (var_0.origin[0], var_0.origin[1], var_2[2]);

  if(interactionhasactivation(var_0)) {
    level thread[[level.interactions[var_0.script_noteworthy].activation_func]](var_0, self);
    return;
  }

  if(!isDefined(level.interactions[var_0.script_noteworthy].spend_type)) {
    level.interactions[var_0.script_noteworthy].spend_type = "null";
  }

  var_3 = level.interactions[var_0.script_noteworthy].spend_type;
  var_4 = undefined;

  if(interaction_is_weapon_buy(var_0)) {
    if(!scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy)) {
      var_5 = getweaponnamestring(var_0.script_noteworthy);
      var_6 = getweaponcostint(var_0.script_noteworthy);
      self.interaction_trigger sethintstringparams(var_5, var_6);
    }
  } else if(trial_hitmarker(var_0)) {
    var_7 = strtok(var_0.name, "_");
    var_8 = int(var_7[1]);
    self.interaction_trigger sethintstringparams(var_8);
  } else if(trial_is_event(var_0)) {
    var_9 = remove_specific_structs(var_0.script_label);

    switch (var_0.script_noteworthy) {
      case "seq_button":
        self.interaction_trigger sethintstringparams(var_9);
        break;
    }
  } else if(interaction_is_chess_piece(var_0)) {
    var_9 = getalphabetstring(level.currentalphanumericcode[0]);
    var_10 = getalphabetstring(level.currentalphanumericcode[1]);
    var_11 = getnumberstring(level.currentalphanumericcode[2]);

    switch (var_0.script_noteworthy) {
      case "chess_piece_selection":
        self.interaction_trigger sethintstringparams(var_9);
        break;
      case "chess_puzzle_alphabet":
        self.interaction_trigger sethintstringparams(var_10);
        break;
      case "chess_puzzle_number":
        self.interaction_trigger sethintstringparams(var_11);
        break;
    }
  } else if(interaction_is_pvpve_weapon_pickup(var_0)) {
    if(isDefined(level.set_pvpve_weapon_interaction_func)) {
      [[level.set_pvpve_weapon_interaction_func]](var_0, self);
    }
  } else if(interaction_is_weapon_pickup(var_0)) {
    set_weapon_interaction_string(var_0, self);
  } else if(interaction_is_trap(var_0)) {
    self.interaction_trigger.origin = (var_0.origin[0], var_0.origin[1], var_2[2] - 15);
  }

  set_interaction_trigger_properties(self.interaction_trigger, var_0);

  if(!isDefined(var_0.suseduration)) {
    var_0.suseduration = "duration_none";
  }

  if(!isDefined(var_1)) {
    thread wait_for_interaction_triggered(var_0);
  }

  self.interaction_trigger makeusable();
}

function remove_specific_structs(var_0) {
  if(getdvarint("scr_rocket_fuel_puzzle", 0) != 0) {
    switch (var_0) {
      case "A":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/STABILIZE_PRESSURE_X1";
      case "B":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/STABILIZE_PRESSURE_X2";
      case "C":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/INCREMENT_X1";
      case "D":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/INCREMENT_X2";
      case "E":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/MIX_GAUGE_X2_TO_X1";
      case "F":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/RESET_X1";
      case "G":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/RESET_X2";
      case "H":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/DEPLOY_READINGS";
      case "I":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/MIX_GAUGE_X1_TO_X2";
      case "J":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/DISPLAY_READINGS";
    }
  }

  if(getdvarint("scr_jugg_maze_fuel_puzzle", 0) != 0) {
    switch (var_0) {
      case "A":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/SW_POLE_X1";
      case "B":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/SW_POLE_X2";
      case "C":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/INCREMENT_X1";
      case "D":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/INCREMENT_X2";
      case "E":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/RESET_GAUGES";
      case "F":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/ADJUST_INCR_X1";
      case "G":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/ADJUST_INCR_X2";
      case "H":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/LOCK_FUEL_VALS";
      case "I":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/RANDOMIZE";
      case "J":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/DISPLAY_READINGS";
    }
  }

  switch (var_0) {
    case "A":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/A";
    case "B":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/B";
    case "C":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/C";
    case "D":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/D";
    case "E":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/E";
    case "F":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/F";
    case "G":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/G";
    case "H":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/H";
    case "I":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/I";
    case "J":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/J";
  }
}

function getalphabetstring(var_0) {
  switch (var_0) {
    case "A":
      return &"CP_LAB/A";
    case "B":
      return &"CP_LAB/B";
    case "C":
      return &"CP_LAB/C";
    case "D":
      return &"CP_LAB/D";
    case "E":
      return &"CP_LAB/E";
    case "F":
      return &"CP_LAB/F";
    case "G":
      return &"CP_LAB/G";
    case "H":
      return &"CP_LAB/H";
    case "R":
      return &"CP_LAB/ROOK";
    case "N":
      return &"CP_LAB/KNIGHT";
    case "Q":
      return &"CP_LAB/QUEEN";
    case "K":
      return &"CP_LAB/KING";
    case "P":
      return &"CP_LAB/PAWN";
  }
}

function getnumberstring(var_0) {
  switch (var_0) {
    case "1":
      return &"CP_LAB/1";
    case "2":
      return &"CP_LAB/2";
    case "3":
      return &"CP_LAB/3";
    case "4":
      return &"CP_LAB/4";
    case "5":
      return &"CP_LAB/5";
    case "6":
      return &"CP_LAB/6";
    case "7":
      return &"CP_LAB/7";
    case "8":
      return &"CP_LAB/8";
  }
}

function set_weapon_interaction_string(var_0, var_1) {
  var_2 = get_weapon_name_string(var_0);
  self.interaction_trigger sethintstringparams(var_2);
}

function get_weapon_name_string(var_0) {
  switch (var_0.name) {
    case "iw8_pi_golf21_mp":
      return &"CP_LOOT_WEAPONS/PI_GOLF21";
    case "iw8_pi_mike1911_mp":
      return &"CP_LOOT_WEAPONS/PI_MAGNUM";
    case "iw8_sm_mpapa5_mp":
      return &"CP_LOOT_WEAPONS/SM_MPAPA5";
    case "iw8_sm_augolf_mp":
      return &"CP_LOOT_WEAPONS/SM_AUGOLF";
    case "iw8_sm_papa90_epic_cp":
    case "iw8_sm_papa90_mp":
      return &"CP_LOOT_WEAPONS/SM_PAPA90";
    case "iw8_ar_mike4_mp":
      return &"CP_LOOT_WEAPONS/AR_MIKE4";
    case "iw8_ar_akilo47_mp":
      return &"CP_LOOT_WEAPONS/AR_AKILO47";
    case "iw8_ar_akilo47_epic_cp":
      return &"CP_LOOT_WEAPONS/AR_AKILO47";
    case "iw8_ar_falpha_mp":
      return &"CP_LOOT_WEAPONS/AR_FALPHA";
    case "iw8_lm_kilo121_mp":
      return &"CP_LOOT_WEAPONS/LM_KILO121";
    case "iw8_lm_pkilo_mp":
      return &"CP_LOOT_WEAPONS/LM_PKILO";
    case "iw8_sn_mike14_mp":
      return &"CP_LOOT_WEAPONS/SN_MIKE14";
    case "iw8_sn_kilo98_mp":
      return &"CP_LOOT_WEAPONS/SN_KILO98";
    case "iw8_sn_alpha50_mp":
      return &"CP_LOOT_WEAPONS/SN_ALPHA50";
  }
}

function getweaponnamestring(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = scripts\cp\utility::getbaseweaponname(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  switch (var_1) {
    default:
      if(isDefined(level.custom_weaponnamestring_func)) {
        return [[level.custom_weaponnamestring_func]](var_1, var_0);
      }

      return &"CP_ZMB_WEAPONS/GENERIC";
  }
}

function getweaponcostint(var_0) {
  return int(level.interactions[var_0].cost);
}

function set_interaction_trigger_properties(var_0, var_1) {
  var_2 = get_interaction_hintstring(var_1, self);

  if(isDefined(var_2)) {
    self.interaction_trigger setHintString(var_2);
  }

  if(interaction_is_weapon_buy(var_1)) {
    if(isDefined(var_2) && !isstring(var_2) && var_2 == &"COOP_INTERACTIONS/PURCHASE_AMMO") {
      var_3 = scripts\cp\utility::getrawbaseweaponname(var_1.script_noteworthy);
      var_4 = scripts\cp\cp_weapon::get_weapon_level(var_3);
      var_5 = getweaponnamestring(var_1.script_noteworthy);

      if(var_4 > 1) {
        self.interaction_trigger sethintstringparams(int(4500), var_5);
      } else {
        self.interaction_trigger sethintstringparams(int(0.5 * level.interactions[var_1.script_noteworthy].cost), var_5);
      }
    }
  } else {
    self.interaction_trigger setusefov(160);
  }

  self.interaction_trigger setusepriority(1);

  if(isDefined(level.interaction_trigger_properties_func)) {
    [[level.interaction_trigger_properties_func]](var_0, var_1, var_2);
    return;
  }
}

function get_interaction_hintstring(var_0, var_1) {
  if(isDefined(level.interactions[var_0.script_noteworthy].hint_func)) {
    return [[level.interactions[var_0.script_noteworthy].hint_func]](var_0, var_1);
  }

  if(isDefined(var_0.cooling_down)) {
    return &"COOP_INTERACTIONS/COOLDOWN";
  }

  if(istrue(var_0.requires_power) && !istrue(var_0.powered_on)) {
    return &"COOP_INTERACTIONS/REQUIRES_POWER";
  }

  if(interaction_is_weapon_buy(var_0)) {
    if(!scripts\cp\utility::coop_mode_has("wall_buys")) {
      return undefined;
    }
  }

  if(!isDefined(level.interaction_hintstrings[var_0.script_noteworthy])) {
    return "";
  }

  return level.interaction_hintstrings[var_0.script_noteworthy];
}

function wait_for_interaction_triggered(var_0) {
  if(isDefined(level.wait_for_interaction_func)) {
    self thread[[level.wait_for_interaction_func]](var_0);
    return;
  }
}

function play_weapon_purchase_vo(var_0, var_1) {
  var_2 = var_0.script_noteworthy;
  var_3 = getweaponbasename(var_2);

  switch (var_3) {
    default:
      break;
  }
}

function can_purchase_ammo(var_0) {
  var_1 = self getweaponslistall();
  var_2 = undefined;
  var_3 = undefined;
  var_4 = scripts\cp\utility::getrawbaseweaponname(var_0);

  foreach(var_6 in var_1) {
    var_3 = scripts\cp\utility::getrawbaseweaponname(var_6);

    if(var_3 == var_4) {
      var_2 = var_6;
      break;
    }
  }

  if(isDefined(var_2)) {
    var_8 = self getweaponammostock(var_2);
    var_9 = weaponmaxammo(var_2);
    var_10 = scripts\cp\perks\cp_prestige::prestige_getminammo();
    var_11 = int(var_10 * var_9);

    if(var_8 < var_11) {
      return true;
    } else if(weaponmaxammo(var_2) == weaponclipsize(var_2) && self getweaponammoclip(var_2) < weaponclipsize(var_2)) {
      return true;
    } else {
      return false;
    }
  }

  return true;
}

function interaction_post_activate_delay(var_0) {
  self endon("disconnect");

  if(interaction_is_button_mash(var_0)) {
    return;
  }

  if(interaction_is_door_buy(var_0)) {
    return;
  }

  if(interaction_is_atm(var_0)) {
    return;
  }

  if(interaction_is_chess_piece(var_0)) {
    return;
  }

  scripts\cp\utility::allow_player_interactions(0);
  wait 1.5;

  if(!scripts\cp\utility::areinteractionsenabled()) {
    scripts\cp\utility::allow_player_interactions(1);
    return;
  }
}

function delayed_trigger_unset() {
  wait 0.25;
  self.triggered = undefined;
}

function addtointeractionslistbynoteworthy(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");

  foreach(var_3 in var_1) {
    add_to_current_interaction_list(var_3);
  }
}

function removefrominteractionslistbynoteworthy(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");

  foreach(var_3 in var_1) {
    remove_from_current_interaction_list(var_3);
  }
}

function remove_from_current_interaction_list(var_0) {
  var_0 notify("remove_from_current_interaction_list");
  var_0.in_array = 0;

  if(scripts\engine\utility::array_contains(level.current_interaction_structs, var_0)) {
    level.current_interaction_structs = scripts\engine\utility::array_remove(level.current_interaction_structs, var_0);
  }

  scripts\cp\coop_personal_ents::update_special_mode_for_all_players();
}

function add_to_current_interaction_list(var_0) {
  var_0 notify("add_to_current_interaction_list");
  var_0.in_array = 1;

  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, var_0)) {
    level.current_interaction_structs = scripts\engine\utility::array_add(level.current_interaction_structs, var_0);
  }

  scripts\cp\coop_personal_ents::update_special_mode_for_all_players();
}

function remove_from_current_interaction_list_for_player(var_0, var_1) {
  var_0 notify("remove_from_current_interaction_list_for_player_" + var_1.name);

  if(!scripts\engine\utility::array_contains(var_1.disabled_interactions, var_0)) {
    var_1.disabled_interactions = scripts\engine\utility::array_add(var_1.disabled_interactions, var_0);
  }

  scripts\cp\coop_personal_ents::update_special_mode_for_player(var_1);
}

function add_to_current_interaction_list_for_player(var_0, var_1) {
  var_0 notify("add_to_current_interaction_list_for_player_" + var_1.name);

  if(scripts\engine\utility::array_contains(var_1.disabled_interactions, var_0)) {
    var_1.disabled_interactions = scripts\engine\utility::array_remove(var_1.disabled_interactions, var_0);
  }

  scripts\cp\coop_personal_ents::update_special_mode_for_player(var_1);
}

function can_purchase_interaction(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, var_0)) {
    return false;
  }

  if(scripts\cp\utility::isnmlactive()) {
    return true;
  }

  if(isDefined(var_0.script_location) && var_0.script_location == "afterlife") {
    return true;
  }

  if(isDefined(var_1)) {
    var_4 = var_1;
  } else {
    var_4 = level.interactions[var_1.script_noteworthy].cost;
  }

  if(interaction_is_weapon_buy(var_1)) {
    var_5 = var_1.script_noteworthy;

    if(var_1.script_parameters == "tickets") {
      if(self hasweapon(var_5)) {
        return false;
      }

      self.itempicked = var_1.script_noteworthy;
      level.transactionid = randomint(100);
    }

    var_6 = weaponmaxammo(var_1.script_noteworthy);
    var_7 = scripts\cp\perks\cp_prestige::prestige_getminammo();
    var_8 = int(var_7 * var_6);
    var_9 = self getweaponammostock(var_5);

    if(var_9 >= var_8) {
      return false;
    }
  }

  if(scripts\cp\cp_persistence::player_has_enough_currency(var_4, var_3)) {
    return true;
  }

  return false;
}

function trial_headicon_origin() {
  if(isDefined(self.script_noteworthy) && isDefined(level.interactions[self.script_noteworthy]) && isDefined(level.interactions[self.script_noteworthy].cost)) {
    return level.interactions[self.script_noteworthy].cost;
  }

  return 0;
}

function take_player_money(var_0, var_1) {
  if(scripts\cp\utility::isnmlactive()) {
    return;
  }

  scripts\cp\cp_persistence::take_player_currency(var_0, 1, var_1);
}

function should_interaction_fill_consumable_meter(var_0) {
  if(isDefined(var_0)) {}

  switch (var_0) {
    case "wondercard_machine":
    case "bleedoutPenalty":
    case "atm":
      return 0;
    default:
      return 1;
  }
}

function getammopurchasestring(var_0, var_1) {
  var_2 = level.interactions[var_0.script_noteworthy].cost;
  var_3 = scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy);
  var_4 = var_1 getcurrentweapon();
  var_5 = weaponmaxammo(var_4);
  var_6 = var_1 scripts\cp\perks\cp_prestige::prestige_getminammo();
  var_7 = int(var_6 * var_5);
  var_8 = var_1 getweaponammostock(var_4);
  var_9 = self getweaponslistall();

  foreach(var_11 in var_9) {
    var_12 = scripts\cp\utility::getrawbaseweaponname(var_11);

    if(var_12 == scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy)) {
      var_13 = var_11;
      var_8 = self getweaponammostock(var_13);
      var_5 = weaponmaxammo(var_13);
      var_7 = int(var_6 * var_5);
    }
  }

  if(var_0.script_parameters == "tickets") {
    return level.interaction_hintstrings[var_0.script_noteworthy];
  }

  switch (var_2) {
    case 250:
      return &"CP_ZMB_INTERACTIONS/TICKETS_AMMO";
    case 1500:
    case 1250:
    case 1000:
    case 500:
      return &"COOP_INTERACTIONS/PURCHASE_AMMO";
    default:
      return &"COOP_INTERACTIONS/PURCHASE_AMMO";
  }
}

function default_weapon_hint_func(var_0, var_1) {
  if(var_1 scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy)) {
    return getammopurchasestring(var_0, var_1);
  }

  return undefined;
}

function interaction_sound_monitor() {
  level endon("game_ended");

  for(;;) {
    level waittill("interaction", var_0, var_1, var_2);

    switch (var_0) {
      case "wall_buy":
        if(isDefined(var_2.purchasing_ammo)) {
          if(soundexists("purchase_ammo")) {
            var_2 scripts\cp\utility::playlocalsound_safe("purchase_ammo");
          }
        } else if(soundexists("purchase_weapon")) {
          var_2 scripts\cp\utility::playlocalsound_safe("purchase_weapon");
        }

        break;
      case "purchase":
        var_3 = get_interaction_sound(var_1, var_2);

        if(isDefined(var_3) && soundexists(var_3)) {
          var_2 scripts\cp\utility::playlocalsound_safe(var_3);
        }

        break;
      case "purchase_denied":
        var_2 scripts\cp\utility::playlocalsound_safe("purchase_deny");
        break;
    }
  }
}

function get_interaction_sound(var_0, var_1) {
  var_2 = [];

  switch (var_0.script_noteworthy) {
    case "secure_window":
      return undefined;
    case "lost_and_found":
      var_2 = ["lost_and_found_purchase"];
      break;
    case "blackhole_trap":
    case "scrambler":
    case "interaction_discoballtrap":
    case "beamtrap":
    case "rockettrap":
      var_2 = ["trap_control_panel_purchase"];
      break;
    case "sliding_door":
    case "debris":
      var_2 = ["purchase_door"];
      break;
    case "team_door_switch":
      var_2 = ["purchase_door"];
      break;
    case "atm_deposit":
      var_2 = ["atm_deposit"];
      break;
    case "atm_withdrawal":
      var_2 = ["atm_withdrawal"];
      break;
    case "repair_kevin":
    case "souvenir_pickup":
    case "kevin_battery":
    case "kevin_head":
      var_2 = ["zmb_item_pickup"];
      break;
    case "medium_ticket_prize":
    case "small_ticket_prize":
    case "iw7_forgefreeze_zm+forgefreezealtfire":
    case "zfreeze_semtex_mp":
      var_2 = ["purchase_ticket"];
      break;
    case "large_ticket_prize":
      var_2 = ["ark_purchase"];
      break;
    case "ark_quest_station":
      var_2 = ["ark_turn_in"];
      break;
    default:
      var_2 = ["ark_turn_in"];
      break;
  }

  if(!var_2.size) {
    return undefined;
  }

  return scripts\engine\utility::random(var_2);
}

function interaction_post_activate_update(var_0) {
  if(!isDefined(var_0.post_activate_update)) {
    return;
  }

  if(isDefined(level.interaction_post_activate_update_func)) {
    level thread[[level.interaction_post_activate_update_func]](var_0, self);
    return;
  }
}

function interaction_is_trap(var_0) {
  return var_0.script_noteworthy == "trap_electric" || var_0.script_noteworthy == "trap_firebarrel";
}

function interaction_is_atm(var_0) {
  return var_0.script_noteworthy == "atm_withdrawal" || var_0.script_noteworthy == "atm_deposit";
}

function interaction_is_window_entrance(var_0) {
  return var_0.script_noteworthy == "secure_window";
}

function interaction_is_crafting_station(var_0) {
  return var_0.script_noteworthy == "crafting_station";
}

function interaction_is_grenade_wall_buy(var_0) {
  return var_0.script_noteworthy == "power_bioSpike" || var_0.script_noteworthy == "power_c4";
}

function interaction_is_pvpve_weapon_pickup(var_0) {
  return var_0.script_noteworthy == "PvPvE_weapon_pickup";
}

function interaction_is_weapon_pickup(var_0) {
  return var_0.script_noteworthy == "weaponPickup";
}

function interaction_is_fortune_teller(var_0) {
  return var_0.script_noteworthy == "jaroslav_machine";
}

function interaction_is_perk(var_0) {
  return isDefined(var_0.perk_type);
}

function interaction_waiting_on_power(var_0) {
  return istrue(var_0.requires_power) && !var_0.powered_on;
}

function interaction_is_valid(var_0, var_1) {
  if(var_1 isinphase()) {
    return false;
  }

  if(isDefined(var_0.triggered)) {
    return false;
  }

  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, var_0)) {
    return false;
  }

  if(istrue(var_0.out_of_order)) {
    level notify("player_accessed_interaction_on_cooldown", var_1);
    return false;
  }

  if(istrue(var_0.in_use)) {
    return false;
  }

  if(interaction_waiting_on_power(var_0)) {
    level notify("player_accessed_nonpowered_interaction", var_1);

    if(isDefined(var_0.perk_type) && soundexists("perk_machine_deny")) {
      var_1 playlocalsound("perk_machine_deny");
    } else {
      var_1 playlocalsound("purchase_deny");
    }

    return false;
  }

  if(isDefined(var_0.cooling_down)) {
    level notify("player_accessed_interaction_on_cooldown", var_1);
    return false;
  }

  if(scripts\engine\utility::array_contains(var_1.disabled_interactions, var_0)) {
    return false;
  }

  return true;
}

function trial_hitmarker(var_0) {
  return var_0.script_noteworthy == "sequence_interaction";
}

function trial_is_event(var_0) {
  return var_0.script_noteworthy == "seq_button";
}

function interaction_is_chess_piece(var_0) {
  return var_0.script_noteworthy == "chess_piece_selection" || var_0.script_noteworthy == "chess_puzzle_alphabet" || var_0.script_noteworthy == "chess_puzzle_number";
}

function interaction_is_weapon_upgrade(var_0) {
  return var_0.script_noteworthy == "weapon_upgrade";
}

function interaction_is_weapon_buy(var_0) {
  if(isDefined(var_0.name)) {
    return (var_0.name == "wall_buy");
  }

  return 0;
}

function interaction_is_button_mash(var_0) {
  return isDefined(var_0.isbuttonmash) && var_0.isbuttonmash;
}

function interaction_is_door_buy(var_0) {
  return var_0.script_noteworthy == "debris_350" || var_0.script_noteworthy == "debris_750" || var_0.script_noteworthy == "debris_1000" || var_0.script_noteworthy == "debris_1250" || var_0.script_noteworthy == "debris_1500" || var_0.script_noteworthy == "debris_2000" || var_0.script_noteworthy == "1v1_stairway_door" || var_0.script_noteworthy == "1v1_exit_door" || var_0.script_noteworthy == "team_door_switch" || var_0.script_noteworthy == "team_door";
}

function interaction_is_special_door_buy(var_0) {
  return var_0.script_noteworthy == "power_door_sliding" || var_0.script_noteworthy == "team_door_switch" || var_0.script_noteworthy == "1v1_stairway_door" || var_0.script_noteworthy == "1v1_exit_door" || var_0.script_noteworthy == "team_door";
}

function interaction_is_chi_door(var_0) {
  return var_0.script_noteworthy == "chi_0" || var_0.script_noteworthy == "chi_1" || var_0.script_noteworthy == "chi_2";
}

function interaction_is_ticket_buy(var_0) {
  return var_0.script_noteworthy == "small_ticket_prize" || var_0.script_noteworthy == "medium_ticket_prize" || var_0.script_noteworthy == "arcade_counter_grenade" || var_0.script_noteworthy == "arcade_counter_ammo" || var_0.script_noteworthy == "large_ticket_prize" || var_0.script_noteworthy == "zfreeze_semtex_mp" || var_0.script_noteworthy == "iw7_forgefreeze_zm+forgefreezealtfire" || var_0.script_noteworthy == "gold_teeth";
}

function can_use_perk(var_0) {
  if(scripts\cp\utility::has_zombie_perk(var_0.perk_type)) {
    return false;
  } else if(self.self_revives_purchased >= self.max_self_revive_machine_use && var_0.perk_type == "perk_machine_revive") {
    return false;
  } else if(isDefined(self.zombies_perks) && self.zombies_perks.size > 4) {
    return false;
  }

  return true;
}

function interaction_show_fail_reason(var_0, var_1, var_2, var_3) {
  thread interaction_fail_internal(var_0, var_1, var_2, var_3);
}

function interaction_fail_internal(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  level notify("interaction", "purchase_denied", level.interactions[var_0.script_noteworthy], self);
  self.delay_hint = 1;
  self.interaction_trigger setHintString(var_1);
  wait 1;
  self.delay_hint = undefined;
  set_interaction_trigger_properties(self.interaction_trigger, var_0);
}

function interaction_cooldown(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray(var_0.script_noteworthy, "script_noteworthy");

  foreach(var_4 in var_2) {
    if(var_4.target == var_0.target) {
      var_4.cooling_down = 1;
    }
  }

  if(istrue(level.cooldown_override)) {
    wait 1;
  } else {
    level scripts\engine\utility::ref_143b9(var_1, "override_cooldowns");
  }

  foreach(var_4 in var_2) {
    if(var_4.target == var_0.target) {
      var_4.cooling_down = undefined;
    }
  }

  var_8 = 5184;

  foreach(var_10 in level.players) {
    foreach(var_4 in var_2) {
      if(distancesquared(var_10.origin, var_4.origin) >= var_8) {
        continue;
      }

      refresh_interaction(var_10);
    }
  }
}

function refresh_interaction() {
  self notify("stop_interaction_logic");
  self.last_interaction_point = undefined;

  if(isDefined(self.interaction_trigger)) {
    self.interaction_trigger setHintString("");
    return;
  }
}

function disable_wall_buy_interactions() {
  var_0 = scripts\engine\utility::getStructArray("interaction", "targetname");

  foreach(var_2 in var_0) {
    if(interaction_is_weapon_buy(var_2) || interaction_is_grenade_wall_buy(var_2) || interaction_is_ticket_buy(var_2) || isDefined(var_2.script_parameters) && var_2.script_parameters == "tickets") {
      var_2.disabled = 1;
    }
  }
}

function spawninteractionmodel(var_0, var_1) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");

  if(isDefined(var_0.script_modelname)) {
    var_2 = spawn("script_model", var_1.origin);

    if(isDefined(var_1.angles)) {
      var_2.angles = var_1.angles;
    }

    var_2 setModel(var_0.script_modelname);

    if(isDefined(var_0.targetmodels)) {
      var_0.targetmodels[var_0.targetmodels.size] = var_2;
      return;
    }

    return;
  }
}

function move_to_closest_interaction(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 = undefined;
  var_2 = undefined;
  var_3 = -1;
  var_4 = 0;
  var_5 = squared(75);

  for(;;) {
    if(istrue(var_0.inlaststand) || istrue(var_0.siege_activated) || istrue(var_0.flung)) {
      var_1 = undefined;
      update_struct_information(var_0, -1, undefined, undefined);
    } else if(!var_0 scripts\cp\utility::areinteractionsenabled()) {
      var_1 = undefined;
      update_struct_information(var_0, -1, undefined, undefined);
    } else {
      var_6 = [];
      level.current_interaction_structs = scripts\engine\utility::array_removeundefined(level.current_interaction_structs);
      var_7 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.current_interaction_structs, undefined, 10, 750, 1);

      foreach(var_9 in var_0.disabled_interactions) {
        var_7 = scripts\engine\utility::array_remove(var_7, var_9);
      }

      foreach(var_9 in var_7) {
        if(is_permitted_guided_interaction(var_0, var_9, var_1)) {
          var_6 = var_9;
        }
      }

      if(istrue(var_0.resetguidedinteraction)) {
        var_1 = undefined;
        update_struct_information(var_0, -1, undefined, undefined);
        var_0.resetguidedinteraction = undefined;
        wait 0.05;
        continue;
      }

      var_6 = scripts\engine\utility::array_removeundefined(var_6);
      var_6 = scripts\engine\utility::array_remove_duplicates(var_6);

      if(var_6.size < 1) {
        var_1 = undefined;
        update_struct_information(var_0, -1, undefined, undefined);
        wait 0.05;
        continue;
      }

      var_6 = sortbydistance(var_6, var_0.origin);

      foreach(var_14 in var_6) {
        var_4 = 0;

        if(var_0 adsButtonPressed()) {
          update_struct_information(var_0, -1, undefined, undefined);
          var_1 = undefined;

          while(var_0 adsButtonPressed()) {
            wait 0.05;
          }
        }

        if(distancesquared(var_0.origin, var_14.origin) <= var_5) {
          update_struct_information(var_0, -1, undefined, undefined);
          var_1 = undefined;
          continue;
        }

        if(isDefined(var_1) && var_14 == var_1) {
          break;
        }

        var_2 = get_interaction_origin(var_14, var_0);
        var_3 = get_interaction_cost(var_14, var_0);
        var_1 = var_14;
        var_4 = 1;
        break;
      }

      if(var_4) {
        update_struct_information(var_0, var_3, var_2, var_1);
      }
    }

    wait 0.1;
  }
}

function get_interaction_origin(var_0, var_1) {
  var_2 = (0, 0, 68);
  var_3 = var_0.origin;

  if(interaction_is_weapon_buy(var_0)) {
    if(isDefined(var_0.target)) {
      var_4 = scripts\engine\utility::getStruct(var_0.target, "targetname");

      if(isDefined(var_4)) {
        var_3 = var_4.origin;
      } else {
        var_3 = var_0.origin;
      }
    }
  } else if(!isDefined(var_3)) {
    var_3 = var_0.origin;
  }

  if(isDefined(level.guided_interaction_offset_func)) {
    var_2 = [[level.guided_interaction_offset_func]](var_0, var_1);
  } else {
    var_5 = get_area_for_power(var_0);

    if(isDefined(var_0.script_noteworthy)) {
      var_6 = var_0.script_noteworthy;

      switch (var_6) {
        case "iw7_ripper_zmr":
        case "iw7_ripper_zm+ripperscope_zm":
        case "shooting_gallery":
          var_2 = (0, 0, 12);
          break;
        case "iw7_ake_zml":
        case "iw7_ake_zm":
          if(var_5 == "swamp_stage") {
            var_2 = (0, 0, 12);
          }

          break;
        case "zfreeze_semtex_mp":
          var_2 = (0, 0, 20);
          break;
        case "iw7_sonic_zmr":
        case "iw7_sonic_zm":
          if(var_5 == "moon") {
            var_2 = (0, 0, 30);
          } else {
            var_2 = (0, 0, 56);
          }

          break;
        default:
          var_2 = (0, 0, 56);
          break;
      }
    }
  }

  var_7 = scripts\engine\utility::drop_to_ground(var_3, 12) + var_2;
  return var_7;
}

function get_interaction_cost(var_0, var_1) {
  var_2 = 1;
  var_3 = 0;

  if(isDefined(level.interactions[var_0.script_noteworthy])) {
    if(isDefined(level.interactions[var_0.script_noteworthy].cost)) {
      var_3 = int(level.interactions[var_0.script_noteworthy].cost);
    } else {
      return 0;
    }
  }

  if(interaction_is_weapon_buy(var_0)) {
    if(var_1 scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy)) {
      var_4 = scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy);
      var_5 = var_1 scripts\cp\cp_weapon::get_weapon_level(var_4);

      if(var_5 > 1) {
        var_3 = 4500;
      } else {
        var_2 = 0.5;
        var_3 = int(var_3 * var_2);
      }
    } else {
      var_3 = int(var_3 * var_2);
    }
  } else if(interaction_is_weapon_upgrade(var_0)) {
    var_6 = var_1 getcurrentweapon();

    if(var_1 scripts\cp\cp_weapon::can_upgrade(var_6)) {
      var_5 = var_1 scripts\cp\cp_weapon::get_weapon_level(var_6);
      var_3 = scripts\engine\utility::ter_op(var_5 > 1, 10000, 5000);
    } else {
      var_3 = 0;
    }

    if(istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
      var_3 = 0;
    }
  } else if(is_struct_perk_machine(var_0)) {
    if(isDefined(var_0.script_noteworthy) && !can_use_perk(var_1, var_0)) {
      var_3 = 0;
    } else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "perk_machine_revive") {
      var_3 = 500;
    } else {
      var_3 = get_perk_machine_cost(var_0);
    }
  } else if(interaction_is_fortune_teller(var_0)) {
    if(var_1.card_refills == 1) {
      var_3 = level.fortune_visit_cost_2;
    } else {
      var_3 = level.fortune_visit_cost_1;
    }
  }

  if(var_1 scripts\cp\utility::is_consumable_active("next_purchase_free")) {
    var_3 = 0;
  }

  return var_3;
}

function is_struct_perk_machine(var_0) {
  if(!isDefined(var_0.script_noteworthy)) {
    return false;
  }

  if(var_0.script_noteworthy == "perk_machine_more" || var_0.script_noteworthy == "perk_machine_rat_a_tat" || var_0.script_noteworthy == "perk_machine_revive" || var_0.script_noteworthy == "perk_machine_run" || var_0.script_noteworthy == "perk_machine_smack" || var_0.script_noteworthy == "perk_machine_tough" || var_0.script_noteworthy == "perk_machine_flash" || var_0.script_noteworthy == "perk_machine_boom" || var_0.script_noteworthy == "perk_machine_fwoosh" || var_0.script_noteworthy == "perk_machine_deadeye" || var_0.script_noteworthy == "perk_machine_change" || var_0.script_noteworthy == "perk_machine_zap") {
    return true;
  }

  return false;
}

function get_perk_machine_cost(var_0) {
  switch (var_0.perk_type) {
    case "perk_machine_zap":
    case "perk_machine_change":
    case "perk_machine_deadeye":
    case "perk_machine_fwoosh":
    case "perk_machine_boom":
    case "perk_machine_revive":
      return 1500;
    case "perk_machine_flash":
      return 3000;
    case "perk_machine_tough":
      return 2500;
    case "perk_machine_smack":
    case "perk_machine_run":
    case "perk_machine_rat_a_tat":
    case "perk_machine_more":
      return 2000;
  }
}

function is_permitted_guided_interaction(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("disconnect");

  if(!isDefined(var_1)) {
    return 0;
  }

  var_3 = undefined;

  if(isDefined(var_1.script_noteworthy)) {
    var_3 = var_1.script_noteworthy;
  } else {
    return 0;
  }

  if(istrue(var_1.out_of_order) || isDefined(var_1.cooling_down)) {
    return 0;
  }

  if(istrue(var_1.disabledguidedinteractions)) {
    return 0;
  }

  if(isDefined(var_1.perk_type) && var_1.perk_type == "perk_machine_revive" && var_0.self_revives_purchased >= var_0.max_self_revive_machine_use) {
    return 0;
  }

  if(!scripts\cp\utility::coop_mode_has("wall_buys")) {
    if(interaction_is_weapon_buy(var_1) || interaction_is_grenade_wall_buy(var_1) || interaction_is_ticket_buy(var_1) || interaction_is_chi_door(var_1) || isDefined(var_1.script_parameters) && var_1.script_parameters == "tickets") {
      return 0;
    }
  }

  if(interaction_is_fortune_teller(var_1)) {
    if(var_0.card_refills == 2) {
      return 0;
    }
  }

  if(var_3 == "secure_window" || var_3 == "white_ark" || var_3 == "wor_standee" || var_3 == "generator" || var_3 == "center_speaker_locs" || var_3 == "fourth_speaker" || var_3 == "ark_quest_station" || var_3 == "dj_quest_part_1" || var_3 == "dj_quest_part_2" || var_3 == "dj_quest_part_3" || var_3 == "dj_quest_door" || var_3 == "dj_quest_speaker" || var_3 == "lost_and_found" || var_3 == "fast_travel" || var_3 == "crafting_pickup" || var_3 == "pap_upgrade" || var_3 == "team_door" || var_3 == "neil_head" || var_3 == "neil_battery" || var_3 == "neil_repair" || var_3 == "neil_firmware" || var_3 == "barnstorming_group" || var_3 == "demon_group" || var_3 == "starmaster_group" || var_3 == "group_cosmicarc" || var_3 == "group_pitfall" || var_3 == "group_riverraid" || var_3 == "spider_arcade_group" || var_3 == "robottank_group" || var_3 == "gator_teeth_placement" || var_3 == "atm_withdrawal" && isDefined(level.atm_amount_deposited) && level.atm_amount_deposited < 1000 || var_3 == "crafting_station" && !isDefined(var_0.current_crafting_struct)) {
    return 0;
  }

  if(isDefined(level.guidedinteractionexclusion)) {
    if(![[level.guidedinteractionexclusion]](var_1, var_0, var_3)) {
      return 0;
    }
  }

  if(istrue(var_1.requires_power) && !istrue(var_1.powered_on)) {
    return 0;
  }

  if(isDefined(level.active_volume_check)) {
    if(var_3 == "pap_upgrade" || var_3 == "weapon_upgrade") {
      return 1;
    } else if(!self[[level.active_volume_check]](var_1.origin)) {
      return 0;
    }
  }

  var_4 = var_1.origin;

  if(isDefined(level.guidedinteractionendposoverride)) {
    var_4 = [[level.guidedinteractionendposoverride]](var_0, var_1);
  }

  if(!scripts\engine\utility::within_fov(var_0.origin, var_0.angles, var_4, cos(25))) {
    return 0;
  }

  if(interaction_is_door_buy(var_1) || interaction_is_chi_door(var_1)) {
    var_5 = get_spawn_volumes_player_is_in(0, undefined, var_0);

    foreach(var_7 in var_5) {
      var_8 = get_adjacent_volumes_from_volume(var_7);

      foreach(var_10 in var_8) {
        if(ispointinvolume(var_1.origin, var_10)) {
          return 0;
        }
      }
    }
  }

  var_13 = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid"]);

  if(var_1.script_noteworthy == "trap_hydrant") {
    var_4 = var_1.origin + (0, 0, 50);
  }

  if(scripts\engine\trace::ray_trace_passed(var_0 getEye(), var_4, [var_0], var_13)) {
    return 1;
  }

  return 0;
}

function update_struct_information(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = -1;
  }

  if(isDefined(var_2) && var_2 != self.origin) {
    wait 0.1;
    self dontinterpolate();
    self.origin = var_2;
    wait 0.1;
  }

  if(isDefined(var_3) && var_3.script_parameters == "tickets") {
    var_1 = 2;
    return;
  }
}

function get_spawn_volumes_player_is_in(var_0, var_1, var_2) {
  if(isDefined(level.get_spawn_volume_func)) {
    return [[level.get_spawn_volume_func]]();
  }

  var_3 = [];
  var_4 = level.spawn_volume_array;

  foreach(var_6 in var_4) {
    if(!var_6.active) {
      continue;
    }

    var_7 = 0;

    if(isDefined(var_1) && !var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(var_2 istouching(var_6)) {
      var_7 = 1;
    } else if(istrue(var_0) && is_in_adjacent_volume(var_2, var_6)) {
      var_7 = 1;
    }

    if(var_7) {
      var_3 = var_6;
    }
  }

  return var_3;
}