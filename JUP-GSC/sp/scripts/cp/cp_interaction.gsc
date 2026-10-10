/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_interaction.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\coop_personal_ents;
#using scripts\cp\interaction;
#using scripts\cp\perks\cp_prestige;
#using scripts\cp\persistence;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace cp_interaction;

function coop_interaction_pregame() {
  level thread assign_trigger_on_player_spawned();
}

function init() {
  level thread assign_trigger_on_player_spawned();
  flag_init("init_interaction_done");

  if(flag_exist("init_spawn_volumes_done")) {
    flag_wait("init_spawn_volumes_done");
  }

  if(flag_exist("strike_init_done")) {
    flag_wait("strike_init_done");
  }

  level.interactions = [];
  level.interaction_hintstrings = [];
  level.all_interaction_structs = getStructArray("interaction", "targetname");
  level.current_interaction_structs = level.all_interaction_structs;
  level.weapon_hint_func = &default_weapon_hint_func;
  level thread interaction_sound_monitor();

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

  foreach(interaction_struct in level.current_interaction_structs) {
    interaction_struct.in_array = 1;

    if(!isDefined(interaction_struct.angles)) {
      interaction_struct.angles = (0, 0, 0);
    }

    interaction_struct.targetmodels = [];

    if(!isDefined(interaction_struct.script_parameters)) {
      interaction_struct.script_parameters = "default";
    }

    if(interaction_struct.script_parameters == "requires_power") {
      interaction_struct.requires_power = 1;
      interaction_struct.powered_on = 0;
      interaction_struct.power_area = get_area_for_power(interaction_struct);
    } else {
      interaction_struct.requires_power = 0;
      interaction_struct.powered_on = 0;
    }

    if(isDefined(level.interactions[interaction_struct.script_noteworthy]) && istrue(level.interactions[interaction_struct.script_noteworthy].is_p_ent)) {
      scripts\cp\coop_personal_ents::addtopersonalinteractionlist(interaction_struct);
    }
  }

  if(getdvarint(@ "hash_ca862f7c198bc459", 0) == 0) {
    level thread drop_interaction_structs_to_ground();
  }

  keys = getarraykeys(level.interactions);

  for(i = 0; i < keys.size; i++) {
    if(isDefined(level.interactions[keys[i]].init_func)) {
      structarray = getStructArray(keys[i], "script_noteworthy");
      level thread[[level.interactions[keys[i]].init_func]](structarray);
    }
  }

  foreach(interaction_struct in level.current_interaction_structs) {
    if(isDefined(level.interactions[interaction_struct.script_noteworthy]) && isDefined(level.interactions[interaction_struct.script_noteworthy].useduration)) {
      interaction_struct.useduration = level.interactions[interaction_struct.script_noteworthy].useduration;
    } else {
      interaction_struct.useduration = "duration_short";
    }

    if(isDefined(interaction_struct.script_modelname)) {
      if(isDefined(interaction_struct.target)) {
        var_2632cf7dfde3c0a5 = getStructArray(interaction_struct.target, "targetname");

        foreach(target_struct in var_2632cf7dfde3c0a5) {
          if(!isDefined(target_struct.script_noteworthy) || tolower(target_struct.script_noteworthy) != "scenenode" && tolower(target_struct.script_noteworthy) != "manual_script_model") {
            thread spawninteractionmodel(interaction_struct, target_struct);
          }
        }

        continue;
      }

      if(isDefined(interaction_struct.script_noteworthy) && tolower(interaction_struct.script_noteworthy) != "scenenode") {
        thread spawninteractionmodel(interaction_struct, interaction_struct);
      }
    }
  }

  flag_set("init_interaction_done");

  foreach(player in level.players) {
    curweapon = player getcurrentweapon();

    if(isDefined(level.wave_num) && isDefined(curweapon)) {
      self.waveswithweapons = [level.wave_num][getcompleteweaponname(curweapon)];
    }
  }

  level thread function_985a0cba8e1c90e1();
}

function drop_interaction_structs_to_ground() {
  if(!flag_exist("wall_buy_setup_done")) {
    flag_init("wall_buy_setup_done");
  }

  if(!flag("wall_buy_setup_done")) {
    flag_wait("wall_buy_setup_done");
  }

  foreach(interaction_struct in level.all_interaction_structs) {
    if(isDefined(interaction_struct.groupname) && interaction_struct.groupname == "locOverride") {
      continue;
    }

    ground_pos = drop_to_ground(interaction_struct.origin, 10, -200);
    interaction_struct.origin = ground_pos + (0, 0, 1);
  }
}

function get_area_for_power(interaction_struct) {
  volumes = getEntArray("spawn_volume", "targetname");

  foreach(volume in volumes) {
    if(ispointinvolume(interaction_struct.origin, volume)) {
      if(isDefined(volume.basename)) {
        return volume.basename;
      }
    }
  }

  return undefined;
}

function get_adjacent_volumes_from_volume() {
  if(isDefined(level.adjacent_volumes[self.basename])) {
    new_array = [];

    foreach(vol_name in level.adjacent_volumes[self.basename]) {
      new_array[new_array.size] = level.spawn_volume_names[vol_name];
    }

    return new_array;
  }

  return [];
}

function is_in_adjacent_volume(volume) {
  if(!isDefined(volume)) {
    return false;
  }

  if(!isDefined(volume.adjacent_volumes)) {
    return false;
  }

  foreach(vol in volume.adjacent_volumes) {
    if(!vol.active) {
      continue;
    }

    if(self istouching(vol)) {
      return true;
    }
  }

  return false;
}

function release_interaction_ent(player) {
  player waittill("disconnect");
  self.in_use = 0;
  self notify("interaction_ent_released");
}

function assign_trigger_on_player_spawned() {
  level endon("game_ended");

  while(true) {
    level waittill("player_spawned", player);
    player.interaction_trigger = player get_player_interaction_trigger();

    if(!isDefined(player.interaction_trigger)) {
      iprintlnbold("NO TRIGGER FOUND!");
    }

    reset_interaction_triggers();
    player.last_interaction_point = undefined;
    player.interaction_trigger makeunusable();
    player thread release_player_interaction_trigger();
    player thread player_interaction_monitor();
    player thread player_interaction_weapon_switch_monitor();
  }
}

function player_interaction_weapon_switch_monitor() {
  self endon("disconnect");
  self endon("death");

  while(true) {
    waittill_any_3("weapon_switch_started", "weapon_change", "weaponchange");
    self.last_interaction_point = undefined;
    self.resetguidedinteraction = 1;
    self notify("stop_interaction_logic");
  }
}

function get_player_interaction_trigger() {
  if(isDefined(self.interaction_trigger)) {
    return self.interaction_trigger;
  }

  interaction_trigger = spawn("script_model", (0, 0, 0));
  interaction_trigger setModel("tag_origin");
  interaction_trigger.in_use = 1;
  interaction_trigger thread deleteonplayerdeathdisconnect(self);
  return interaction_trigger;
}

function release_player_interaction_trigger() {
  trigger = self.interaction_trigger;
  waittill_any_2("death", "disconnect");
  trigger.in_use = 0;
}

function registerinteraction(script_noteworthy, hint_func, activation_func, init_func, var_ad96ac0ec299e386, suseduration, var_5a9d289a0e9ac2d8) {
  scripts\cp\interaction::registerinteraction(script_noteworthy, hint_func, activation_func, init_func, var_ad96ac0ec299e386, suseduration, var_5a9d289a0e9ac2d8);
}

