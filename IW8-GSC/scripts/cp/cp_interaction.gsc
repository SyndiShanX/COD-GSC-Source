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

  foreach(var1 in level.current_interaction_structs) {
    var1.in_array = 1;

    if(!isDefined(var1.angles)) {
      var1.angles = (0, 0, 0);
    }

    var1.targetmodels = [];

    if(!isDefined(var1.script_parameters)) {
      var1.script_parameters = "default";
    }

    if(var1.script_parameters == "requires_power") {
      var1.requires_power = 1;
      var1.powered_on = 0;
      var1.power_area = get_area_for_power(var1);
    } else {
      var1.requires_power = 0;
      var1.powered_on = 0;
    }

    if(isDefined(level.interactions[var1.script_noteworthy]) && istrue(level.interactions[var1.script_noteworthy].is_p_ent)) {
      scripts\cp\coop_personal_ents::addtopersonalinteractionlist(var1);
    }
  }

  if(getdvarint("scr_skip_interaction_dtg", 0) == 0) {
    thread drop_interaction_structs_to_ground();
  }

  var3 = getarraykeys(level.interactions);

  for(var4 = 0; var4 < var3.size; var4++) {
    if(isDefined(level.interactions[var3[var4]].init_func)) {
      var5 = scripts\engine\utility::getStructArray(var3[var4], "script_noteworthy");
      level thread[[level.interactions[var3[var4]].init_func]](var5);
    }
  }

  foreach(var1 in level.current_interaction_structs) {
    if(isDefined(level.interactions[var1.script_noteworthy]) && isDefined(level.interactions[var1.script_noteworthy].useduration)) {
      var1.useduration = level.interactions[var1.script_noteworthy].useduration;
    } else {
      var1.useduration = "duration_short";
    }

    if(isDefined(var1.script_modelname)) {
      if(isDefined(var1.target)) {
        var7 = scripts\engine\utility::getStructArray(var1.target, "targetname");

        foreach(var9 in var7) {
          if(!isDefined(var9.script_noteworthy) || tolower(var9.script_noteworthy) != "scenenode" && tolower(var9.script_noteworthy) != "manual_script_model") {
            thread spawninteractionmodel(var1, var9);
          }
        }

        continue;
      }

      if(isDefined(var1.script_noteworthy) && tolower(var1.script_noteworthy) != "scenenode") {
        thread spawninteractionmodel(var1, var1);
      }
    }
  }

  scripts\engine\utility::flag_set("init_interaction_done");

  foreach(var13 in level.players) {
    var14 = var13 getcurrentweapon();

    if(isDefined(level.wave_num) && isDefined(var14)) {
      self.waveswithweapons = [level.wave_num][createheadicon(var14)];
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

  foreach(var1 in level.all_interaction_structs) {
    if(isDefined(var1.groupname) && var1.groupname == "locOverride") {
      continue;
    }

    var2 = scripts\engine\utility::drop_to_ground(var1.origin, 10, -200);
    var1.origin = var2 + (0, 0, 1);
  }
}

function get_area_for_power(var0) {
  var1 = getEntArray("spawn_volume", "targetname");

  foreach(var3 in var1) {
    if(ispointinvolume(var0.origin, var3)) {
      if(isDefined(var3.basename)) {
        return var3.basename;
      }
    }
  }

  return undefined;
}

function get_adjacent_volumes_from_volume() {
  if(isDefined(level.adjacent_volumes[self.basename])) {
    var0 = [];

    foreach(var2 in level.adjacent_volumes[self.basename]) {
      var0 = level.spawn_volume_names[var2];
    }

    return var0;
  }

  return [];
}

function is_in_adjacent_volume(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(!isDefined(var0.adjacent_volumes)) {
    return false;
  }

  foreach(var2 in var0.adjacent_volumes) {
    if(!var2.active) {
      continue;
    }

    if(self istouching(var2)) {
      return true;
    }
  }

  return false;
}

function release_interaction_ent(var0) {
  var0 waittill("disconnect");
  self.in_use = 0;
  self notify("interaction_ent_released");
}

function assign_trigger_on_player_spawned() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var0);
    var0.interaction_trigger = get_player_interaction_trigger(var0);

    if(!isDefined(var0.interaction_trigger)) {
      iprintlnbold("NO TRIGGER FOUND!");
    }

    reset_interaction_triggers();
    var0.last_interaction_point = undefined;
    var0.interaction_trigger makeunusable();
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

  var0 = spawn("script_model", (0, 0, 0));
  var0 setModel("tag_origin");
  var0.in_use = 1;
  var0 thread scripts\cp\utility::deleteonplayerdeathdisconnect(self);
  return var0;
}

function release_player_interaction_trigger() {
  var0 = self.interaction_trigger;
  scripts\engine\utility::ref_143a5("death", "disconnect");
  var0.in_use = 0;
}

