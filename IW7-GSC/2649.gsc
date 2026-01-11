/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2649.gsc
***************************************/

coop_interaction_pregame() {
  func_96E3();
  level thread func_23D8();

  if(scripts\cp\utility::coop_mode_has("guided_interaction")) {
    level thread func_23CB();
  }
}

init() {
  scripts\engine\utility::flag_init("init_interaction_done");

  if(!scripts\engine\utility::flag("init_spawn_volumes_done")) {
    scripts\engine\utility::flag_wait("init_spawn_volumes_done");
  }

  level.interactions = [];
  level.interaction_hintstrings = [];
  level.all_interaction_structs = scripts\engine\utility::getstructarray("interaction", "targetname");
  level.current_interaction_structs = level.all_interaction_structs;
  level.func_9A46 = 0;
  level.weapon_hint_func = ::func_502F;
  level.func_13C63 = ::func_5030;
  level thread func_9A3D();

  foreach(var_01 in level.current_interaction_structs) {
    if(!isDefined(var_1.name)) {
      var_1.name = var_1.script_noteworthy;
    }

    if(!isDefined(var_1.script_parameters)) {
      var_1.script_parameters = "default";
    }

    if(var_1.script_parameters == "requires_power") {
      var_1.requires_power = 1;
      var_1.powered_on = 0;
      var_1.power_area = get_area_for_power(var_01);
      continue;
    }

    var_1.requires_power = 0;
    var_1.powered_on = 0;
  }

  level thread func_5CF3();

  if(isDefined(level.func_768C)) {
    [[level.func_768C]]();
  }

  if(isDefined(level.map_interaction_func)) {
    [[level.map_interaction_func]]();
  }

  var_03 = getarraykeys(level.interactions);

  for(var_04 = 0; var_04 < var_3.size; var_4++) {
    if(isDefined(level.interactions[var_3[var_04]].init_func)) {
      level thread[[level.interactions[var_3[var_04]].init_func]]();
    }

    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("init_interaction_done");

  foreach(var_06 in level.players) {
    var_07 = var_06 getcurrentweapon();

    if(isDefined(level.wave_num) && isDefined(var_07)) {
      self.func_13BE8 = [level.wave_num][var_07];
    }
  }

  level thread func_C00C();
  level thread func_4616();
}

func_5CF3() {
  if(!scripts\engine\utility::flag_exist("wall_buy_setup_done")) {
    scripts\engine\utility::flag_init("wall_buy_setup_done");
  }

  if(!scripts\engine\utility::flag("wall_buy_setup_done")) {
    scripts\engine\utility::flag_wait("wall_buy_setup_done");
  }

  foreach(var_01 in level.all_interaction_structs) {
    if(isDefined(var_1.groupname) && var_1.groupname == "locOverride") {
      continue;
    }
    var_02 = scripts\engine\utility::drop_to_ground(var_1.origin, 10, -200);
    var_1.origin = var_02 + (0, 0, 1);
    wait 0.05;
  }
}

get_area_for_power(var_00) {
  var_01 = getEntArray("spawn_volume", "targetname");

  foreach(var_03 in var_01) {
    if(ispointinvolume(var_0.origin, var_03)) {
      if(isDefined(var_3.basename)) {
        return var_3.basename;
      }
    }
  }

  return undefined;
}

func_96E3() {
  var_00 = getEntArray("player_use_trigger", "targetname");

  foreach(var_02 in var_00) {
    var_2.in_use = 0;
    var_02 scripts\engine\utility::trigger_off();
  }
}

func_23CB() {
  level endon("game_ended");
  wait 5;

  for(;;) {
    var_00 = getEntArray("interactionEnt", "targetname");

    foreach(var_02 in level.players) {
      if(!scripts\engine\utility::is_true(var_2.func_23DE)) {
        var_2.func_23DE = 1;
        var_03 = spawn("script_model", var_2.origin);
        var_2.guidedinteractionent = var_03;
        var_03 thread func_DF3C(var_02);
        var_03 thread func_BC88(var_02);
        var_02 setclientomnvar("zm_interaction_cost", -1);
        var_02 setclientomnvar("zm_interaction_ent", var_03);

        if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
          var_02 thread scripts\cp\zombies\interaction_magicwheel::magic_wheel_tutorial();
          var_02 thread scripts\cp\zombies\zombie_doors::func_59FA();
        }
      }
    }

    level waittill("player_spawned", var_02);
  }
}

func_BC88(var_00) {
  level endon("game_ended");
  var_00 endon("disconnect");
  var_01 = undefined;
  var_02 = undefined;
  var_03 = -1;
  var_04 = 0;
  var_05 = squared(75);

  for(;;) {
    if(scripts\engine\utility::is_true(var_0.inlaststand) || scripts\engine\utility::is_true(var_0.siege_activated) || scripts\engine\utility::is_true(var_0.flung)) {
      var_01 = undefined;
      func_12E34(var_00, -1, undefined, undefined);
    } else if(!var_00 scripts\cp\utility::areinteractionsenabled()) {
      var_01 = undefined;
      func_12E34(var_00, -1, undefined, undefined);
    } else {
      var_06 = [];
      level.current_interaction_structs = scripts\engine\utility::array_removeundefined(level.current_interaction_structs);
      var_07 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.current_interaction_structs, undefined, 10, 750, 1);

      foreach(var_09 in var_0.disabled_interactions) {
      var_07 = scripts\engine\utility::array_remove(var_07, var_09);
      }

      foreach(var_09 in var_07) {
        if(func_9C64(var_00, var_09, var_01)) {
          var_6[var_6.size] = var_09;
        }
      }

      if(scripts\engine\utility::is_true(var_0.resetguidedinteraction)) {
        var_01 = undefined;
        func_12E34(var_00, -1, undefined, undefined);
        var_0.resetguidedinteraction = undefined;
        wait 0.05;
        continue;
      }

      var_06 = scripts\engine\utility::array_removeundefined(var_06);
      var_06 = scripts\engine\utility::array_remove_duplicates(var_06);

      if(var_6.size < 1) {
        var_01 = undefined;
        func_12E34(var_00, -1, undefined, undefined);
        wait 0.05;
        continue;
      }

      var_06 = sortbydistance(var_06, var_0.origin);

      foreach(var_14 in var_06) {
        var_04 = 0;

        if(var_00 adsbuttonpressed()) {
          func_12E34(var_00, -1, undefined, undefined);
          var_01 = undefined;

          while(var_00 adsbuttonpressed()) {
            wait 0.05;
          }
        }

        if(distancesquared(var_0.origin, var_14.origin) <= var_05) {
          func_12E34(var_00, -1, undefined, undefined);
          var_01 = undefined;
          continue;
        } else if(isDefined(var_01) && var_14 == var_01) {
          break;
        } else {
          var_02 = func_7A4A(var_14, var_00);
          var_03 = func_7A48(var_14, var_00);
          var_01 = var_14;
          var_04 = 1;
          break;
        }
      }

      if(var_04) {
        func_12E34(var_00, var_03, var_02, var_01);
      }
    }

    wait 0.1;
  }
}

