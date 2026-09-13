/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_interaction.gsc
***********************************************/

coop_interaction_pregame() {
  level thread assign_trigger_on_player_spawned();
}

init() {
  level thread assign_trigger_on_player_spawned();
  scripts\engine\utility::flag_init("init_interaction_done");

  if(scripts\engine\utility::flag_exist("init_spawn_volumes_done"))
    scripts\engine\utility::flag_wait("init_spawn_volumes_done");

  if(scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_wait("strike_init_done");

  level.interactions = [];
  level.interaction_hintstrings = [];
  level.all_interaction_structs = scripts\engine\utility::getStructArray("interaction", "targetname");
  level.current_interaction_structs = level.all_interaction_structs;
  level.weapon_hint_func = ::default_weapon_hint_func;
  level thread interaction_sound_monitor();

  if(isDefined(level.gametype_interaction_func))
    [[level.gametype_interaction_func]]();

  if(isDefined(level.deployable_box_interaction))
    [[level.deployable_box_interaction]]();

  if(isDefined(level.map_interaction_func))
    [[level.map_interaction_func]]();

  if(isDefined(level.weapon_upgrade_interaction))
    [[level.weapon_upgrade_interaction]]();

  if(isDefined(level.init_personal_ent_zones))
    level[[level.init_personal_ent_zones]]();

  foreach(_id_DF071553D0996FF9 in level.current_interaction_structs) {
    _id_DF071553D0996FF9.in_array = 1;

    if(!isDefined(_id_DF071553D0996FF9.angles))
      _id_DF071553D0996FF9.angles = (0, 0, 0);

    _id_DF071553D0996FF9.targetmodels = [];

    if(!isDefined(_id_DF071553D0996FF9.script_parameters))
      _id_DF071553D0996FF9.script_parameters = "default";

    if(_id_DF071553D0996FF9.script_parameters == "requires_power") {
      _id_DF071553D0996FF9.requires_power = 1;
      _id_DF071553D0996FF9.powered_on = 0;
      _id_DF071553D0996FF9.power_area = get_area_for_power(_id_DF071553D0996FF9);
    } else {
      _id_DF071553D0996FF9.requires_power = 0;
      _id_DF071553D0996FF9.powered_on = 0;
    }

    if(isDefined(level.interactions[_id_DF071553D0996FF9.script_noteworthy]) && istrue(level.interactions[_id_DF071553D0996FF9.script_noteworthy].is_p_ent))
      scripts\cp\coop_personal_ents::addtopersonalinteractionlist(_id_DF071553D0996FF9);
  }

  if(getdvarint("dvar_CA862F7C198BC459", 0) == 0)
    level thread drop_interaction_structs_to_ground();

  keys = getarraykeys(level.interactions);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(level.interactions[keys[_id_AC0E594AC96AA3A8]].init_func)) {
      _id_70DAB3207FB65169 = scripts\engine\utility::getStructArray(keys[_id_AC0E594AC96AA3A8], "script_noteworthy");
      level thread[[level.interactions[keys[_id_AC0E594AC96AA3A8]].init_func]](_id_70DAB3207FB65169);
    }
  }

  foreach(_id_DF071553D0996FF9 in level.current_interaction_structs) {
    if(isDefined(level.interactions[_id_DF071553D0996FF9.script_noteworthy]) && isDefined(level.interactions[_id_DF071553D0996FF9.script_noteworthy].useduration))
      _id_DF071553D0996FF9.useduration = level.interactions[_id_DF071553D0996FF9.script_noteworthy].useduration;
    else
      _id_DF071553D0996FF9.useduration = "duration_short";

    if(isDefined(_id_DF071553D0996FF9.script_modelname)) {
      if(isDefined(_id_DF071553D0996FF9.target)) {
        _id_2632CF7DFDE3C0A5 = scripts\engine\utility::getStructArray(_id_DF071553D0996FF9.target, "targetname");

        foreach(_id_E0D9D2880C046704 in _id_2632CF7DFDE3C0A5) {
          if(!isDefined(_id_E0D9D2880C046704.script_noteworthy) || tolower(_id_E0D9D2880C046704.script_noteworthy) != "scenenode" && tolower(_id_E0D9D2880C046704.script_noteworthy) != "manual_script_model")
            thread spawninteractionmodel(_id_DF071553D0996FF9, _id_E0D9D2880C046704);
        }

        continue;
      }

      if(isDefined(_id_DF071553D0996FF9.script_noteworthy) && tolower(_id_DF071553D0996FF9.script_noteworthy) != "scenenode")
        thread spawninteractionmodel(_id_DF071553D0996FF9, _id_DF071553D0996FF9);
    }
  }

  scripts\engine\utility::flag_set("init_interaction_done");

  foreach(player in level.players) {
    _id_2869A3A20D48E6AD = player getcurrentweapon();

    if(isDefined(level.wave_num) && isDefined(_id_2869A3A20D48E6AD))
      self.waveswithweapons = [level.wave_num][getcompleteweaponname(_id_2869A3A20D48E6AD)];
  }
}

drop_interaction_structs_to_ground() {
  if(!scripts\engine\utility::flag_exist("wall_buy_setup_done"))
    scripts\engine\utility::flag_init("wall_buy_setup_done");

  if(!scripts\engine\utility::flag("wall_buy_setup_done"))
    scripts\engine\utility::flag_wait("wall_buy_setup_done");

  foreach(_id_DF071553D0996FF9 in level.all_interaction_structs) {
    if(isDefined(_id_DF071553D0996FF9.groupname) && _id_DF071553D0996FF9.groupname == "locOverride") {
      continue;
    }
    ground_pos = scripts\engine\utility::drop_to_ground(_id_DF071553D0996FF9.origin, 10, -200);
    _id_DF071553D0996FF9.origin = ground_pos + (0, 0, 1);
  }
}

get_area_for_power(_id_DF071553D0996FF9) {
  volumes = getEntArray("spawn_volume", "targetname");

  foreach(volume in volumes) {
    if(ispointinvolume(_id_DF071553D0996FF9.origin, volume)) {
      if(isDefined(volume.basename))
        return volume.basename;
    }
  }

  return undefined;
}

get_adjacent_volumes_from_volume() {
  if(isDefined(level.adjacent_volumes[self.basename])) {
    _id_055F75D9F16D814F = [];

    foreach(_id_34950A0EAD955410 in level.adjacent_volumes[self.basename])
    _id_055F75D9F16D814F[_id_055F75D9F16D814F.size] = level.spawn_volume_names[_id_34950A0EAD955410];

    return _id_055F75D9F16D814F;
  }

  return [];
}

is_in_adjacent_volume(volume) {
  if(!isDefined(volume))
    return 0;

  if(!isDefined(volume.adjacent_volumes))
    return 0;

  foreach(vol in volume.adjacent_volumes) {
    if(!vol.active) {
      continue;
    }
    if(self istouching(vol))
      return 1;
  }

  return 0;
}

release_interaction_ent(player) {
  player waittill("disconnect");
  self.in_use = 0;
  self notify("interaction_ent_released");
}

assign_trigger_on_player_spawned() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", player);
    player.interaction_trigger = player get_player_interaction_trigger();

    if(!isDefined(player.interaction_trigger))
      iprintlnbold("NO TRIGGER FOUND!");

    reset_interaction_triggers();
    player.last_interaction_point = undefined;
    player.interaction_trigger makeunusable();
    player thread release_player_interaction_trigger();
    player thread player_interaction_monitor();
    player thread player_interaction_weapon_switch_monitor();
  }
}