function registerinteraction(var0, var1, var2, var3, var4, var5, var6) {
  var7 = undefined;
  var8 = undefined;
  var9 = undefined;
  var10 = undefined;

  if(!isDefined(var5)) {
    var5 = "duration_short";
  }

  var11 = spawnStruct();
  var11.script_noteworthy = var0;
  var11.hint_func = var1;
  var11.spend_type = var7;
  var11.tutorial = var8;
  var11.activation_func = var2;
  var11.enabled = 1;
  var11.disabledguidedinteractions = 1;
  var11.cost = 0;
  var11.requires_power = var9;
  var11.init_func = var3;
  var11.can_use_override_func = undefined;
  var11.noactivation = var4;
  var11.useduration = var5;
  var11.is_p_ent = var6;
  level.interactions[var0] = var11;
  var12 = scripts\engine\utility::getStructArray(var0, "script_noteworthy");
  add_interaction_structs_to_interaction_arrays(var12);

  if(isDefined(var3)) {
    if(scripts\engine\utility::flag_exist("interactions_initialized") && scripts\engine\utility::flag("interactions_initialized")) {
      level thread[[var3]](var12);

      if(istrue(var6)) {
        foreach(var11 in var12) {
          scripts\cp\coop_personal_ents::addtopersonalinteractionlist(var11);
        }

        return;
      }

      return;
    }

    return;
  }
}

function add_interaction_structs_to_interaction_arrays(var0) {
  level.current_interaction_structs = scripts\engine\utility::array_combine(level.current_interaction_structs, var0);
  level.current_interaction_structs = scripts\engine\utility::array_remove_duplicates(level.current_interaction_structs);
}

function interactionhasactivation(var0) {
  return istrue(level.interactions[var0.script_noteworthy].noactivation);
}

function register_interaction(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  registerinteraction(var0, var3, var4, var7, var9, var10);
}

function reset_interaction_triggers() {
  foreach(var1 in level.players) {
    if(isDefined(var1.interaction_trigger)) {
      hide_interaction_trigger_from_others(var1);
    }
  }
}

function hide_interaction_trigger_from_others(var0) {
  foreach(var2 in level.players) {
    if(var2 == var0) {
      var0.interaction_trigger enableplayeruse(var0);
      continue;
    }

    var0.interaction_trigger disableplayeruse(var2);
  }
}

function wherethehellami(var0, var1) {
  for(;;) {
    thread scripts\engine\utility::draw_capsule(var1.origin, 12, 12, var1.angles, (1, 1, 0), 0, 1);
    wait 0.05;
  }
}

function ref_11e94() {
  return isDefined(self.last_interaction_point);
}

