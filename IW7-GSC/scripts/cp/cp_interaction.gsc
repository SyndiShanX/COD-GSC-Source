/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\cp_interaction.gsc
*****************************************/

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
  level.var_9A46 = 0;
  level.weapon_hint_func = ::func_502F;
  level.var_13C63 = ::func_5030;
  level thread func_9A3D();
  foreach(var_01 in level.current_interaction_structs) {
    if(!isDefined(var_01.name)) {
      var_01.name = var_01.script_noteworthy;
    }

    if(!isDefined(var_01.script_parameters)) {
      var_01.script_parameters = "default";
    }

    if(var_01.script_parameters == "requires_power") {
      var_01.requires_power = 1;
      var_01.powered_on = 0;
      var_01.power_area = get_area_for_power(var_01);
      continue;
    }

    var_01.requires_power = 0;
    var_01.powered_on = 0;
  }

  level thread func_5CF3();
  if(isDefined(level.var_768C)) {
    [[level.var_768C]]();
  }

  if(isDefined(level.map_interaction_func)) {
    [[level.map_interaction_func]]();
  }

  var_03 = getarraykeys(level.interactions);
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    if(isDefined(level.interactions[var_03[var_04]].init_func)) {
      level thread[[level.interactions[var_03[var_04]].init_func]]();
    }

    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("init_interaction_done");
  foreach(var_06 in level.players) {
    var_07 = var_06 getcurrentweapon();
    if(isDefined(level.wave_num) && isDefined(var_07)) {
      self.var_13BE8 = [level.wave_num][var_07];
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
    if(isDefined(var_01.groupname) && var_01.groupname == "locOverride") {
      continue;
    }

    var_02 = scripts\engine\utility::drop_to_ground(var_01.origin, 10, -200);
    var_01.origin = var_02 + (0, 0, 1);
    wait(0.05);
  }
}

get_area_for_power(param_00) {
  var_01 = getEntArray("spawn_volume", "targetname");
  foreach(var_03 in var_01) {
    if(ispointinvolume(param_00.origin, var_03)) {
      if(isDefined(var_03.basename)) {
        return var_03.basename;
      }
    }
  }

  return undefined;
}

func_96E3() {
  var_00 = getEntArray("player_use_trigger", "targetname");
  foreach(var_02 in var_00) {
    var_02.in_use = 0;
    var_02 scripts\engine\utility::trigger_off();
  }
}