func_7A4A(var_00, var_01) {
  var_02 = (0, 0, 68);
  var_03 = var_0.origin;

  if(interaction_is_weapon_buy(var_00)) {
    if(isDefined(var_0.target)) {
      var_04 = scripts\engine\utility::getstruct(var_0.target, "targetname");

      if(isDefined(var_04)) {
        var_03 = var_4.origin;
      }
      else {
        var_03 = var_0.origin;
      }
    }
  } else if(!isDefined(var_03))
    var_03 = var_0.origin;

  if(isDefined(level.guided_interaction_offset_func)) {
    var_02 = [[level.guided_interaction_offset_func]](var_00, var_01);
  }
  else {
    var_05 = get_area_for_power(var_00);

    if(isDefined(var_0.name)) {
      var_06 = var_0.script_noteworthy;

      switch (var_06) {
        case "iw7_ripper_zmr":
        case "iw7_ripper_zm+ripperscope_zm":
        case "shooting_gallery":
          var_02 = (0, 0, 12);
          break;
        case "iw7_ake_zml":
        case "iw7_ake_zm":
          if(var_05 == "swamp_stage") {
            var_02 = (0, 0, 12);
          }

          break;
        case "zfreeze_semtex_mp":
          var_02 = (0, 0, 20);
          break;
        case "iw7_sonic_zmr":
        case "iw7_sonic_zm":
          if(var_05 == "moon") {
            var_02 = (0, 0, 30);
          }
          else {
            var_02 = (0, 0, 56);
          }

          break;
        default:
          var_02 = (0, 0, 56);
      }
    }
  }

  var_07 = scripts\engine\utility::drop_to_ground(var_03, 12) + var_02;
  return var_07;
}

func_7A48(var_00, var_01) {
  var_02 = 1;
  var_03 = int(level.interactions[var_0.script_noteworthy].cost);

  if(interaction_is_weapon_buy(var_00)) {
    if(var_01 scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy)) {
      var_04 = scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy);
      var_05 = var_01 scripts\cp\cp_weapon::get_weapon_level(var_04);

      if(var_05 > 1) {
        var_03 = 4500;
      }
      else {
        var_02 = 0.5;
        var_03 = int(var_03 * var_02);
      }
    } else
      var_03 = int(var_03 * var_02);
  } else if(interaction_is_weapon_upgrade(var_00)) {
    var_06 = var_01 getcurrentweapon();

    if(var_01 scripts\cp\cp_weapon::can_upgrade(var_06)) {
      var_05 = var_01 scripts\cp\cp_weapon::get_weapon_level(var_06);
      var_03 = scripts\engine\utility::ter_op(var_05 > 1, 10000, 5000);
    } else
      var_03 = 0;

    if(scripts\engine\utility::is_true(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
      var_03 = 0;
    }
  } else if(func_9CDB(var_00)) {
    if(isDefined(var_0.name) && !var_01 can_use_perk(var_00)) {
      var_03 = 0;
    }
    else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && isDefined(var_0.name) && var_0.name == "perk_machine_revive") {
      var_03 = 500;
    }
    else {
      var_03 = get_perk_machine_cost(var_00);
    }
  } else if(interaction_is_fortune_teller(var_00)) {
    if(var_1.card_refills == 1) {
      var_03 = level.fortune_visit_cost_2;
    }
    else {
      var_03 = level.fortune_visit_cost_1;
    }
  }

  if(var_01 scripts\cp\utility::is_consumable_active("next_purchase_free")) {
    var_03 = 0;
  }

  return var_03;
}

func_9CDB(var_00) {
  if(!isDefined(var_0.name)) {
    return 0;
  }

  if(var_0.name == "perk_machine_more" || var_0.name == "perk_machine_rat_a_tat" || var_0.name == "perk_machine_revive" || var_0.name == "perk_machine_run" || var_0.name == "perk_machine_smack" || var_0.name == "perk_machine_tough" || var_0.name == "perk_machine_flash" || var_0.name == "perk_machine_boom" || var_0.name == "perk_machine_fwoosh" || var_0.name == "perk_machine_deadeye" || var_0.name == "perk_machine_change" || var_0.name == "perk_machine_zap") {
    return 1;
  }

  return 0;
}

get_perk_machine_cost(var_00) {
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
    case "perk_machine_run":
    case "perk_machine_more":
    case "perk_machine_rat_a_tat":
    case "perk_machine_smack":
      return 2000;
  }
}

func_9C64(var_00, var_01, var_02) {
  level endon("game_ended");
  var_00 endon("disconnect");

  if(!isDefined(var_01)) {
    return 0;
  }

  var_03 = undefined;

  if(isDefined(var_1.name)) {
    var_03 = var_1.name;
  }
  else {
    return 0;
  }

  if(scripts\engine\utility::is_true(var_1.out_of_order) || isDefined(var_1.cooling_down)) {
    return 0;
  }

  if(isDefined(var_1.perk_type) && var_1.perk_type == "perk_machine_revive" && var_0.self_revives_purchased >= var_0.max_self_revive_machine_use) {
    return 0;
  }

  if(!scripts\cp\utility::coop_mode_has("wall_buys")) {
    if(interaction_is_weapon_buy(var_01) || interaction_is_grenade_wall_buy(var_01) || interaction_is_ticket_buy(var_01) || interaction_is_chi_door(var_01) || isDefined(var_1.script_parameters) && var_1.script_parameters == "tickets") {
      return 0;
    }
  }

  if(interaction_is_fortune_teller(var_01)) {
    if(var_0.card_refills == 2) {
      return 0;
    }
  }

  if(var_03 == "secure_window" || var_03 == "white_ark" || var_03 == "wor_standee" || var_03 == "generator" || var_03 == "center_speaker_locs" || var_03 == "fourth_speaker" || var_03 == "ark_quest_station" || var_03 == "dj_quest_part_1" || var_03 == "dj_quest_part_2" || var_03 == "dj_quest_part_3" || var_03 == "dj_quest_door" || var_03 == "dj_quest_speaker" || var_03 == "lost_and_found" || var_03 == "fast_travel" || var_03 == "crafting_pickup" || var_03 == "pap_upgrade" || var_03 == "team_door" || var_03 == "neil_head" || var_03 == "neil_battery" || var_03 == "neil_repair" || var_03 == "neil_firmware" || var_03 == "barnstorming_group" || var_03 == "demon_group" || var_03 == "starmaster_group" || var_03 == "group_cosmicarc" || var_03 == "group_pitfall" || var_03 == "group_riverraid" || var_03 == "spider_arcade_group" || var_03 == "robottank_group" || var_03 == "gator_teeth_placement" || var_03 == "atm_withdrawal" && isDefined(level.atm_amount_deposited) && level.atm_amount_deposited < 1000 || var_03 == "crafting_station" && !isDefined(var_0.current_crafting_struct)) {
    return 0;
  }

  if(isDefined(level.guidedinteractionexclusion)) {
    if(![
        [level.guidedinteractionexclusion]
      ](var_01, var_00, var_03))
      return 0;
  }

  if(scripts\engine\utility::is_true(var_1.requires_power) && !scripts\engine\utility::is_true(var_1.powered_on)) {
    return 0;
  }

  if(isDefined(level.active_volume_check)) {
    if(var_03 == "pap_upgrade" || var_03 == "weapon_upgrade") {
      return 1;
    }
    else if(!self[[level.active_volume_check]](var_1.origin)) {
      return 0;
    }
  }

  var_04 = var_1.origin;

  if(isDefined(level.guidedinteractionendposoverride)) {
    var_04 = [[level.guidedinteractionendposoverride]](var_00, var_01);
  }

  if(!scripts\engine\utility::within_fov(var_0.origin, var_0.angles, var_04, cos(25))) {
    return 0;
  }

  if(interaction_is_door_buy(var_01) || interaction_is_chi_door(var_01)) {
    var_05 = get_spawn_volumes_player_is_in(0, undefined, var_00);

    foreach(var_07 in var_05) {
      var_08 = var_07 func_77D3();

      foreach(var_10 in var_08) {
        if(ispointinvolume(var_1.origin, var_10)) {
          return 0;
        }
      }
    }
  }

  var_13 = physics_createcontents(["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip", "physicscontents_solid"]);

  if(var_1.script_noteworthy == "trap_hydrant") {
    var_04 = var_1.origin + (0, 0, 50);
  }

  if(scripts\engine\trace::ray_trace_passed(var_00 getEye(), var_04, [var_00], var_13)) {
    return 1;
  }
  else {
    return 0;
  }
}