player_interaction_weapon_switch_monitor() {
  self endon("disconnect");
  self endon("death");

  for(;;) {
    scripts\engine\utility::waittill_any_3("weapon_switch_started", "weapon_change", "weaponchange");
    self.last_interaction_point = undefined;
    self.resetguidedinteraction = 1;
    self notify("stop_interaction_logic");
  }
}

get_player_interaction_trigger() {
  if(isDefined(self.interaction_trigger))
    return self.interaction_trigger;
  else {
    interaction_trigger = spawn("script_model", (0, 0, 0));
    interaction_trigger setModel("tag_origin");
    interaction_trigger.in_use = 1;
    interaction_trigger thread scripts\cp\utility::deleteonplayerdeathdisconnect(self);
    return interaction_trigger;
  }
}

release_player_interaction_trigger() {
  trigger = self.interaction_trigger;
  scripts\engine\utility::waittill_any_2("death", "disconnect");
  trigger.in_use = 0;
}

registerinteraction(script_noteworthy, hint_func, activation_func, init_func, _id_AD96AC0EC299E386, suseduration, _id_5A9D289A0E9AC2D8) {
  _id_71332A5B74214116::registerinteraction(script_noteworthy, hint_func, activation_func, init_func, _id_AD96AC0EC299E386, suseduration, _id_5A9D289A0E9AC2D8);
}

add_interaction_structs_to_interaction_arrays(_id_70DAB3207FB65169) {
  level.current_interaction_structs = scripts\engine\utility::array_combine(level.current_interaction_structs, _id_70DAB3207FB65169);
  level.current_interaction_structs = scripts\engine\utility::array_remove_duplicates(level.current_interaction_structs);
}

interactionhasactivation(_id_DF071553D0996FF9) {
  return istrue(level.interactions[_id_DF071553D0996FF9.script_noteworthy].noactivation);
}

register_interaction(script_noteworthy, spend_type, tutorial, hint_func, activation_func, _id_CA8CDB622A3BCECB, requires_power, init_func, can_use_override_func, _id_AD96AC0EC299E386, suseduration) {
  _id_71332A5B74214116::registerinteraction(script_noteworthy, hint_func, activation_func, init_func, _id_AD96AC0EC299E386, suseduration);
}

reset_interaction_triggers() {
  foreach(player in level.players) {
    if(isDefined(player.interaction_trigger))
      hide_interaction_trigger_from_others(player);
  }
}

hide_interaction_trigger_from_others(_id_59805FF5786C34AD) {
  foreach(player in level.players) {
    if(player == _id_59805FF5786C34AD) {
      _id_59805FF5786C34AD.interaction_trigger enableplayeruse(_id_59805FF5786C34AD);
      continue;
    }

    _id_59805FF5786C34AD.interaction_trigger disableplayeruse(player);
  }
}

wherethehellami(player, trigger) {
  for(;;) {
    thread scripts\engine\utility::draw_capsule(trigger.origin, 12, 12, trigger.angles, (1, 1, 0), 0, 1);
    wait 0.05;
  }
}

no_previous_interaction_point() {
  return isDefined(self.last_interaction_point);
}

interaction_point_has_changed(_id_AC3DC6CF8564E576) {
  return self.last_interaction_point != _id_AC3DC6CF8564E576;
}

player_interaction_monitor() {
  self notify("player_interaction_monitor");
  self endon("player_interaction_monitor");
  self endon("disconnect");
  self endon("death");

  if(scripts\engine\utility::flag_exist("init_interaction_done"))
    scripts\engine\utility::flag_wait("init_interaction_done");
  else {
    while(!isDefined(level.current_interaction_structs))
      wait 1;
  }

  if(isDefined(level.player_interaction_monitor))
    self thread[[level.player_interaction_monitor]]();
}

flash_inventory() {
  self endon("window_trap_placed");
  self endon("death");

  if(!isDefined(self.next_inventory_flash))
    self.next_inventory_flash = gettime() + 2500;
  else if(gettime() < self.next_inventory_flash) {
    return;
  }
  self.next_inventory_flash = gettime() + 2500;
  wait 1.5;
}

can_use_interaction(_id_AC3DC6CF8564E576) {
  if(!isDefined(_id_AC3DC6CF8564E576))
    return 0;

  if(istrue(self.iscarrying))
    return 0;

  if(istrue(_id_AC3DC6CF8564E576.disabled) || !scripts\cp\utility::areinteractionsenabled())
    return 0;

  if(istrue(_id_AC3DC6CF8564E576.awaitingpent))
    return 0;

  if(self secondaryoffhandbuttonPressed() || self isthrowinggrenade() || self fragButtonPressed())
    return 0;

  if(!self isonground())
    return 0;

  if(!isDefined(_id_AC3DC6CF8564E576.script_noteworthy)) {
    thread debugremoveinteractionandsendmessage(_id_AC3DC6CF8564E576, "interaction_struct Struct at: " + _id_AC3DC6CF8564E576.origin + " does not have a .script_noteworthy defined.");
    return 0;
  }

  if(!isDefined(level.interactions[_id_AC3DC6CF8564E576.script_noteworthy])) {
    thread debugremoveinteractionandsendmessage(_id_AC3DC6CF8564E576, "interaction_struct Struct at: " + _id_AC3DC6CF8564E576.origin + " with .script_noteworthy: " + _id_AC3DC6CF8564E576.script_noteworthy + " has not been registered as an interaction_struct");
    return 0;
  }

  return 1;
}

debugremoveinteractionandsendmessage(_id_DF071553D0996FF9, message) {}

reset_interaction() {
  self endon("disconnect");
  wait 0.2;
  self.interaction_trigger makeunusable();
  self.last_interaction_point = undefined;
}