func_23CB() {
  level endon("game_ended");
  wait(5);
  for(;;) {
    var_00 = getEntArray("interactionEnt", "targetname");
    foreach(var_02 in level.players) {
      if(!scripts\engine\utility::istrue(var_02.var_23DE)) {
        var_02.var_23DE = 1;
        var_03 = spawn("script_model", var_02.origin);
        var_02.guidedinteractionent = var_03;
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

func_BC88(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  var_01 = undefined;
  var_02 = undefined;
  var_03 = -1;
  var_04 = 0;
  var_05 = squared(75);
  for(;;) {
    if(scripts\engine\utility::istrue(param_00.inlaststand) || scripts\engine\utility::istrue(param_00.siege_activated) || scripts\engine\utility::istrue(param_00.flung)) {
      var_01 = undefined;
      func_12E34(param_00, -1, undefined, undefined);
    } else if(!param_00 scripts\cp\utility::areinteractionsenabled()) {
      var_01 = undefined;
      func_12E34(param_00, -1, undefined, undefined);
    } else {
      var_06 = [];
      level.current_interaction_structs = scripts\engine\utility::array_removeundefined(level.current_interaction_structs);
      var_07 = scripts\engine\utility::get_array_of_closest(param_00.origin, level.current_interaction_structs, undefined, 10, 750, 1);
      foreach(var_09 in param_00.disabled_interactions) {
        var_07 = scripts\engine\utility::array_remove(var_07, var_09);
      }

      foreach(var_09 in var_07) {
        if(func_9C64(param_00, var_09, var_01)) {
          var_06[var_06.size] = var_09;
        }
      }

      if(scripts\engine\utility::istrue(param_00.resetguidedinteraction)) {
        var_01 = undefined;
        func_12E34(param_00, -1, undefined, undefined);
        param_00.resetguidedinteraction = undefined;
        wait(0.05);
        continue;
      }

      var_06 = scripts\engine\utility::array_removeundefined(var_06);
      var_06 = scripts\engine\utility::array_remove_duplicates(var_06);
      if(var_06.size < 1) {
        var_01 = undefined;
        func_12E34(param_00, -1, undefined, undefined);
        wait(0.05);
        continue;
      }

      var_06 = sortbydistance(var_06, param_00.origin);
      foreach(var_0E in var_06) {
        var_04 = 0;
        if(param_00 adsbuttonpressed()) {
          func_12E34(param_00, -1, undefined, undefined);
          var_01 = undefined;
          while(param_00 adsbuttonpressed()) {
            wait(0.05);
          }
        }

        if(distancesquared(param_00.origin, var_0E.origin) <= var_05) {
          func_12E34(param_00, -1, undefined, undefined);
          var_01 = undefined;
          continue;
        } else if(isDefined(var_01) && var_0E == var_01) {
          break;
        } else {
          var_02 = func_7A4A(var_0E, param_00);
          var_03 = func_7A48(var_0E, param_00);
          var_01 = var_0E;
          var_04 = 1;
          break;
        }
      }

      if(var_04) {
        func_12E34(param_00, var_03, var_02, var_01);
      }
    }

    wait(0.1);
  }
}

func_7A4A(param_00, param_01) {
  var_02 = (0, 0, 68);
  var_03 = param_00.origin;
  if(interaction_is_weapon_buy(param_00)) {
    if(isDefined(param_00.target)) {
      var_04 = scripts\engine\utility::getstruct(param_00.target, "targetname");
      if(isDefined(var_04)) {
        var_03 = var_04.origin;
      } else {
        var_03 = param_00.origin;
      }
    }
  } else if(!isDefined(var_03)) {
    var_03 = param_00.origin;
  }

  if(isDefined(level.guided_interaction_offset_func)) {
    var_02 = [[level.guided_interaction_offset_func]](param_00, param_01);
  } else {
    var_05 = get_area_for_power(param_00);
    if(isDefined(param_00.name)) {
      var_06 = param_00.script_noteworthy;
      switch (var_06) {
        case "iw7_ripper_zm+ripperscope_zm":
        case "iw7_ripper_zmr":
        case "shooting_gallery":
          var_02 = (0, 0, 12);
          break;

        case "iw7_ake_zm":
        case "iw7_ake_zml":
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
          } else {
            var_02 = (0, 0, 56);
          }
          break;

        default:
          var_02 = (0, 0, 56);
          break;
      }
    }
  }

  var_07 = scripts\engine\utility::drop_to_ground(var_03, 12) + var_02;
  return var_07;
}

func_7A48(param_00, param_01) {
  var_02 = 1;
  var_03 = int(level.interactions[param_00.script_noteworthy].cost);
  if(interaction_is_weapon_buy(param_00)) {
    if(param_01 scripts\cp\cp_weapon::has_weapon_variation(param_00.script_noteworthy)) {
      var_04 = scripts\cp\utility::getrawbaseweaponname(param_00.script_noteworthy);
      var_05 = param_01 scripts\cp\cp_weapon::get_weapon_level(var_04);
      if(var_05 > 1) {
        var_03 = 4500;
      } else {
        var_02 = 0.5;
        var_03 = int(var_03 * var_02);
      }
    } else {
      var_03 = int(var_03 * var_02);
    }
  } else if(interaction_is_weapon_upgrade(param_00)) {
    var_06 = param_01 getcurrentweapon();
    if(param_01 scripts\cp\cp_weapon::can_upgrade(var_06)) {
      var_05 = param_01 scripts\cp\cp_weapon::get_weapon_level(var_06);
      var_03 = scripts\engine\utility::ter_op(var_05 > 1, 10000, 5000);
    } else {
      var_03 = 0;
    }

    if(scripts\engine\utility::istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
      var_03 = 0;
    }
  } else if(func_9CDB(param_00)) {
    if(isDefined(param_00.name) && !param_01 can_use_perk(param_00)) {
      var_03 = 0;
    } else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && isDefined(param_00.name) && param_00.name == "perk_machine_revive") {
      var_03 = 500;
    } else {
      var_03 = get_perk_machine_cost(param_00);
    }
  } else if(interaction_is_fortune_teller(param_00)) {
    if(param_01.card_refills >= 1) {
      var_03 = level.fortune_visit_cost_2;
    } else {
      var_03 = level.fortune_visit_cost_1;
    }
  }

  if(param_01 scripts\cp\utility::is_consumable_active("next_purchase_free")) {
    var_03 = 0;
  }

  return var_03;
}

func_9CDB(param_00) {
  if(!isDefined(param_00.name)) {
    return 0;
  }

  if(param_00.name == "perk_machine_more" || param_00.name == "perk_machine_rat_a_tat" || param_00.name == "perk_machine_revive" || param_00.name == "perk_machine_run" || param_00.name == "perk_machine_smack" || param_00.name == "perk_machine_tough" || param_00.name == "perk_machine_flash" || param_00.name == "perk_machine_boom" || param_00.name == "perk_machine_fwoosh" || param_00.name == "perk_machine_deadeye" || param_00.name == "perk_machine_change" || param_00.name == "perk_machine_zap") {
    return 1;
  }

  return 0;
}

get_perk_machine_cost(param_00) {
  switch (param_00.perk_type) {
    case "perk_machine_deadeye":
    case "perk_machine_zap":
    case "perk_machine_fwoosh":
    case "perk_machine_boom":
    case "perk_machine_change":
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

func_9C64(param_00, param_01, param_02) {
  level endon("game_ended");
  param_00 endon("disconnect");
  if(!isDefined(param_01)) {
    return 0;
  }

  var_03 = undefined;
  if(isDefined(param_01.name)) {
    var_03 = param_01.name;
  } else {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_01.out_of_order) || isDefined(param_01.cooling_down)) {
    return 0;
  }

  if(isDefined(param_01.perk_type) && param_01.perk_type == "perk_machine_revive" && param_00.self_revives_purchased >= param_00.max_self_revive_machine_use) {
    return 0;
  }

  if(!scripts\cp\utility::coop_mode_has("wall_buys")) {
    if(interaction_is_weapon_buy(param_01) || interaction_is_grenade_wall_buy(param_01) || interaction_is_ticket_buy(param_01) || interaction_is_chi_door(param_01) || isDefined(param_01.script_parameters) && param_01.script_parameters == "tickets") {
      return 0;
    }
  }

  if(interaction_is_fortune_teller(param_01)) {
    if(!scripts\engine\utility::istrue(level.unlimited_fnf)) {
      if(param_00.card_refills >= 2) {
        return 0;
      }
    }
  }

  if(var_03 == "secure_window" || var_03 == "white_ark" || var_03 == "wor_standee" || var_03 == "generator" || var_03 == "center_speaker_locs" || var_03 == "fourth_speaker" || var_03 == "ark_quest_station" || var_03 == "dj_quest_part_1" || var_03 == "dj_quest_part_2" || var_03 == "dj_quest_part_3" || var_03 == "dj_quest_door" || var_03 == "dj_quest_speaker" || var_03 == "lost_and_found" || var_03 == "fast_travel" || var_03 == "crafting_pickup" || var_03 == "pap_quest" || var_03 == "team_door" || var_03 == "neil_head" || var_03 == "neil_battery" || var_03 == "neil_repair" || var_03 == "neil_firmware" || var_03 == "barnstorming_group" || var_03 == "demon_group" || var_03 == "starmaster_group" || var_03 == "group_cosmicarc" || var_03 == "group_pitfall" || var_03 == "group_riverraid" || var_03 == "spider_arcade_group" || var_03 == "robottank_group" || var_03 == "gator_teeth_placement" || var_03 == "atm_withdrawal" && isDefined(level.atm_amount_deposited) && level.atm_amount_deposited < 1000 || var_03 == "crafting_station" && !isDefined(param_00.current_crafting_struct)) {
    return 0;
  }

  if(isDefined(level.guidedinteractionexclusion)) {
    if(![
        [level.guidedinteractionexclusion]
      ](param_01, param_00, var_03)) {
      return 0;
    }
  }

  if(scripts\engine\utility::istrue(param_01.requires_power) && !scripts\engine\utility::istrue(param_01.powered_on)) {
    return 0;
  }

  if(var_03 == "boss_fight_activation") {
    if(scripts\engine\utility::flag_exist("boss_fight_ready_soon") && scripts\engine\utility::flag("boss_fight_ready_soon")) {
      return 0;
    } else {
      return 1;
    }
  }

  if(isDefined(level.active_volume_check)) {
    if(var_03 == "weapon_upgrade") {
      return 1;
    } else if(!self[[level.active_volume_check]](param_01.origin)) {
      return 0;
    }
  }

  var_04 = param_01.origin;
  if(isDefined(level.guidedinteractionendposoverride)) {
    var_04 = [[level.guidedinteractionendposoverride]](param_00, param_01);
  }

  if(!scripts\engine\utility::within_fov(param_00.origin, param_00 getplayerangles(), var_04, cos(25))) {
    return 0;
  }

  if(interaction_is_door_buy(param_01) || interaction_is_chi_door(param_01)) {
    var_05 = get_spawn_volumes_player_is_in(0, undefined, param_00);
    foreach(var_07 in var_05) {
      var_08 = var_07 func_77D3();
      foreach(var_0A in var_08) {
        if(ispointinvolume(param_01.origin, var_0A)) {
          return 0;
        }
      }
    }
  }

  var_0D = physics_createcontents(["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip", "physicscontents_solid"]);
  if(param_01.script_noteworthy == "trap_hydrant") {
    var_04 = param_01.origin + (0, 0, 50);
  }

  if(scripts\common\trace::ray_trace_passed(param_00 getEye(), var_04, [param_00], var_0D)) {
    return 1;
  }

  return 0;
}

func_77D3() {
  if(isDefined(level.var_186E[self.basename])) {
    var_00 = [];
    foreach(var_02 in level.var_186E[self.basename]) {
      var_00[var_00.size] = level.var_10817[var_02];
    }

    return var_00;
  }

  return [];
}

func_9C0F(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(!isDefined(param_00.var_186E)) {
    return 0;
  }

  foreach(var_02 in param_00.var_186E) {
    if(!var_02.var_19) {
      continue;
    }

    if(self istouching(var_02)) {
      return 1;
    }
  }

  return 0;
}

get_spawn_volumes_player_is_in(param_00, param_01, param_02) {
  if(isDefined(level.var_7C80)) {
    return [[level.var_7C80]]();
  }

  var_03 = [];
  var_04 = level.spawn_volume_array;
  foreach(var_06 in var_04) {
    if(!var_06.var_19) {
      continue;
    }

    var_07 = 0;
    if(isDefined(param_01) && !param_02 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(param_02 istouching(var_06)) {
      var_07 = 1;
    } else if(scripts\engine\utility::istrue(param_00) && param_02 func_9C0F(var_06)) {
      var_07 = 1;
    }

    if(var_07) {
      var_03[var_03.size] = var_06;
    }
  }

  return var_03;
}

func_12E34(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_01)) {
    param_01 = -1;
  }

  if(isDefined(param_02) && param_02 != self.origin) {
    param_00 setclientomnvar("zm_interaction_cost", -1);
    wait(0.1);
    self dontinterpolate();
    self.origin = param_02;
    wait(0.1);
  }

  if(isDefined(param_03) && param_03.script_parameters == "tickets") {
    param_01 = 2;
  }

  if(isDefined(param_03) && interaction_is_sliding_door(param_03) && scripts\engine\utility::istrue(param_03.player_opened)) {
    param_01 = 0;
  }

  param_00 setclientomnvar("zm_interaction_cost", param_01);
}

func_79D0(param_00) {
  foreach(var_02 in param_00) {
    if(!scripts\engine\utility::istrue(var_02.in_use)) {
      var_02.in_use = 1;
      var_02 setModel("tag_origin");
      return var_02;
    }
  }
}

func_DF3C(param_00) {
  param_00 waittill("disconnect");
  self.in_use = 0;
  self notify("interaction_ent_released");
}

func_23D8() {
  level endon("game_ended");
  for(;;) {
    level waittill("player_spawned", var_00);
    var_00.interaction_trigger = get_player_interaction_trigger();
    if(!isDefined(var_00.interaction_trigger)) {
      break;
    }

    reset_interaction_triggers();
    if(!isDefined(var_00.interaction_trigger)) {
      iprintlnbold("NO TRIGGER FOUND!");
    }

    var_00.last_interaction_point = undefined;
    var_00.interaction_trigger makeunusable();
    var_00 thread func_DF3F();
    var_00 thread player_interaction_monitor();
    var_00 thread func_D104();
  }
}

func_D104() {
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
  var_00 = getEntArray("player_use_trigger", "targetname");
  var_01 = undefined;
  foreach(var_03 in var_00) {
    if(!var_03.in_use) {
      var_03.in_use = 1;
      var_03 scripts\engine\utility::trigger_on();
      return var_03;
    }
  }

  return undefined;
}

func_DF3F() {
  var_00 = self.interaction_trigger;
  scripts\engine\utility::waittill_any_3("death", "disconnect");
  var_00.in_use = 0;
}

register_interaction(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = spawnStruct();
  var_09.name = param_00;
  var_09.hint_func = param_03;
  var_09.spend_type = param_01;
  var_09.tutorial = param_02;
  var_09.activation_func = param_04;
  var_09.enabled = 1;
  if(!isDefined(param_05)) {
    param_05 = 0;
  }

  var_09.cost = param_05;
  if(isDefined(param_06)) {
    var_09.requires_power = param_06;
  } else {
    var_09.requires_power = 0;
  }

  var_09.init_func = param_07;
  var_09.can_use_override_func = param_08;
  level.interactions[param_00] = var_09;
}

func_15BC(param_00, param_01) {
  level thread[[level.interactions[param_00].activation_func]](param_01);
}

reset_interaction_triggers() {
  foreach(var_01 in level.players) {
    if(isDefined(var_01.interaction_trigger)) {
      func_8E90(var_01);
    }
  }
}

func_8E90(param_00) {
  foreach(var_02 in level.players) {
    if(var_02 == param_00) {
      param_00.interaction_trigger enableplayeruse(param_00);
      continue;
    }

    param_00.interaction_trigger disableplayeruse(var_02);
  }
}

func_13D07(param_00, param_01) {
  for(;;) {
    thread scripts\engine\utility::draw_entity_bounds(param_01, 0.1, (1, 0, 0), 1, 0.1);
    wait(0.1);
  }
}

player_interaction_monitor() {
  self notify("player_interaction_monitor");
  self endon("player_interaction_monitor");
  self endon("disconnect");
  self endon("death");
  while(!isDefined(level.current_interaction_structs)) {
    wait(1);
  }

  if(isDefined(level.player_interaction_monitor)) {
    self thread[[level.player_interaction_monitor]]();
  }
}

flash_inventory() {
  self endon("window_trap_placed");
  self endon("death");
  if(!isDefined(self.var_BF46)) {
    self.var_BF46 = gettime() + 2500;
  } else if(gettime() < self.var_BF46) {
    return;
  }

  self.var_BF46 = gettime() + 2500;
  self setclientomnvar("zom_crafted_weapon", 0);
  wait(0.5);
  self setclientomnvar("zom_crafted_weapon", 8);
  wait(1.5);
}

can_use_interaction(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.iscarrying)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_00.disabled) || !scripts\cp\utility::areinteractionsenabled() || self isinphase()) {
    return 0;
  }

  if(self secondaryoffhandbuttonpressed() || self isthrowinggrenade() || self fragbuttonpressed()) {
    return 0;
  }

  if(!self isonground()) {
    return 0;
  }

  if(param_00.script_noteworthy == "game_race" && distancesquared(self.origin, param_00.origin) > 576) {
    return 0;
  }

  if(param_00.script_noteworthy == "ritual_stone" && scripts\engine\utility::istrue(self.rave_mode)) {
    return 0;
  }

  return 1;
}