func_77D3() {
  if(isDefined(level.func_186E[self.basename])) {
    var_00 = [];

    foreach(var_02 in level.func_186E[self.basename]) {
    var_0[var_0.size] = level.func_10817[var_02];
    }

    return var_00;
  }

  return [];
}

func_9C0F(var_00) {
  if(!isDefined(var_00)) {
    return 0;
  }

  if(!isDefined(var_0.func_186E)) {
    return 0;
  }

  foreach(var_02 in var_0.func_186E) {
    if(!var_2.active) {
      continue;
    }
    if(self istouching(var_02)) {
      return 1;
    }
  }

  return 0;
}

get_spawn_volumes_player_is_in(var_00, var_01, var_02) {
  if(isDefined(level.func_7C80)) {
    return [[level.func_7C80]]();
  }

  var_03 = [];
  var_04 = level.spawn_volume_array;

  foreach(var_06 in var_04) {
    if(!var_6.active) {
      continue;
    }
    var_07 = 0;

    if(isDefined(var_01) && !var_02 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(var_02 istouching(var_06)) {
      var_07 = 1;
    }
    else if(scripts\engine\utility::is_true(var_00) && var_02 func_9C0F(var_06)) {
      var_07 = 1;
    }

    if(var_07) {
      var_3[var_3.size] = var_06;
    }
  }

  return var_03;
}

func_12E34(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_01)) {
    var_01 = -1;
  }

  if(isDefined(var_02) && var_02 != self.origin) {
    var_00 setclientomnvar("zm_interaction_cost", -1);
    wait 0.1;
    self dontinterpolate();
    self.origin = var_02;
    wait 0.1;
  }

  if(isDefined(var_03) && var_3.script_parameters == "tickets") {
    var_01 = 2;
  }

  var_00 setclientomnvar("zm_interaction_cost", var_01);
}

func_79D0(var_00) {
  foreach(var_02 in var_00) {
    if(!scripts\engine\utility::is_true(var_2.in_use)) {
      var_2.in_use = 1;
      var_02 setModel("tag_origin");
      return var_02;
    }
  }
}

func_DF3C(var_00) {
  var_00 waittill("disconnect");
  self.in_use = 0;
  self notify("interaction_ent_released");
}

func_23D8() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_00);
    var_0.interaction_trigger = get_player_interaction_trigger();

    if(!isDefined(var_0.interaction_trigger)) {
      break;
    }
    reset_interaction_triggers();

    if(!isDefined(var_0.interaction_trigger)) {
      iprintlnbold("NO TRIGGER FOUND!");
    }

    var_0.last_interaction_point = undefined;
    var_0.interaction_trigger makeunusable();
    var_00 thread func_DF3F();
    var_00 thread player_interaction_monitor();
    var_00 thread func_D104();
  }
}

func_D104() {
  self endon("disconnect");
  self endon("death");

  for(;;) {
    scripts\engine\utility::waittill_any("weapon_switch_started", "weapon_change", "weaponchange");
    self.last_interaction_point = undefined;
    self.resetguidedinteraction = 1;
    self notify("stop_interaction_logic");
  }
}

get_player_interaction_trigger() {
  var_00 = getEntArray("player_use_trigger", "targetname");
  var_01 = undefined;

  foreach(var_03 in var_00) {
    if(!var_3.in_use) {
      var_3.in_use = 1;
      var_03 scripts\engine\utility::trigger_on();
      return var_03;
    }
  }

  return undefined;
}

func_DF3F() {
  var_00 = self.interaction_trigger;
  scripts\engine\utility::waittill_any("death", "disconnect");
  var_0.in_use = 0;
}

register_interaction(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  var_09 = spawnStruct();
  var_9.name = var_00;
  var_9.hint_func = var_03;
  var_9.spend_type = var_01;
  var_9.tutorial = var_02;
  var_9.activation_func = var_04;
  var_9.enabled = 1;

  if(!isDefined(var_05)) {
    var_05 = 0;
  }

  var_9.cost = var_05;

  if(isDefined(var_06)) {
    var_9.requires_power = var_06;
  }
  else {
    var_9.requires_power = 0;
  }

  var_9.init_func = var_07;
  var_9.can_use_override_func = var_08;
  level.interactions[var_00] = var_09;
}

func_15BC(var_00, var_01) {
  level thread[[level.interactions[var_00].activation_func]](var_01);
}

reset_interaction_triggers() {
  foreach(var_01 in level.players) {
    if(isDefined(var_1.interaction_trigger)) {
      func_8E90(var_01);
    }
  }
}

func_8E90(var_00) {
  foreach(var_02 in level.players) {
    if(var_02 == var_00) {
      var_0.interaction_trigger enableplayeruse(var_00);
      continue;
    }

    var_0.interaction_trigger disableplayeruse(var_02);
  }
}

func_13D07(var_00, var_01) {
  for(;;) {
    thread scripts\engine\utility::draw_entity_bounds(var_01, 0.1, (1, 0, 0), 1, 0.1);
    wait 0.1;
  }
}

player_interaction_monitor() {
  self notify("player_interaction_monitor");
  self endon("player_interaction_monitor");
  self endon("disconnect");
  self endon("death");

  while(!isDefined(level.current_interaction_structs)) {
    wait 1;
  }

  if(isDefined(level.player_interaction_monitor)) {
    self thread[[level.player_interaction_monitor]]();
    return;
  }
}

flash_inventory() {
  self endon("window_trap_placed");
  self endon("death");

  if(!isDefined(self.func_BF46)) {
    self.func_BF46 = gettime() + 2500;
  }
  else if(gettime() < self.func_BF46) {
    return;
  }
  self.func_BF46 = gettime() + 2500;
  self setclientomnvar("zom_crafted_weapon", 0);
  wait 0.5;
  self setclientomnvar("zom_crafted_weapon", 8);
  wait 1.5;
}

can_use_interaction(var_00) {
  if(!isDefined(var_00)) {
    return 0;
  }

  if(scripts\engine\utility::is_true(self.iscarrying)) {
    return 0;
  }

  if(scripts\engine\utility::is_true(var_0.disabled) || !scripts\cp\utility::areinteractionsenabled() || self isinphase()) {
    return 0;
  }

  if(self secondaryoffhandbuttonpressed() || self isthrowinggrenade() || self fragbuttonpressed()) {
    return 0;
  }

  if(!self isonground()) {
    return 0;
  }

  if(var_0.script_noteworthy == "game_race" && distancesquared(self.origin, var_0.origin) > 576) {
    return 0;
  }

  if(var_0.script_noteworthy == "ritual_stone" && scripts\engine\utility::is_true(self.rave_mode)) {
    return 0;
  }

  return 1;
}

reset_interaction() {
  if(isDefined(self.interaction_trigger.name)) {
    scripts\cp\zombies\zombie_analytics::func_AF74(self.interaction_trigger.name, 0);
  }

  wait 0.2;
  self notify("stop_interaction_logic");
  self.interaction_trigger makeunusable();
  self.last_interaction_point = undefined;
  self setclientomnvar("zm_tutorial_num", 0);
}