function add_interaction_structs_to_interaction_arrays(structarray) {
  level.current_interaction_structs = array_combine(level.current_interaction_structs, structarray);
  level.current_interaction_structs = array_remove_duplicates(level.current_interaction_structs);
}

function interactionhasactivation(interaction_struct) {
  return istrue(level.interactions[interaction_struct.script_noteworthy].noactivation);
}

function register_interaction(script_noteworthy, spend_type, tutorial, hint_func, activation_func, activation_cost, requires_power, init_func, can_use_override_func, var_ad96ac0ec299e386, suseduration) {
  scripts\cp\interaction::registerinteraction(script_noteworthy, hint_func, activation_func, init_func, var_ad96ac0ec299e386, suseduration);
}

function reset_interaction_triggers() {
  foreach(player in level.players) {
    if(isDefined(player.interaction_trigger)) {
      hide_interaction_trigger_from_others(player);
    }
  }
}

function hide_interaction_trigger_from_others(allowed_player) {
  foreach(player in level.players) {
    if(player == allowed_player) {
      allowed_player.interaction_trigger enableplayeruse(allowed_player);
      continue;
    }

    allowed_player.interaction_trigger disableplayeruse(player);
  }
}

function wherethehellami(player, trigger) {
  while(true) {
    thread draw_capsule(trigger.origin, 12, 12, trigger.angles, (1, 1, 0), 0, 1);
    wait 0.05;
  }
}

function no_previous_interaction_point() {
  return isDefined(self.last_interaction_point);
}

function interaction_point_has_changed(interaction_point) {
  return self.last_interaction_point != interaction_point;
}