reset_interaction() {
  if(isDefined(self.interaction_trigger.name)) {
    scripts\cp\zombies\zombie_analytics::func_AF74(self.interaction_trigger.name, 0);
  }

  wait(0.2);
  self notify("stop_interaction_logic");
  self.interaction_trigger makeunusable();
  self.last_interaction_point = undefined;
  self setclientomnvar("zm_tutorial_num", 0);
}

set_interaction_point(param_00, param_01) {
  if(scripts\engine\utility::istrue(self.interaction_trigger.var_55F3)) {
    return;
  }

  self.interaction_trigger dontinterpolate();
  self.last_interaction_point = param_00;
  var_02 = self getEye();
  self.interaction_trigger.origin = (param_00.origin[0], param_00.origin[1], var_02[2]);
  if(!isDefined(level.interactions[param_00.script_noteworthy].spend_type)) {
    level.interactions[param_00.script_noteworthy].spend_type = "null";
  }

  var_03 = level.interactions[param_00.script_noteworthy].spend_type;
  var_04 = undefined;
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    if(var_03 == "wall_buy") {
      var_04 = scripts\cp\cp_hud_message::get_has_seen_tutorial("wall_buy");
    }

    if(!scripts\engine\utility::istrue(var_04)) {
      if(isDefined(level.interactions[param_00.script_noteworthy].tutorial)) {
        thread scripts\cp\cp_hud_message::tutorial_lookup_func(var_03);
      }
    }
  }

  if(interaction_is_weapon_buy(param_00)) {
    if(!scripts\cp\cp_weapon::has_weapon_variation(param_00.script_noteworthy)) {
      var_05 = _meth_8228(param_00.script_noteworthy);
      var_06 = _meth_8220(param_00.script_noteworthy);
      self.interaction_trigger sethintstringparams(var_05, var_06);
    }
  } else if(interaction_is_weapon_upgrade(param_00)) {
    var_07 = self getcurrentweapon();
    var_05 = _meth_8228(var_07);
    if(scripts\cp\cp_weapon::can_upgrade(var_07)) {
      if(isDefined(var_05)) {
        var_08 = scripts\cp\cp_weapon::get_weapon_level(var_07);
        var_06 = scripts\engine\utility::ter_op(var_08 > 1, int(10000), int(5000));
        self.interaction_trigger sethintstringparams(var_05, var_06);
      }
    } else if(isDefined(var_05)) {
      self.interaction_trigger sethintstringparams(var_05);
    }
  } else if(func_9A16(param_00)) {
    if(!isDefined(self.current_crafting_struct)) {
      level thread[[level.interactions[param_00.script_noteworthy].activation_func]](param_00, self);
      interaction_post_activate_update(param_00);
      self notify("new_power", "souvenir_pickup");
      if(scripts\cp\utility::map_check(0)) {
        thread scripts\cp\cp_vo::add_to_nag_vo("nag_use_souvenircoin", "zmb_comment_vo", 60, 180, 6, 1);
      }

      return;
    }

    self.interaction_trigger.origin = param_00.origin;
  } else if(func_9A26(param_00)) {
    self.interaction_trigger.origin = (param_00.origin[0], param_00.origin[1], var_02[2] - 15);
  } else if(func_9A15(param_00) && param_00.script_noteworthy == "atm_withdrawal") {
    self.interaction_trigger sethintstringparams(level.atm_amount_deposited);
  } else if(interaction_is_fortune_teller(param_00)) {
    if(self.card_refills >= 1) {
      self.interaction_trigger sethintstringparams(level.fortune_visit_cost_2);
    } else {
      self.interaction_trigger sethintstringparams(level.fortune_visit_cost_1);
    }
  } else if(param_00.script_noteworthy == "spawned_essence") {
    self.interaction_trigger.origin = param_00.origin;
  }

  func_F422(self.interaction_trigger, param_00);
  if(!isDefined(param_01)) {
    thread func_135DF(param_00);
  }

  self.interaction_trigger makeusable();
}