set_interaction_point(var_00, var_01) {
  if(scripts\engine\utility::is_true(self.interaction_trigger.func_55F3)) {
    return;
  }
  self.interaction_trigger dontinterpolate();
  self.last_interaction_point = var_00;
  var_02 = self getEye();
  self.interaction_trigger.origin = (var_0.origin[0], var_0.origin[1], var_2[2]);

  if(!isDefined(level.interactions[var_0.script_noteworthy].spend_type)) {
    level.interactions[var_0.script_noteworthy].spend_type = "null";
  }

  var_03 = level.interactions[var_0.script_noteworthy].spend_type;
  var_04 = undefined;

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    if(var_03 == "wall_buy") {
      var_04 = scripts\cp\cp_hud_message::get_has_seen_tutorial("wall_buy");
    }

    if(!scripts\engine\utility::is_true(var_04)) {
      if(isDefined(level.interactions[var_0.script_noteworthy].tutorial)) {
        thread scripts\cp\cp_hud_message::tutorial_lookup_func(var_03);
      }
    }
  }

  if(interaction_is_weapon_buy(var_00)) {
    if(!scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy)) {
      var_05 = _meth_8228(var_0.script_noteworthy);
      var_06 = _meth_8220(var_0.script_noteworthy);
      self.interaction_trigger sethintstringparams(var_05, var_06);
    }
  } else if(interaction_is_weapon_upgrade(var_00)) {
    var_07 = self getcurrentweapon();
    var_05 = _meth_8228(var_07);

    if(scripts\cp\cp_weapon::can_upgrade(var_07)) {
      if(isDefined(var_05)) {
        var_08 = scripts\cp\cp_weapon::get_weapon_level(var_07);
        var_06 = scripts\engine\utility::ter_op(var_08 > 1, int(10000), int(5000));
        self.interaction_trigger sethintstringparams(var_05, var_06);
      }
    } else if(isDefined(var_05))
      self.interaction_trigger sethintstringparams(var_05);
  } else if(func_9A16(var_00)) {
    if(!isDefined(self.current_crafting_struct)) {
      level thread[[level.interactions[var_0.script_noteworthy].activation_func]](var_00, self);
      interaction_post_activate_update(var_00);
      self notify("new_power", "souvenir_pickup");

      if(scripts\cp\utility::map_check(0)) {
        thread scripts\cp\cp_vo::add_to_nag_vo("nag_use_souvenircoin", "zmb_comment_vo", 60, 180, 6, 1);
      }

      return;
    }

    self.interaction_trigger.origin = var_0.origin;
  } else if(func_9A26(var_00))
    self.interaction_trigger.origin = (var_0.origin[0], var_0.origin[1], var_2[2] - 15);
  else if(func_9A15(var_00) && var_0.script_noteworthy == "atm_withdrawal") {
    self.interaction_trigger sethintstringparams(level.atm_amount_deposited);
  }
  else if(interaction_is_fortune_teller(var_00)) {
    if(self.card_refills == 1) {
      self.interaction_trigger sethintstringparams(level.fortune_visit_cost_2);
    }
    else {
      self.interaction_trigger sethintstringparams(level.fortune_visit_cost_1);
    }
  } else if(var_0.script_noteworthy == "spawned_essence")
    self.interaction_trigger.origin = var_0.origin;

  func_F422(self.interaction_trigger, var_00);

  if(!isDefined(var_01)) {
    thread func_135DF(var_00);
  }

  self.interaction_trigger makeusable();
}

_meth_8228(var_00) {
  if(!isDefined(var_00)) {
    return undefined;
  }

  var_01 = scripts\cp\utility::getbaseweaponname(var_00);

  if(!isDefined(var_01)) {
    return undefined;
  }

  switch (var_01) {
    case "iw7_udm45":
      return &"CP_ZMB_WEAPONS_UDM45";
    case "iw7_rvn":
      return &"CP_ZMB_WEAPONS_RVN";
    case "iw7_ake":
      return &"CP_ZMB_WEAPONS_AKE";
    case "iw7_lmg03":
      return &"CP_ZMB_WEAPONS_LMG03";
    case "iw7_ar57":
      return &"CP_ZMB_WEAPONS_AR57";
    case "iw7_arclassic":
      return &"CP_ZMB_WEAPONS_ARCLASSIC";
    case "iw7_axe":
      return &"CP_ZMB_WEAPONS_AXE";
    case "iw7_lockon":
      return &"CP_ZMB_WEAPONS_LOCKON";
    case "iw7_chargeshot":
      return &"CP_ZMB_WEAPONS_CHARGESHOT";
    case "iw7_cheytacc":
      return &"CP_ZMB_WEAPONS_CHEYTACC";
    case "iw7_cheytac":
      return &"CP_ZMB_WEAPONS_CHEYTAC";
    case "iw7_crb":
      return &"CP_ZMB_WEAPONS_CRB";
    case "iw7_devastator":
      return &"CP_ZMB_WEAPONS_DEVASTATOR";
    case "iw7_dischord":
      return &"CP_ZMB_WEAPONS_DISCHORD";
    case "iw7_emc":
      return &"CP_ZMB_WEAPONS_EMC";
    case "iw7_erad":
      return &"CP_ZMB_WEAPONS_ERAD";
    case "iw7_facemelter":
      return &"CP_ZMB_WEAPONS_FACE_MELTER";
    case "iw7_fhr":
      return &"CP_ZMB_WEAPONS_FHR";
    case "iw7_fmg":
      return &"CP_ZMB_WEAPONS_FMG";
    case "iw7_forgefreeze":
      return &"CP_ZMB_WEAPONS_FORGE_FREEZE";
    case "iw7_g18c":
      return &"CP_ZMB_WEAPONS_G18C";
    case "iw7_g18":
      return &"CP_ZMB_WEAPONS_G18";
    case "iw7_glprox":
      return &"CP_ZMB_WEAPONS_GLPROX";
    case "iw7_headcutter":
      return &"CP_ZMB_WEAPONS_HEAD_CUTTER";
    case "iw7_kbs":
      return &"CP_ZMB_WEAPONS_KBS";
    case "iw7_m1":
      return &"CP_ZMB_WEAPONS_M1";
    case "iw7_m1c":
      return &"CP_ZMB_WEAPONS_M1C";
    case "iw7_m4":
      return &"CP_ZMB_WEAPONS_M4";
    case "iw7_m8":
      return &"CP_ZMB_WEAPONS_M8";
    case "iw7_mauler":
      return &"CP_ZMB_WEAPONS_MAULER";
    case "iw7_nrg":
      return &"CP_ZMB_WEAPONS_NRG";
    case "iw7_revolver":
      return &"CP_ZMB_WEAPONS_REVOLVER";
    case "iw7_ripper":
      return &"CP_ZMB_WEAPONS_RIPPER";
    case "iw7_sdfar":
      return &"CP_ZMB_WEAPONS_SDFAR";
    case "iw7_sdflmg":
      return &"CP_ZMB_WEAPONS_SDFLMG";
    case "iw7_sdfshotty":
      return &"CP_ZMB_WEAPONS_SDFSHOTTY";
    case "iw7_shredder":
      return &"CP_ZMB_WEAPONS_SHREDDER";
    case "iw7_sonic":
      return &"CP_ZMB_WEAPONS_SONIC";
    case "iw7_spasc":
      return &"CP_ZMB_WEAPONS_SPASC";
    case "iw7_spas":
      return &"CP_ZMB_WEAPONS_SPAS";
    case "iw7_steeldragon":
      return &"CP_ZMB_WEAPONS_STEEL_DRAGON";
    case "iw7_ump45c":
      return &"CP_ZMB_WEAPONS_UMP45C";
    case "iw7_ump45":
      return &"CP_ZMB_WEAPONS_UMP45";
    case "iw7_vr":
      return &"CP_ZMB_WEAPONS_VR";
    case "iw7_crdb":
      return &"CP_ZMB_WEAPONS_CRDB";
    case "iw7_minilmg":
      return &"CP_ZMB_WEAPONS_MINILMG";
    case "iw7_mp28":
      return &"CP_ZMB_WEAPONS_MP28";
    case "iw7_mod2187":
      return &"CP_ZMB_WEAPONS_MOD2187";
    case "iw7_ba50cal":
      return &"CP_ZMB_WEAPONS_BA50CAL";
    case "iw7_longshot":
      return &"CP_ZMB_WEAPONS_LONGSHOT";
    case "iw7_cutie":
    case "iw7_cutie_zm":
      return &"CP_ZMB_WEAPONS_MAD";
    default:
      if(isDefined(level.custom_weaponnamestring_func)) {
        return [
          [level.custom_weaponnamestring_func]
        ](var_01, var_00);
        return;
      }

      return &"CP_ZMB_WEAPONS_GENERIC";
      return;
  }
}