function trial_juggernauts_to_spawn(var0) {
  return self.last_interaction_point != var0;
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

function can_use_interaction(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(istrue(self.iscarrying)) {
    return false;
  }

  if(istrue(var0.disabled) || !scripts\cp\utility::areinteractionsenabled() || self isinphase()) {
    return false;
  }

  if(istrue(var0.awaitingpent)) {
    return false;
  }

  if(self secondaryoffhandbuttonPressed() || self isthrowinggrenade() || self fragButtonPressed()) {
    return false;
  }

  if(!self isonground()) {
    return false;
  }

  if(!isDefined(var0.script_noteworthy)) {
    thread debugremoveinteractionandsendmessage(var0, "interaction_struct Struct at: " + var0.origin + " does not have a .script_noteworthy defined.");
    return false;
  }

  if(!isDefined(level.interactions[var0.script_noteworthy])) {
    thread debugremoveinteractionandsendmessage(var0, "interaction_struct Struct at: " + var0.origin + " with .script_noteworthy: " + var0.script_noteworthy + " has not been registered as an interaction_struct");
    return false;
  }

  return true;
}

function debugremoveinteractionandsendmessage(var0, var1) {}

function reset_interaction() {
  self endon("disconnect");
  wait 0.2;
  self.interaction_trigger makeunusable();
  self.last_interaction_point = undefined;
}

function set_interaction_point(var0, var1) {
  if(istrue(self.interaction_trigger.disableinteraction)) {
    return;
  }

  self notify("set_interaction_point");
  self.interaction_trigger dontinterpolate();
  self.last_interaction_point = var0;
  var2 = self getEye();
  self.interaction_trigger.origin = (var0.origin[0], var0.origin[1], var2[2]);

  if(interactionhasactivation(var0)) {
    level thread[[level.interactions[var0.script_noteworthy].activation_func]](var0, self);
    return;
  }

  if(!isDefined(level.interactions[var0.script_noteworthy].spend_type)) {
    level.interactions[var0.script_noteworthy].spend_type = "null";
  }

  var3 = level.interactions[var0.script_noteworthy].spend_type;
  var4 = undefined;

  if(interaction_is_weapon_buy(var0)) {
    if(!scripts\cp\cp_weapon::has_weapon_variation(var0.script_noteworthy)) {
      var5 = getweaponnamestring(var0.script_noteworthy);
      var6 = getweaponcostint(var0.script_noteworthy);
      self.interaction_trigger sethintstringparams(var5, var6);
    }
  } else if(trial_hitmarker(var0)) {
    var7 = strtok(var0.name, "_");
    var8 = int(var7[1]);
    self.interaction_trigger sethintstringparams(var8);
  } else if(trial_is_event(var0)) {
    var9 = remove_specific_structs(var0.script_label);

    switch (var0.script_noteworthy) {
      case "seq_button":
        self.interaction_trigger sethintstringparams(var9);
        break;
    }
  } else if(interaction_is_chess_piece(var0)) {
    var9 = getalphabetstring(level.currentalphanumericcode[0]);
    var10 = getalphabetstring(level.currentalphanumericcode[1]);
    var11 = getnumberstring(level.currentalphanumericcode[2]);

    switch (var0.script_noteworthy) {
      case "chess_piece_selection":
        self.interaction_trigger sethintstringparams(var9);
        break;
      case "chess_puzzle_alphabet":
        self.interaction_trigger sethintstringparams(var10);
        break;
      case "chess_puzzle_number":
        self.interaction_trigger sethintstringparams(var11);
        break;
    }
  } else if(interaction_is_pvpve_weapon_pickup(var0)) {
    if(isDefined(level.set_pvpve_weapon_interaction_func)) {
      [[level.set_pvpve_weapon_interaction_func]](var0, self);
    }
  } else if(interaction_is_weapon_pickup(var0)) {
    set_weapon_interaction_string(var0, self);
  } else if(interaction_is_trap(var0)) {
    self.interaction_trigger.origin = (var0.origin[0], var0.origin[1], var2[2] - 15);
  }

  set_interaction_trigger_properties(self.interaction_trigger, var0);

  if(!isDefined(var0.suseduration)) {
    var0.suseduration = "duration_none";
  }

  if(!isDefined(var1)) {
    thread wait_for_interaction_triggered(var0);
  }

  self.interaction_trigger makeusable();
}

function remove_specific_structs(var0) {
  if(getdvarint("scr_rocket_fuel_puzzle", 0) != 0) {
    switch (var0) {
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
    switch (var0) {
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

  switch (var0) {
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

function getalphabetstring(var0) {
  switch (var0) {
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

function getnumberstring(var0) {
  switch (var0) {
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

function set_weapon_interaction_string(var0, var1) {
  var2 = get_weapon_name_string(var0);
  self.interaction_trigger sethintstringparams(var2);
}

function get_weapon_name_string(var0) {
  switch (var0.name) {
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

function getweaponnamestring(var0) {
  if(!isDefined(var0)) {
    return undefined;
  }

  var1 = scripts\cp\utility::getbaseweaponname(var0);

  if(!isDefined(var1)) {
    return undefined;
  }

  switch (var1) {
    default:
      if(isDefined(level.custom_weaponnamestring_func)) {
        return [[level.custom_weaponnamestring_func]](var1, var0);
      }

      return &"CP_ZMB_WEAPONS/GENERIC";
  }
}

function getweaponcostint(var0) {
  return int(level.interactions[var0].cost);
}

function set_interaction_trigger_properties(var0, var1) {
  var2 = get_interaction_hintstring(var1, self);

  if(isDefined(var2)) {
    self.interaction_trigger setHintString(var2);
  }

  if(interaction_is_weapon_buy(var1)) {
    if(isDefined(var2) && !isstring(var2) && var2 == &"COOP_INTERACTIONS/PURCHASE_AMMO") {
      var3 = scripts\cp\utility::getrawbaseweaponname(var1.script_noteworthy);
      var4 = scripts\cp\cp_weapon::get_weapon_level(var3);
      var5 = getweaponnamestring(var1.script_noteworthy);

      if(var4 > 1) {
        self.interaction_trigger sethintstringparams(int(4500), var5);
      } else {
        self.interaction_trigger sethintstringparams(int(0.5 * level.interactions[var1.script_noteworthy].cost), var5);
      }
    }
  } else {
    self.interaction_trigger setusefov(160);
  }

  self.interaction_trigger setusepriority(1);

  if(isDefined(level.interaction_trigger_properties_func)) {
    [[level.interaction_trigger_properties_func]](var0, var1, var2);
    return;
  }
}

function get_interaction_hintstring(var0, var1) {
  if(isDefined(level.interactions[var0.script_noteworthy].hint_func)) {
    return [[level.interactions[var0.script_noteworthy].hint_func]](var0, var1);
  }

  if(isDefined(var0.cooling_down)) {
    return &"COOP_INTERACTIONS/COOLDOWN";
  }

  if(istrue(var0.requires_power) && !istrue(var0.powered_on)) {
    return &"COOP_INTERACTIONS/REQUIRES_POWER";
  }

  if(interaction_is_weapon_buy(var0)) {
    if(!scripts\cp\utility::coop_mode_has("wall_buys")) {
      return undefined;
    }
  }

  if(!isDefined(level.interaction_hintstrings[var0.script_noteworthy])) {
    return "";
  }

  return level.interaction_hintstrings[var0.script_noteworthy];
}

function wait_for_interaction_triggered(var0) {
  if(isDefined(level.wait_for_interaction_func)) {
    self thread[[level.wait_for_interaction_func]](var0);
    return;
  }
}

function play_weapon_purchase_vo(var0, var1) {
  var2 = var0.script_noteworthy;
  var3 = getweaponbasename(var2);

  switch (var3) {
    default:
      break;
  }
}

function can_purchase_ammo(var0) {
  var1 = self getweaponslistall();
  var2 = undefined;
  var3 = undefined;
  var4 = scripts\cp\utility::getrawbaseweaponname(var0);

  foreach(var6 in var1) {
    var3 = scripts\cp\utility::getrawbaseweaponname(var6);

    if(var3 == var4) {
      var2 = var6;
      break;
    }
  }

  if(isDefined(var2)) {
    var8 = self getweaponammostock(var2);
    var9 = weaponmaxammo(var2);
    var10 = scripts\cp\perks\cp_prestige::prestige_getminammo();
    var11 = int(var10 * var9);

    if(var8 < var11) {
      return true;
    } else if(weaponmaxammo(var2) == weaponclipsize(var2) && self getweaponammoclip(var2) < weaponclipsize(var2)) {
      return true;
    } else {
      return false;
    }
  }

  return true;
}

function interaction_post_activate_delay(var0) {
  self endon("disconnect");

  if(interaction_is_button_mash(var0)) {
    return;
  }

  if(interaction_is_door_buy(var0)) {
    return;
  }

  if(interaction_is_atm(var0)) {
    return;
  }

  if(interaction_is_chess_piece(var0)) {
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

function addtointeractionslistbynoteworthy(var0) {
  var1 = scripts\engine\utility::getStructArray(var0, "script_noteworthy");

  foreach(var3 in var1) {
    add_to_current_interaction_list(var3);
  }
}

function removefrominteractionslistbynoteworthy(var0) {
  var1 = scripts\engine\utility::getStructArray(var0, "script_noteworthy");

  foreach(var3 in var1) {
    remove_from_current_interaction_list(var3);
  }
}

function remove_from_current_interaction_list(var0) {
  var0 notify("remove_from_current_interaction_list");
  var0.in_array = 0;

  if(scripts\engine\utility::array_contains(level.current_interaction_structs, var0)) {
    level.current_interaction_structs = scripts\engine\utility::array_remove(level.current_interaction_structs, var0);
  }

  scripts\cp\coop_personal_ents::update_special_mode_for_all_players();
}

function add_to_current_interaction_list(var0) {
  var0 notify("add_to_current_interaction_list");
  var0.in_array = 1;

  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, var0)) {
    level.current_interaction_structs = scripts\engine\utility::array_add(level.current_interaction_structs, var0);
  }

  scripts\cp\coop_personal_ents::update_special_mode_for_all_players();
}

function remove_from_current_interaction_list_for_player(var0, var1) {
  var0 notify("remove_from_current_interaction_list_for_player_" + var1.name);

  if(!scripts\engine\utility::array_contains(var1.disabled_interactions, var0)) {
    var1.disabled_interactions = scripts\engine\utility::array_add(var1.disabled_interactions, var0);
  }

  scripts\cp\coop_personal_ents::update_special_mode_for_player(var1);
}

function add_to_current_interaction_list_for_player(var0, var1) {
  var0 notify("add_to_current_interaction_list_for_player_" + var1.name);

  if(scripts\engine\utility::array_contains(var1.disabled_interactions, var0)) {
    var1.disabled_interactions = scripts\engine\utility::array_remove(var1.disabled_interactions, var0);
  }

  scripts\cp\coop_personal_ents::update_special_mode_for_player(var1);
}

function can_purchase_interaction(var0, var1, var2, var3) {
  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, var0)) {
    return false;
  }

  if(scripts\cp\utility::isnmlactive()) {
    return true;
  }

  if(isDefined(var0.script_location) && var0.script_location == "afterlife") {
    return true;
  }

  if(isDefined(var1)) {
    var4 = var1;
  } else {
    var4 = level.interactions[var1.script_noteworthy].cost;
  }

  if(interaction_is_weapon_buy(var1)) {
    var5 = var1.script_noteworthy;

    if(var1.script_parameters == "tickets") {
      if(self hasweapon(var5)) {
        return false;
      }

      self.itempicked = var1.script_noteworthy;
      level.transactionid = randomint(100);
    }

    var6 = weaponmaxammo(var1.script_noteworthy);
    var7 = scripts\cp\perks\cp_prestige::prestige_getminammo();
    var8 = int(var7 * var6);
    var9 = self getweaponammostock(var5);

    if(var9 >= var8) {
      return false;
    }
  }

  if(scripts\cp\cp_persistence::player_has_enough_currency(var4, var3)) {
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

function take_player_money(var0, var1) {
  if(scripts\cp\utility::isnmlactive()) {
    return;
  }

  scripts\cp\cp_persistence::take_player_currency(var0, 1, var1);
}

function should_interaction_fill_consumable_meter(var0) {
  if(isDefined(var0)) {}

  switch (var0) {
    case "wondercard_machine":
    case "bleedoutPenalty":
    case "atm":
      return 0;
    default:
      return 1;
  }
}

function getammopurchasestring(var0, var1) {
  var2 = level.interactions[var0.script_noteworthy].cost;
  var3 = scripts\cp\utility::getrawbaseweaponname(var0.script_noteworthy);
  var4 = var1 getcurrentweapon();
  var5 = weaponmaxammo(var4);
  var6 = var1 scripts\cp\perks\cp_prestige::prestige_getminammo();
  var7 = int(var6 * var5);
  var8 = var1 getweaponammostock(var4);
  var9 = self getweaponslistall();

  foreach(var11 in var9) {
    var12 = scripts\cp\utility::getrawbaseweaponname(var11);

    if(var12 == scripts\cp\utility::getrawbaseweaponname(var0.script_noteworthy)) {
      var13 = var11;
      var8 = self getweaponammostock(var13);
      var5 = weaponmaxammo(var13);
      var7 = int(var6 * var5);
    }
  }

  if(var0.script_parameters == "tickets") {
    return level.interaction_hintstrings[var0.script_noteworthy];
  }

  switch (var2) {
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

function default_weapon_hint_func(var0, var1) {
  if(var1 scripts\cp\cp_weapon::has_weapon_variation(var0.script_noteworthy)) {
    return getammopurchasestring(var0, var1);
  }

  return undefined;
}

function interaction_sound_monitor() {
  level endon("game_ended");

  for(;;) {
    level waittill("interaction", var0, var1, var2);

    switch (var0) {
      case "wall_buy":
        if(isDefined(var2.purchasing_ammo)) {
          if(soundexists("purchase_ammo")) {
            var2 scripts\cp\utility::playlocalsound_safe("purchase_ammo");
          }
        } else if(soundexists("purchase_weapon")) {
          var2 scripts\cp\utility::playlocalsound_safe("purchase_weapon");
        }

        break;
      case "purchase":
        var3 = get_interaction_sound(var1, var2);

        if(isDefined(var3) && soundexists(var3)) {
          var2 scripts\cp\utility::playlocalsound_safe(var3);
        }

        break;
      case "purchase_denied":
        var2 scripts\cp\utility::playlocalsound_safe("purchase_deny");
        break;
    }
  }
}

function get_interaction_sound(var0, var1) {
  var2 = [];

  switch (var0.script_noteworthy) {
    case "secure_window":
      return undefined;
    case "lost_and_found":
      var2 = ["lost_and_found_purchase"];
      break;
    case "blackhole_trap":
    case "scrambler":
    case "interaction_discoballtrap":
    case "beamtrap":
    case "rockettrap":
      var2 = ["trap_control_panel_purchase"];
      break;
    case "sliding_door":
    case "debris":
      var2 = ["purchase_door"];
      break;
    case "team_door_switch":
      var2 = ["purchase_door"];
      break;
    case "atm_deposit":
      var2 = ["atm_deposit"];
      break;
    case "atm_withdrawal":
      var2 = ["atm_withdrawal"];
      break;
    case "repair_kevin":
    case "souvenir_pickup":
    case "kevin_battery":
    case "kevin_head":
      var2 = ["zmb_item_pickup"];
      break;
    case "medium_ticket_prize":
    case "small_ticket_prize":
    case "iw7_forgefreeze_zm+forgefreezealtfire":
    case "zfreeze_semtex_mp":
      var2 = ["purchase_ticket"];
      break;
    case "large_ticket_prize":
      var2 = ["ark_purchase"];
      break;
    case "ark_quest_station":
      var2 = ["ark_turn_in"];
      break;
    default:
      var2 = ["ark_turn_in"];
      break;
  }

  if(!var2.size) {
    return undefined;
  }

  return scripts\engine\utility::random(var2);
}

function interaction_post_activate_update(var0) {
  if(!isDefined(var0.post_activate_update)) {
    return;
  }

  if(isDefined(level.interaction_post_activate_update_func)) {
    level thread[[level.interaction_post_activate_update_func]](var0, self);
    return;
  }
}

function interaction_is_trap(var0) {
  return var0.script_noteworthy == "trap_electric" || var0.script_noteworthy == "trap_firebarrel";
}

function interaction_is_atm(var0) {
  return var0.script_noteworthy == "atm_withdrawal" || var0.script_noteworthy == "atm_deposit";
}

function interaction_is_window_entrance(var0) {
  return var0.script_noteworthy == "secure_window";
}

function interaction_is_crafting_station(var0) {
  return var0.script_noteworthy == "crafting_station";
}

function interaction_is_grenade_wall_buy(var0) {
  return var0.script_noteworthy == "power_bioSpike" || var0.script_noteworthy == "power_c4";
}

function interaction_is_pvpve_weapon_pickup(var0) {
  return var0.script_noteworthy == "PvPvE_weapon_pickup";
}

function interaction_is_weapon_pickup(var0) {
  return var0.script_noteworthy == "weaponPickup";
}

function interaction_is_fortune_teller(var0) {
  return var0.script_noteworthy == "jaroslav_machine";
}

function interaction_is_perk(var0) {
  return isDefined(var0.perk_type);
}

function interaction_waiting_on_power(var0) {
  return istrue(var0.requires_power) && !var0.powered_on;
}

function interaction_is_valid(var0, var1) {
  if(var1 isinphase()) {
    return false;
  }

  if(isDefined(var0.triggered)) {
    return false;
  }

  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, var0)) {
    return false;
  }

  if(istrue(var0.out_of_order)) {
    level notify("player_accessed_interaction_on_cooldown", var1);
    return false;
  }

  if(istrue(var0.in_use)) {
    return false;
  }

  if(interaction_waiting_on_power(var0)) {
    level notify("player_accessed_nonpowered_interaction", var1);

    if(isDefined(var0.perk_type) && soundexists("perk_machine_deny")) {
      var1 playlocalsound("perk_machine_deny");
    } else {
      var1 playlocalsound("purchase_deny");
    }

    return false;
  }

  if(isDefined(var0.cooling_down)) {
    level notify("player_accessed_interaction_on_cooldown", var1);
    return false;
  }

  if(scripts\engine\utility::array_contains(var1.disabled_interactions, var0)) {
    return false;
  }

  return true;
}

function trial_hitmarker(var0) {
  return var0.script_noteworthy == "sequence_interaction";
}

function trial_is_event(var0) {
  return var0.script_noteworthy == "seq_button";
}

function interaction_is_chess_piece(var0) {
  return var0.script_noteworthy == "chess_piece_selection" || var0.script_noteworthy == "chess_puzzle_alphabet" || var0.script_noteworthy == "chess_puzzle_number";
}

function interaction_is_weapon_upgrade(var0) {
  return var0.script_noteworthy == "weapon_upgrade";
}

function interaction_is_weapon_buy(var0) {
  if(isDefined(var0.name)) {
    return (var0.name == "wall_buy");
  }

  return 0;
}

function interaction_is_button_mash(var0) {
  return isDefined(var0.isbuttonmash) && var0.isbuttonmash;
}

function interaction_is_door_buy(var0) {
  return var0.script_noteworthy == "debris_350" || var0.script_noteworthy == "debris_750" || var0.script_noteworthy == "debris_1000" || var0.script_noteworthy == "debris_1250" || var0.script_noteworthy == "debris_1500" || var0.script_noteworthy == "debris_2000" || var0.script_noteworthy == "1v1_stairway_door" || var0.script_noteworthy == "1v1_exit_door" || var0.script_noteworthy == "team_door_switch" || var0.script_noteworthy == "team_door";
}

function interaction_is_special_door_buy(var0) {
  return var0.script_noteworthy == "power_door_sliding" || var0.script_noteworthy == "team_door_switch" || var0.script_noteworthy == "1v1_stairway_door" || var0.script_noteworthy == "1v1_exit_door" || var0.script_noteworthy == "team_door";
}

function interaction_is_chi_door(var0) {
  return var0.script_noteworthy == "chi_0" || var0.script_noteworthy == "chi_1" || var0.script_noteworthy == "chi_2";
}

function interaction_is_ticket_buy(var0) {
  return var0.script_noteworthy == "small_ticket_prize" || var0.script_noteworthy == "medium_ticket_prize" || var0.script_noteworthy == "arcade_counter_grenade" || var0.script_noteworthy == "arcade_counter_ammo" || var0.script_noteworthy == "large_ticket_prize" || var0.script_noteworthy == "zfreeze_semtex_mp" || var0.script_noteworthy == "iw7_forgefreeze_zm+forgefreezealtfire" || var0.script_noteworthy == "gold_teeth";
}

function can_use_perk(var0) {
  if(scripts\cp\utility::has_zombie_perk(var0.perk_type)) {
    return false;
  } else if(self.self_revives_purchased >= self.max_self_revive_machine_use && var0.perk_type == "perk_machine_revive") {
    return false;
  } else if(isDefined(self.zombies_perks) && self.zombies_perks.size > 4) {
    return false;
  }

  return true;
}

function interaction_show_fail_reason(var0, var1, var2, var3) {
  thread interaction_fail_internal(var0, var1, var2, var3);
}

function interaction_fail_internal(var0, var1, var2, var3) {
  self endon("disconnect");
  level notify("interaction", "purchase_denied", level.interactions[var0.script_noteworthy], self);
  self.delay_hint = 1;
  self.interaction_trigger setHintString(var1);
  wait 1;
  self.delay_hint = undefined;
  set_interaction_trigger_properties(self.interaction_trigger, var0);
}

function interaction_cooldown(var0, var1) {
  var2 = scripts\engine\utility::getStructArray(var0.script_noteworthy, "script_noteworthy");

  foreach(var4 in var2) {
    if(var4.target == var0.target) {
      var4.cooling_down = 1;
    }
  }

  if(istrue(level.cooldown_override)) {
    wait 1;
  } else {
    level scripts\engine\utility::ref_143b9(var1, "override_cooldowns");
  }

  foreach(var4 in var2) {
    if(var4.target == var0.target) {
      var4.cooling_down = undefined;
    }
  }

  var8 = 5184;

  foreach(var10 in level.players) {
    foreach(var4 in var2) {
      if(distancesquared(var10.origin, var4.origin) >= var8) {
        continue;
      }

      refresh_interaction(var10);
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
  var0 = scripts\engine\utility::getStructArray("interaction", "targetname");

  foreach(var2 in var0) {
    if(interaction_is_weapon_buy(var2) || interaction_is_grenade_wall_buy(var2) || interaction_is_ticket_buy(var2) || isDefined(var2.script_parameters) && var2.script_parameters == "tickets") {
      var2.disabled = 1;
    }
  }
}

function spawninteractionmodel(var0, var1) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");

  if(isDefined(var0.script_modelname)) {
    var2 = spawn("script_model", var1.origin);

    if(isDefined(var1.angles)) {
      var2.angles = var1.angles;
    }

    var2 setModel(var0.script_modelname);

    if(isDefined(var0.targetmodels)) {
      var0.targetmodels[var0.targetmodels.size] = var2;
      return;
    }

    return;
  }
}

function move_to_closest_interaction(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var1 = undefined;
  var2 = undefined;
  var3 = -1;
  var4 = 0;
  var5 = squared(75);

  for(;;) {
    if(istrue(var0.inlaststand) || istrue(var0.siege_activated) || istrue(var0.flung)) {
      var1 = undefined;
      update_struct_information(var0, -1, undefined, undefined);
    } else if(!var0 scripts\cp\utility::areinteractionsenabled()) {
      var1 = undefined;
      update_struct_information(var0, -1, undefined, undefined);
    } else {
      var6 = [];
      level.current_interaction_structs = scripts\engine\utility::array_removeundefined(level.current_interaction_structs);
      var7 = scripts\engine\utility::get_array_of_closest(var0.origin, level.current_interaction_structs, undefined, 10, 750, 1);

      foreach(var9 in var0.disabled_interactions) {
        var7 = scripts\engine\utility::array_remove(var7, var9);
      }

      foreach(var9 in var7) {
        if(is_permitted_guided_interaction(var0, var9, var1)) {
          var6 = var9;
        }
      }

      if(istrue(var0.resetguidedinteraction)) {
        var1 = undefined;
        update_struct_information(var0, -1, undefined, undefined);
        var0.resetguidedinteraction = undefined;
        wait 0.05;
        continue;
      }

      var6 = scripts\engine\utility::array_removeundefined(var6);
      var6 = scripts\engine\utility::array_remove_duplicates(var6);

      if(var6.size < 1) {
        var1 = undefined;
        update_struct_information(var0, -1, undefined, undefined);
        wait 0.05;
        continue;
      }

      var6 = sortbydistance(var6, var0.origin);

      foreach(var14 in var6) {
        var4 = 0;

        if(var0 adsButtonPressed()) {
          update_struct_information(var0, -1, undefined, undefined);
          var1 = undefined;

          while(var0 adsButtonPressed()) {
            wait 0.05;
          }
        }

        if(distancesquared(var0.origin, var14.origin) <= var5) {
          update_struct_information(var0, -1, undefined, undefined);
          var1 = undefined;
          continue;
        }

        if(isDefined(var1) && var14 == var1) {
          break;
        }

        var2 = get_interaction_origin(var14, var0);
        var3 = get_interaction_cost(var14, var0);
        var1 = var14;
        var4 = 1;
        break;
      }

      if(var4) {
        update_struct_information(var0, var3, var2, var1);
      }
    }

    wait 0.1;
  }
}

function get_interaction_origin(var0, var1) {
  var2 = (0, 0, 68);
  var3 = var0.origin;

  if(interaction_is_weapon_buy(var0)) {
    if(isDefined(var0.target)) {
      var4 = scripts\engine\utility::getStruct(var0.target, "targetname");

      if(isDefined(var4)) {
        var3 = var4.origin;
      } else {
        var3 = var0.origin;
      }
    }
  } else if(!isDefined(var3)) {
    var3 = var0.origin;
  }

  if(isDefined(level.guided_interaction_offset_func)) {
    var2 = [[level.guided_interaction_offset_func]](var0, var1);
  } else {
    var5 = get_area_for_power(var0);

    if(isDefined(var0.script_noteworthy)) {
      var6 = var0.script_noteworthy;

      switch (var6) {
        case "iw7_ripper_zmr":
        case "iw7_ripper_zm+ripperscope_zm":
        case "shooting_gallery":
          var2 = (0, 0, 12);
          break;
        case "iw7_ake_zml":
        case "iw7_ake_zm":
          if(var5 == "swamp_stage") {
            var2 = (0, 0, 12);
          }

          break;
        case "zfreeze_semtex_mp":
          var2 = (0, 0, 20);
          break;
        case "iw7_sonic_zmr":
        case "iw7_sonic_zm":
          if(var5 == "moon") {
            var2 = (0, 0, 30);
          } else {
            var2 = (0, 0, 56);
          }

          break;
        default:
          var2 = (0, 0, 56);
          break;
      }
    }
  }

  var7 = scripts\engine\utility::drop_to_ground(var3, 12) + var2;
  return var7;
}

function get_interaction_cost(var0, var1) {
  var2 = 1;
  var3 = 0;

  if(isDefined(level.interactions[var0.script_noteworthy])) {
    if(isDefined(level.interactions[var0.script_noteworthy].cost)) {
      var3 = int(level.interactions[var0.script_noteworthy].cost);
    } else {
      return 0;
    }
  }

  if(interaction_is_weapon_buy(var0)) {
    if(var1 scripts\cp\cp_weapon::has_weapon_variation(var0.script_noteworthy)) {
      var4 = scripts\cp\utility::getrawbaseweaponname(var0.script_noteworthy);
      var5 = var1 scripts\cp\cp_weapon::get_weapon_level(var4);

      if(var5 > 1) {
        var3 = 4500;
      } else {
        var2 = 0.5;
        var3 = int(var3 * var2);
      }
    } else {
      var3 = int(var3 * var2);
    }
  } else if(interaction_is_weapon_upgrade(var0)) {
    var6 = var1 getcurrentweapon();

    if(var1 scripts\cp\cp_weapon::can_upgrade(var6)) {
      var5 = var1 scripts\cp\cp_weapon::get_weapon_level(var6);
      var3 = scripts\engine\utility::ter_op(var5 > 1, 10000, 5000);
    } else {
      var3 = 0;
    }

    if(istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
      var3 = 0;
    }
  } else if(is_struct_perk_machine(var0)) {
    if(isDefined(var0.script_noteworthy) && !can_use_perk(var1, var0)) {
      var3 = 0;
    } else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && isDefined(var0.script_noteworthy) && var0.script_noteworthy == "perk_machine_revive") {
      var3 = 500;
    } else {
      var3 = get_perk_machine_cost(var0);
    }
  } else if(interaction_is_fortune_teller(var0)) {
    if(var1.card_refills == 1) {
      var3 = level.fortune_visit_cost_2;
    } else {
      var3 = level.fortune_visit_cost_1;
    }
  }

  if(var1 scripts\cp\utility::is_consumable_active("next_purchase_free")) {
    var3 = 0;
  }

  return var3;
}

function is_struct_perk_machine(var0) {
  if(!isDefined(var0.script_noteworthy)) {
    return false;
  }

  if(var0.script_noteworthy == "perk_machine_more" || var0.script_noteworthy == "perk_machine_rat_a_tat" || var0.script_noteworthy == "perk_machine_revive" || var0.script_noteworthy == "perk_machine_run" || var0.script_noteworthy == "perk_machine_smack" || var0.script_noteworthy == "perk_machine_tough" || var0.script_noteworthy == "perk_machine_flash" || var0.script_noteworthy == "perk_machine_boom" || var0.script_noteworthy == "perk_machine_fwoosh" || var0.script_noteworthy == "perk_machine_deadeye" || var0.script_noteworthy == "perk_machine_change" || var0.script_noteworthy == "perk_machine_zap") {
    return true;
  }

  return false;
}

function get_perk_machine_cost(var0) {
  switch (var0.perk_type) {
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

function is_permitted_guided_interaction(var0, var1, var2) {
  level endon("game_ended");
  var0 endon("disconnect");

  if(!isDefined(var1)) {
    return 0;
  }

  var3 = undefined;

  if(isDefined(var1.script_noteworthy)) {
    var3 = var1.script_noteworthy;
  } else {
    return 0;
  }

  if(istrue(var1.out_of_order) || isDefined(var1.cooling_down)) {
    return 0;
  }

  if(istrue(var1.disabledguidedinteractions)) {
    return 0;
  }

  if(isDefined(var1.perk_type) && var1.perk_type == "perk_machine_revive" && var0.self_revives_purchased >= var0.max_self_revive_machine_use) {
    return 0;
  }

  if(!scripts\cp\utility::coop_mode_has("wall_buys")) {
    if(interaction_is_weapon_buy(var1) || interaction_is_grenade_wall_buy(var1) || interaction_is_ticket_buy(var1) || interaction_is_chi_door(var1) || isDefined(var1.script_parameters) && var1.script_parameters == "tickets") {
      return 0;
    }
  }

  if(interaction_is_fortune_teller(var1)) {
    if(var0.card_refills == 2) {
      return 0;
    }
  }

  if(var3 == "secure_window" || var3 == "white_ark" || var3 == "wor_standee" || var3 == "generator" || var3 == "center_speaker_locs" || var3 == "fourth_speaker" || var3 == "ark_quest_station" || var3 == "dj_quest_part_1" || var3 == "dj_quest_part_2" || var3 == "dj_quest_part_3" || var3 == "dj_quest_door" || var3 == "dj_quest_speaker" || var3 == "lost_and_found" || var3 == "fast_travel" || var3 == "crafting_pickup" || var3 == "pap_upgrade" || var3 == "team_door" || var3 == "neil_head" || var3 == "neil_battery" || var3 == "neil_repair" || var3 == "neil_firmware" || var3 == "barnstorming_group" || var3 == "demon_group" || var3 == "starmaster_group" || var3 == "group_cosmicarc" || var3 == "group_pitfall" || var3 == "group_riverraid" || var3 == "spider_arcade_group" || var3 == "robottank_group" || var3 == "gator_teeth_placement" || var3 == "atm_withdrawal" && isDefined(level.atm_amount_deposited) && level.atm_amount_deposited < 1000 || var3 == "crafting_station" && !isDefined(var0.current_crafting_struct)) {
    return 0;
  }

  if(isDefined(level.guidedinteractionexclusion)) {
    if(![[level.guidedinteractionexclusion]](var1, var0, var3)) {
      return 0;
    }
  }

  if(istrue(var1.requires_power) && !istrue(var1.powered_on)) {
    return 0;
  }

  if(isDefined(level.active_volume_check)) {
    if(var3 == "pap_upgrade" || var3 == "weapon_upgrade") {
      return 1;
    } else if(!self[[level.active_volume_check]](var1.origin)) {
      return 0;
    }
  }

  var4 = var1.origin;

  if(isDefined(level.guidedinteractionendposoverride)) {
    var4 = [[level.guidedinteractionendposoverride]](var0, var1);
  }

  if(!scripts\engine\utility::within_fov(var0.origin, var0.angles, var4, cos(25))) {
    return 0;
  }

  if(interaction_is_door_buy(var1) || interaction_is_chi_door(var1)) {
    var5 = get_spawn_volumes_player_is_in(0, undefined, var0);

    foreach(var7 in var5) {
      var8 = get_adjacent_volumes_from_volume(var7);

      foreach(var10 in var8) {
        if(ispointinvolume(var1.origin, var10)) {
          return 0;
        }
      }
    }
  }

  var13 = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid"]);

  if(var1.script_noteworthy == "trap_hydrant") {
    var4 = var1.origin + (0, 0, 50);
  }

  if(scripts\engine\trace::ray_trace_passed(var0 getEye(), var4, [var0], var13)) {
    return 1;
  }

  return 0;
}

function update_struct_information(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = -1;
  }

  if(isDefined(var2) && var2 != self.origin) {
    wait 0.1;
    self dontinterpolate();
    self.origin = var2;
    wait 0.1;
  }

  if(isDefined(var3) && var3.script_parameters == "tickets") {
    var1 = 2;
    return;
  }
}

function get_spawn_volumes_player_is_in(var0, var1, var2) {
  if(isDefined(level.get_spawn_volume_func)) {
    return [[level.get_spawn_volume_func]]();
  }

  var3 = [];
  var4 = level.spawn_volume_array;

  foreach(var6 in var4) {
    if(!var6.active) {
      continue;
    }

    var7 = 0;

    if(isDefined(var1) && !var2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(var2 istouching(var6)) {
      var7 = 1;
    } else if(istrue(var0) && is_in_adjacent_volume(var2, var6)) {
      var7 = 1;
    }

    if(var7) {
      var3 = var6;
    }
  }

  return var3;
}