_meth_8228(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  var_01 = scripts\cp\utility::getbaseweaponname(param_00);
  if(!isDefined(var_01)) {
    return undefined;
  }

  switch (var_01) {
    case "iw7_wylerdagger":
      return &"CP_QUEST_WOR_PURCHASE_SPEAKER";

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

    case "iw7_gauss":
      return &"CP_ZMB_WEAPONS_GAUSS";

    case "iw7_tacburst":
      return &"CP_ZMB_WEAPONS_TACBURST";

    case "iw7_unsalmg":
      return &"CP_ZMB_WEAPONS_UNSALMG";

    case "iw7_mag":
      return &"CP_ZMB_WEAPONS_MAG";

    case "iw7_cutie":
    case "iw7_cutier_zm":
    case "iw7_cutie_zm":
      return &"CP_ZMB_WEAPONS_MAD";

    case "iw7_venomx":
    case "iw7_venomx_zm_pap2":
    case "iw7_venomx_zm_pap1":
    case "iw7_venomx_zm":
      return &"CP_FINAL_VENOMX";

    default:
      if(isDefined(level.custom_weaponnamestring_func)) {
        return [
          [level.custom_weaponnamestring_func]
        ](var_01, param_00);
      }
      return &"CP_ZMB_WEAPONS_GENERIC";
  }
}

_meth_8220(param_00) {
  return int(level.interactions[param_00].cost);
}

func_F422(param_00, param_01) {
  var_02 = func_7A49(param_01, self);
  if(isDefined(var_02)) {
    self.interaction_trigger sethintstring(var_02);
  }

  if(param_01.script_noteworthy == "weapon_purchase" && isDefined(self.weapon_purchase_looking_at)) {
    if(scripts\cp\zombies\direct_boss_fight::is_kung_fu(self.weapon_purchase_looking_at.var_39C)) {
      self.interaction_trigger sethintstringparams(scripts\cp\zombies\direct_boss_fight::get_kung_fu_string(self.weapon_purchase_looking_at.var_39C));
    } else {
      var_03 = _meth_8228(self.weapon_purchase_looking_at.var_39C);
      self.interaction_trigger sethintstringparams(var_03, int(scripts\cp\zombies\direct_boss_fight::get_weapon_cost(self.weapon_purchase_looking_at.var_39C)));
    }
  } else if(interaction_is_weapon_buy(param_01)) {
    if(isDefined(var_02) && !isstring(var_02) && var_02 == &"COOP_INTERACTIONS_PURCHASE_AMMO") {
      var_04 = scripts\cp\utility::getrawbaseweaponname(param_01.script_noteworthy);
      var_05 = scripts\cp\cp_weapon::get_weapon_level(var_04);
      var_03 = _meth_8228(param_01.script_noteworthy);
      if(var_05 > 1) {
        self.interaction_trigger sethintstringparams(int(4500), var_03);
      } else {
        self.interaction_trigger sethintstringparams(int(0.5 * level.interactions[param_01.script_noteworthy].cost), var_03);
      }
    }
  } else if(interactionislostandfound(param_01) && scripts\engine\utility::istrue(self.have_things_in_lost_and_found)) {
    if(isDefined(self.lost_and_found_spot) && self.lost_and_found_spot == param_01) {
      func_F474(self);
    }
  } else if(interaction_is_window_entrance(param_01) || func_9A19(param_01) || func_9A1C(param_01) || func_9A1E(param_01) || interaction_is_weapon_upgrade(param_01) || func_9A16(param_01)) {
    self.interaction_trigger usetriggerrequirelookat(0);
    self.interaction_trigger setusefov(360);
  } else if(param_01.script_noteworthy == "coaster") {
    self.interaction_trigger usetriggerrequirelookat(1);
    self.interaction_trigger setusefov(245);
  } else if(param_01.script_noteworthy == "dj_quest_speaker_mid" || param_01.script_noteworthy == "dj_quest_speaker" || param_01.script_noteworthy == "weapon_purchase" || param_01.script_noteworthy == "boss_fight_activation") {
    self.interaction_trigger usetriggerrequirelookat(0);
    self.interaction_trigger setusefov(360);
  } else if(param_01.script_noteworthy == "spawned_essence") {
    self.interaction_trigger usetriggerrequirelookat(1);
    self.interaction_trigger setusefov(360);
  } else if(param_01.script_noteworthy == "dj_quest_part_1" || param_01.script_noteworthy == "dj_quest_part_2" || param_01.script_noteworthy == "dj_quest_part_3") {
    self.interaction_trigger usetriggerrequirelookat(0);
    self.interaction_trigger setusefov(245);
  } else {
    self.interaction_trigger usetriggerrequirelookat(1);
    self.interaction_trigger setusefov(160);
  }

  if(isDefined(level.interaction_trigger_properties_func)) {
    [[level.interaction_trigger_properties_func]](param_00, param_01, var_02);
  }
}