_meth_8220(var_00) {
  return int(level.interactions[var_00].cost);
}

func_F422(var_00, var_01) {
  var_02 = func_7A49(var_01, self);

  if(isDefined(var_02)) {
    self.interaction_trigger sethintstring(var_02);
  }

  if(interaction_is_weapon_buy(var_01)) {
    if(isDefined(var_02) && !isstring(var_02) && var_02 == &"COOP_INTERACTIONS_PURCHASE_AMMO") {
      var_03 = scripts\cp\utility::getrawbaseweaponname(var_1.script_noteworthy);
      var_04 = scripts\cp\cp_weapon::get_weapon_level(var_03);
      var_05 = _meth_8228(var_1.script_noteworthy);

      if(var_04 > 1) {
        self.interaction_trigger sethintstringparams(int(4500), var_05);
      }
      else {
        self.interaction_trigger sethintstringparams(int(0.5 * level.interactions[var_1.script_noteworthy].cost), var_05);
      }
    }
  } else if(interactionislostandfound(var_01) && scripts\engine\utility::is_true(self.have_things_in_lost_and_found)) {
    if(isDefined(self.lost_and_found_spot) && self.lost_and_found_spot == var_01) {
      func_F474(self);
    }
  } else if(interaction_is_window_entrance(var_01) || func_9A19(var_01) || func_9A1C(var_01) || func_9A1E(var_01) || interaction_is_weapon_upgrade(var_01) || func_9A16(var_01)) {
    self.interaction_trigger usetriggerrequirelookat(0);
    self.interaction_trigger setusefov(360);
  } else if(var_1.script_noteworthy == "coaster") {
    self.interaction_trigger usetriggerrequirelookat(1);
    self.interaction_trigger setusefov(245);
  } else if(var_1.script_noteworthy == "dj_quest_speaker_mid" || var_1.script_noteworthy == "dj_quest_speaker") {
    self.interaction_trigger usetriggerrequirelookat(0);
    self.interaction_trigger setusefov(360);
  } else if(var_1.script_noteworthy == "spawned_essence") {
    self.interaction_trigger usetriggerrequirelookat(1);
    self.interaction_trigger setusefov(360);
  } else if(var_1.script_noteworthy == "dj_quest_part_1" || var_1.script_noteworthy == "dj_quest_part_2" || var_1.script_noteworthy == "dj_quest_part_3") {
    self.interaction_trigger usetriggerrequirelookat(0);
    self.interaction_trigger setusefov(245);
  } else {
    self.interaction_trigger usetriggerrequirelookat(1);
    self.interaction_trigger setusefov(160);
  }

  if(isDefined(level.interaction_trigger_properties_func)) {
    [[level.interaction_trigger_properties_func]](var_00, var_01, var_02);
  }
}

func_F474(var_00) {
  if(isDefined(var_0.lost_and_found_primary_count)) {
    var_01 = [];

    foreach(var_03 in var_0.lost_and_found_primary_count) {
      if(scripts\cp\utility::isstrstart(var_03, "alt_")) {
        continue;
      }
      if(!scripts\engine\utility::array_contains(var_01, var_03)) {
        var_01 = scripts\engine\utility::array_add(var_01, var_03);
      }
    }

    if(var_1.size > 2) {
      var_05 = _meth_8228(var_1[1]);
      var_06 = _meth_8228(var_1[2]);
      var_0.interaction_trigger sethintstringparams(var_05, var_06);
    } else {
      var_05 = _meth_8228(var_1[1]);
      var_0.interaction_trigger sethintstringparams(var_05);
    }
  }
}

func_7A49(var_00, var_01) {
  if(isDefined(level.interactions[var_0.script_noteworthy].hint_func)) {
    return [[level.interactions[var_0.script_noteworthy].hint_func]](var_00, var_01);
  }

  if(isDefined(var_0.cooling_down)) {
    return &"COOP_INTERACTIONS_COOLDOWN";
  }

  if(var_0.requires_power && !var_0.powered_on) {
    return &"COOP_INTERACTIONS_REQUIRES_POWER";
  }

  if(interaction_is_weapon_buy(var_00)) {
    if(!scripts\cp\utility::coop_mode_has("wall_buys")) {
      return undefined;
    }
  }

  if(interaction_is_crafting_station(var_00)) {
    if(!isDefined(var_1.current_crafting_struct) && var_0.available_ingredient_slots > 0) {
      return level.interaction_hintstrings["crafting_nopiece"];
    }
  }

  if(func_9A16(var_00)) {
    return level.interaction_hintstrings["crafting_item_swap"];
  }

  return level.interaction_hintstrings[var_0.script_noteworthy];
}

func_C00C() {
  self endon("game_ended");

  for(;;) {
    level waittill("player_accessed_nonpowered_interaction", var_00);
    var_00 thread scripts\cp\cp_vo::try_to_play_vo("no_power", "zmb_comment_vo", "high", 30, 0, 0, 1, 50);
  }
}

func_4616() {
  self endon("game_ended");

  for(;;) {
    level waittill("player_accessed_interaction_on_cooldown", var_00);
    var_00 thread scripts\cp\cp_vo::try_to_play_vo("round_cooldown", "zmb_comment_vo", "high", 30, 0, 0, 1, 50);
  }
}

func_135DF(var_00) {
  if(isDefined(level.wait_for_interaction_func)) {
    self thread[[level.wait_for_interaction_func]](var_00);
  }
}

play_weapon_purchase_vo(var_00, var_01) {
  var_02 = var_0.script_noteworthy;
  var_03 = getweaponbasename(var_02);

  switch (var_03) {
    case "iw7_cutie_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_wonder", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_nunchucks_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_nunchucks", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_katana_zm":
      if(randomint(100) > 50) {
        var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_wonder", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      }
      else {
        var_01 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_katana", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      }

      break;
    case "iw7_harpoon4_zm":
    case "iw7_harpoon3_zm":
    case "iw7_harpoon2_zm":
    case "iw7_harpoon1_zm":
    case "iw7_harpoon_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_wonder", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_ake_zml":
    case "iw7_ake_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_assault", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_lmg03_zm":
    case "iw7_ameli_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_ar57_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_assault", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_axe_zm_pap2":
    case "iw7_axe_zm_pap1":
    case "iw7_axe_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_chargeshot_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_launcher", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_cheytac_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_sniper", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_crb_zml":
    case "iw7_crb_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_smg", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_devastator_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_shotgun", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_dischord_zm_pap1":
    case "iw7_dischord_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_wonder", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_emc_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_pistol", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_erad_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_smg", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_facemelter_zm_pap1":
    case "iw7_facemelter_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_wonder", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_fhr_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_smg", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_fmg_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_smg", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_forgefreeze_zm_pap2":
    case "iw7_forgefreeze_zm_pap1":
    case "iw7_forgefreeze_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_wonder", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_g18_zmr":
    case "iw7_g18_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_pistol", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_lockon_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_launcher", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_glprox_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_launcher", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_headcutter_zm_pap1":
    case "iw7_headcutter_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_wonder", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_kbs_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_sniper", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_m1c_zm":
    case "iw7_m1_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_sniper", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_m4_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_assault", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_m8_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_assault", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_mauler_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_nrg_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_pistol", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_revolver_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_pistol", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_ripper_zm":
    case "iw7_ripper_zmr":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_smg", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_sdfar_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_assault", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_sdflmg_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_sdfshotty_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_shotgun", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_shredder_zm_pap1":
    case "iw7_shredder_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_wonder", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_sonic_zmr":
    case "iw7_sonic_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_shotgun", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_spas_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_shotgun", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_steeldragon_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_wonder", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_ump45_zml":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_smg", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
    case "iw7_spasc_zm":
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_shotgun", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
  }
}

can_purchase_ammo(var_00) {
  var_01 = self getweaponslistall();
  var_02 = undefined;
  var_03 = undefined;
  var_04 = scripts\cp\utility::getrawbaseweaponname(var_00);

  foreach(var_06 in var_01) {
    var_03 = scripts\cp\utility::getrawbaseweaponname(var_06);

    if(var_03 == var_04) {
      var_02 = var_06;
      break;
    }
  }

  if(isDefined(var_02)) {
    var_08 = self getweaponammostock(var_02);
    var_09 = weaponmaxammo(var_02);
    var_10 = scripts\cp\perks\prestige::prestige_getminammo();
    var_11 = int(var_10 * var_09);

    if(var_08 < var_11) {
      return 1;
    }
    else if(weaponmaxammo(var_02) == weaponclipsize(var_02) && self getweaponammoclip(var_02) < weaponclipsize(var_02)) {
      return 1;
    }
    else {
      return 0;
    }
  }

  return 1;
}

interaction_post_activate_delay(var_00) {
  self endon("disconnect");

  if(interaction_is_door_buy(var_00)) {
    return;
  }
  if(func_9A15(var_00)) {
    return;
  }
  scripts\cp\utility::allow_player_interactions(0);
  wait 1.5;

  if(!scripts\cp\utility::areinteractionsenabled()) {
    scripts\cp\utility::allow_player_interactions(1);
  }
}

delayed_trigger_unset() {
  wait 0.25;
  self.triggered = undefined;
}

remove_from_current_interaction_list(var_00) {
  if(scripts\engine\utility::array_contains(level.current_interaction_structs, var_00)) {
    level.current_interaction_structs = scripts\engine\utility::array_remove(level.current_interaction_structs, var_00);
  }
}

add_to_current_interaction_list(var_00) {
  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, var_00)) {
    level.current_interaction_structs = scripts\engine\utility::array_add(level.current_interaction_structs, var_00);
  }
}