set_interaction_point(_id_AC3DC6CF8564E576, _id_9883D93111FD5AB9) {
  if(istrue(self.interaction_trigger.disableinteraction)) {
    return;
  }
  self notify("set_interaction_point");
  self.interaction_trigger dontinterpolate();
  self.last_interaction_point = _id_AC3DC6CF8564E576;
  _id_C2F4EC03C9EC610E = self getEye();
  self.interaction_trigger.origin = (_id_AC3DC6CF8564E576.origin[0], _id_AC3DC6CF8564E576.origin[1], _id_C2F4EC03C9EC610E[2]);

  if(interactionhasactivation(_id_AC3DC6CF8564E576)) {
    level thread[[level.interactions[_id_AC3DC6CF8564E576.script_noteworthy].activation_func]](_id_AC3DC6CF8564E576, self);
    return;
  }

  if(!isDefined(level.interactions[_id_AC3DC6CF8564E576.script_noteworthy].spend_type))
    level.interactions[_id_AC3DC6CF8564E576.script_noteworthy].spend_type = "null";

  spend_type = level.interactions[_id_AC3DC6CF8564E576.script_noteworthy].spend_type;
  _id_8F8B25936FAE5C37 = undefined;
  self.interaction_trigger makeusable();

  if(interaction_is_weapon_buy(_id_AC3DC6CF8564E576)) {
    if(!_id_74502A9E0EF1F19C::has_weapon_variation(_id_AC3DC6CF8564E576.script_noteworthy)) {
      _id_8881DC0ED6701CDF = getweaponnamestring(_id_AC3DC6CF8564E576.script_noteworthy);
      _id_4AB7947CF9474481 = getweaponcostint(_id_AC3DC6CF8564E576.script_noteworthy);
      self.interaction_trigger sethintstringparams(_id_8881DC0ED6701CDF, _id_4AB7947CF9474481);
    }
  } else if(interaction_is_floor_is_lava_client(_id_AC3DC6CF8564E576)) {
    _id_DC4F149F969D05AF = strtok(_id_AC3DC6CF8564E576.name, "_");
    num = int(_id_DC4F149F969D05AF[1]);
    self.interaction_trigger sethintstringparams(num);
  } else if(interaction_is_jugg_maze_button(_id_AC3DC6CF8564E576)) {
    a = getjuggmazebutton(_id_AC3DC6CF8564E576.script_label);

    switch (_id_AC3DC6CF8564E576.script_noteworthy) {
      case "seq_button":
        self.interaction_trigger sethintstringparams(a);
        break;
    }
  } else if(interaction_is_chess_piece(_id_AC3DC6CF8564E576)) {
    a = getalphabetstring(level.currentalphanumericcode[0]);
    b = getalphabetstring(level.currentalphanumericcode[1]);
    c = getnumberstring(level.currentalphanumericcode[2]);

    switch (_id_AC3DC6CF8564E576.script_noteworthy) {
      case "chess_piece_selection":
        self.interaction_trigger sethintstringparams(a);
        break;
      case "chess_puzzle_alphabet":
        self.interaction_trigger sethintstringparams(b);
        break;
      case "chess_puzzle_number":
        self.interaction_trigger sethintstringparams(c);
        break;
    }
  } else if(interaction_is_weapon_pickup(_id_AC3DC6CF8564E576))
    set_weapon_interaction_string(_id_AC3DC6CF8564E576, self);
  else if(interaction_is_trap(_id_AC3DC6CF8564E576))
    self.interaction_trigger.origin = (_id_AC3DC6CF8564E576.origin[0], _id_AC3DC6CF8564E576.origin[1], _id_C2F4EC03C9EC610E[2] - 15);

  set_interaction_trigger_properties(self.interaction_trigger, _id_AC3DC6CF8564E576);

  if(!isDefined(_id_AC3DC6CF8564E576.suseduration))
    _id_AC3DC6CF8564E576.suseduration = "duration_none";

  if(!isDefined(_id_9883D93111FD5AB9))
    thread wait_for_interaction_triggered(_id_AC3DC6CF8564E576);
}