func_F474(param_00) {
  if(isDefined(param_00.lost_and_found_primary_count)) {
    var_01 = [];
    foreach(var_03 in param_00.lost_and_found_primary_count) {
      if(scripts\cp\utility::isstrstart(var_03, "alt_")) {
        continue;
      }

      if(!scripts\engine\utility::array_contains(var_01, var_03)) {
        var_01 = scripts\engine\utility::array_add(var_01, var_03);
      }
    }

    if(var_01.size > 2) {
      var_05 = _meth_8228(var_01[1]);
      var_06 = _meth_8228(var_01[2]);
      param_00.interaction_trigger sethintstringparams(var_05, var_06);
      return;
    }

    var_05 = _meth_8228(var_02[1]);
    param_00.interaction_trigger sethintstringparams(var_05);
  }
}

func_7A49(param_00, param_01) {
  if(isDefined(level.interactions[param_00.script_noteworthy].hint_func)) {
    return [[level.interactions[param_00.script_noteworthy].hint_func]](param_00, param_01);
  }

  if(isDefined(param_00.cooling_down)) {
    return &"COOP_INTERACTIONS_COOLDOWN";
  }

  if(param_00.requires_power && !param_00.powered_on) {
    if(isDefined(level.needspowerstring)) {
      return level.needspowerstring;
    } else {
      return &"COOP_INTERACTIONS_REQUIRES_POWER";
    }
  }

  if(interaction_is_weapon_buy(param_00)) {
    if(!scripts\cp\utility::coop_mode_has("wall_buys")) {
      return undefined;
    }
  }

  if(interaction_is_crafting_station(param_00)) {
    if(!isDefined(param_01.current_crafting_struct) && param_00.available_ingredient_slots > 0) {
      return level.interaction_hintstrings["crafting_nopiece"];
    }
  }

  if(func_9A16(param_00)) {
    return level.interaction_hintstrings["crafting_item_swap"];
  }

  return level.interaction_hintstrings[param_00.script_noteworthy];
}

func_C00C() {
  self endon("game_ended");
  for(;;) {
    level waittill("player_accessed_nonpowered_interaction", var_00, var_01);
    if(scripts\cp\utility::map_check(4)) {
      if(issubstr(var_01.script_noteworthy, "_trap")) {
        var_00 thread scripts\cp\cp_vo::try_to_play_vo("trap_not_avail", "zmb_comment_vo");
      } else {
        var_00 thread scripts\cp\cp_vo::try_to_play_vo("no_power", "zmb_comment_vo", "high", 30, 0, 0, 1, 50);
      }

      continue;
    }

    var_00 thread scripts\cp\cp_vo::try_to_play_vo("no_power", "zmb_comment_vo", "high", 30, 0, 0, 1, 50);
  }
}

func_4616() {
  self endon("game_ended");
  for(;;) {
    level waittill("player_accessed_interaction_on_cooldown", var_00, var_01);
    if(scripts\cp\utility::map_check(4)) {
      if(issubstr(var_01.script_noteworthy, "_trap")) {
        var_00 thread scripts\cp\cp_vo::try_to_play_vo("trap_cooldown", "zmb_comment_vo");
      } else {
        var_00 thread scripts\cp\cp_vo::try_to_play_vo("round_cooldown", "zmb_comment_vo", "high", 30, 0, 0, 1, 50);
      }

      continue;
    }

    var_00 thread scripts\cp\cp_vo::try_to_play_vo("round_cooldown", "zmb_comment_vo", "high", 30, 0, 0, 1, 50);
  }
}

func_135DF(param_00) {
  if(isDefined(level.wait_for_interaction_func)) {
    self thread[[level.wait_for_interaction_func]](param_00);
  }
}

play_weapon_purchase_vo(param_00, param_01) {
  var_02 = param_00.script_noteworthy;
  var_03 = getweaponbasename(var_02);
  switch (var_03) {
    case "iw7_cutier_zm":
    case "iw7_cutie_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_wonder", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_nunchucks_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_nunchucks", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_katana_zm":
      if(randomint(100) > 50) {
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_wonder", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      } else {
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_katana", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      }
      break;

    case "iw7_harpoon3_zm":
    case "iw7_harpoon_zm":
    case "iw7_harpoon4_zm":
    case "iw7_harpoon2_zm":
    case "iw7_harpoon1_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_wonder", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_ake_zm":
    case "iw7_ake_zml":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_assault", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_ameli_zm":
    case "iw7_lmg03_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_ar57_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_assault", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_axe_zm_pap2":
    case "iw7_axe_zm_pap1":
    case "iw7_axe_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_chargeshot_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_launcher", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_cheytac_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_sniper", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_crb_zml":
    case "iw7_crb_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_smg", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_devastator_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_shotgun", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_dischord_zm_pap1":
    case "iw7_dischord_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_wonder", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_emc_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_pistol", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_erad_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_smg", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_facemelter_zm_pap1":
    case "iw7_facemelter_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_wonder", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_fhr_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_smg", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_fmg_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_smg", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_forgefreeze_zm_pap2":
    case "iw7_forgefreeze_zm_pap1":
    case "iw7_forgefreeze_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_wonder", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_g18_zm":
    case "iw7_g18_zmr":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_pistol", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_lockon_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_launcher", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_glprox_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_launcher", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_headcutter_zm_pap1":
    case "iw7_headcutter_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_wonder", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_kbs_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_sniper", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_m1c_zm":
    case "iw7_m1_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_sniper", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_m4_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_assault", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_m8_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_assault", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_mauler_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_nrg_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_pistol", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_revolver_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_pistol", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_ripper_zm":
    case "iw7_ripper_zmr":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_smg", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_sdfar_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_assault", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_sdflmg_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_sdfshotty_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_shotgun", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_shredder_zm_pap1":
    case "iw7_shredder_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_wonder", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_sonic_zmr":
    case "iw7_sonic_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_shotgun", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_spas_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_shotgun", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_steeldragon_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_wonder", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_ump45_zml":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_smg", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    case "iw7_spasc_zm":
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_shotgun", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;

    default:
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      break;
  }
}

can_purchase_ammo(param_00) {
  var_01 = self getweaponslistall();
  var_02 = undefined;
  var_03 = undefined;
  var_04 = scripts\cp\utility::getrawbaseweaponname(param_00);
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
    var_0A = scripts\cp\perks\prestige::prestige_getminammo();
    var_0B = int(var_0A * var_09);
    if(var_08 < var_0B) {
      return 1;
    } else if(weaponmaxammo(var_02) == weaponclipsize(var_02) && self getweaponammoclip(var_02) < weaponclipsize(var_02)) {
      return 1;
    } else {
      return 0;
    }
  }

  return 1;
}

interaction_post_activate_delay(param_00) {
  self endon("disconnect");
  if(isDefined(level.should_post_activate_delay_func)) {
    if(![
        [level.should_post_activate_delay_func]
      ](param_00)) {
      return;
    }
  }

  if(interaction_is_door_buy(param_00)) {
    return;
  }

  if(func_9A15(param_00)) {
    return;
  }

  scripts\cp\utility::allow_player_interactions(0);
  wait(1.5);
  if(!scripts\cp\utility::areinteractionsenabled()) {
    scripts\cp\utility::allow_player_interactions(1);
  }
}