remove_from_current_interaction_list_for_player(var_00, var_01) {
  var_1.disabled_interactions = scripts\engine\utility::array_add(var_1.disabled_interactions, var_00);
}

add_to_current_interaction_list_for_player(var_00, var_01) {
  var_1.disabled_interactions = scripts\engine\utility::array_remove(var_1.disabled_interactions, var_00);
}

can_purchase_interaction(var_00, var_01, var_02, var_03) {
  if(isDefined(var_0.script_location) && var_0.script_location == "afterlife") {
    return 1;
  }

  if(scripts\cp\powers\coop_phaseshift::isentityphaseshifted(self)) {
    return 0;
  }

  if(isDefined(var_01)) {
    var_04 = var_01;
  }
  else {
    var_04 = level.interactions[var_0.script_noteworthy].cost;
  }

  if(interaction_is_fortune_teller(var_00)) {
    switch (self.card_refills) {
      case 0:
        var_04 = level.fortune_visit_cost_1;
        break;
      case 1:
        var_04 = level.fortune_visit_cost_2;
        break;
    }
  } else if(interaction_is_weapon_upgrade(var_00) && !scripts\cp\cp_weapon::can_upgrade(self getcurrentweapon())) {
    if(scripts\engine\utility::is_true(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
      return 1;
    }
    else {
      return 0;
    }
  } else if(interaction_is_perk(var_00)) {
    if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && var_0.perk_type == "perk_machine_revive" && !scripts\cp\utility::has_zombie_perk("perk_machine_revive") && self.self_revives_purchased >= self.max_self_revive_machine_use) {
      return 0;
    }
  } else if(interaction_is_special_door_buy(var_00)) {
    var_05 = 0;

    switch (var_0.script_side) {
      case "moon":
        if(!isDefined(level.moon_donations) || level.moon_donations < 3) {
          var_05 = 1;
        }

        break;
      case "kepler":
        if(!isDefined(level.kepler_donations) || level.kepler_donations < 3) {
          var_05 = 1;
        }

        break;
      case "triton":
        if(!isDefined(level.triton_donations) || level.triton_donations < 3) {
          var_05 = 1;
        }

        break;
    }

    if(!var_05) {
      return 0;
    }
  } else if(interaction_is_chi_door(var_00)) {
    switch (var_0.script_noteworthy) {
      case "chi_0":
        if(var_01 != 0) {
          break;
        }
        if(!isDefined(level.kungfu_weapons) || !isDefined(scripts\engine\utility::array_find(level.kungfu_weapons[0], var_03))) {
          break;
        }
        return 1;
      case "chi_1":
        if(var_01 != 1) {
          break;
        }
        if(!isDefined(level.kungfu_weapons) || !isDefined(scripts\engine\utility::array_find(level.kungfu_weapons[1], var_03))) {
          break;
        }
        return 1;
      case "chi_2":
        if(var_01 != 2) {
          break;
        }
        if(!isDefined(level.kungfu_weapons) || !isDefined(scripts\engine\utility::array_find(level.kungfu_weapons[2], var_03))) {
          break;
        }
        return 1;
    }

    return 0;
  } else if(interaction_is_weapon_buy(var_00)) {
    var_06 = var_0.script_noteworthy;

    if(var_0.script_parameters == "tickets") {
      if(self hasweapon(var_06)) {
        return 0;
      }

      self.itempicked = var_0.script_noteworthy;
      level.transactionid = randomint(100);
      scripts\cp\zombies\zombie_analytics::log_item_purchase_with_tickets(level.wave_num, self.itempicked, level.transactionid);
    }

    var_07 = weaponmaxammo(var_0.script_noteworthy);
    var_08 = scripts\cp\perks\prestige::prestige_getminammo();
    var_09 = int(var_08 * var_07);
    var_10 = self getweaponammostock(var_06);

    if(var_10 >= var_09) {
      return 0;
    }
  }

  if(var_0.script_parameters == "tickets") {
    if(self.num_tickets >= var_04) {
      return 1;
    }

    return 0;
  }

  if(scripts\cp\cp_persistence::player_has_enough_currency(var_04, var_02)) {
    return 1;
  }

  return 0;
}

take_player_money(var_00, var_01) {
  scripts\cp\cp_persistence::take_player_currency(var_00, 1, var_01);
}

should_interaction_fill_consumable_meter(var_00) {
  if(!isDefined(var_00)) {}

  switch (var_00) {
    case "wondercard_machine":
    case "bleedoutPenalty":
    case "atm":
      return 0;
    default:
      return 1;
  }
}

func_5030(var_00, var_01) {}

func_7DBA(var_00, var_01) {
  var_02 = level.interactions[var_0.script_noteworthy].cost;
  var_03 = scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy);
  var_04 = var_01 getcurrentweapon();
  var_05 = scripts\cp\utility::getbaseweaponname(var_04);
  var_06 = weaponmaxammo(var_04);
  var_07 = var_01 scripts\cp\perks\prestige::prestige_getminammo();
  var_08 = int(var_07 * var_06);
  var_09 = var_01 getweaponammostock(var_04);
  var_10 = self getweaponslistall();

  foreach(var_12 in var_10) {
    var_13 = scripts\cp\utility::getrawbaseweaponname(var_12);

    if(var_13 == scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy)) {
      var_14 = var_12;
      var_09 = self getweaponammostock(var_14);
      var_06 = weaponmaxammo(var_14);
      var_08 = int(var_07 * var_06);
    }
  }

  if(var_0.script_parameters == "tickets") {
    return level.interaction_hintstrings[var_0.script_noteworthy];
  }

  switch (var_02) {
    case 250:
      return &"CP_ZMB_INTERACTIONS_TICKETS_AMMO";
    case 1500:
    case 1250:
    case 1000:
    case 500:
      return &"COOP_INTERACTIONS_PURCHASE_AMMO";
    default:
      return &"COOP_INTERACTIONS_PURCHASE_AMMO";
  }
}