function player_interaction_monitor() {
  self notify("player_interaction_monitor");
  self endon("player_interaction_monitor");
  self endon("disconnect");
  self endon("death");

  if(flag_exist("init_interaction_done")) {
    flag_wait("init_interaction_done");
  } else {
    while(!isDefined(level.current_interaction_structs)) {
      wait 1;
    }
  }

  if(getdvarint(@ "hash_ea23b78eb72018ca", 0) == 1) {
    self.interaction_trigger thread wherethehellami(self, self.interaction_trigger);
  }

  if(isDefined(level.player_interaction_monitor)) {
    self thread[[level.player_interaction_monitor]]();
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

function can_use_interaction(interaction_point) {
  if(!isDefined(interaction_point)) {
    return false;
  }

  if(istrue(self.iscarrying)) {
    return false;
  }

  if(istrue(interaction_point.disabled) || !areinteractionsenabled()) {
    return false;
  }

  if(istrue(interaction_point.awaitingpent)) {
    return false;
  }

  if(self secondaryoffhandbuttonPressed() || self isthrowinggrenade() || self fragButtonPressed()) {
    return false;
  }

  if(!self isonground()) {
    return false;
  }

  if(!isDefined(interaction_point.script_noteworthy)) {
    thread debugremoveinteractionandsendmessage(interaction_point, "interaction_struct Struct at: " + interaction_point.origin + " does not have a .script_noteworthy defined.");
    return false;
  }

  if(!isDefined(level.interactions[interaction_point.script_noteworthy])) {
    thread debugremoveinteractionandsendmessage(interaction_point, "interaction_struct Struct at: " + interaction_point.origin + " with .script_noteworthy: " + interaction_point.script_noteworthy + " has not been registered as an interaction_struct");
    return false;
  }

  return true;
}

function debugremoveinteractionandsendmessage(interaction_struct, message) {
  println("<dev string:x1c>");
  println("<dev string:x95>");
  println(message);
  println("<dev string:xa2>");
  println("<dev string:xe3>" + level.script);
  println("<dev string:xeb>" + level.gametype);
  println("<dev string:x1c>");
  remove_from_current_interaction_list(interaction_struct);
}

function reset_interaction() {
  self endon("disconnect");
  wait 0.2;
  self.interaction_trigger makeunusable();
  self.last_interaction_point = undefined;
}

function set_interaction_point(interaction_point, var_9883d93111fd5ab9) {
  if(istrue(self.interaction_trigger.disableinteraction)) {
    return;
  }

  self notify("set_interaction_point");
  self.interaction_trigger dontinterpolate();
  self.last_interaction_point = interaction_point;
  eye = self getEye();
  self.interaction_trigger.origin = (interaction_point.origin[0], interaction_point.origin[1], eye[2]);

  if(interactionhasactivation(interaction_point)) {
    level thread[[level.interactions[interaction_point.script_noteworthy].activation_func]](interaction_point, self);
    return;
  }

  if(!isDefined(level.interactions[interaction_point.script_noteworthy].spend_type)) {
    level.interactions[interaction_point.script_noteworthy].spend_type = "null";
  }

  spend_type = level.interactions[interaction_point.script_noteworthy].spend_type;
  var_8f8b25936fae5c37 = undefined;
  self.interaction_trigger makeusable();

  if(interaction_is_weapon_buy(interaction_point)) {
    if(!scripts\cp\weapon::has_weapon_variation(interaction_point.script_noteworthy)) {
      weaponnamestring = getweaponnamestring(interaction_point.script_noteworthy);
      weaponcostint = getweaponcostint(interaction_point.script_noteworthy);
      self.interaction_trigger sethintstringparams(weaponnamestring, weaponcostint);
    }
  } else if(interaction_is_floor_is_lava_client(interaction_point)) {
    var_dc4f149f969d05af = strtok(interaction_point.name, "_");
    num = int(var_dc4f149f969d05af[1]);
    self.interaction_trigger sethintstringparams(num);
  } else if(interaction_is_jugg_maze_button(interaction_point)) {
    a = getjuggmazebutton(interaction_point.script_label);

    switch (interaction_point.script_noteworthy) {
      case #"hash_ee9888957c53cd6d":
        self.interaction_trigger sethintstringparams(a);
        break;
    }
  } else if(interaction_is_chess_piece(interaction_point)) {
    a = getalphabetstring(level.currentalphanumericcode[0]);
    b = getalphabetstring(level.currentalphanumericcode[1]);
    c = getnumberstring(level.currentalphanumericcode[2]);

    switch (interaction_point.script_noteworthy) {
      case #"hash_cea00219c45f45b":
        self.interaction_trigger sethintstringparams(a);
        break;
      case #"hash_9eafc3040785fe7e":
        self.interaction_trigger sethintstringparams(b);
        break;
      case #"hash_db37e69d86c806dc":
        self.interaction_trigger sethintstringparams(c);
        break;
    }
  } else if(interaction_is_weapon_pickup(interaction_point)) {
    set_weapon_interaction_string(interaction_point, self);
  } else if(interaction_is_trap(interaction_point)) {
    self.interaction_trigger.origin = (interaction_point.origin[0], interaction_point.origin[1], eye[2] - 15);
  }

  set_interaction_trigger_properties(self.interaction_trigger, interaction_point);

  if(!isDefined(interaction_point.suseduration)) {
    interaction_point.suseduration = "duration_none";
  }

  if(!isDefined(var_9883d93111fd5ab9)) {
    thread wait_for_interaction_triggered(interaction_point);
  }
}

function getjuggmazebutton(alphabet) {
  if(getdvarint(@ "hash_176fa03e6da10955", 0) != 0) {
    switch (alphabet) {
      case #"hash_31105fbc01bdb66c":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/STABILIZE_PRESSURE_X1";
      case #"hash_311062bc01bdbb25":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/STABILIZE_PRESSURE_X2";
      case #"hash_311061bc01bdb992":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/INCREMENT_X1";
      case #"hash_31105cbc01bdb1b3":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/INCREMENT_X2";
      case #"hash_31105bbc01bdb020":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/MIX_GAUGE_X2_TO_X1";
      case #"hash_31105ebc01bdb4d9":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/RESET_X1";
      case #"hash_31105dbc01bdb346":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/RESET_X2";
      case #"hash_311068bc01bdc497":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/DEPLOY_READINGS";
      case #"hash_311067bc01bdc304":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/MIX_GAUGE_X1_TO_X2";
      case #"hash_31106abc01bdc7bd":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/DISPLAY_READINGS";
    }
  }

  if(getdvarint(@ "hash_da6b87817db1cba0", 0) != 0) {
    switch (alphabet) {
      case #"hash_31105fbc01bdb66c":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/SW_POLE_X1";
      case #"hash_311062bc01bdbb25":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/SW_POLE_X2";
      case #"hash_311061bc01bdb992":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/INCREMENT_X1";
      case #"hash_31105cbc01bdb1b3":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/INCREMENT_X2";
      case #"hash_31105bbc01bdb020":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/RESET_GAUGES";
      case #"hash_31105ebc01bdb4d9":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/ADJUST_INCR_X1";
      case #"hash_31105dbc01bdb346":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/ADJUST_INCR_X2";
      case #"hash_311068bc01bdc497":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/LOCK_FUEL_VALS";
      case #"hash_311067bc01bdc304":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/RANDOMIZE";
      case #"hash_31106abc01bdc7bd":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/DISPLAY_READINGS";
    }
  }

  switch (alphabet) {
    case #"hash_31105fbc01bdb66c":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/A";
    case #"hash_311062bc01bdbb25":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/B";
    case #"hash_311061bc01bdb992":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/C";
    case #"hash_31105cbc01bdb1b3":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/D";
    case #"hash_31105bbc01bdb020":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/E";
    case #"hash_31105ebc01bdb4d9":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/F";
    case #"hash_31105dbc01bdb346":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/G";
    case #"hash_311068bc01bdc497":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/H";
    case #"hash_311067bc01bdc304":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/I";
    case #"hash_31106abc01bdc7bd":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/J";
  }
}

function getalphabetstring(alphabet) {
  switch (alphabet) {
    case #"hash_31105fbc01bdb66c":
      return &"CP_LAB/A";
    case #"hash_311062bc01bdbb25":
      return &"CP_LAB/B";
    case #"hash_311061bc01bdb992":
      return &"CP_LAB/C";
    case #"hash_31105cbc01bdb1b3":
      return &"CP_LAB/D";
    case #"hash_31105bbc01bdb020":
      return &"CP_LAB/E";
    case #"hash_31105ebc01bdb4d9":
      return &"CP_LAB/F";
    case #"hash_31105dbc01bdb346":
      return &"CP_LAB/G";
    case #"hash_311068bc01bdc497":
      return &"CP_LAB/H";
    case #"hash_311072bc01bdd455":
      return &"CP_LAB/ROOK";
    case #"hash_311066bc01bdc171":
      return &"CP_LAB/KNIGHT";
    case #"hash_31106fbc01bdcf9c":
      return &"CP_LAB/QUEEN";
    case #"hash_311069bc01bdc62a":
      return &"CP_LAB/KING";
    case #"hash_311070bc01bdd12f":
      return &"CP_LAB/PAWN";
  }
}

function getnumberstring(number) {
  switch (number) {
    case #"hash_31100fbc01bd387c":
      return &"CP_LAB/1";
    case #"hash_311012bc01bd3d35":
      return &"CP_LAB/2";
    case #"hash_311011bc01bd3ba2":
      return &"CP_LAB/3";
    case #"hash_31100cbc01bd33c3":
      return &"CP_LAB/4";
    case #"hash_31100bbc01bd3230":
      return &"CP_LAB/5";
    case #"hash_31100ebc01bd36e9":
      return &"CP_LAB/6";
    case #"hash_31100dbc01bd3556":
      return &"CP_LAB/7";
    case #"hash_311018bc01bd46a7":
      return &"CP_LAB/8";
  }
}

function set_weapon_interaction_string(interaction_point, player) {
  weapon_name_string = get_weapon_name_string(interaction_point);
  self.interaction_trigger sethintstringparams(weapon_name_string);
}

function get_weapon_name_string(interaction_point) {
  switch (interaction_point.name) {
    case #"hash_da6958311b58f75b":
      return &"CP_LOOT_WEAPONS/PI_GOLF21";
    case #"hash_cfce2a2737ab1be6":
      return &"CP_LOOT_WEAPONS/PI_MAGNUM";
    case #"hash_16a70270ad1be05":
      return &"CP_LOOT_WEAPONS/SM_MPAPA5";
    case #"hash_c7149abad793a9b1":
      return &"CP_LOOT_WEAPONS/SM_AUGOLF";
    case #"hash_1ca5befa8dd4212c":
    case #"hash_6e395906bcf5969a":
      return &"CP_LOOT_WEAPONS/SM_PAPA90";
    case #"hash_1a3a5f8a962ed552":
      return &"CP_LOOT_WEAPONS/AR_MIKE4";
    case #"hash_4da38b8f68dd24e9":
      return &"CP_LOOT_WEAPONS/AR_AKILO47";
    case #"hash_7332dd92c8f8e421":
      return &"CP_LOOT_WEAPONS/AR_AKILO47";
    case #"hash_b1d476fe8b4f829a":
      return &"CP_LOOT_WEAPONS/AR_FALPHA";
    case #"hash_e1a2fa29b8332d53":
      return &"CP_LOOT_WEAPONS/LM_KILO121";
    case #"hash_373244181c39a617":
      return &"CP_LOOT_WEAPONS/LM_PKILO";
    case #"hash_b9e0da8080aefc13":
      return &"CP_LOOT_WEAPONS/SN_MIKE14";
    case #"hash_720415103e03ae2":
      return &"CP_LOOT_WEAPONS/SN_KILO98";
    case #"hash_5d0a7e04f70f7955":
      return &"CP_LOOT_WEAPONS/SN_ALPHA50";
  }
}

function getweaponnamestring(weaponname) {
  if(!isDefined(weaponname)) {
    return undefined;
  }

  base_weapon = getbaseweaponname(weaponname);

  if(!isDefined(base_weapon)) {
    return undefined;
  }

  if(isDefined(level.custom_weaponnamestring_func)) {
    return [[level.custom_weaponnamestring_func]](base_weapon, weaponname);
  }

  return &"CP_ZMB_WEAPONS/GENERIC";
}

function getweaponcostint(weaponname) {
  return int(level.interactions[weaponname].cost);
}

function set_interaction_trigger_properties(interaction_trigger, interaction_struct) {
  hintstring = get_interaction_hintstring(interaction_struct, self);

  if(isDefined(hintstring)) {
    self.interaction_trigger setHintString(hintstring);
  }

  if(interaction_is_weapon_buy(interaction_struct)) {
    if(isDefined(hintstring) && !isstring(hintstring) && hintstring == &"COOP_INTERACTIONS/PURCHASE_AMMO") {
      var_9211cdaadb7bca55 = getrawbaseweaponname(interaction_struct.script_noteworthy);
      weaponlevel = scripts\cp\weapon::get_weapon_level(var_9211cdaadb7bca55);
      weaponnamestring = getweaponnamestring(interaction_struct.script_noteworthy);

      if(weaponlevel > 1) {
        self.interaction_trigger sethintstringparams(int(4500), weaponnamestring);
      } else {
        self.interaction_trigger sethintstringparams(int(0.5 * level.interactions[interaction_struct.script_noteworthy].cost), weaponnamestring);
      }
    }
  } else {
    self.interaction_trigger setusefov(160);
  }

  self.interaction_trigger setusepriority(1);

  if(isDefined(level.var_a30bd62e41e58a08) && isDefined(level.var_a30bd62e41e58a08[interaction_struct.script_noteworthy])) {
    [[level.var_a30bd62e41e58a08[interaction_struct.script_noteworthy]]](interaction_trigger, interaction_struct, hintstring);
    return;
  }

  if(isDefined(level.interaction_trigger_properties_func)) {
    [[level.interaction_trigger_properties_func]](interaction_trigger, interaction_struct, hintstring);
  }
}

function get_interaction_hintstring(interaction_struct, player) {
  if(isDefined(level.interactions[interaction_struct.script_noteworthy].hint_func)) {
    return [[level.interactions[interaction_struct.script_noteworthy].hint_func]](interaction_struct, player);
  }

  if(isDefined(interaction_struct.cooling_down)) {
    return &"COOP_INTERACTIONS/COOLDOWN";
  }

  if(istrue(interaction_struct.requires_power) && !istrue(interaction_struct.powered_on)) {
    return &"COOP_INTERACTIONS/REQUIRES_POWER";
  }

  if(interaction_is_weapon_buy(interaction_struct)) {
    if(!coop_mode_has("wall_buys")) {
      return undefined;
    }
  }

  if(!isDefined(level.interaction_hintstrings[interaction_struct.script_noteworthy])) {
    println("<dev string:xf6>" + interaction_struct.script_noteworthy);
    return "";
  }

  return level.interaction_hintstrings[interaction_struct.script_noteworthy];
}

function wait_for_interaction_triggered(interaction_struct) {
  if(isDefined(level.wait_for_interaction_func)) {
    self thread[[level.wait_for_interaction_func]](interaction_struct);
  }
}

function play_weapon_purchase_vo(interaction_struct, player) {
  item = interaction_struct.script_noteworthy;
  base_weapon = getweaponbasename(item);
}

function can_purchase_ammo(wall_weapon) {
  weapons = self getweaponslistall();
  ammo_weapon = undefined;
  var_9211cdaadb7bca55 = undefined;
  var_fbc51cc04b895926 = getrawbaseweaponname(wall_weapon);

  foreach(weapon in weapons) {
    var_9211cdaadb7bca55 = getrawbaseweaponname(weapon);

    if(var_9211cdaadb7bca55 == var_fbc51cc04b895926) {
      ammo_weapon = weapon;
      break;
    }
  }

  if(isDefined(ammo_weapon)) {
    current_ammo = self getweaponammostock(ammo_weapon);
    max_ammo = weaponmaxammo(ammo_weapon);
    var_629f6083f99f1d29 = scripts\cp\perks\cp_prestige::prestige_getminammo();
    scaled_ammo = int(var_629f6083f99f1d29 * max_ammo);

    if(current_ammo < scaled_ammo) {
      return true;
    } else if(weaponmaxammo(ammo_weapon) == weaponclipsize(ammo_weapon) && self getweaponammoclip(ammo_weapon) < weaponclipsize(ammo_weapon)) {
      return true;
    } else {
      return false;
    }
  }

  return true;
}

function interaction_post_activate_delay(interaction_struct) {
  self endon("disconnect");

  if(interaction_is_button_mash(interaction_struct)) {
    return;
  }

  if(interaction_is_door_buy(interaction_struct)) {
    return;
  }

  if(interaction_is_atm(interaction_struct)) {
    return;
  }

  if(interaction_is_chess_piece(interaction_struct)) {
    return;
  }

  val::set("post_activate_delay", "interactions", 0);
  wait 1.5;
  val::reset_all("post_activate_delay");
}

function delayed_trigger_unset() {
  wait 0.25;
  self.triggered = undefined;
}

function addtointeractionslistbynoteworthy(noteworthy) {
  var_a28cb3eb323db0ae = getStructArray(noteworthy, "script_noteworthy");

  foreach(interaction_struct in var_a28cb3eb323db0ae) {
    add_to_current_interaction_list(interaction_struct);
  }
}

function removefrominteractionslistbynoteworthy(noteworthy) {
  var_a28cb3eb323db0ae = getStructArray(noteworthy, "script_noteworthy");

  foreach(interaction_struct in var_a28cb3eb323db0ae) {
    remove_from_current_interaction_list(interaction_struct);
  }
}

function remove_from_current_interaction_list(interaction_struct) {
  interaction_struct notify("remove_from_current_interaction_list");
  interaction_struct.in_array = 0;

  if(array_contains(level.current_interaction_structs, interaction_struct)) {
    level.current_interaction_structs = array_remove(level.current_interaction_structs, interaction_struct);
  }

  scripts\cp\coop_personal_ents::update_special_mode_for_all_players();
}

function add_to_current_interaction_list(interaction_struct) {
  interaction_struct notify("add_to_current_interaction_list");
  interaction_struct.in_array = 1;

  if(!array_contains(level.current_interaction_structs, interaction_struct)) {
    level.current_interaction_structs = array_add(level.current_interaction_structs, interaction_struct);
  }

  scripts\cp\coop_personal_ents::update_special_mode_for_all_players();
}

function remove_from_current_interaction_list_for_player(interaction_struct, player) {
  interaction_struct notify("remove_from_current_interaction_list_for_player_" + player.name);

  if(!array_contains(player.disabled_interactions, interaction_struct)) {
    player.disabled_interactions = array_add(player.disabled_interactions, interaction_struct);
  }

  scripts\cp\coop_personal_ents::update_special_mode_for_player(player);
}

function add_to_current_interaction_list_for_player(interaction_struct, player) {
  interaction_struct notify("add_to_current_interaction_list_for_player_" + player.name);

  if(array_contains(player.disabled_interactions, interaction_struct)) {
    player.disabled_interactions = array_remove(player.disabled_interactions, interaction_struct);
  }

  scripts\cp\coop_personal_ents::update_special_mode_for_player(player);
}

function can_purchase_interaction(interaction_struct, amount, spend_type, weapon) {
  if(!array_contains(level.current_interaction_structs, interaction_struct)) {
    return false;
  }

  if(isnmlactive()) {
    return true;
  }

  if(isDefined(interaction_struct.script_location) && interaction_struct.script_location == "afterlife") {
    return true;
  }

  if(isDefined(amount)) {
    cost = amount;
  } else {
    cost = level.interactions[interaction_struct.script_noteworthy].cost;
  }

  if(interaction_is_weapon_buy(interaction_struct)) {
    var_895fa4b47e915c65 = interaction_struct.script_noteworthy;

    if(interaction_struct.script_parameters == "tickets") {
      if(self hasweapon(var_895fa4b47e915c65)) {
        return false;
      }

      self.itempicked = interaction_struct.script_noteworthy;
      level.transactionid = randomint(100);
    }

    max_ammo = weaponmaxammo(interaction_struct.script_noteworthy);
    var_629f6083f99f1d29 = scripts\cp\perks\cp_prestige::prestige_getminammo();
    scaled_ammo = int(var_629f6083f99f1d29 * max_ammo);
    current_ammo = self getweaponammostock(var_895fa4b47e915c65);

    if(current_ammo >= scaled_ammo) {
      return false;
    }
  }

  if(scripts\cp\persistence::player_has_enough_currency(cost, spend_type)) {
    return true;
  }

  return false;
}

function interaction_get_cost() {
  if(isDefined(self.cost)) {
    return int(self.cost);
  }

  return 0;
}

function take_player_money(cost, spending_type) {
  if(isnmlactive()) {
    return;
  }

  scripts\cp\persistence::take_player_currency(cost, 1, spending_type);
}

function should_interaction_fill_consumable_meter(spending_type) {
  if(!isDefined(spending_type)) {
    assertmsg("Spending type is not defined.");
  }

  switch (spending_type) {
    case #"hash_c932d6c10cbe95f":
    case #"hash_94d89c28c481dde6":
    case #"hash_c6b8c582ba70471e":
      return 0;
    default:
      return 1;
  }
}

function getammopurchasestring(interaction_struct, player) {
  cost = level.interactions[interaction_struct.script_noteworthy].cost;
  base_weapon = getrawbaseweaponname(interaction_struct.script_noteworthy);
  currentweapon = player getcurrentweapon();
  max_ammo = weaponmaxammo(currentweapon);
  var_629f6083f99f1d29 = player scripts\cp\perks\cp_prestige::prestige_getminammo();
  scaled_ammo = int(var_629f6083f99f1d29 * max_ammo);
  current_ammo = player getweaponammostock(currentweapon);
  weapons = self getweaponslistall();

  foreach(weapon in weapons) {
    var_9211cdaadb7bca55 = getrawbaseweaponname(weapon);

    if(var_9211cdaadb7bca55 == getrawbaseweaponname(interaction_struct.script_noteworthy)) {
      var_3626ccbdf1758532 = weapon;
      current_ammo = self getweaponammostock(var_3626ccbdf1758532);
      max_ammo = weaponmaxammo(var_3626ccbdf1758532);
      scaled_ammo = int(var_629f6083f99f1d29 * max_ammo);
    }
  }

  if(interaction_struct.script_parameters == "tickets") {
    return level.interaction_hintstrings[interaction_struct.script_noteworthy];
  }

  switch (cost) {
    case 250:
      return &"CP_ZMB_INTERACTIONS/TICKETS_AMMO";
    case 500:
    case 1000:
    case 1250:
    case 1500:
      return &"COOP_INTERACTIONS/PURCHASE_AMMO";
    default:
      return &"COOP_INTERACTIONS/PURCHASE_AMMO";
  }
}

function default_weapon_hint_func(interaction_struct, player) {
  if(player scripts\cp\weapon::has_weapon_variation(interaction_struct.script_noteworthy)) {
    return getammopurchasestring(interaction_struct, player);
  }

  return undefined;
}

function interaction_sound_monitor() {
  level endon("game_ended");

  while(true) {
    level waittill("interaction", interaction_type, interaction_struct, player);

    switch (interaction_type) {
      case #"hash_52dba21b7b0431e":
        if(isDefined(player.purchasing_ammo)) {
          if(soundexists("purchase_ammo")) {
            player playlocalsound_safe("purchase_ammo");
          }
        } else if(soundexists("purchase_weapon")) {
          player playlocalsound_safe("purchase_weapon");
        }

        break;
      case #"hash_5f4247cbd74f75c2":
        sound = get_interaction_sound(interaction_struct, player);

        if(isDefined(sound) && soundexists(sound)) {
          player playlocalsound_safe(sound);
        }

        break;
      case #"hash_8a373ba44407fd2c":
        player playlocalsound_safe("cp_computer_fail");
        break;
    }
  }
}

function get_interaction_sound(interaction_struct, player) {
  alias_array = [];

  switch (interaction_struct.script_noteworthy) {
    case #"hash_8ded6fdf599c8405":
      return undefined;
    case #"hash_c373b5c1c961382":
      alias_array = ["lost_and_found_purchase"];
      break;
    case #"hash_17705e021d413644":
    case #"hash_5176ea8ac5ebd6d2":
    case #"hash_79aacf81624606a1":
    case #"hash_ad9fd60c8d16f5c4":
    case #"hash_ee5629fbd73d7dec":
      alias_array = ["trap_control_panel_purchase"];
      break;
    case #"hash_43c3b099403349e6":
    case #"hash_74d7342ec02bc5ba":
      alias_array = ["purchase_door"];
      break;
    case #"hash_d33dd55dbc3e9e86":
      alias_array = ["purchase_door"];
      break;
    case #"hash_338a7935f889f966":
      alias_array = ["atm_deposit"];
      break;
    case #"hash_7111b6336bce51b7":
      alias_array = ["atm_withdrawal"];
      break;
    case #"hash_540029e95443eff9":
    case #"hash_6b74d503b2df6dde":
    case #"hash_ecd90e4994d7d04c":
    case #"hash_f9208728ecc14a4d":
      alias_array = ["zmb_item_pickup"];
      break;
    case #"hash_37ad8039ea91a8a5":
    case #"hash_a3d81e14ec5a5b24":
    case #"hash_c588128f7226d6cf":
    case #"hash_dc336228a1085866":
      alias_array = ["purchase_ticket"];
      break;
    case #"hash_1e249caad9c87d9e":
      alias_array = ["ark_purchase"];
      break;
    case #"hash_e66a57d8aeebc251":
      alias_array = ["ark_turn_in"];
      break;
    default:
      alias_array = ["ark_turn_in"];
      break;
  }

  if(!alias_array.size) {
    return undefined;
  }

  return random(alias_array);
}

function interaction_post_activate_update(interaction_struct) {
  if(!isDefined(interaction_struct.post_activate_update)) {
    return;
  }

  if(isDefined(level.interaction_post_activate_update_func)) {
    level thread[[level.interaction_post_activate_update_func]](interaction_struct, self);
    return;
  }
}

function interaction_is_trap(interaction_struct) {
  return interaction_struct.script_noteworthy == "trap_electric" || interaction_struct.script_noteworthy == "trap_firebarrel";
}

function interaction_is_atm(interaction_struct) {
  return interaction_struct.script_noteworthy == "atm_withdrawal" || interaction_struct.script_noteworthy == "atm_deposit";
}

function interaction_is_window_entrance(interaction_struct) {
  return interaction_struct.script_noteworthy == "secure_window";
}

function interaction_is_crafting_station(interaction_struct) {
  return interaction_struct.script_noteworthy == "crafting_station";
}

function interaction_is_grenade_wall_buy(interaction_struct) {
  return interaction_struct.script_noteworthy == "power_bioSpike" || interaction_struct.script_noteworthy == "power_c4";
}

function interaction_is_weapon_pickup(interaction_struct) {
  return interaction_struct.script_noteworthy == "weaponPickup";
}

function interaction_is_fortune_teller(interaction_struct) {
  return interaction_struct.script_noteworthy == "jaroslav_machine";
}

function interaction_is_perk(interaction_struct) {
  return isDefined(interaction_struct.perk_type);
}

function interaction_waiting_on_power(interaction_struct) {
  return istrue(interaction_struct.requires_power) && !interaction_struct.powered_on;
}

function interaction_is_valid(interaction_struct, player) {
  if(isDefined(interaction_struct.triggered)) {
    return false;
  }

  if(!array_contains(level.current_interaction_structs, interaction_struct)) {
    return false;
  }

  if(istrue(interaction_struct.out_of_order)) {
    level notify("player_accessed_interaction_on_cooldown", player);
    return false;
  }

  if(istrue(interaction_struct.in_use)) {
    return false;
  }

  if(interaction_waiting_on_power(interaction_struct)) {
    level notify("player_accessed_nonpowered_interaction", player);

    if(isDefined(interaction_struct.perk_type) && soundexists("perk_machine_deny")) {
      player playlocalsound("perk_machine_deny");
    } else {
      player playlocalsound("purchase_deny");
    }

    return false;
  }

  if(isDefined(interaction_struct.cooling_down)) {
    level notify("player_accessed_interaction_on_cooldown", player);
    return false;
  }

  if(array_contains(player.disabled_interactions, interaction_struct)) {
    return false;
  }

  return true;
}

function interaction_is_floor_is_lava_client(interaction_struct) {
  return interaction_struct.script_noteworthy == "sequence_interaction";
}

function interaction_is_jugg_maze_button(interaction_struct) {
  return interaction_struct.script_noteworthy == "seq_button";
}

function interaction_is_chess_piece(interaction_struct) {
  return interaction_struct.script_noteworthy == "chess_piece_selection" || interaction_struct.script_noteworthy == "chess_puzzle_alphabet" || interaction_struct.script_noteworthy == "chess_puzzle_number";
}

function interaction_is_weapon_upgrade(interaction_struct) {
  return interaction_struct.script_noteworthy == "weapon_upgrade";
}

function interaction_is_weapon_buy(interaction_struct) {
  if(isDefined(interaction_struct.name)) {
    return (interaction_struct.name == "wall_buy");
  }

  return 0;
}

function interaction_is_button_mash(interaction_struct) {
  return isDefined(interaction_struct.isbuttonmash) && interaction_struct.isbuttonmash;
}

function interaction_is_door_buy(interaction_struct) {
  return interaction_struct.script_noteworthy == "debris_350" || interaction_struct.script_noteworthy == "debris_750" || interaction_struct.script_noteworthy == "debris_1000" || interaction_struct.script_noteworthy == "debris_1250" || interaction_struct.script_noteworthy == "debris_1500" || interaction_struct.script_noteworthy == "debris_2000" || interaction_struct.script_noteworthy == "1v1_stairway_door" || interaction_struct.script_noteworthy == "1v1_exit_door" || interaction_struct.script_noteworthy == "team_door_switch" || interaction_struct.script_noteworthy == "team_door";
}

function interaction_is_special_door_buy(interaction_struct) {
  return interaction_struct.script_noteworthy == "power_door_sliding" || interaction_struct.script_noteworthy == "team_door_switch" || interaction_struct.script_noteworthy == "1v1_stairway_door" || interaction_struct.script_noteworthy == "1v1_exit_door" || interaction_struct.script_noteworthy == "team_door";
}

function interaction_is_chi_door(interaction_struct) {
  return interaction_struct.script_noteworthy == "chi_0" || interaction_struct.script_noteworthy == "chi_1" || interaction_struct.script_noteworthy == "chi_2";
}

function interaction_is_ticket_buy(interaction_struct) {
  return interaction_struct.script_noteworthy == "small_ticket_prize" || interaction_struct.script_noteworthy == "medium_ticket_prize" || interaction_struct.script_noteworthy == "arcade_counter_grenade" || interaction_struct.script_noteworthy == "arcade_counter_ammo" || interaction_struct.script_noteworthy == "large_ticket_prize" || interaction_struct.script_noteworthy == "zfreeze_semtex_mp" || interaction_struct.script_noteworthy == "iw7_forgefreeze_zm+forgefreezealtfire" || interaction_struct.script_noteworthy == "gold_teeth";
}

function can_use_perk(interaction_struct) {
  if(has_zombie_perk(interaction_struct.perk_type)) {
    return false;
  } else if(self.self_revives_purchased >= self.max_self_revive_machine_use && interaction_struct.perk_type == "perk_machine_revive") {
    return false;
  } else if(isDefined(self.zombies_perks) && self.zombies_perks.size > 4) {
    return false;
  }

  return true;
}

function interaction_show_fail_reason(interaction_struct, stringname, check_condition, var_1e59f2dcd3b86d22) {
  thread interaction_fail_internal(interaction_struct, stringname, check_condition, var_1e59f2dcd3b86d22);
}

function interaction_fail_internal(interaction_struct, stringname, check_condition, var_1e59f2dcd3b86d22) {
  self endon("disconnect");
  level notify("interaction", "purchase_denied", level.interactions[interaction_struct.script_noteworthy], self);
  self.delay_hint = 1;
  self.interaction_trigger setHintString(stringname);
  wait 1;
  self.delay_hint = undefined;
  set_interaction_trigger_properties(self.interaction_trigger, interaction_struct);
}

function interaction_cooldown(interaction_struct, time) {
  interactions = getStructArray(interaction_struct.script_noteworthy, "script_noteworthy");

  foreach(struct in interactions) {
    if(struct.target == interaction_struct.target) {
      struct.cooling_down = 1;
    }
  }

  if(istrue(level.cooldown_override)) {
    wait 1;
  } else {
    level waittill_any_timeout_1(time, "override_cooldowns");
  }

  foreach(struct in interactions) {
    if(struct.target == interaction_struct.target) {
      struct.cooling_down = undefined;
    }
  }

  distcheck = 5184;

  foreach(player in level.players) {
    foreach(struct in interactions) {
      if(distancesquared(player.origin, struct.origin) >= distcheck) {
        continue;
      }

      player refresh_interaction();
    }
  }
}

function refresh_interaction() {
  self notify("stop_interaction_logic");
  self.last_interaction_point = undefined;

  if(isDefined(self.interaction_trigger)) {
    self.interaction_trigger setHintString("");
  }
}

function disable_wall_buy_interactions() {
  structs = getStructArray("interaction", "targetname");

  foreach(struct in structs) {
    if(interaction_is_weapon_buy(struct) || interaction_is_grenade_wall_buy(struct) || interaction_is_ticket_buy(struct) || isDefined(struct.script_parameters) && struct.script_parameters == "tickets") {
      struct.disabled = 1;
    }
  }
}

function function_985a0cba8e1c90e1() {
  flag_init("<dev string:x112>");
  level endon("<dev string:x132>");
  level.var_375b54a9c54da547 = [];

  while(true) {
    flag_wait("<dev string:x112>");
    var_602b797d1505f4be = getDvar(@ "hash_f3287037720f9cac", "<dev string:x13d>");
    var_d7792c2745050aa0 = getDvar(@ "hash_700b2c240fd3492a", "<dev string:x13d>");
    var_9a4914e120057019 = getStructArray("<dev string:x13e>", "<dev string:x14a>");
    function_1ddb68f2137782b(var_602b797d1505f4be, var_d7792c2745050aa0);
    flag_clear("<dev string:x112>");
    level.var_375b54a9c54da547 = [];
  }
}

function function_1ddb68f2137782b(var_602b797d1505f4be, var_d7792c2745050aa0) {
  level endon("<dev string:x132>");
  level endon("<dev string:x155>");
  var_17f783daa20df724 = getStructArray(var_d7792c2745050aa0, var_602b797d1505f4be);
  level.var_375b54a9c54da547 = var_17f783daa20df724;

  while(true) {
    foreach(interaction_struct in var_17f783daa20df724) {
      thread draw_line_for_time(interaction_struct.origin, interaction_struct.origin + (0, 0, 256), 1, 0, 0, 1);
    }

    wait 1;
  }
}

function spawninteractionmodel(interaction_struct, target_struct) {
  level endon("game_ended");
  flag_wait("interactions_initialized");

  if(isDefined(interaction_struct.script_modelname)) {
    model = spawn("script_model", target_struct.origin);

    if(isDefined(target_struct.angles)) {
      model.angles = target_struct.angles;
    }

    model setModel(interaction_struct.script_modelname);

    if(isDefined(interaction_struct.targetmodels)) {
      interaction_struct.targetmodels[interaction_struct.targetmodels.size] = model;
    }
  }
}

function move_to_closest_interaction(player) {
  level endon("game_ended");
  player endon("disconnect");
  currentstruct = undefined;
  entorigin = undefined;
  omnvarvalue = -1;
  var_3414e5c0a9919716 = 0;
  tooclosedist = squared(75);

  while(true) {
    if(istrue(player.inlaststand) || istrue(player.siege_activated) || istrue(player.flung)) {
      currentstruct = undefined;
      update_struct_information(player, -1, undefined, undefined);
    } else if(!player areinteractionsenabled()) {
      currentstruct = undefined;
      update_struct_information(player, -1, undefined, undefined);
    } else {
      var_936a8cb7ab047d5f = [];
      level.current_interaction_structs = array_removeundefined(level.current_interaction_structs);
      var_d5b8724607c37b52 = get_array_of_closest(player.origin, level.current_interaction_structs, undefined, 10, 750, 1);

      foreach(item in player.disabled_interactions) {
        var_d5b8724607c37b52 = array_remove(var_d5b8724607c37b52, item);
      }

      foreach(item in var_d5b8724607c37b52) {
        if(is_permitted_guided_interaction(player, item, currentstruct)) {
          var_936a8cb7ab047d5f[var_936a8cb7ab047d5f.size] = item;
        }
      }

      if(istrue(player.resetguidedinteraction)) {
        currentstruct = undefined;
        update_struct_information(player, -1, undefined, undefined);
        player.resetguidedinteraction = undefined;
        wait 0.05;
        continue;
      }

      var_936a8cb7ab047d5f = array_removeundefined(var_936a8cb7ab047d5f);
      var_936a8cb7ab047d5f = array_remove_duplicates(var_936a8cb7ab047d5f);

      if(var_936a8cb7ab047d5f.size < 1) {
        currentstruct = undefined;
        update_struct_information(player, -1, undefined, undefined);
        wait 0.05;
        continue;
      }

      var_936a8cb7ab047d5f = sortbydistance(var_936a8cb7ab047d5f, player.origin);

      foreach(struct in var_936a8cb7ab047d5f) {
        var_3414e5c0a9919716 = 0;

        if(player adsButtonPressed()) {
          update_struct_information(player, -1, undefined, undefined);
          currentstruct = undefined;

          while(player adsButtonPressed()) {
            wait 0.05;
          }
        }

        if(distancesquared(player.origin, struct.origin) <= tooclosedist) {
          update_struct_information(player, -1, undefined, undefined);
          currentstruct = undefined;
          continue;
        }

        if(isDefined(currentstruct) && struct == currentstruct) {
          break;
        }

        entorigin = get_interaction_origin(struct, player);
        omnvarvalue = get_interaction_cost(struct, player);
        currentstruct = struct;
        var_3414e5c0a9919716 = 1;
        break;
      }

      if(var_3414e5c0a9919716) {
        update_struct_information(player, omnvarvalue, entorigin, currentstruct);
      }
    }

    wait 0.1;
  }
}

function get_interaction_origin(struct, player) {
  offset = (0, 0, 68);
  pos = struct.origin;

  if(interaction_is_weapon_buy(struct)) {
    if(isDefined(struct.target)) {
      targetstruct = getStruct(struct.target, "targetname");

      if(isDefined(targetstruct)) {
        pos = targetstruct.origin;
      } else {
        pos = struct.origin;
      }
    }
  } else if(!isDefined(pos)) {
    pos = struct.origin;
  }

  if(isDefined(level.guided_interaction_offset_func)) {
    offset = [[level.guided_interaction_offset_func]](struct, player);
  } else {
    var_28eb544eca57f217 = get_area_for_power(struct);

    if(isDefined(struct.script_noteworthy)) {
      structname = struct.script_noteworthy;

      switch (structname) {
        case #"hash_33a1e53dbf58c00e":
        case #"hash_7ea424151841c4eb":
        case #"hash_c83dceded64d47dd":
          offset = (0, 0, 12);
          break;
        case #"hash_4cd897d490012f2e":
        case #"hash_fa26459eb1dd64e6":
          if(var_28eb544eca57f217 == "swamp_stage") {
            offset = (0, 0, 12);
          }

          break;
        case #"hash_37ad8039ea91a8a5":
          offset = (0, 0, 20);
          break;
        case #"hash_c36284ec9d5582db":
        case #"hash_e999e97bad9cb00b":
          if(var_28eb544eca57f217 == "moon") {
            offset = (0, 0, 30);
          } else {
            offset = (0, 0, 56);
          }

          break;
        default:
          offset = (0, 0, 56);
          break;
      }
    }
  }

  neworigin = drop_to_ground(pos, 12) + offset;
  return neworigin;
}

function get_interaction_cost(struct, player) {
  modifier = 1;
  omnvarvalue = 0;

  if(isDefined(level.interactions[struct.script_noteworthy])) {
    if(isDefined(level.interactions[struct.script_noteworthy].cost)) {
      omnvarvalue = int(level.interactions[struct.script_noteworthy].cost);
    } else {
      return 0;
    }
  }

  if(interaction_is_weapon_buy(struct)) {
    if(player scripts\cp\weapon::has_weapon_variation(struct.script_noteworthy)) {
      var_9211cdaadb7bca55 = getrawbaseweaponname(struct.script_noteworthy);
      weaponlevel = player scripts\cp\weapon::get_weapon_level(var_9211cdaadb7bca55);

      if(weaponlevel > 1) {
        omnvarvalue = 4500;
      } else {
        modifier = 0.5;
        omnvarvalue = int(omnvarvalue * modifier);
      }
    } else {
      omnvarvalue = int(omnvarvalue * modifier);
    }
  } else if(interaction_is_weapon_upgrade(struct)) {
    curweapon = player getcurrentweapon();

    if(player scripts\cp\weapon::can_upgrade(curweapon)) {
      weaponlevel = player scripts\cp\weapon::get_weapon_level(curweapon);
      omnvarvalue = ter_op(weaponlevel > 1, 10000, 5000);
    } else {
      omnvarvalue = 0;
    }

    if(istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
      omnvarvalue = 0;
    }
  } else if(is_struct_perk_machine(struct)) {
    if(isDefined(struct.script_noteworthy) && !player can_use_perk(struct)) {
      omnvarvalue = 0;
    } else if((isplayingsolo() || level.only_one_player) && isDefined(struct.script_noteworthy) && struct.script_noteworthy == "perk_machine_revive") {
      omnvarvalue = 500;
    } else {
      omnvarvalue = get_perk_machine_cost(struct);
    }
  } else if(interaction_is_fortune_teller(struct)) {
    if(player.card_refills == 1) {
      omnvarvalue = level.fortune_visit_cost_2;
    } else {
      omnvarvalue = level.fortune_visit_cost_1;
    }
  }

  if(player is_consumable_active("next_purchase_free")) {
    omnvarvalue = 0;
  }

  return omnvarvalue;
}

function is_struct_perk_machine(struct) {
  if(!isDefined(struct.script_noteworthy)) {
    return false;
  }

  if(struct.script_noteworthy == "perk_machine_more" || struct.script_noteworthy == "perk_machine_rat_a_tat" || struct.script_noteworthy == "perk_machine_revive" || struct.script_noteworthy == "perk_machine_run" || struct.script_noteworthy == "perk_machine_smack" || struct.script_noteworthy == "perk_machine_tough" || struct.script_noteworthy == "perk_machine_flash" || struct.script_noteworthy == "perk_machine_boom" || struct.script_noteworthy == "perk_machine_fwoosh" || struct.script_noteworthy == "perk_machine_deadeye" || struct.script_noteworthy == "perk_machine_change" || struct.script_noteworthy == "perk_machine_zap") {
    return true;
  }

  return false;
}

function get_perk_machine_cost(struct) {
  switch (struct.perk_type) {
    case #"hash_3777b0d50b80d951":
    case #"hash_46904519b2213853":
    case #"hash_8baf700e5db691d8":
    case #"hash_aa2341f864220fe7":
    case #"hash_e87d2f5be60558f7":
    case #"hash_f79672486bfae476":
      return 1500;
    case #"hash_a9530646732cbfda":
      return 3000;
    case #"hash_dc25c11d04255e93":
      return 2500;
    case #"hash_27fd715b45bd7d11":
    case #"hash_acdb572603152d89":
    case #"hash_ad8ded5bc73cdeb5":
    case #"hash_c1a8e38b57dc5875":
      return 2000;
  }
}

function is_permitted_guided_interaction(player, struct, currentstruct) {
  level endon("game_ended");
  player endon("disconnect");

  if(!isDefined(struct)) {
    return 0;
  }

  structname = undefined;

  if(isDefined(struct.script_noteworthy)) {
    structname = struct.script_noteworthy;
  } else {
    return 0;
  }

  if(istrue(struct.out_of_order) || isDefined(struct.cooling_down)) {
    return 0;
  }

  if(istrue(struct.disabledguidedinteractions)) {
    return 0;
  }

  if(isDefined(struct.perk_type) && struct.perk_type == "perk_machine_revive" && player.self_revives_purchased >= player.max_self_revive_machine_use) {
    return 0;
  }

  if(!coop_mode_has("wall_buys")) {
    if(interaction_is_weapon_buy(struct) || interaction_is_grenade_wall_buy(struct) || interaction_is_ticket_buy(struct) || interaction_is_chi_door(struct) || isDefined(struct.script_parameters) && struct.script_parameters == "tickets") {
      return 0;
    }
  }

  if(interaction_is_fortune_teller(struct)) {
    if(player.card_refills == 2) {
      return 0;
    }
  }

  if(structname == "secure_window" || structname == "white_ark" || structname == "wor_standee" || structname == "generator" || structname == "center_speaker_locs" || structname == "fourth_speaker" || structname == "ark_quest_station" || structname == "dj_quest_part_1" || structname == "dj_quest_part_2" || structname == "dj_quest_part_3" || structname == "dj_quest_door" || structname == "dj_quest_speaker" || structname == "lost_and_found" || structname == "fast_travel" || structname == "crafting_pickup" || structname == "pap_upgrade" || structname == "team_door" || structname == "neil_head" || structname == "neil_battery" || structname == "neil_repair" || structname == "neil_firmware" || structname == "barnstorming_group" || structname == "demon_group" || structname == "starmaster_group" || structname == "group_cosmicarc" || structname == "group_pitfall" || structname == "group_riverraid" || structname == "spider_arcade_group" || structname == "robottank_group" || structname == "gator_teeth_placement" || structname == "atm_withdrawal" && isDefined(level.atm_amount_deposited) && level.atm_amount_deposited < 1000 || structname == "crafting_station" && !isDefined(player.current_crafting_struct)) {
    return 0;
  }

  if(isDefined(level.guidedinteractionexclusion)) {
    if(![[level.guidedinteractionexclusion]](struct, player, structname)) {
      return 0;
    }
  }

  if(istrue(struct.requires_power) && !istrue(struct.powered_on)) {
    return 0;
  }

  if(isDefined(level.active_volume_check)) {
    if(structname == "pap_upgrade" || structname == "weapon_upgrade") {
      return 1;
    } else if(!self[[level.active_volume_check]](struct.origin)) {
      return 0;
    }
  }

  end_pos = struct.origin;

  if(isDefined(level.guidedinteractionendposoverride)) {
    end_pos = [[level.guidedinteractionendposoverride]](player, struct);
  }

  if(!within_fov(player.origin, player.angles, end_pos, cos(25))) {
    return 0;
  }

  if(interaction_is_door_buy(struct) || interaction_is_chi_door(struct)) {
    var_ee46ba4828993237 = get_spawn_volumes_player_is_in(0, undefined, player);

    foreach(var_27dfbfcbd63d339e in var_ee46ba4828993237) {
      var_eb6e6263d4667983 = var_27dfbfcbd63d339e get_adjacent_volumes_from_volume();

      foreach(volume in var_eb6e6263d4667983) {
        if(ispointinvolume(struct.origin, volume)) {
          return 0;
        }
      }
    }
  }

  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip"]);

  if(struct.script_noteworthy == "trap_hydrant") {
    end_pos = struct.origin + (0, 0, 50);
  }

  if(scripts\engine\trace::ray_trace_passed(player getEye(), end_pos, [player], contents)) {
    return 1;
  }

  return 0;
}

function update_struct_information(player, cost, origin, currentstruct) {
  if(!isDefined(cost)) {
    cost = -1;
  }

  if(isDefined(origin) && origin != self.origin) {
    wait 0.1;
    self dontinterpolate();
    self.origin = origin;
    wait 0.1;
  }

  if(isDefined(currentstruct) && currentstruct.script_parameters == "tickets") {
    cost = 2;
  }
}

function get_spawn_volumes_player_is_in(var_62e2246e21a8b5ea, var_ce0a3f24a858d58b, player) {
  if(isDefined(level.get_spawn_volume_func)) {
    return [[level.get_spawn_volume_func]]();
  }

  spawn_volume_array = [];
  volume_array = level.spawn_volume_array;

  foreach(volume in volume_array) {
    if(!volume.active) {
      continue;
    }

    player_found = 0;

    if(isDefined(var_ce0a3f24a858d58b) && !player is_valid_player()) {
      continue;
    }

    if(player istouching(volume)) {
      player_found = 1;
    } else if(istrue(var_62e2246e21a8b5ea) && player is_in_adjacent_volume(volume)) {
      player_found = 1;
    }

    if(player_found) {
      spawn_volume_array[spawn_volume_array.size] = volume;
    }
  }

  return spawn_volume_array;
}