delayed_trigger_unset() {
  wait(0.25);
  self.triggered = undefined;
}

remove_from_current_interaction_list(param_00) {
  if(scripts\engine\utility::array_contains(level.current_interaction_structs, param_00)) {
    level.current_interaction_structs = scripts\engine\utility::array_remove(level.current_interaction_structs, param_00);
  }
}

add_to_current_interaction_list(param_00) {
  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, param_00)) {
    level.current_interaction_structs = scripts\engine\utility::array_add(level.current_interaction_structs, param_00);
  }
}

remove_from_current_interaction_list_for_player(param_00, param_01) {
  param_01.disabled_interactions = scripts\engine\utility::array_add(param_01.disabled_interactions, param_00);
}

add_to_current_interaction_list_for_player(param_00, param_01) {
  param_01.disabled_interactions = scripts\engine\utility::array_remove(param_01.disabled_interactions, param_00);
}

can_purchase_interaction(param_00, param_01, param_02, param_03) {
  if(isDefined(param_00.script_location) && param_00.script_location == "afterlife") {
    return 1;
  }

  if(scripts\cp\powers\coop_phaseshift::isentityphaseshifted(self)) {
    return 0;
  }

  if(isDefined(param_01)) {
    var_04 = param_01;
  } else if(interaction_is_sliding_door(param_01)) {
    var_04 = 0;
  } else {
    var_04 = level.interactions[param_01.script_noteworthy].cost;
  }

  if(interaction_is_fortune_teller(param_00)) {
    switch (self.card_refills) {
      case 0:
        var_04 = level.fortune_visit_cost_1;
        break;

      default:
        var_04 = level.fortune_visit_cost_2;
        break;
    }
  } else if(interaction_is_weapon_upgrade(param_00) && !scripts\cp\cp_weapon::can_upgrade(self getcurrentweapon())) {
    if(scripts\engine\utility::istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
      return 1;
    } else {
      return 0;
    }
  } else if(interaction_is_perk(param_00)) {
    if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && param_00.perk_type == "perk_machine_revive" && !scripts\cp\utility::has_zombie_perk("perk_machine_revive") && self.self_revives_purchased >= self.max_self_revive_machine_use) {
      return 0;
    }
  } else if(interaction_is_special_door_buy(param_00)) {
    var_05 = 0;
    switch (param_00.script_side) {
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
  } else if(interaction_is_chi_door(param_00)) {
    switch (param_00.script_noteworthy) {
      case "chi_0":
        if(param_01 != 0) {
          break;
        }

        if(!isDefined(level.kungfu_weapons) || !isDefined(scripts\engine\utility::array_find(level.kungfu_weapons[0], param_03))) {
          break;
        }
        return 1;

      case "chi_1":
        if(param_01 != 1) {
          break;
        }

        if(!isDefined(level.kungfu_weapons) || !isDefined(scripts\engine\utility::array_find(level.kungfu_weapons[1], param_03))) {
          break;
        }
        return 1;

      case "chi_2":
        if(param_01 != 2) {
          break;
        }

        if(!isDefined(level.kungfu_weapons) || !isDefined(scripts\engine\utility::array_find(level.kungfu_weapons[2], param_03))) {
          break;
        }
        return 1;
    }

    return 0;
  } else if(interaction_is_weapon_buy(param_00)) {
    var_06 = param_00.script_noteworthy;
    if(param_00.script_parameters == "tickets") {
      if(self hasweapon(var_06)) {
        return 0;
      }

      self.itempicked = param_00.script_noteworthy;
      level.transactionid = randomint(100);
      scripts\cp\zombies\zombie_analytics::log_item_purchase_with_tickets(level.wave_num, self.itempicked, level.transactionid);
    }

    var_07 = weaponmaxammo(param_00.script_noteworthy);
    var_08 = scripts\cp\perks\prestige::prestige_getminammo();
    var_09 = int(var_08 * var_07);
    var_0A = self getweaponammostock(var_06);
    if(var_0A >= var_09) {
      return 0;
    }
  }

  if(param_00.script_parameters == "tickets") {
    if(self.num_tickets >= var_04) {
      return 1;
    }

    return 0;
  }

  if(scripts\cp\cp_persistence::player_has_enough_currency(var_04, param_02)) {
    return 1;
  }

  return 0;
}

take_player_money(param_00, param_01) {
  scripts\cp\cp_persistence::take_player_currency(param_00, 1, param_01);
}

should_interaction_fill_consumable_meter(param_00) {
  if(!isDefined(param_00)) {}

  switch (param_00) {
    case "wondercard_machine":
    case "atm":
    case "bleedoutPenalty":
      return 0;

    default:
      return 1;
  }
}

func_5030(param_00, param_01) {}