getjuggmazebutton(_id_8A4FC1DC1FD4995E) {
  if(getdvarint("dvar_176FA03E6DA10955", 0) != 0) {
    switch (_id_8A4FC1DC1FD4995E) {
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

  if(getdvarint("dvar_DA6B87817DB1CBA0", 0) != 0) {
    switch (_id_8A4FC1DC1FD4995E) {
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

  switch (_id_8A4FC1DC1FD4995E) {
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

getalphabetstring(_id_8A4FC1DC1FD4995E) {
  switch (_id_8A4FC1DC1FD4995E) {
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

getnumberstring(number) {
  switch (number) {
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

set_weapon_interaction_string(_id_AC3DC6CF8564E576, player) {
  _id_96F1780C385B8C4F = get_weapon_name_string(_id_AC3DC6CF8564E576);
  self.interaction_trigger sethintstringparams(_id_96F1780C385B8C4F);
}

get_weapon_name_string(_id_AC3DC6CF8564E576) {
  switch (_id_AC3DC6CF8564E576.name) {
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

getweaponnamestring(weaponname) {
  if(!isDefined(weaponname))
    return undefined;

  base_weapon = scripts\cp\utility::getbaseweaponname(weaponname);

  if(!isDefined(base_weapon))
    return undefined;

  switch (base_weapon) {
    default:
      if(isDefined(level.custom_weaponnamestring_func)) {
        return [[level.custom_weaponnamestring_func]](base_weapon, weaponname);
        return;
      }

      return &"CP_ZMB_WEAPONS/GENERIC";
      return;
  }
}

getweaponcostint(weaponname) {
  return int(level.interactions[weaponname].cost);
}

set_interaction_trigger_properties(interaction_trigger, _id_DF071553D0996FF9) {
  hintstring = get_interaction_hintstring(_id_DF071553D0996FF9, self);

  if(isDefined(hintstring))
    self.interaction_trigger setHintString(hintstring);

  if(interaction_is_weapon_buy(_id_DF071553D0996FF9)) {
    if(isDefined(hintstring) && !isstring(hintstring) && hintstring == &"COOP_INTERACTIONS/PURCHASE_AMMO") {
      _id_9211CDAADB7BCA55 = scripts\cp\utility::getrawbaseweaponname(_id_DF071553D0996FF9.script_noteworthy);
      _id_E66E40F52978E295 = _id_74502A9E0EF1F19C::get_weapon_level(_id_9211CDAADB7BCA55);
      _id_8881DC0ED6701CDF = getweaponnamestring(_id_DF071553D0996FF9.script_noteworthy);

      if(_id_E66E40F52978E295 > 1)
        self.interaction_trigger sethintstringparams(int(4500), _id_8881DC0ED6701CDF);
      else
        self.interaction_trigger sethintstringparams(int(0.5 * level.interactions[_id_DF071553D0996FF9.script_noteworthy].cost), _id_8881DC0ED6701CDF);
    }
  } else
    self.interaction_trigger setusefov(160);

  self.interaction_trigger setusepriority(1);

  if(isDefined(level._id_A30BD62E41E58A08) && isDefined(level._id_A30BD62E41E58A08[_id_DF071553D0996FF9.script_noteworthy]))
    [[level._id_A30BD62E41E58A08[_id_DF071553D0996FF9.script_noteworthy]]](interaction_trigger, _id_DF071553D0996FF9, hintstring);
  else if(isDefined(level.interaction_trigger_properties_func))
    [[level.interaction_trigger_properties_func]](interaction_trigger, _id_DF071553D0996FF9, hintstring);
}

get_interaction_hintstring(_id_DF071553D0996FF9, player) {
  if(isDefined(level.interactions[_id_DF071553D0996FF9.script_noteworthy].hint_func))
    return [[level.interactions[_id_DF071553D0996FF9.script_noteworthy].hint_func]](_id_DF071553D0996FF9, player);

  if(isDefined(_id_DF071553D0996FF9.cooling_down))
    return &"COOP_INTERACTIONS/COOLDOWN";

  if(istrue(_id_DF071553D0996FF9.requires_power) && !istrue(_id_DF071553D0996FF9.powered_on))
    return &"COOP_INTERACTIONS/REQUIRES_POWER";

  if(interaction_is_weapon_buy(_id_DF071553D0996FF9)) {
    if(!scripts\cp\utility::coop_mode_has("wall_buys"))
      return undefined;
  }

  if(!isDefined(level.interaction_hintstrings[_id_DF071553D0996FF9.script_noteworthy]))
    return "";

  return level.interaction_hintstrings[_id_DF071553D0996FF9.script_noteworthy];
}

wait_for_interaction_triggered(_id_DF071553D0996FF9) {
  if(isDefined(level.wait_for_interaction_func))
    self thread[[level.wait_for_interaction_func]](_id_DF071553D0996FF9);
}

play_weapon_purchase_vo(_id_DF071553D0996FF9, player) {
  item = _id_DF071553D0996FF9.script_noteworthy;
  base_weapon = getweaponbasename(item);

  switch (base_weapon) {
    default:
      break;
  }
}

can_purchase_ammo(_id_D4DF17A1168AC8E2) {
  weapons = self getweaponslistall();
  _id_C53C17F2D86BCA58 = undefined;
  _id_9211CDAADB7BCA55 = undefined;
  _id_FBC51CC04B895926 = scripts\cp\utility::getrawbaseweaponname(_id_D4DF17A1168AC8E2);

  foreach(weapon in weapons) {
    _id_9211CDAADB7BCA55 = scripts\cp\utility::getrawbaseweaponname(weapon);

    if(_id_9211CDAADB7BCA55 == _id_FBC51CC04B895926) {
      _id_C53C17F2D86BCA58 = weapon;
      break;
    }
  }

  if(isDefined(_id_C53C17F2D86BCA58)) {
    _id_0DE8A9EAD75A0581 = self getweaponammostock(_id_C53C17F2D86BCA58);
    _id_8529009219E1AD48 = weaponmaxammo(_id_C53C17F2D86BCA58);
    _id_629F6083F99F1D29 = scripts\cp\perks\cp_prestige::prestige_getminammo();
    _id_DB6891EE5A14D7AA = int(_id_629F6083F99F1D29 * _id_8529009219E1AD48);

    if(_id_0DE8A9EAD75A0581 < _id_DB6891EE5A14D7AA)
      return 1;
    else if(weaponmaxammo(_id_C53C17F2D86BCA58) == weaponclipsize(_id_C53C17F2D86BCA58) && self getweaponammoclip(_id_C53C17F2D86BCA58) < weaponclipsize(_id_C53C17F2D86BCA58))
      return 1;
    else
      return 0;
  }

  return 1;
}

interaction_post_activate_delay(_id_DF071553D0996FF9) {
  self endon("disconnect");

  if(interaction_is_button_mash(_id_DF071553D0996FF9)) {
    return;
  }
  if(interaction_is_door_buy(_id_DF071553D0996FF9)) {
    return;
  }
  if(interaction_is_atm(_id_DF071553D0996FF9)) {
    return;
  }
  if(interaction_is_chess_piece(_id_DF071553D0996FF9)) {
    return;
  }
  _id_3B64EB40368C1450::set("post_activate_delay", "interactions", 0);
  wait 1.5;
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("post_activate_delay");
}

delayed_trigger_unset() {
  wait 0.25;
  self.triggered = undefined;
}

addtointeractionslistbynoteworthy(noteworthy) {
  _id_A28CB3EB323DB0AE = scripts\engine\utility::getStructArray(noteworthy, "script_noteworthy");

  foreach(_id_DF071553D0996FF9 in _id_A28CB3EB323DB0AE)
  add_to_current_interaction_list(_id_DF071553D0996FF9);
}

removefrominteractionslistbynoteworthy(noteworthy) {
  _id_A28CB3EB323DB0AE = scripts\engine\utility::getStructArray(noteworthy, "script_noteworthy");

  foreach(_id_DF071553D0996FF9 in _id_A28CB3EB323DB0AE)
  remove_from_current_interaction_list(_id_DF071553D0996FF9);
}

remove_from_current_interaction_list(_id_DF071553D0996FF9) {
  _id_DF071553D0996FF9 notify("remove_from_current_interaction_list");
  _id_DF071553D0996FF9.in_array = 0;

  if(scripts\engine\utility::array_contains(level.current_interaction_structs, _id_DF071553D0996FF9))
    level.current_interaction_structs = scripts\engine\utility::array_remove(level.current_interaction_structs, _id_DF071553D0996FF9);

  scripts\cp\coop_personal_ents::update_special_mode_for_all_players();
}

add_to_current_interaction_list(_id_DF071553D0996FF9) {
  _id_DF071553D0996FF9 notify("add_to_current_interaction_list");
  _id_DF071553D0996FF9.in_array = 1;

  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, _id_DF071553D0996FF9))
    level.current_interaction_structs = scripts\engine\utility::array_add(level.current_interaction_structs, _id_DF071553D0996FF9);

  scripts\cp\coop_personal_ents::update_special_mode_for_all_players();
}

remove_from_current_interaction_list_for_player(_id_DF071553D0996FF9, player) {
  _id_DF071553D0996FF9 notify("remove_from_current_interaction_list_for_player_" + player.name);

  if(!scripts\engine\utility::array_contains(player.disabled_interactions, _id_DF071553D0996FF9))
    player.disabled_interactions = scripts\engine\utility::array_add(player.disabled_interactions, _id_DF071553D0996FF9);

  scripts\cp\coop_personal_ents::update_special_mode_for_player(player);
}

add_to_current_interaction_list_for_player(_id_DF071553D0996FF9, player) {
  _id_DF071553D0996FF9 notify("add_to_current_interaction_list_for_player_" + player.name);

  if(scripts\engine\utility::array_contains(player.disabled_interactions, _id_DF071553D0996FF9))
    player.disabled_interactions = scripts\engine\utility::array_remove(player.disabled_interactions, _id_DF071553D0996FF9);

  scripts\cp\coop_personal_ents::update_special_mode_for_player(player);
}

can_purchase_interaction(_id_DF071553D0996FF9, amount, spend_type, weapon) {
  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, _id_DF071553D0996FF9))
    return 0;

  if(scripts\cp\utility::isnmlactive())
    return 1;

  if(isDefined(_id_DF071553D0996FF9.script_location) && _id_DF071553D0996FF9.script_location == "afterlife")
    return 1;

  if(isDefined(amount))
    cost = amount;
  else
    cost = level.interactions[_id_DF071553D0996FF9.script_noteworthy].cost;

  if(interaction_is_weapon_buy(_id_DF071553D0996FF9)) {
    _id_895FA4B47E915C65 = _id_DF071553D0996FF9.script_noteworthy;

    if(_id_DF071553D0996FF9.script_parameters == "tickets") {
      if(self hasweapon(_id_895FA4B47E915C65))
        return 0;

      self.itempicked = _id_DF071553D0996FF9.script_noteworthy;
      level.transactionid = randomint(100);
    }

    _id_8529009219E1AD48 = weaponmaxammo(_id_DF071553D0996FF9.script_noteworthy);
    _id_629F6083F99F1D29 = scripts\cp\perks\cp_prestige::prestige_getminammo();
    _id_DB6891EE5A14D7AA = int(_id_629F6083F99F1D29 * _id_8529009219E1AD48);
    _id_0DE8A9EAD75A0581 = self getweaponammostock(_id_895FA4B47E915C65);

    if(_id_0DE8A9EAD75A0581 >= _id_DB6891EE5A14D7AA)
      return 0;
  }

  if(scripts\cp\cp_persistence::player_has_enough_currency(cost, spend_type))
    return 1;

  return 0;
}

interaction_get_cost() {
  if(isDefined(self.cost))
    return int(self.cost);
  else
    return 0;
}

take_player_money(cost, _id_E42F7EB456B932F2) {
  if(scripts\cp\utility::isnmlactive()) {
    return;
  }
  scripts\cp\cp_persistence::take_player_currency(cost, 1, _id_E42F7EB456B932F2);
}

should_interaction_fill_consumable_meter(_id_E42F7EB456B932F2) {
  if(!isDefined(_id_E42F7EB456B932F2)) {}

  switch (_id_E42F7EB456B932F2) {
    case "wondercard_machine":
    case "atm":
    case "bleedoutPenalty":
      return 0;
    default:
      return 1;
  }
}

getammopurchasestring(_id_DF071553D0996FF9, player) {
  cost = level.interactions[_id_DF071553D0996FF9.script_noteworthy].cost;
  base_weapon = scripts\cp\utility::getrawbaseweaponname(_id_DF071553D0996FF9.script_noteworthy);
  currentweapon = player getcurrentweapon();
  _id_8529009219E1AD48 = weaponmaxammo(currentweapon);
  _id_629F6083F99F1D29 = player scripts\cp\perks\cp_prestige::prestige_getminammo();
  _id_DB6891EE5A14D7AA = int(_id_629F6083F99F1D29 * _id_8529009219E1AD48);
  _id_0DE8A9EAD75A0581 = player getweaponammostock(currentweapon);
  weapons = self getweaponslistall();

  foreach(weapon in weapons) {
    _id_9211CDAADB7BCA55 = scripts\cp\utility::getrawbaseweaponname(weapon);

    if(_id_9211CDAADB7BCA55 == scripts\cp\utility::getrawbaseweaponname(_id_DF071553D0996FF9.script_noteworthy)) {
      _id_3626CCBDF1758532 = weapon;
      _id_0DE8A9EAD75A0581 = self getweaponammostock(_id_3626CCBDF1758532);
      _id_8529009219E1AD48 = weaponmaxammo(_id_3626CCBDF1758532);
      _id_DB6891EE5A14D7AA = int(_id_629F6083F99F1D29 * _id_8529009219E1AD48);
    }
  }

  if(_id_DF071553D0996FF9.script_parameters == "tickets")
    return level.interaction_hintstrings[_id_DF071553D0996FF9.script_noteworthy];

  switch (cost) {
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

default_weapon_hint_func(_id_DF071553D0996FF9, player) {
  if(player _id_74502A9E0EF1F19C::has_weapon_variation(_id_DF071553D0996FF9.script_noteworthy))
    return getammopurchasestring(_id_DF071553D0996FF9, player);

  return undefined;
}

interaction_sound_monitor() {
  level endon("game_ended");

  for(;;) {
    level waittill("interaction", _id_F4DE912991CD9448, _id_DF071553D0996FF9, player);

    switch (_id_F4DE912991CD9448) {
      case "wall_buy":
        if(isDefined(player.purchasing_ammo)) {
          if(soundexists("purchase_ammo"))
            player scripts\cp\utility::playlocalsound_safe("purchase_ammo");
        } else if(soundexists("purchase_weapon"))
          player scripts\cp\utility::playlocalsound_safe("purchase_weapon");

        break;
      case "purchase":
        sound = get_interaction_sound(_id_DF071553D0996FF9, player);

        if(isDefined(sound) && soundexists(sound))
          player scripts\cp\utility::playlocalsound_safe(sound);

        break;
      case "purchase_denied":
        player scripts\cp\utility::playlocalsound_safe("cp_computer_fail");
        break;
    }
  }
}

get_interaction_sound(_id_DF071553D0996FF9, player) {
  _id_F6F217EA2AA761F9 = [];

  switch (_id_DF071553D0996FF9.script_noteworthy) {
    case "secure_window":
      return undefined;
    case "lost_and_found":
      _id_F6F217EA2AA761F9 = ["lost_and_found_purchase"];
      break;
    case "blackhole_trap":
    case "scrambler":
    case "interaction_discoballtrap":
    case "beamtrap":
    case "rockettrap":
      _id_F6F217EA2AA761F9 = ["trap_control_panel_purchase"];
      break;
    case "sliding_door":
    case "debris":
      _id_F6F217EA2AA761F9 = ["purchase_door"];
      break;
    case "team_door_switch":
      _id_F6F217EA2AA761F9 = ["purchase_door"];
      break;
    case "atm_deposit":
      _id_F6F217EA2AA761F9 = ["atm_deposit"];
      break;
    case "atm_withdrawal":
      _id_F6F217EA2AA761F9 = ["atm_withdrawal"];
      break;
    case "repair_kevin":
    case "souvenir_pickup":
    case "kevin_battery":
    case "kevin_head":
      _id_F6F217EA2AA761F9 = ["zmb_item_pickup"];
      break;
    case "medium_ticket_prize":
    case "small_ticket_prize":
    case "iw7_forgefreeze_zm+forgefreezealtfire":
    case "zfreeze_semtex_mp":
      _id_F6F217EA2AA761F9 = ["purchase_ticket"];
      break;
    case "large_ticket_prize":
      _id_F6F217EA2AA761F9 = ["ark_purchase"];
      break;
    case "ark_quest_station":
      _id_F6F217EA2AA761F9 = ["ark_turn_in"];
      break;
    default:
      _id_F6F217EA2AA761F9 = ["ark_turn_in"];
      break;
  }

  if(!_id_F6F217EA2AA761F9.size)
    return undefined;

  return scripts\engine\utility::random(_id_F6F217EA2AA761F9);
}

interaction_post_activate_update(_id_DF071553D0996FF9) {
  if(!isDefined(_id_DF071553D0996FF9.post_activate_update)) {
    return;
  }
  if(isDefined(level.interaction_post_activate_update_func)) {
    level thread[[level.interaction_post_activate_update_func]](_id_DF071553D0996FF9, self);
    return;
  }
}

interaction_is_trap(_id_DF071553D0996FF9) {
  return _id_DF071553D0996FF9.script_noteworthy == "trap_electric" || _id_DF071553D0996FF9.script_noteworthy == "trap_firebarrel";
}

interaction_is_atm(_id_DF071553D0996FF9) {
  return _id_DF071553D0996FF9.script_noteworthy == "atm_withdrawal" || _id_DF071553D0996FF9.script_noteworthy == "atm_deposit";
}

interaction_is_window_entrance(_id_DF071553D0996FF9) {
  return _id_DF071553D0996FF9.script_noteworthy == "secure_window";
}

interaction_is_crafting_station(_id_DF071553D0996FF9) {
  return _id_DF071553D0996FF9.script_noteworthy == "crafting_station";
}

interaction_is_grenade_wall_buy(_id_DF071553D0996FF9) {
  return _id_DF071553D0996FF9.script_noteworthy == "power_bioSpike" || _id_DF071553D0996FF9.script_noteworthy == "power_c4";
}

interaction_is_weapon_pickup(_id_DF071553D0996FF9) {
  return _id_DF071553D0996FF9.script_noteworthy == "weaponPickup";
}

interaction_is_fortune_teller(_id_DF071553D0996FF9) {
  return _id_DF071553D0996FF9.script_noteworthy == "jaroslav_machine";
}

interaction_is_perk(_id_DF071553D0996FF9) {
  return isDefined(_id_DF071553D0996FF9.perk_type);
}

interaction_waiting_on_power(_id_DF071553D0996FF9) {
  return istrue(_id_DF071553D0996FF9.requires_power) && !_id_DF071553D0996FF9.powered_on;
}

interaction_is_valid(_id_DF071553D0996FF9, player) {
  if(isDefined(_id_DF071553D0996FF9.triggered))
    return 0;

  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, _id_DF071553D0996FF9))
    return 0;

  if(istrue(_id_DF071553D0996FF9.out_of_order)) {
    level notify("player_accessed_interaction_on_cooldown", player);
    return 0;
  }

  if(istrue(_id_DF071553D0996FF9.in_use))
    return 0;

  if(interaction_waiting_on_power(_id_DF071553D0996FF9)) {
    level notify("player_accessed_nonpowered_interaction", player);

    if(isDefined(_id_DF071553D0996FF9.perk_type) && soundexists("perk_machine_deny"))
      player playlocalsound("perk_machine_deny");
    else
      player playlocalsound("purchase_deny");

    return 0;
  }

  if(isDefined(_id_DF071553D0996FF9.cooling_down)) {
    level notify("player_accessed_interaction_on_cooldown", player);
    return 0;
  }

  if(scripts\engine\utility::array_contains(player.disabled_interactions, _id_DF071553D0996FF9))
    return 0;

  return 1;
}

interaction_is_floor_is_lava_client(_id_DF071553D0996FF9) {
  return _id_DF071553D0996FF9.script_noteworthy == "sequence_interaction";
}

interaction_is_jugg_maze_button(_id_DF071553D0996FF9) {
  return _id_DF071553D0996FF9.script_noteworthy == "seq_button";
}

interaction_is_chess_piece(_id_DF071553D0996FF9) {
  return _id_DF071553D0996FF9.script_noteworthy == "chess_piece_selection" || _id_DF071553D0996FF9.script_noteworthy == "chess_puzzle_alphabet" || _id_DF071553D0996FF9.script_noteworthy == "chess_puzzle_number";
}

interaction_is_weapon_upgrade(_id_DF071553D0996FF9) {
  return _id_DF071553D0996FF9.script_noteworthy == "weapon_upgrade";
}

interaction_is_weapon_buy(_id_DF071553D0996FF9) {
  if(isDefined(_id_DF071553D0996FF9.name))
    return _id_DF071553D0996FF9.name == "wall_buy";
  else
    return 0;
}

interaction_is_button_mash(_id_DF071553D0996FF9) {
  return isDefined(_id_DF071553D0996FF9.isbuttonmash) && _id_DF071553D0996FF9.isbuttonmash;
}

interaction_is_door_buy(_id_DF071553D0996FF9) {
  return _id_DF071553D0996FF9.script_noteworthy == "debris_350" || _id_DF071553D0996FF9.script_noteworthy == "debris_750" || _id_DF071553D0996FF9.script_noteworthy == "debris_1000" || _id_DF071553D0996FF9.script_noteworthy == "debris_1250" || _id_DF071553D0996FF9.script_noteworthy == "debris_1500" || _id_DF071553D0996FF9.script_noteworthy == "debris_2000" || _id_DF071553D0996FF9.script_noteworthy == "1v1_stairway_door" || _id_DF071553D0996FF9.script_noteworthy == "1v1_exit_door" || _id_DF071553D0996FF9.script_noteworthy == "team_door_switch" || _id_DF071553D0996FF9.script_noteworthy == "team_door";
}

interaction_is_special_door_buy(_id_DF071553D0996FF9) {
  return _id_DF071553D0996FF9.script_noteworthy == "power_door_sliding" || _id_DF071553D0996FF9.script_noteworthy == "team_door_switch" || _id_DF071553D0996FF9.script_noteworthy == "1v1_stairway_door" || _id_DF071553D0996FF9.script_noteworthy == "1v1_exit_door" || _id_DF071553D0996FF9.script_noteworthy == "team_door";
}

interaction_is_chi_door(_id_DF071553D0996FF9) {
  return _id_DF071553D0996FF9.script_noteworthy == "chi_0" || _id_DF071553D0996FF9.script_noteworthy == "chi_1" || _id_DF071553D0996FF9.script_noteworthy == "chi_2";
}

interaction_is_ticket_buy(_id_DF071553D0996FF9) {
  return _id_DF071553D0996FF9.script_noteworthy == "small_ticket_prize" || _id_DF071553D0996FF9.script_noteworthy == "medium_ticket_prize" || _id_DF071553D0996FF9.script_noteworthy == "arcade_counter_grenade" || _id_DF071553D0996FF9.script_noteworthy == "arcade_counter_ammo" || _id_DF071553D0996FF9.script_noteworthy == "large_ticket_prize" || _id_DF071553D0996FF9.script_noteworthy == "zfreeze_semtex_mp" || _id_DF071553D0996FF9.script_noteworthy == "iw7_forgefreeze_zm+forgefreezealtfire" || _id_DF071553D0996FF9.script_noteworthy == "gold_teeth";
}

can_use_perk(_id_DF071553D0996FF9) {
  if(scripts\cp\utility::has_zombie_perk(_id_DF071553D0996FF9.perk_type))
    return 0;
  else if(self.self_revives_purchased >= self.max_self_revive_machine_use && _id_DF071553D0996FF9.perk_type == "perk_machine_revive")
    return 0;
  else if(isDefined(self.zombies_perks) && self.zombies_perks.size > 4)
    return 0;

  return 1;
}

interaction_show_fail_reason(_id_DF071553D0996FF9, _id_99D7CBC0F2079DA7, _id_EDFE2FDDCB8449A1, _id_1E59F2DCD3B86D22) {
  thread interaction_fail_internal(_id_DF071553D0996FF9, _id_99D7CBC0F2079DA7, _id_EDFE2FDDCB8449A1, _id_1E59F2DCD3B86D22);
}

interaction_fail_internal(_id_DF071553D0996FF9, _id_99D7CBC0F2079DA7, _id_EDFE2FDDCB8449A1, _id_1E59F2DCD3B86D22) {
  self endon("disconnect");
  level notify("interaction", "purchase_denied", level.interactions[_id_DF071553D0996FF9.script_noteworthy], self);
  self.delay_hint = 1;
  self.interaction_trigger setHintString(_id_99D7CBC0F2079DA7);
  wait 1;
  self.delay_hint = undefined;
  set_interaction_trigger_properties(self.interaction_trigger, _id_DF071553D0996FF9);
}

interaction_cooldown(_id_DF071553D0996FF9, time) {
  interactions = scripts\engine\utility::getStructArray(_id_DF071553D0996FF9.script_noteworthy, "script_noteworthy");

  foreach(struct in interactions) {
    if(struct.target == _id_DF071553D0996FF9.target)
      struct.cooling_down = 1;
  }

  if(istrue(level.cooldown_override))
    wait 1;
  else
    level scripts\engine\utility::waittill_any_timeout_1(time, "override_cooldowns");

  foreach(struct in interactions) {
    if(struct.target == _id_DF071553D0996FF9.target)
      struct.cooling_down = undefined;
  }

  _id_D43D6364668556C7 = 5184;

  foreach(player in level.players) {
    foreach(struct in interactions) {
      if(distancesquared(player.origin, struct.origin) >= _id_D43D6364668556C7) {
        continue;
      }
      player refresh_interaction();
    }
  }
}

refresh_interaction() {
  self notify("stop_interaction_logic");
  self.last_interaction_point = undefined;

  if(isDefined(self.interaction_trigger))
    self.interaction_trigger setHintString("");
}

disable_wall_buy_interactions() {
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("interaction", "targetname");

  foreach(struct in _id_9E4E1482CB40C9C5) {
    if(interaction_is_weapon_buy(struct) || interaction_is_grenade_wall_buy(struct) || interaction_is_ticket_buy(struct) || isDefined(struct.script_parameters) && struct.script_parameters == "tickets") {
      struct.disabled = 1;
      continue;
    }
  }
}

spawninteractionmodel(_id_DF071553D0996FF9, _id_E0D9D2880C046704) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");

  if(isDefined(_id_DF071553D0996FF9.script_modelname)) {
    model = spawn("script_model", _id_E0D9D2880C046704.origin);

    if(isDefined(_id_E0D9D2880C046704.angles))
      model.angles = _id_E0D9D2880C046704.angles;

    model setModel(_id_DF071553D0996FF9.script_modelname);

    if(isDefined(_id_DF071553D0996FF9.targetmodels))
      _id_DF071553D0996FF9.targetmodels[_id_DF071553D0996FF9.targetmodels.size] = model;
  }
}

move_to_closest_interaction(player) {
  level endon("game_ended");
  player endon("disconnect");
  _id_43E0B9317508501B = undefined;
  _id_47293B1E94FF8FB0 = undefined;
  _id_5C9DDCF56D36F133 = -1;
  _id_3414E5C0A9919716 = 0;
  _id_6A625DF0D00319BB = squared(75);

  for(;;) {
    if(istrue(player.inlaststand) || istrue(player.siege_activated) || istrue(player.flung)) {
      _id_43E0B9317508501B = undefined;
      update_struct_information(player, -1, undefined, undefined);
    } else if(!player scripts\cp\utility::areinteractionsenabled()) {
      _id_43E0B9317508501B = undefined;
      update_struct_information(player, -1, undefined, undefined);
    } else {
      _id_936A8CB7AB047D5F = [];
      level.current_interaction_structs = scripts\engine\utility::array_removeundefined(level.current_interaction_structs);
      _id_D5B8724607C37B52 = scripts\engine\utility::get_array_of_closest(player.origin, level.current_interaction_structs, undefined, 10, 750, 1);

      foreach(item in player.disabled_interactions)
      _id_D5B8724607C37B52 = scripts\engine\utility::array_remove(_id_D5B8724607C37B52, item);

      foreach(item in _id_D5B8724607C37B52) {
        if(is_permitted_guided_interaction(player, item, _id_43E0B9317508501B))
          _id_936A8CB7AB047D5F[_id_936A8CB7AB047D5F.size] = item;
      }

      if(istrue(player.resetguidedinteraction)) {
        _id_43E0B9317508501B = undefined;
        update_struct_information(player, -1, undefined, undefined);
        player.resetguidedinteraction = undefined;
        wait 0.05;
        continue;
      }

      _id_936A8CB7AB047D5F = scripts\engine\utility::array_removeundefined(_id_936A8CB7AB047D5F);
      _id_936A8CB7AB047D5F = scripts\engine\utility::array_remove_duplicates(_id_936A8CB7AB047D5F);

      if(_id_936A8CB7AB047D5F.size < 1) {
        _id_43E0B9317508501B = undefined;
        update_struct_information(player, -1, undefined, undefined);
        wait 0.05;
        continue;
      }

      _id_936A8CB7AB047D5F = sortbydistance(_id_936A8CB7AB047D5F, player.origin);

      foreach(struct in _id_936A8CB7AB047D5F) {
        _id_3414E5C0A9919716 = 0;

        if(player adsButtonPressed()) {
          update_struct_information(player, -1, undefined, undefined);
          _id_43E0B9317508501B = undefined;

          while(player adsButtonPressed())
            wait 0.05;
        }

        if(distancesquared(player.origin, struct.origin) <= _id_6A625DF0D00319BB) {
          update_struct_information(player, -1, undefined, undefined);
          _id_43E0B9317508501B = undefined;
          continue;
        } else if(isDefined(_id_43E0B9317508501B) && struct == _id_43E0B9317508501B) {
          break;
        } else {
          _id_47293B1E94FF8FB0 = get_interaction_origin(struct, player);
          _id_5C9DDCF56D36F133 = get_interaction_cost(struct, player);
          _id_43E0B9317508501B = struct;
          _id_3414E5C0A9919716 = 1;
          break;
        }
      }

      if(_id_3414E5C0A9919716)
        update_struct_information(player, _id_5C9DDCF56D36F133, _id_47293B1E94FF8FB0, _id_43E0B9317508501B);
    }

    wait 0.1;
  }
}

get_interaction_origin(struct, player) {
  offset = (0, 0, 68);
  pos = struct.origin;

  if(interaction_is_weapon_buy(struct)) {
    if(isDefined(struct.target)) {
      _id_CED0426E7E729ED5 = scripts\engine\utility::getStruct(struct.target, "targetname");

      if(isDefined(_id_CED0426E7E729ED5))
        pos = _id_CED0426E7E729ED5.origin;
      else
        pos = struct.origin;
    }
  } else if(!isDefined(pos))
    pos = struct.origin;

  if(isDefined(level.guided_interaction_offset_func))
    offset = [[level.guided_interaction_offset_func]](struct, player);
  else {
    _id_28EB544ECA57F217 = get_area_for_power(struct);

    if(isDefined(struct.script_noteworthy)) {
      _id_CAB957ADC8D7710F = struct.script_noteworthy;

      switch (_id_CAB957ADC8D7710F) {
        case "iw7_ripper_zmr":
        case "iw7_ripper_zm+ripperscope_zm":
        case "shooting_gallery":
          offset = (0, 0, 12);
          break;
        case "iw7_ake_zml":
        case "iw7_ake_zm":
          if(_id_28EB544ECA57F217 == "swamp_stage")
            offset = (0, 0, 12);

          break;
        case "zfreeze_semtex_mp":
          offset = (0, 0, 20);
          break;
        case "iw7_sonic_zmr":
        case "iw7_sonic_zm":
          if(_id_28EB544ECA57F217 == "moon")
            offset = (0, 0, 30);
          else
            offset = (0, 0, 56);

          break;
        default:
          offset = (0, 0, 56);
      }
    }
  }

  _id_A9706ADAF7C52E27 = scripts\engine\utility::drop_to_ground(pos, 12) + offset;
  return _id_A9706ADAF7C52E27;
}

get_interaction_cost(struct, player) {
  modifier = 1;
  _id_5C9DDCF56D36F133 = 0;

  if(isDefined(level.interactions[struct.script_noteworthy])) {
    if(isDefined(level.interactions[struct.script_noteworthy].cost))
      _id_5C9DDCF56D36F133 = int(level.interactions[struct.script_noteworthy].cost);
    else
      return 0;
  }

  if(interaction_is_weapon_buy(struct)) {
    if(player _id_74502A9E0EF1F19C::has_weapon_variation(struct.script_noteworthy)) {
      _id_9211CDAADB7BCA55 = scripts\cp\utility::getrawbaseweaponname(struct.script_noteworthy);
      _id_E66E40F52978E295 = player _id_74502A9E0EF1F19C::get_weapon_level(_id_9211CDAADB7BCA55);

      if(_id_E66E40F52978E295 > 1)
        _id_5C9DDCF56D36F133 = 4500;
      else {
        modifier = 0.5;
        _id_5C9DDCF56D36F133 = int(_id_5C9DDCF56D36F133 * modifier);
      }
    } else
      _id_5C9DDCF56D36F133 = int(_id_5C9DDCF56D36F133 * modifier);
  } else if(interaction_is_weapon_upgrade(struct)) {
    _id_2869A3A20D48E6AD = player getcurrentweapon();

    if(player _id_74502A9E0EF1F19C::can_upgrade(_id_2869A3A20D48E6AD)) {
      _id_E66E40F52978E295 = player _id_74502A9E0EF1F19C::get_weapon_level(_id_2869A3A20D48E6AD);
      _id_5C9DDCF56D36F133 = scripts\engine\utility::ter_op(_id_E66E40F52978E295 > 1, 10000, 5000);
    } else
      _id_5C9DDCF56D36F133 = 0;

    if(istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses))
      _id_5C9DDCF56D36F133 = 0;
  } else if(is_struct_perk_machine(struct)) {
    if(isDefined(struct.script_noteworthy) && !player can_use_perk(struct))
      _id_5C9DDCF56D36F133 = 0;
    else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && isDefined(struct.script_noteworthy) && struct.script_noteworthy == "perk_machine_revive")
      _id_5C9DDCF56D36F133 = 500;
    else
      _id_5C9DDCF56D36F133 = get_perk_machine_cost(struct);
  } else if(interaction_is_fortune_teller(struct)) {
    if(player.card_refills == 1)
      _id_5C9DDCF56D36F133 = level.fortune_visit_cost_2;
    else
      _id_5C9DDCF56D36F133 = level.fortune_visit_cost_1;
  }

  if(player scripts\cp\utility::is_consumable_active("next_purchase_free"))
    _id_5C9DDCF56D36F133 = 0;

  return _id_5C9DDCF56D36F133;
}

is_struct_perk_machine(struct) {
  if(!isDefined(struct.script_noteworthy))
    return 0;

  if(struct.script_noteworthy == "perk_machine_more" || struct.script_noteworthy == "perk_machine_rat_a_tat" || struct.script_noteworthy == "perk_machine_revive" || struct.script_noteworthy == "perk_machine_run" || struct.script_noteworthy == "perk_machine_smack" || struct.script_noteworthy == "perk_machine_tough" || struct.script_noteworthy == "perk_machine_flash" || struct.script_noteworthy == "perk_machine_boom" || struct.script_noteworthy == "perk_machine_fwoosh" || struct.script_noteworthy == "perk_machine_deadeye" || struct.script_noteworthy == "perk_machine_change" || struct.script_noteworthy == "perk_machine_zap")
    return 1;

  return 0;
}

get_perk_machine_cost(struct) {
  switch (struct.perk_type) {
    case "perk_machine_change":
    case "perk_machine_deadeye":
    case "perk_machine_revive":
    case "perk_machine_fwoosh":
    case "perk_machine_boom":
    case "perk_machine_zap":
      return 1500;
    case "perk_machine_flash":
      return 3000;
    case "perk_machine_tough":
      return 2500;
    case "perk_machine_more":
    case "perk_machine_run":
    case "perk_machine_rat_a_tat":
    case "perk_machine_smack":
      return 2000;
  }
}

is_permitted_guided_interaction(player, struct, _id_43E0B9317508501B) {
  level endon("game_ended");
  player endon("disconnect");

  if(!isDefined(struct))
    return 0;

  _id_CAB957ADC8D7710F = undefined;

  if(isDefined(struct.script_noteworthy))
    _id_CAB957ADC8D7710F = struct.script_noteworthy;
  else
    return 0;

  if(istrue(struct.out_of_order) || isDefined(struct.cooling_down))
    return 0;

  if(istrue(struct.disabledguidedinteractions))
    return 0;

  if(isDefined(struct.perk_type) && struct.perk_type == "perk_machine_revive" && player.self_revives_purchased >= player.max_self_revive_machine_use)
    return 0;

  if(!scripts\cp\utility::coop_mode_has("wall_buys")) {
    if(interaction_is_weapon_buy(struct) || interaction_is_grenade_wall_buy(struct) || interaction_is_ticket_buy(struct) || interaction_is_chi_door(struct) || isDefined(struct.script_parameters) && struct.script_parameters == "tickets")
      return 0;
  }

  if(interaction_is_fortune_teller(struct)) {
    if(player.card_refills == 2)
      return 0;
  }

  if(_id_CAB957ADC8D7710F == "secure_window" || _id_CAB957ADC8D7710F == "white_ark" || _id_CAB957ADC8D7710F == "wor_standee" || _id_CAB957ADC8D7710F == "generator" || _id_CAB957ADC8D7710F == "center_speaker_locs" || _id_CAB957ADC8D7710F == "fourth_speaker" || _id_CAB957ADC8D7710F == "ark_quest_station" || _id_CAB957ADC8D7710F == "dj_quest_part_1" || _id_CAB957ADC8D7710F == "dj_quest_part_2" || _id_CAB957ADC8D7710F == "dj_quest_part_3" || _id_CAB957ADC8D7710F == "dj_quest_door" || _id_CAB957ADC8D7710F == "dj_quest_speaker" || _id_CAB957ADC8D7710F == "lost_and_found" || _id_CAB957ADC8D7710F == "fast_travel" || _id_CAB957ADC8D7710F == "crafting_pickup" || _id_CAB957ADC8D7710F == "pap_upgrade" || _id_CAB957ADC8D7710F == "team_door" || _id_CAB957ADC8D7710F == "neil_head" || _id_CAB957ADC8D7710F == "neil_battery" || _id_CAB957ADC8D7710F == "neil_repair" || _id_CAB957ADC8D7710F == "neil_firmware" || _id_CAB957ADC8D7710F == "barnstorming_group" || _id_CAB957ADC8D7710F == "demon_group" || _id_CAB957ADC8D7710F == "starmaster_group" || _id_CAB957ADC8D7710F == "group_cosmicarc" || _id_CAB957ADC8D7710F == "group_pitfall" || _id_CAB957ADC8D7710F == "group_riverraid" || _id_CAB957ADC8D7710F == "spider_arcade_group" || _id_CAB957ADC8D7710F == "robottank_group" || _id_CAB957ADC8D7710F == "gator_teeth_placement" || _id_CAB957ADC8D7710F == "atm_withdrawal" && isDefined(level.atm_amount_deposited) && level.atm_amount_deposited < 1000 || _id_CAB957ADC8D7710F == "crafting_station" && !isDefined(player.current_crafting_struct))
    return 0;

  if(isDefined(level.guidedinteractionexclusion)) {
    if(![[level.guidedinteractionexclusion]](struct, player, _id_CAB957ADC8D7710F))
      return 0;
  }

  if(istrue(struct.requires_power) && !istrue(struct.powered_on))
    return 0;

  if(isDefined(level.active_volume_check)) {
    if(_id_CAB957ADC8D7710F == "pap_upgrade" || _id_CAB957ADC8D7710F == "weapon_upgrade")
      return 1;
    else if(!self[[level.active_volume_check]](struct.origin))
      return 0;
  }

  end_pos = struct.origin;

  if(isDefined(level.guidedinteractionendposoverride))
    end_pos = [[level.guidedinteractionendposoverride]](player, struct);

  if(!scripts\engine\utility::within_fov(player.origin, player.angles, end_pos, cos(25)))
    return 0;

  if(interaction_is_door_buy(struct) || interaction_is_chi_door(struct)) {
    _id_EE46BA4828993237 = get_spawn_volumes_player_is_in(0, undefined, player);

    foreach(_id_27DFBFCBD63D339E in _id_EE46BA4828993237) {
      _id_EB6E6263D4667983 = _id_27DFBFCBD63D339E get_adjacent_volumes_from_volume();

      foreach(volume in _id_EB6E6263D4667983) {
        if(ispointinvolume(struct.origin, volume))
          return 0;
      }
    }
  }

  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip"]);

  if(struct.script_noteworthy == "trap_hydrant")
    end_pos = struct.origin + (0, 0, 50);

  if(scripts\engine\trace::ray_trace_passed(player getEye(), end_pos, [player], contents))
    return 1;
  else
    return 0;
}

update_struct_information(player, cost, origin, _id_43E0B9317508501B) {
  if(!isDefined(cost))
    cost = -1;

  if(isDefined(origin) && origin != self.origin) {
    wait 0.1;
    self dontinterpolate();
    self.origin = origin;
    wait 0.1;
  }

  if(isDefined(_id_43E0B9317508501B) && _id_43E0B9317508501B.script_parameters == "tickets")
    cost = 2;
}

get_spawn_volumes_player_is_in(_id_62E2246E21A8B5EA, _id_CE0A3F24A858D58B, player) {
  if(isDefined(level.get_spawn_volume_func))
    return [[level.get_spawn_volume_func]]();

  spawn_volume_array = [];
  _id_62CB1AB5DFED14C1 = level.spawn_volume_array;

  foreach(volume in _id_62CB1AB5DFED14C1) {
    if(!volume.active) {
      continue;
    }
    _id_D836141A923F5093 = 0;

    if(isDefined(_id_CE0A3F24A858D58B) && !player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(player istouching(volume))
      _id_D836141A923F5093 = 1;
    else if(istrue(_id_62E2246E21A8B5EA) && player is_in_adjacent_volume(volume))
      _id_D836141A923F5093 = 1;

    if(_id_D836141A923F5093)
      spawn_volume_array[spawn_volume_array.size] = volume;
  }

  return spawn_volume_array;
}