func_502F(var_00, var_01) {
  if(var_01 scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy)) {
    return func_7DBA(var_00, var_01);
  }

  return undefined;
}

func_9A3D() {
  level endon("game_ended");

  for(;;) {
    level waittill("interaction", var_00, var_01, var_02);

    switch (var_00) {
      case "wall_buy":
        if(isDefined(var_2.purchasing_ammo)) {
          if(soundexists("purchase_ammo")) {
            var_02 playlocalsound("purchase_ammo");
          }
        } else if(soundexists("purchase_weapon"))
          var_02 playlocalsound("purchase_weapon");

        break;
      case "purchase":
        var_03 = func_7A4B(var_01, var_02);

        if(isDefined(var_03) && soundexists(var_03)) {
          var_02 playlocalsound(var_03);
        }

        break;
      case "purchase_denied":
        if(var_1.name == "jaroslav_machine" && soundexists("ui_consumable_purchase_deny")) {
          var_02 playlocalsound("ui_consumable_purchase_deny");
        }
        else if(var_1.name == "lost_and_found" && soundexists("lost_and_found_deny")) {
          var_02 playlocalsound("lost_and_found_deny");
        }
        else if(soundexists("trap_control_panel_deny") && var_1.name == "beamtrap" || var_1.name == "interaction_discoballtrap" || var_1.name == "scrambler" || var_1.name == "blackhole_trap" || var_1.name == "rockettrap") {
          var_02 playlocalsound("trap_control_panel_deny");
        }
        else if(soundexists("purchase_deny")) {
          var_02 playlocalsound("purchase_deny");
        }

        break;
    }
  }
}

func_7A4B(var_00, var_01) {
  var_02 = [];

  switch (var_0.name) {
    case "secure_window":
      return undefined;
    case "lost_and_found":
      var_02 = ["lost_and_found_purchase"];
      break;
    case "rockettrap":
    case "blackhole_trap":
    case "scrambler":
    case "interaction_discoballtrap":
    case "beamtrap":
      var_02 = ["trap_control_panel_purchase"];
      break;
    case "sliding_door":
    case "debris":
      var_02 = ["purchase_door"];
      break;
    case "team_door_switch":
      var_02 = ["purchase_door"];
      break;
    case "atm_deposit":
      var_02 = ["atm_deposit"];
      break;
    case "atm_withdrawal":
      var_02 = ["atm_withdrawal"];
      break;
    case "repair_kevin":
    case "kevin_battery":
    case "kevin_head":
    case "souvenir_pickup":
      var_02 = ["zmb_item_pickup"];
      break;
    case "medium_ticket_prize":
    case "small_ticket_prize":
    case "iw7_forgefreeze_zm+forgefreezealtfire":
    case "zfreeze_semtex_mp":
      var_02 = ["purchase_ticket"];
      break;
    case "large_ticket_prize":
      var_02 = ["ark_purchase"];
      break;
    case "ark_quest_station":
      var_02 = ["ark_turn_in"];
      break;
  }

  if(!var_2.size) {
    return undefined;
  }

  return scripts\engine\utility::random(var_02);
}

interaction_post_activate_update(var_00) {
  if(!isDefined(var_0.post_activate_update)) {
    return;
  }
  if(isDefined(level.interaction_post_activate_update_func)) {
    level thread[[level.interaction_post_activate_update_func]](var_00, self);
    return;
  }

  if(isDefined(var_0.souvenir)) {
    var_0.souvenir_toy delete();
    var_0.souvenir_toy = spawn("script_model", var_0.souvenir_origin);
    var_0.souvenir_toy setModel(var_0.souvenir_model);
    var_0.script_noteworthy = "crafting_station";
    var_0.requires_power = 1;
    var_0.powered_on = 1;
    var_0.script_parameters = "requires_power";
    var_0.name = "crafting_station";

    if(isDefined(var_0.souvenir_fx)) {
      var_0.souvenir_fx delete();
    }

    if(scripts\cp\utility::is_valid_player()) {
      self playlocalsound("zmb_item_pickup");
    }

    var_0.souvenir = undefined;
    var_0.post_activate_update = undefined;
    var_0.power_name = undefined;
    var_0.crafted_souvenir = undefined;
  }
}

func_9A26(var_00) {
  return var_0.script_noteworthy == "trap_electric" || var_0.script_noteworthy == "trap_firebarrel";
}

interaction_is_white_ark(var_00) {
  return var_0.script_noteworthy == "white_ark";
}

interaction_is_ark_quest_station(var_00) {
  return var_0.script_noteworthy == "ark_quest_station";
}

func_9A15(var_00) {
  return var_0.script_noteworthy == "atm_withdrawal" || var_0.script_noteworthy == "atm_deposit";
}

func_9A1C(var_00) {
  return var_0.script_noteworthy == "neil_head";
}

interactionislostandfound(var_00) {
  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "lost_and_found") {
    return 1;
  }

  if(isDefined(var_0.name) && var_0.name == "lost_and_found") {
    return 1;
  }

  return 0;
}

interaction_is_window_entrance(var_00) {
  return var_0.script_noteworthy == "secure_window";
}

func_9A1E(var_00) {
  return var_0.script_noteworthy == "pillage_item";
}

func_9A19(var_00) {
  return var_0.script_noteworthy == "fast_travel";
}

interaction_is_crafting_station(var_00) {
  return var_0.script_noteworthy == "crafting_station";
}

interaction_is_grenade_wall_buy(var_00) {
  return var_0.script_noteworthy == "power_bioSpike" || var_0.script_noteworthy == "power_c4";
}

func_9A16(var_00) {
  return var_0.script_noteworthy == "crafting_pickup";
}

interaction_is_fortune_teller(var_00) {
  return var_0.script_noteworthy == "jaroslav_machine";
}

interaction_is_perk(var_00) {
  return isDefined(var_0.perk_type);
}

func_9A42(var_00) {
  return var_0.requires_power && !var_0.powered_on;
}

interaction_is_souvenir(var_00) {
  return isDefined(var_0.crafted_souvenir);
}

player_has_souvenir(var_00, var_01) {
  if(isDefined(var_1.current_crafted_inventory)) {
    return var_1.current_crafted_inventory.item == var_0.script_noteworthy;
  }

  return 0;
}

func_9A2C(var_00) {
  return var_0.script_noteworthy == "crafted_windowtrap";
}

interaction_is_challenge_station(var_00) {
  return isDefined(var_0.groupname) && var_0.groupname == "challenge";
}

interaction_is_valid(var_00, var_01) {
  if(var_01 isinphase()) {
    return 0;
  }

  if(isDefined(var_0.triggered)) {
    return 0;
  }

  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, var_00)) {
    return 0;
  }

  if(scripts\engine\utility::is_true(var_0.out_of_order)) {
    level notify("player_accessed_interaction_on_cooldown", var_01);
    return 0;
  }

  if(scripts\engine\utility::is_true(var_0.in_use)) {
    return 0;
  }

  if(func_9A42(var_00)) {
    level notify("player_accessed_nonpowered_interaction", var_01);

    if(isDefined(var_0.perk_type) && soundexists("perk_machine_deny")) {
      var_01 playlocalsound("perk_machine_deny");
    }
    else {
      var_01 playlocalsound("purchase_deny");
    }

    return 0;
  }

  if(isDefined(var_0.cooling_down)) {
    level notify("player_accessed_interaction_on_cooldown", var_01);
    return 0;
  }

  if(scripts\engine\utility::array_contains(var_1.disabled_interactions, var_00)) {
    return 0;
  }

  return 1;
}

interaction_is_weapon_upgrade(var_00) {
  return var_0.script_noteworthy == "weapon_upgrade";
}