func_7DBA(param_00, param_01) {
  var_02 = level.interactions[param_00.script_noteworthy].cost;
  var_03 = scripts\cp\utility::getrawbaseweaponname(param_00.script_noteworthy);
  var_04 = param_01 getcurrentweapon();
  var_05 = scripts\cp\utility::getbaseweaponname(var_04);
  var_06 = weaponmaxammo(var_04);
  var_07 = param_01 scripts\cp\perks\prestige::prestige_getminammo();
  var_08 = int(var_07 * var_06);
  var_09 = param_01 getweaponammostock(var_04);
  var_0A = self getweaponslistall();
  foreach(var_0C in var_0A) {
    var_0D = scripts\cp\utility::getrawbaseweaponname(var_0C);
    if(var_0D == scripts\cp\utility::getrawbaseweaponname(param_00.script_noteworthy)) {
      var_0E = var_0C;
      var_09 = self getweaponammostock(var_0E);
      var_06 = weaponmaxammo(var_0E);
      var_08 = int(var_07 * var_06);
    }
  }

  if(param_00.script_parameters == "tickets") {
    return level.interaction_hintstrings[param_00.script_noteworthy];
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

func_502F(param_00, param_01) {
  if(param_01 scripts\cp\cp_weapon::has_weapon_variation(param_00.script_noteworthy)) {
    return func_7DBA(param_00, param_01);
  }

  return undefined;
}

func_9A3D() {
  level endon("game_ended");
  for(;;) {
    level waittill("interaction", var_00, var_01, var_02);
    switch (var_00) {
      case "wall_buy":
        if(isDefined(var_02.purchasing_ammo)) {
          if(soundexists("purchase_ammo")) {
            var_02 playlocalsound("purchase_ammo");
          }
        } else if(isDefined(var_01)) {
          if(isDefined(var_01.script_noteworthy) && var_01.script_noteworthy == "iw7_venomx_zm") {
            if(scripts\engine\utility::flag_exist("completepuzzles_step4") && scripts\engine\utility::flag("completepuzzles_step4")) {
              if(soundexists("purchase_weapon")) {
                var_02 playlocalsound("purchase_weapon");
              }
            }
          } else if(soundexists("purchase_weapon")) {
            var_02 playlocalsound("purchase_weapon");
          }
        } else if(soundexists("purchase_weapon")) {
          var_02 playlocalsound("purchase_weapon");
        }
        break;

      case "purchase":
        var_03 = func_7A4B(var_01, var_02);
        if(isDefined(var_03) && soundexists(var_03)) {
          var_02 playlocalsound(var_03);
        }
        break;

      case "purchase_denied":
        if(var_01.name == "jaroslav_machine" && soundexists("ui_consumable_purchase_deny")) {
          var_02 playlocalsound("ui_consumable_purchase_deny");
        } else if(var_01.name == "lost_and_found" && soundexists("lost_and_found_deny")) {
          var_02 playlocalsound("lost_and_found_deny");
        } else if((soundexists("trap_control_panel_deny") && var_01.name == "beamtrap") || var_01.name == "interaction_discoballtrap" || var_01.name == "scrambler" || var_01.name == "blackhole_trap" || var_01.name == "rockettrap") {
          var_02 playlocalsound("trap_control_panel_deny");
        } else if(soundexists("purchase_deny")) {
          var_02 playlocalsound("purchase_deny");
        }
        break;
    }
  }
}

func_7A4B(param_00, param_01) {
  var_02 = [];
  switch (param_00.name) {
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
    case "facility_sliding_door_2000":
    case "facility_sliding_door_1500":
    case "facility_sliding_door_1250":
    case "facility_sliding_door_1000":
    case "facility_sliding_door_750":
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

  if(!var_02.size) {
    return undefined;
  }

  return scripts\engine\utility::random(var_02);
}

interaction_post_activate_update(param_00) {
  if(!isDefined(param_00.post_activate_update)) {
    return;
  }

  if(isDefined(level.interaction_post_activate_update_func)) {
    level thread[[level.interaction_post_activate_update_func]](param_00, self);
    return;
  }

  if(isDefined(param_00.souvenir)) {
    param_00.souvenir_toy delete();
    param_00.souvenir_toy = spawn("script_model", param_00.souvenir_origin);
    param_00.souvenir_toy setModel(param_00.souvenir_model);
    param_00.script_noteworthy = "crafting_station";
    param_00.requires_power = 1;
    param_00.powered_on = 1;
    param_00.script_parameters = "requires_power";
    param_00.name = "crafting_station";
    if(isDefined(param_00.souvenir_fx)) {
      param_00.souvenir_fx delete();
    }

    if(scripts\cp\utility::is_valid_player()) {
      self playlocalsound("zmb_item_pickup");
    }

    param_00.souvenir = undefined;
    param_00.post_activate_update = undefined;
    param_00.power_name = undefined;
    param_00.crafted_souvenir = undefined;
  }
}

func_9A26(param_00) {
  return param_00.script_noteworthy == "trap_electric" || param_00.script_noteworthy == "trap_firebarrel";
}

interaction_is_white_ark(param_00) {
  return param_00.script_noteworthy == "white_ark";
}

interaction_is_ark_quest_station(param_00) {
  return param_00.script_noteworthy == "ark_quest_station";
}

func_9A15(param_00) {
  return param_00.script_noteworthy == "atm_withdrawal" || param_00.script_noteworthy == "atm_deposit";
}

func_9A1C(param_00) {
  return param_00.script_noteworthy == "neil_head";
}

interactionislostandfound(param_00) {
  if(isDefined(param_00.script_noteworthy) && param_00.script_noteworthy == "lost_and_found") {
    return 1;
  }

  if(isDefined(param_00.name) && param_00.name == "lost_and_found") {
    return 1;
  }

  return 0;
}

interaction_is_window_entrance(param_00) {
  return param_00.script_noteworthy == "secure_window";
}

func_9A1E(param_00) {
  return param_00.script_noteworthy == "pillage_item";
}

func_9A19(param_00) {
  return param_00.script_noteworthy == "fast_travel";
}

interaction_is_crafting_station(param_00) {
  return param_00.script_noteworthy == "crafting_station";
}

interaction_is_grenade_wall_buy(param_00) {
  return param_00.script_noteworthy == "power_bioSpike" || param_00.script_noteworthy == "power_c4";
}

func_9A16(param_00) {
  return param_00.script_noteworthy == "crafting_pickup";
}

interaction_is_fortune_teller(param_00) {
  return param_00.script_noteworthy == "jaroslav_machine";
}

interaction_is_perk(param_00) {
  return isDefined(param_00.perk_type);
}

func_9A42(param_00) {
  return param_00.requires_power && !param_00.powered_on;
}

interaction_is_souvenir(param_00) {
  return isDefined(param_00.crafted_souvenir);
}

player_has_souvenir(param_00, param_01) {
  if(isDefined(param_01.current_crafted_inventory)) {
    return param_01.current_crafted_inventory.randomintrange == param_00.script_noteworthy;
  }

  return 0;
}

func_9A2C(param_00) {
  return param_00.script_noteworthy == "crafted_windowtrap";
}

interaction_is_challenge_station(param_00) {
  return isDefined(param_00.groupname) && param_00.groupname == "challenge";
}

interaction_is_valid(param_00, param_01) {
  if(param_01 isinphase()) {
    return 0;
  }

  if(isDefined(param_00.triggered)) {
    return 0;
  }

  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, param_00)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_00.out_of_order)) {
    level notify("player_accessed_interaction_on_cooldown", param_01);
    return 0;
  }

  if(scripts\engine\utility::istrue(param_00.in_use)) {
    return 0;
  }

  if(func_9A42(param_00)) {
    level notify("player_accessed_nonpowered_interaction", param_01, param_00);
    if(isDefined(param_00.perk_type) && soundexists("perk_machine_deny")) {
      param_01 playlocalsound("perk_machine_deny");
    } else {
      param_01 playlocalsound("purchase_deny");
    }

    return 0;
  }

  if(isDefined(param_00.cooling_down)) {
    level notify("player_accessed_interaction_on_cooldown", param_01, param_00);
    return 0;
  }

  if(scripts\engine\utility::array_contains(param_01.disabled_interactions, param_00)) {
    return 0;
  }

  return 1;
}

interaction_is_weapon_upgrade(param_00) {
  return param_00.script_noteworthy == "weapon_upgrade";
}

interaction_is_sliding_door(param_00) {
  return isDefined(param_00.script_noteworthy) && param_00.script_noteworthy == "facility_sliding_door_750" || param_00.script_noteworthy == "facility_sliding_door_1000" || param_00.script_noteworthy == "facility_sliding_door_1250" || param_00.script_noteworthy == "facility_sliding_door_1500" || param_00.script_noteworthy == "facility_sliding_door_2000";
}

interaction_is_weapon_buy(param_00) {
  if(isDefined(param_00.name)) {
    return param_00.name == "wall_buy";
  }

  return 0;
}

interaction_is_door_buy(param_00) {
  return param_00.script_noteworthy == "debris_350" || param_00.script_noteworthy == "debris_750" || param_00.script_noteworthy == "debris_1000" || param_00.script_noteworthy == "debris_1250" || param_00.script_noteworthy == "debris_1500" || param_00.script_noteworthy == "debris_2000" || param_00.script_noteworthy == "team_door_switch" || param_00.script_noteworthy == "team_door";
}

interaction_is_special_door_buy(param_00) {
  return param_00.script_noteworthy == "power_door_sliding" || param_00.script_noteworthy == "team_door_switch" || param_00.script_noteworthy == "team_door";
}

interaction_is_chi_door(param_00) {
  return param_00.script_noteworthy == "chi_0" || param_00.script_noteworthy == "chi_1" || param_00.script_noteworthy == "chi_2";
}