interaction_is_weapon_buy(var_00) {
  if(isDefined(var_0.name)) {
    return var_0.name == "wall_buy";
  }
  else {
    return 0;
  }
}

interaction_is_door_buy(var_00) {
  return var_0.script_noteworthy == "debris_350" || var_0.script_noteworthy == "debris_750" || var_0.script_noteworthy == "debris_1000" || var_0.script_noteworthy == "debris_1250" || var_0.script_noteworthy == "debris_1500" || var_0.script_noteworthy == "debris_2000" || var_0.script_noteworthy == "team_door_switch" || var_0.script_noteworthy == "team_door";
}

interaction_is_special_door_buy(var_00) {
  return var_0.script_noteworthy == "power_door_sliding" || var_0.script_noteworthy == "team_door_switch" || var_0.script_noteworthy == "team_door";
}

interaction_is_chi_door(var_00) {
  return var_0.script_noteworthy == "chi_0" || var_0.script_noteworthy == "chi_1" || var_0.script_noteworthy == "chi_2";
}

interaction_is_ticket_buy(var_00) {
  return var_0.script_noteworthy == "small_ticket_prize" || var_0.script_noteworthy == "medium_ticket_prize" || var_0.script_noteworthy == "arcade_counter_grenade" || var_0.script_noteworthy == "arcade_counter_ammo" || var_0.script_noteworthy == "large_ticket_prize" || var_0.script_noteworthy == "zfreeze_semtex_mp" || var_0.script_noteworthy == "iw7_forgefreeze_zm+forgefreezealtfire" || var_0.script_noteworthy == "gold_teeth";
}

func_9A1F(var_00) {
  return isDefined(var_0.power_name);
}

func_D0C3(var_00) {
  return scripts\cp\powers\coop_powers::hasequipment(var_0.power_name);
}

can_use_perk(var_00) {
  if(scripts\cp\utility::has_zombie_perk(var_0.perk_type)) {
    return 0;
  }
  else if(self.self_revives_purchased >= self.max_self_revive_machine_use && var_0.perk_type == "perk_machine_revive") {
    return 0;
  }
  else if(isDefined(self.zombies_perks) && self.zombies_perks.size > 4) {
    return 0;
  }

  return 1;
}

interaction_show_fail_reason(var_00, var_01, var_02, var_03) {
  thread interaction_fail_internal(var_00, var_01, var_02, var_03);
}

interaction_fail_internal(var_00, var_01, var_02, var_03) {
  self endon("disconnect");
  level notify("interaction", "purchase_denied", level.interactions[var_0.script_noteworthy], self);
  self.delay_hint = 1;
  self.interaction_trigger sethintstring(var_01);
  wait 1;
  self.delay_hint = undefined;
  func_F422(self.interaction_trigger, var_00);
}

disable_linked_interactions(var_00) {
  var_01 = scripts\engine\utility::getstructarray(var_0.script_noteworthy, "script_noteworthy");

  foreach(var_03 in var_01) {
    if(var_3.target == var_0.target) {
      scripts\cp\zombies\zombie_analytics::func_AF74(var_3.name, 0);
      remove_from_current_interaction_list(var_03);
    }
  }
}

enable_linked_interactions(var_00) {
  var_01 = scripts\engine\utility::getstructarray(var_0.script_noteworthy, "script_noteworthy");

  foreach(var_03 in var_01) {
    if(var_3.target == var_0.target) {
      scripts\cp\zombies\zombie_analytics::func_AF74(var_3.name, 1);
      add_to_current_interaction_list(var_03);
    }
  }
}

disable_like_interactions(var_00) {
  var_01 = scripts\engine\utility::getstructarray(var_0.script_noteworthy, "script_noteworthy");

  foreach(var_03 in var_01) {
    scripts\cp\zombies\zombie_analytics::func_AF74(var_3.name, 0);
    remove_from_current_interaction_list(var_03);
  }
}

enable_like_interactions(var_00) {
  var_01 = scripts\engine\utility::getstructarray(var_0.script_noteworthy, "script_noteworthy");

  foreach(var_03 in var_01) {
    scripts\cp\zombies\zombie_analytics::func_AF74(var_3.name, 1);
    add_to_current_interaction_list(var_03);
  }
}

interaction_cooldown(var_00, var_01) {
  var_02 = scripts\engine\utility::getstructarray(var_0.script_noteworthy, "script_noteworthy");

  foreach(var_04 in var_02) {
    if(var_4.target == var_0.target) {
      var_4.cooling_down = 1;
    }
  }

  if(scripts\engine\utility::is_true(level.func_4614)) {
    wait 1;
  }
  else {
    level scripts\engine\utility::waittill_any_timeout(var_01, "override_cooldowns");
  }

  foreach(var_04 in var_02) {
    if(var_4.target == var_0.target) {
      var_4.cooling_down = undefined;
    }
  }

  var_08 = 5184;

  foreach(var_10 in level.players) {
    foreach(var_04 in var_02) {
      if(distancesquared(var_10.origin, var_4.origin) >= var_08) {
        continue;
      }
      var_10 refresh_interaction();
    }
  }
}

get_linked_interactions(var_00) {
  var_01 = [];
  var_02 = scripts\engine\utility::getstructarray(var_0.script_noteworthy, "script_noteworthy");

  foreach(var_04 in var_02) {
    if(var_4.target == var_0.target) {
      var_1[var_1.size] = var_04;
    }
  }

  return var_01;
}

refresh_interaction() {
  if(isDefined(self.interaction_trigger.name)) {
    scripts\cp\zombies\zombie_analytics::func_AF74(self.interaction_trigger.name, 0);
  }

  self notify("stop_interaction_logic");
  self.last_interaction_point = undefined;
  self.interaction_trigger sethintstringparams();
  self setclientomnvar("zm_interaction_cost", -1);
}

func_9A3A(var_00) {
  return scripts\engine\utility::is_true(var_0.requires_power) && isDefined(var_0.power_area);
}

func_55A2() {
  var_00 = scripts\engine\utility::getstructarray("interaction", "targetname");

  foreach(var_02 in var_00) {
    if(interaction_is_weapon_buy(var_02) || interaction_is_grenade_wall_buy(var_02) || interaction_is_ticket_buy(var_02) || isDefined(var_2.script_parameters) && var_2.script_parameters == "tickets") {
      var_2.disabled = 1;
      scripts\cp\zombies\zombie_analytics::func_AF74(var_2.name, 0);
      continue;
    }
  }
}

func_55A3(var_00) {
  var_01 = scripts\engine\utility::getstructarray("interaction", "targetname");

  foreach(var_03 in var_01) {
    if(interaction_is_weapon_buy(var_03) || interaction_is_grenade_wall_buy(var_03) || interaction_is_ticket_buy(var_03) || isDefined(var_3.script_parameters) && var_3.script_parameters == "tickets") {
      scripts\cp\zombies\zombie_analytics::func_AF74(var_3.name, 0);
      remove_from_current_interaction_list_for_player(var_03, var_00);
      continue;
    }
  }
}

func_6255(var_00) {
  var_01 = scripts\engine\utility::getstructarray("interaction", "targetname");

  foreach(var_03 in var_01) {
    if(interaction_is_weapon_buy(var_03) || interaction_is_grenade_wall_buy(var_03) || interaction_is_ticket_buy(var_03) || isDefined(var_3.script_parameters) && var_3.script_parameters == "tickets") {
      scripts\cp\zombies\zombie_analytics::func_AF74(var_3.name, 1);
      add_to_current_interaction_list_for_player(var_03, var_00);
      continue;
    }
  }
}

souvenir_team_splash(var_00, var_01) {
  foreach(var_03 in level.players) {
    var_03 thread scripts\cp\cp_hud_message::showsplash(var_00, undefined, var_01);
    wait 0.1;
  }
}