interaction_is_ticket_buy(param_00) {
  return param_00.script_noteworthy == "small_ticket_prize" || param_00.script_noteworthy == "medium_ticket_prize" || param_00.script_noteworthy == "arcade_counter_grenade" || param_00.script_noteworthy == "arcade_counter_ammo" || param_00.script_noteworthy == "large_ticket_prize" || param_00.script_noteworthy == "zfreeze_semtex_mp" || param_00.script_noteworthy == "iw7_forgefreeze_zm+forgefreezealtfire" || param_00.script_noteworthy == "gold_teeth";
}

func_9A1F(param_00) {
  return isDefined(param_00.power_name);
}

func_D0C3(param_00) {
  return scripts\cp\powers\coop_powers::hasequipment(param_00.power_name);
}

can_use_perk(param_00) {
  if(scripts\cp\utility::has_zombie_perk(param_00.perk_type)) {
    return 0;
  } else if(self.self_revives_purchased >= self.max_self_revive_machine_use && param_00.perk_type == "perk_machine_revive") {
    return 0;
  } else if(isDefined(self.zombies_perks) && self.zombies_perks.size > 4 && !scripts\engine\utility::istrue(self.have_permanent_perks)) {
    return 0;
  }

  return 1;
}

interaction_show_fail_reason(param_00, param_01, param_02, param_03) {
  thread interaction_fail_internal(param_00, param_01, param_02, param_03);
}

interaction_fail_internal(param_00, param_01, param_02, param_03) {
  self endon("disconnect");
  level notify("interaction", "purchase_denied", level.interactions[param_00.script_noteworthy], self);
  self.delay_hint = 1;
  self.interaction_trigger sethintstring(param_01);
  wait(1);
  self.delay_hint = undefined;
  func_F422(self.interaction_trigger, param_00);
}

disable_linked_interactions(param_00) {
  var_01 = scripts\engine\utility::getstructarray(param_00.script_noteworthy, "script_noteworthy");
  foreach(var_03 in var_01) {
    if(var_03.target == param_00.target) {
      scripts\cp\zombies\zombie_analytics::func_AF74(var_03.name, 0);
      remove_from_current_interaction_list(var_03);
    }
  }
}

enable_linked_interactions(param_00) {
  var_01 = scripts\engine\utility::getstructarray(param_00.script_noteworthy, "script_noteworthy");
  foreach(var_03 in var_01) {
    if(var_03.target == param_00.target) {
      scripts\cp\zombies\zombie_analytics::func_AF74(var_03.name, 1);
      add_to_current_interaction_list(var_03);
    }
  }
}

disable_like_interactions(param_00) {
  var_01 = scripts\engine\utility::getstructarray(param_00.script_noteworthy, "script_noteworthy");
  foreach(var_03 in var_01) {
    scripts\cp\zombies\zombie_analytics::func_AF74(var_03.name, 0);
    remove_from_current_interaction_list(var_03);
  }
}

enable_like_interactions(param_00) {
  var_01 = scripts\engine\utility::getstructarray(param_00.script_noteworthy, "script_noteworthy");
  foreach(var_03 in var_01) {
    scripts\cp\zombies\zombie_analytics::func_AF74(var_03.name, 1);
    add_to_current_interaction_list(var_03);
  }
}

interaction_cooldown(param_00, param_01) {
  var_02 = scripts\engine\utility::getstructarray(param_00.script_noteworthy, "script_noteworthy");
  foreach(var_04 in var_02) {
    if(var_04.target == param_00.target) {
      var_04.cooling_down = 1;
    }
  }

  if(scripts\engine\utility::istrue(level.var_4614)) {
    wait(1);
  } else {
    level scripts\engine\utility::waittill_any_timeout_1(param_01, "override_cooldowns");
  }

  foreach(var_04 in var_02) {
    if(var_04.target == param_00.target) {
      var_04.cooling_down = undefined;
    }
  }

  var_08 = 5184;
  foreach(var_0A in level.players) {
    foreach(var_04 in var_02) {
      if(distancesquared(var_0A.origin, var_04.origin) >= var_08) {
        continue;
      }

      var_0A refresh_interaction();
    }
  }
}

get_linked_interactions(param_00) {
  var_01 = [];
  var_02 = scripts\engine\utility::getstructarray(param_00.script_noteworthy, "script_noteworthy");
  foreach(var_04 in var_02) {
    if(var_04.target == param_00.target) {
      var_01[var_01.size] = var_04;
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

func_9A3A(param_00) {
  return scripts\engine\utility::istrue(param_00.requires_power) && isDefined(param_00.power_area);
}

func_55A2() {
  var_00 = scripts\engine\utility::getstructarray("interaction", "targetname");
  foreach(var_02 in var_00) {
    if(interaction_is_weapon_buy(var_02) || interaction_is_grenade_wall_buy(var_02) || interaction_is_ticket_buy(var_02) || isDefined(var_02.script_parameters) && var_02.script_parameters == "tickets") {
      var_02.disabled = 1;
      scripts\cp\zombies\zombie_analytics::func_AF74(var_02.name, 0);
      continue;
    }
  }
}

func_55A3(param_00) {
  var_01 = scripts\engine\utility::getstructarray("interaction", "targetname");
  foreach(var_03 in var_01) {
    if(interaction_is_weapon_buy(var_03) || interaction_is_grenade_wall_buy(var_03) || interaction_is_ticket_buy(var_03) || isDefined(var_03.script_parameters) && var_03.script_parameters == "tickets") {
      scripts\cp\zombies\zombie_analytics::func_AF74(var_03.name, 0);
      remove_from_current_interaction_list_for_player(var_03, param_00);
      continue;
    }
  }
}

func_6255(param_00) {
  var_01 = scripts\engine\utility::getstructarray("interaction", "targetname");
  foreach(var_03 in var_01) {
    if(interaction_is_weapon_buy(var_03) || interaction_is_grenade_wall_buy(var_03) || interaction_is_ticket_buy(var_03) || isDefined(var_03.script_parameters) && var_03.script_parameters == "tickets") {
      scripts\cp\zombies\zombie_analytics::func_AF74(var_03.name, 1);
      add_to_current_interaction_list_for_player(var_03, param_00);
      continue;
    }
  }
}

souvenir_team_splash(param_00, param_01) {
  foreach(var_03 in level.players) {
    var_03 thread scripts\cp\cp_hud_message::showsplash(param_00, undefined, param_01);
    wait(0.1);
  }
}

atm_deposit_hint(param_00, param_01) {
  if(exceed_deposit_limit(param_01)) {
    return "";
  }

  return level.interaction_hintstrings[param_00.script_noteworthy];
}

exceed_deposit_limit(param_00) {
  var_01 = -15536;
  if(!isDefined(level.atm_total_deposit_amount)) {
    level.atm_total_deposit_amount = [];
  }

  var_02 = param_00.name;
  if(!isDefined(level.atm_total_deposit_amount[var_02])) {
    level.atm_total_deposit_amount[var_02] = 0;
  }

  return level.atm_total_deposit_amount[var_02] >= var_01;
}

increase_total_deposit_amount(param_00, param_01) {
  var_02 = param_00.name;
  level.atm_total_deposit_amount[var_02] = level.atm_total_deposit_amount[var_02] + param_01;
}