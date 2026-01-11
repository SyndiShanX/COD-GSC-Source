/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_chaos.gsc
*****************************************************/

#include maps\mp\alien\_chaos_utility;
#include maps\mp\alien\_alien_class_skills_main;

CONST_REFILL_COMBO_METER_NOTIFY = "refill_combo_meter";
CONST_ALIEN_EGG_MODEL = "alien_spider_egg_ammo";
CONST_INC_COMBO_COUNTER_ONLY = "inc_combo_counter_only";
CONST_OMNVAR_NAME_PERK = "ui_chaos_perk";
CONST_OMNVAR_NAME_EVENT = "ui_chaos_event";
CONST_COMBO_FREEZE_FLAG = "combo_freeze";
CONST_GRACE_PERIOD_OVER_FLAG = "grace_period_over";
CONST_D_POD_UP_NOTIFY = "action_slot_1";
CONST_D_POD_DOWN_NOTIFY = "action_slot_2";
CONST_COMBO_IS_ALIVE_FLAG = "combo_is_alive";
CONST_IN_HOST_MIGRATION_FLAG = "in_host_migration";
CONST_PRE_GAME_IS_OVER_FLAG = "chaos_pre_game_is_over";

PRE_GAME_PAUSE_TIME = 10;
EGG_TIME_OUT = 30;
COMBO_FREEZE_DURATION = 15;
NUM_RECENT_WEAPON = 3;
FIRST_GRACE_PERIOD = 120;
EGG_LIST_SIZE = 20;
BONUS_GRACE_PERIOD = 30;
BONUS_CASH = 3000;
OBJECTIVE_SCALAR = 10;
COMBO_DURATION_BUFFER = 0.1;
HOT_JOIN_GRACE_PERIOD = 30;
MAX_NUM_SKILL_UPGRADE = 4;

init() {
  init_grace_period_end_time();
  init_highest_combo();
  init_bonus_package_cap();
  init_chaos_score_components();
  init_combo_duration();
  init_num_skill_upgrade_earned();
  init_event_counts();

  register_chaos_events();
  register_perk_progression();
  register_bonus_packages();
  register_cycle_duration();
  register_combo_duration_schedule();
  register_pre_end_game_display_func();

  reset_alien_kill_streak();
  load_vfx();
  add_extra_spawn_locations();
  /#reset_chaos_no_fail();

  common_scripts\utility::flag_init(CONST_COMBO_FREEZE_FLAG);
  common_scripts\utility::flag_init(CONST_GRACE_PERIOD_OVER_FLAG);
  common_scripts\utility::flag_init(CONST_COMBO_IS_ALIVE_FLAG);
  common_scripts\utility::flag_init(CONST_IN_HOST_MIGRATION_FLAG);
  common_scripts\utility::flag_init(CONST_PRE_GAME_IS_OVER_FLAG);
  maps\mp\alien\_hud::chaos_HUD_init();

  level.chaos_event_queue = [];

  level thread LUA_omnvar_update_monitor(level, CONST_OMNVAR_NAME_PERK);
  level thread LUA_omnvar_update_monitor(level, CONST_OMNVAR_NAME_EVENT);
  level thread process_event_notify_queue();
}

load_vfx() {
  level._effect["chaos_pre_bonus_drop"] = LoadFX("vfx/_requests/chaos/vfx_chaos_prebonus_drop");
}

set_chaos_area() {
  level.chaos_area = get_level_specific_chaos_area();
}

get_level_specific_chaos_area() {
  switch (level.script) {
    case "mp_alien_town":
      return "cabin";

    case "mp_alien_armory":
      return "compound";

    case "mp_alien_beacon":
      return "cargo";

    case "mp_alien_dlc3":
      return "caverns_03";

    case "mp_alien_last":
      return "main_base";
  }
}

chaos() {
  level endon("game_ended");

  level thread chaos_host_migration_handler();
  level thread combo_meter_monitor();

  wait PRE_GAME_PAUSE_TIME;

  level thread hot_join_grace_period_monitor();
  level thread bonus_package_drop_monitor();
  level thread start_grace_period(FIRST_GRACE_PERIOD);
  level thread chaos_cycle_spawn_monitor();
  level thread apply_delta_to_combo_duration();
}

update_alien_killed_event(alien_type, death_pos, attacker) {
  if(!should_process_alien_killed_event(attacker)) {
    return;
  }
  attacker_as_player = get_attacker_as_player(attacker);
  if(maps\mp\alien\_chaos_laststand::should_instant_revive(attacker_as_player)) {
    maps\mp\alien\_laststand::instant_revive(attacker_as_player);
  }

  process_chaos_event("kill_" + alien_type);
  drop_alien_egg(death_pos);
  level thread alien_kill_streak_monitor();
}

update_alien_damaged_event(sWeapon) {
  if(!should_process_alien_damaged_event(sWeapon)) {
    return;
  }
  process_chaos_event("refill_combo_meter");
}

update_spending_currency_event(player, spending_type, weapon_ref) {
  if(!maps\mp\alien\_utility::is_chaos_mode()) {
    return;
  }
  if(!isDefined(spending_type)) {
    return;
  }
  if(spending_type == "weapon" && is_new_weapon_pick_up(player, weapon_ref)) {
    process_chaos_event("new_weapon_pick_up");
  }
  else {
    process_chaos_event("inc_combo_counter_only");
  }
}

update_pickup_deployable_box_event() {
  process_chaos_event("deployable_pick_up");
}

process_chaos_event(event_id) {
  if(!maps\mp\alien\_utility::is_chaos_mode()) {
    return;
  }
  event_info = level.chaos_events[event_id];
  AssertEx(isDefined(event_info), "Chaos event id: '" + event_id + "' is not found.");

  process_chaos_event_internal(event_info);
}

update_weapon_pickup(player, weapon_ref) {
  add_to_weapon_picked_up_list(player, weapon_ref);
  add_to_recent_weapon_list(player, weapon_ref);
}

chaos_onPlayerConnect(player) {
  player.weapon_picked_up = [];
  player.recent_weapon_list = [];
  player maps\mp\alien\_chaos_laststand::set_in_chaos_self_revive(player, false);
}

chaos_onSpawnPlayer(player) {
  player maps\mp\alien\_damage::setBodyArmor(level.deployablebox_vest_max);
  player notify("enable_armor");
  player.objectiveScaler = OBJECTIVE_SCALAR;
  player thread refill_pistol_ammo();
  player give_skill_upgrade_earned(player);
}

chaos_custom_giveloadout(player) {
  player give_activated_perks(player);

  if(!common_scripts\utility::flag(CONST_PRE_GAME_IS_OVER_FLAG)) {
    player give_start_up_semtex(player);
  }
}

give_start_up_semtex(player) {
  player SetOffhandPrimaryClass("other");
  player maps\mp\_utility::_giveWeapon("aliensemtex_mp");
  player SetWeaponAmmoStock("aliensemtex_mp", 5);
}

create_alien_eggs() {
  level.alien_egg_list = [];
  level.alien_egg_list_index = 0;

  for(i = 0; i < EGG_LIST_SIZE; i++) {
    level.alien_egg_list[i] = create_alien_egg();
  }
}

set_egg_default_loc(loc) {
  level.eggs_default_loc = loc;
}
is_new_weapon_pick_up(player, weapon_ref) {
  return !common_scripts\utility::array_contains(player.weapon_picked_up, weapon_ref);
}
is_weapon_recently_picked_up(player, weapon_ref) {
  return common_scripts\utility::array_contains(player.recent_weapon_list, weapon_ref);
}

combo_meter_monitor() {
  level endon("game_ended");

  while(true) {
    level waittill(CONST_REFILL_COMBO_METER_NOTIFY);

    while(true) {
      combo_duration = get_combo_duration() * (1 + COMBO_DURATION_BUFFER);
      result = level common_scripts\utility::waittill_any_timeout(combo_duration, CONST_REFILL_COMBO_METER_NOTIFY);

      if(result == "timeout" && !common_scripts\utility::flag(CONST_COMBO_FREEZE_FLAG) && !common_scripts\utility::flag(CONST_IN_HOST_MIGRATION_FLAG)) {
        keep_running_score();
        drop_combo();

        if(common_scripts\utility::flag(CONST_GRACE_PERIOD_OVER_FLAG)) {
          chaos_end_game();
        }

        break;
      }
    }
  }
}

alien_kill_streak_monitor() {
  level notify("alien_kill_streak");
  level endon("alien_kill_streak");

  KILL_STREAK_EXPIRE_DURATION = 0.2;

  inc_alien_kill_streak();
  wait KILL_STREAK_EXPIRE_DURATION;
  process_alien_kill_streak(get_alien_kill_streak());
  reset_alien_kill_streak();
}

process_alien_kill_streak(alien_kill_streak) {
  if(alien_kill_streak < 2) {
    return;
  }
  switch (alien_kill_streak) {
    case 2:
      process_chaos_event("double_kill");
      break;

    case 3:
      process_chaos_event("triple_kill");
      break;

    case 4:
      process_chaos_event("quad_kill");
      break;

    default:
      process_chaos_event("mega_kill");
      break;
  }
}

bonus_package_drop_monitor() {
  level endon("game_ended");

  foreach(bonus_packages_info in level.chaos_bonus_progression) {
    wait bonus_packages_info["wait_duration"];
    level thread drop_bonus_packages(bonus_packages_info);
  }
}

drop_bonus_packages(bonus_info) {
  level endon("game_ended");

  num_of_drops = cap_num_of_drops(bonus_info["num_of_drops"]);
  if(num_of_drops == 0) {
    return;
  }
  bonus_items_list = get_bonus_items_list(bonus_info, num_of_drops);
  drop_locations = get_drop_locations(num_of_drops);

  for(i = 0; i < num_of_drops; i++) {
    level thread drop_bonus_package(bonus_items_list[i], drop_locations[i]);
    common_scripts\utility::waitframe();
  }
}

cap_num_of_drops(num_of_drops) {
  current_num_bonus_package = get_current_num_bonus_package();
  max_num_bonus_package = get_bonus_package_cap();
  return min(num_of_drops, max_num_bonus_package - current_num_bonus_package);
}

chaos_cycle_spawn_monitor() {
  level endon("game_ended");

  foreach(cycle_duration in level.chaos_cycle_duration) {
    level thread maps\mp\alien\_spawnlogic::encounter_cycle_spawn();
    wait cycle_duration;
    maps\mp\alien\_spawn_director::end_cycle();
    common_scripts\utility::waitframe();
  }
}

apply_delta_to_combo_duration() {
  level endon("game_ended");

  foreach(duration_delta in level.combo_duration_schedule) {
    wait(duration_delta["pre_delta_interval"]);
    adjust_combo_duration(duration_delta["delta"]);
  }
}

chaos_host_migration_handler() {
  level endon("game_ended");

  while(true) {
    level waittill("host_migration_begin");
    common_scripts\utility::flag_set(CONST_IN_HOST_MIGRATION_FLAG);

    level waittill("host_migration_end");
    common_scripts\utility::flag_clear(CONST_IN_HOST_MIGRATION_FLAG);
    refill_combo_meter();
  }
}

hot_join_grace_period_monitor() {
  level endon("game_ended");

  wait HOT_JOIN_GRACE_PERIOD;
  common_scripts\utility::flag_set(CONST_PRE_GAME_IS_OVER_FLAG);
}

process_chaos_event_internal(event_info) {
  refill_combo_meter();

  should_inc_combo_counter = should_inc_combo_counter(event_info["combo_inc"]);
  should_inc_score_streak = should_inc_score_streak(event_info["score_inc"]);

  if(should_inc_combo_counter) {
    inc_combo_counter(event_info["combo_inc"]);
  }

  if(should_update_LUA_event(event_info["LUA_event_ID"])) {
    inc_event_count(event_info["LUA_event_ID"]);
    add_to_omnvar_value_queue(level, CONST_OMNVAR_NAME_EVENT, event_info["LUA_event_ID"]);
  }

  if(should_inc_score_streak) {
    inc_score_streak(event_info["score_inc"]);
  }

  if(should_inc_combo_counter || should_inc_score_streak) {
    total_score = calculate_total_score();

    foreach(player in level.players) {
    player maps\mp\alien\_persistence::eog_player_update_stat("score", total_score, true);
    }
  }
}

inc_combo_counter(combo_count_increment) {
  add_combo_counter(combo_count_increment);
  combo_counter = get_combo_counter();
  perk_progression(combo_counter);
  maps\mp\alien\_hud::set_combo_counter(combo_counter);
  record_highest_combo(combo_counter);
}

inc_score_streak(score_streak_increment) {
  add_score_streak(score_streak_increment);
  score_streak = get_score_streak();
  maps\mp\alien\_hud::set_score_streak(score_streak);
}

should_inc_combo_counter(combo_increment) {
  return combo_increment > 0;
}

should_inc_score_streak(score_streak_increment) {
  return score_streak_increment > 0;
}

should_update_LUA_event(LUA_event_ID) {
  return LUA_event_ID > 0;
}

pop_first_item_out_of_queue(ent, omnvar_name) {
  first_item = ent.omnvar_value_queue[omnvar_name][0];

  if(isDefined(first_item)) {
    new_queue = [];
    for(i = 1; i < ent.omnvar_value_queue[omnvar_name].size; i++) {
      new_queue[new_queue.size] = ent.omnvar_value_queue[omnvar_name][i];
    }
    ent.omnvar_value_queue[omnvar_name] = new_queue;
  }

  return first_item;
}

LUA_omnvar_update_monitor(ent, omnvar_name, additional_endon) {
  level endon("game_ended");

  if(isDefined(additional_endon)) {
    ent endon(additional_endon);
  }

  ent.omnvar_value_queue[omnvar_name] = [];

  while(true) {
    value = pop_first_item_out_of_queue(ent, omnvar_name);

    if(isDefined(value)) {
      chaos_event_notify(omnvar_name, value, ent);
      if(isPlayer(ent)) {
        ent setClientOmnvar(omnvar_name, value);
      }
      else {
        setOmnvar(omnvar_name, value);
      }

      common_scripts\utility::waitframe();
    } else {
      ent waittill("update_" + omnvar_name);
    }
  }
}

chaos_event_notify(omnvar_name, omnvar_value, player) {
  switch (omnvar_name) {
    case "ui_chaos_event":
    case "ui_chaos_perk":
      string = get_chaos_event_notify_string(omnvar_name, omnvar_value);
      if(isDefined(string)) {
        add_to_event_notify_queue(omnvar_name, omnvar_value, player, string);
      }
  }
}

get_chaos_event_notify_string(omnvar_name, omnvar_value) {
  if(omnvar_name == "ui_chaos_perk") {
    switch (omnvar_value) {
      case 1:
        return &"ALIEN_CHAOS_PERK_QUICKDRAW";
      case 2:
        return &"ALIEN_CHAOS_PERK_STRONGER_MELEE";
      case 3:
        return &"ALIEN_CHAOS_PERK_TRAP_MASTER";
      case 4:
        return &"ALIEN_CHAOS_PERK_GAS_MASK";
      case 5:
        return &"ALIEN_CHAOS_PERK_FASTRELOAD";
      case 6:
        return &"ALIEN_CHAOS_PERK_BULLET_DAMAGE_1";
      case 7:
        return &"ALIEN_CHAOS_PERK_STEADY_AIM";
      case 8:
        return &"ALIEN_CHAOS_PERK_STALKER";
      case 9:
        return &"ALIEN_CHAOS_PERK_QUICK_REVIVE";
      case 10:
        return &"ALIEN_CHAOS_PERK_FAST_REGEN";
      case 11:
        return &"ALIEN_CHAOS_PERK_MARATHON";
      case 12:
        return &"ALIEN_CHAOS_PERK_MORE_CASH";
      case 13:
        return &"ALIEN_CHAOS_PERK_BULLET_DAMAGE_2";
      case 14:
        return &"ALIEN_CHAOS_PERK_AGILITY";
      case 15:
        return &"ALIEN_CHAOS_PERK_MORE_HEALTH";
      case 16:
        return &"ALIEN_CHAOS_PERK_FERAL_VISION";
    }
  } else {
    switch (omnvar_value) {
      case 2:
        return &"ALIEN_CHAOS_MEGA_KILL";
      case 3:
        return &"ALIEN_CHAOS_QUAD_KILL";
      case 5:
        return &"ALIEN_CHAOS_TRIPLE_KILL";
      case 10:
        return &"ALIEN_CHAOS_DOUBLE_KILL";
    }
  }
}

add_to_event_notify_queue(omnvar_name, omnvar_value, ent, event_string) {
  chaos_event = spawnStruct();
  chaos_event.name = omnvar_name;
  chaos_event.value = omnvar_value;
  chaos_event.ent = ent;
  chaos_event.event_string = event_string;
  chaos_event.time_added = gettime();

  level.chaos_event_queue[level.chaos_event_queue.size] = chaos_event;
}

process_event_notify_queue() {
  level endon("game_ended");

  while(1) {
    if(level.chaos_event_queue.size > 0) {
      event = level.chaos_event_queue[0];
      level.chaos_event_queue = common_scripts\utility::array_remove(level.chaos_event_queue, event);
      if(gettime() - event.time_added > 5000) {
        continue;
      }
      if(isPlayer(event.ent)) {
        event.ent IPrintLnBold(event.event_string);
      }
      else {
        IPrintLnBold(event.event_string);
      }
      wait 2;
    }
    wait .1;
  }
}

add_to_omnvar_value_queue(ent, omnvar_name, value) {
  ent.omnvar_value_queue[omnvar_name][ent.omnvar_value_queue[omnvar_name].size] = value;
  ent notify("update_" + omnvar_name);
}

create_alien_egg() {
  EGG_TRIGGER_RADIUS = 32;
  EGG_TRIGGER_HEIGHT = 76;

  spawn_loc = level.eggs_default_loc;

  alien_egg = spawn("script_model", spawn_loc);
  alien_egg setModel(CONST_ALIEN_EGG_MODEL);

  alien_egg_trigger = spawn("trigger_radius", spawn_loc, 0, EGG_TRIGGER_RADIUS, EGG_TRIGGER_HEIGHT);
  alien_egg_trigger enableLinkTo();
  alien_egg_trigger linkTo(alien_egg);
  alien_egg.trigger = alien_egg_trigger;

  alien_egg thread egg_pick_up_monitor(alien_egg);
  alien_egg thread alien_egg_think(alien_egg);

  return alien_egg;
}

alien_egg_think(alien_egg) {
  result = "none";

  while(true) {
    if(result != "activate") {
      alien_egg waittill("activate");
    }

    result = alien_egg common_scripts\utility::waittill_any_timeout(EGG_TIME_OUT, "picked_up", "activate");

    if(result == "picked_up") {
      process_chaos_event(CONST_INC_COMBO_COUNTER_ONLY);
    }

    if(result != "activate") {
      move_alien_egg(alien_egg, level.eggs_default_loc);
    }
  }
}

drop_alien_egg(pos) {
  MODEL_VERTICAL_OFFSET = (0, 0, 10);

  alien_egg = get_egg_from_list();
  move_alien_egg(alien_egg, pos + MODEL_VERTICAL_OFFSET);
  alien_egg notify("activate");
}

get_egg_from_list() {
  alien_egg = level.alien_egg_list[level.alien_egg_list_index];
  level.alien_egg_list_index = (level.alien_egg_list_index + 1) % EGG_LIST_SIZE;
  return alien_egg;
}

refill_combo_meter() {
  level notify(CONST_REFILL_COMBO_METER_NOTIFY);
  maps\mp\alien\_hud::reset_combo_meter(get_combo_duration());
  common_scripts\utility::flag_set(CONST_COMBO_IS_ALIVE_FLAG);
}

drop_combo() {
  reset_combo_counter();
  maps\mp\alien\_hud::set_combo_counter(0);
  unset_players_perks();
  common_scripts\utility::flag_clear(CONST_COMBO_IS_ALIVE_FLAG);
}

egg_pick_up_monitor(alien_egg) {
  while(true) {
    alien_egg.trigger waittill("trigger", player);

    if(isPlayer(player)) {
      alien_egg notify("picked_up");
      player PlayLocalSound("ball_drone_targeting");
    }

    common_scripts\utility::waitframe();
  }
}

move_alien_egg(alien_egg, pos) {
  alien_egg DontInterpolate();
  alien_egg.origin = pos;
}

perk_progression(combo_counter) {
  if(!isDefined(level.perk_progression[combo_counter])) {
    return;
  }
  level.perk_progression[combo_counter]["is_activated"] = true;
  perk_info = level.perk_progression[combo_counter];
  add_to_omnvar_value_queue(level, CONST_OMNVAR_NAME_PERK, perk_info["LUA_perk_ID"]);
  foreach(player in level.players)[[perk_info["activate_func"]]](player, perk_info["perk_ref"]);
}

unset_players_perks() {
  foreach(player in level.players) {
  unset_player_perks(player);
  }

  set_all_perks_inactivated();
  add_to_omnvar_value_queue(level, CONST_OMNVAR_NAME_PERK, 0);
}

swap_weapon_items(world_item_list) {
  world_item_list = remove_weapon_item(world_item_list);
  world_item_list = add_chaos_weapon(world_item_list);

  return world_item_list;
}

remove_weapon_item(world_item_list) {
  new_list = [];

  foreach(world_item in world_item_list) {
    if(maps\mp\alien\_collectibles::is_collectible_weapon(world_item.script_noteworthy)) {
      continue;
    }
    new_list[new_list.size] = world_item;
  }

  return new_list;
}

add_to_weapon_picked_up_list(player, weapon_ref) {
  if(common_scripts\utility::array_contains(player.weapon_picked_up, weapon_ref)) {
    return;
  }
  player.weapon_picked_up[player.weapon_picked_up.size] = weapon_ref;
}

add_to_recent_weapon_list(player, weapon_ref) {
  if(player.recent_weapon_list.size < NUM_RECENT_WEAPON) {
    player.recent_weapon_list[player.recent_weapon_list.size] = weapon_ref;
  } else {
    for(index = 0; index < NUM_RECENT_WEAPON - 1; index++) {
      player.recent_weapon_list[index] = player.recent_weapon_list[index + 1];
    }

    player.recent_weapon_list[NUM_RECENT_WEAPON - 1] = weapon_ref;
  }
}

give_skill_upgrade_earned(player) {
  num_skill_upgrade_earned = get_num_skill_upgrade_earned();

  foreach(resource_type in ["defense", "offense"]) {
    player maps\mp\alien\_persistence::set_upgrade_level(resource_type, num_skill_upgrade_earned);
    player maps\mp\alien\_persistence::update_resource_stats("upgrade", get_resource_ref(player, resource_type), num_skill_upgrade_earned);
  }
}

get_resource_ref(player, resource_type) {
  return level.alien_combat_resources[resource_type][self getcoopplayerdata("alienPlayerLoadout", resource_type)].ref;
}

register_perk_progression() {
  level.perk_progression = [];

  register_perk("specialty_marathon", ::give_perk, ::take_perk);
  register_perk("fast_hands", ::give_hand_perks, ::take_hand_perks);
  register_perk("specialty_fastreload", ::give_perk, ::take_perk);
  register_perk("specialty_stalker", ::give_perk, ::take_perk);
  register_perk("fast_movement_speed", ::give_speed, ::take_speed);
  register_perk("gas_mask", ::give_gas_mask, ::take_gas_mask);
  register_perk("revive_protection", ::give_revive_protection, ::take_revive_protection);
  register_perk("steady_aim", ::give_steady_aim, ::take_steady_aim);
  register_perk("more_health", ::give_more_health, ::take_more_health);
  register_perk("stronger_melee", ::give_stronger_melee, ::take_stronger_melee);
  register_perk("bullet_damage_1", ::give_bullet_damage_1, ::take_bullet_damage_1);
  register_perk("bullet_damage_2", ::give_bullet_damage_2, ::take_bullet_damage_2);
  register_perk("fast_health_regen", ::give_fast_health_regen, ::take_fast_health_regen);
  register_perk("more_cash", ::give_more_cash, ::take_more_cash);
  register_perk("better_traps", ::give_trap_damage, ::take_trap_damage);
  register_perk("feral_vision", ::give_feral_vision, ::take_feral_vision);
}

FAST_MOVEMENT_SPEED = 1.30;
CHAOS_MEDIC_GAS_DAMAGE_SCALAR = 0;
DEFAULT_GAS_DAMAGE_SCALAR = 1.0;
CHAOS_REVIVE_DAMAGE_SCALAR = 0.5;
DEFAULT_REVIVE_DAMAGE_SCALAR = 1.0;
CHAOS_DEFAULT_HEALTH = 100;
CHAOS_MAX_HEALTH = 200;
CHAOS_MELEE_SCALAR = 3.0;
DEFAULT_MELEE_SCALAR = 1.0;
CHAOS_STEADY_AIM_SCALAR = 0.5;
DEFAULT_STEADY_AIM_SCALAR = 1.0;
CHAOS_BULLET_DAMAGE_SCALAR_1 = 1.2;
CHAOS_BULLET_DAMAGE_SCALAR_2 = 1.5;
DEFAULT_BULLET_DAMAGE_SCALAR = 1.0;
CHAOS_WALLET_SIZE = 8000;
DEFAULT_WALLET_SIZE = 6000;
CHAOS_TRAP_COST_SCALAR = 0.8;
CHAOS_TRAP_DURATION_SCALAR = 1.5;
CHAOS_TRAP_DAMAGE_SCALAR = 2.0;
DEFAULT_TRAP_COST_SCALAR = 1.0;
DEFAULT_TRAP_DURATION_SCALAR = 1.0;
DEFAULT_TRAP_DAMAGE_SCALAR = 1.0;
CHAOS_BONUS_CASH_DROP_SCALAR = 2.0;
DEFAULT_BONUS_CASH_DROP_SCALAR = 1.0;
CHAOS_REVIVE_TIME_SCALAR = 1.5;
DEFAULT_REVIVE_TIME_SCALAR = 1.0;

give_perk(player, perk_ref) {
  player maps\mp\_utility::givePerk(perk_ref, false);
}
take_perk(player, perk_ref) {
  player maps\mp\_utility::_unsetPerk(perk_ref);
}
give_speed(player, perk_ref) {
  player.moveSpeedScaler = FAST_MOVEMENT_SPEED;
}
take_speed(player, perk_ref) {
  player.moveSpeedScaler = 1.0;
}
give_gas_mask(player, perk_ref) {
  player.perk_data["medic"].gas_damage_scalar = CHAOS_MEDIC_GAS_DAMAGE_SCALAR;
}
take_gas_mask(player, perk_ref) {
  player.perk_data["medic"].gas_damage_scalar = DEFAULT_GAS_DAMAGE_SCALAR;
}
give_hand_perks(player, perk_ref) {
  player maps\mp\_utility::givePerk("specialty_quickdraw", false);
  player maps\mp\_utility::givePerk("specialty_quickswap", false);
  player maps\mp\_utility::givePerk("specialty_fastoffhand", false);
  player maps\mp\_utility::givePerk("specialty_fastsprintrecovery", false);
}
take_hand_perks(player, perk_ref) {
  player maps\mp\_utility::_unsetPerk("specialty_quickdraw");
  player maps\mp\_utility::_unsetPerk("specialty_quickswap");
  player maps\mp\_utility::_unsetPerk("specialty_fastoffhand");
  player maps\mp\_utility::_unsetPerk("specialty_fastsprintrecovery");
}
give_revive_protection(player, perk_ref) {
  player.perk_data["medic"].revive_time_scalar = CHAOS_REVIVE_TIME_SCALAR;
  player.perk_data["medic"].revive_damage_scalar = CHAOS_REVIVE_DAMAGE_SCALAR;
}
take_revive_protection(player, perk_ref) {
  player.perk_data["medic"].revive_time_scalar = DEFAULT_REVIVE_TIME_SCALAR;
  player.perk_data["medic"].revive_damage_scalar = DEFAULT_REVIVE_DAMAGE_SCALAR;
}
give_steady_aim(player, perk_ref) {
  player setaimspreadmovementscale(CHAOS_STEADY_AIM_SCALAR);
}
take_steady_aim(player, perk_ref) {
  player setaimspreadmovementscale(DEFAULT_STEADY_AIM_SCALAR);
}
give_more_health(player, perk_ref) {
  player.perk_data["health"].max_health = CHAOS_MAX_HEALTH;
  player.maxhealth = player.perk_data["health"].max_health;
  player notify("health_perk_upgrade");
}
take_more_health(player, perk_ref) {
  player.perk_data["health"].max_health = CHAOS_DEFAULT_HEALTH;
  player.maxhealth = player.perk_data["health"].max_health;
  player notify("health_perk_upgrade");
}
give_stronger_melee(player, perk_ref) {
  player.perk_data["health"].melee_scalar = CHAOS_MELEE_SCALAR;
}
take_stronger_melee(player, perk_ref) {
  player.perk_data["health"].melee_scalar = DEFAULT_MELEE_SCALAR;
}
give_bullet_damage_1(player, perk_ref) {
  player.perk_data["damagemod"].bullet_damage_scalar = CHAOS_BULLET_DAMAGE_SCALAR_1;
}
take_bullet_damage_1(player, perk_ref) {
  player.perk_data["damagemod"].bullet_damage_scalar = DEFAULT_BULLET_DAMAGE_SCALAR;
}
give_bullet_damage_2(player, perk_ref) {
  player.perk_data["damagemod"].bullet_damage_scalar = CHAOS_BULLET_DAMAGE_SCALAR_2;
}
take_bullet_damage_2(player, perk_ref) {
  player.perk_data["damagemod"].bullet_damage_scalar = DEFAULT_BULLET_DAMAGE_SCALAR;
}
give_fast_health_regen(player, perk_ref) {
  player.isHealthBoosted = true;
}
take_fast_health_regen(player, perk_ref) {
  player.isHealthBoosted = undefined;
}
give_more_cash(player, perk_ref) {
  player maps\mp\alien\_persistence::set_player_max_currency(CHAOS_WALLET_SIZE);
  player.chaosinthemoney = true;
}
take_more_cash(player, perk_ref) {
  player maps\mp\alien\_persistence::set_player_max_currency(DEFAULT_WALLET_SIZE);
  player.chaosinthemoney = undefined;
}
give_trap_damage(player, perk_ref) {
  player.perk_data["rigger"].trap_cost_scalar = CHAOS_TRAP_COST_SCALAR;
  player.perk_data["rigger"].trap_duration_scalar = CHAOS_TRAP_DURATION_SCALAR;
  player.perk_data["rigger"].trap_damage_scalar = CHAOS_TRAP_DAMAGE_SCALAR;
}

take_trap_damage(player, perk_ref) {
  player.perk_data["rigger"].trap_cost_scalar = DEFAULT_TRAP_COST_SCALAR;
  player.perk_data["rigger"].trap_duration_scalar = DEFAULT_TRAP_DURATION_SCALAR;
  player.perk_data["rigger"].trap_damage_scalar = DEFAULT_TRAP_DAMAGE_SCALAR;
}
give_feral_vision(player, perk_ref) {
  player thread maps\mp\alien\_outline_proto::set_alien_outline();
  player.isFeral = true;
}
take_feral_vision(player, perk_ref) {
  player thread maps\mp\alien\_outline_proto::unset_alien_outline();
  player.isFeral = undefined;
  player notify("unset_adrenaline");
}

register_bonus_packages() {
  register_drop_locations();
  register_bonus_progression();
  register_package_types();
}

get_drop_locations(num_locations) {
  locations = [];

  player = get_random_player();
  player_angles = player getPlayerAngles();

  yaw_increment = 360 / num_locations;

  for(i = 0; i < num_locations; i++) {
    desired_dir = anglesToForward((0, i * yaw_increment, 0));
    target_vector = RotateVector(desired_dir, player_angles);
    target_vector *= (1, 1, 0);
    target_vector = vectorNormalize(target_vector);

    locations[locations.size] = get_drop_location_rated(target_vector, player.origin);
  }

  return locations;
}

get_bonus_items_list(bonus_info, num_of_drops) {
  bonus_items_list = [];
  random_index_list = maps\mp\alien\_utility::GetMultipleRandomIndex(bonus_info["package_group_chance"], num_of_drops);

  foreach(i, random_index in random_index_list) {
    item_list = strTok(bonus_info["package_group_type"][random_index], "-");
    item_weights = convert_array_to_int(strTok(bonus_info["item_chance"][random_index], "-"));

    selected_item_index = maps\mp\alien\_utility::GetRandomIndex(item_weights);
    bonus_items_list[bonus_items_list.size] = item_list[selected_item_index];
  }

  return bonus_items_list;
}

register_package_types() {
  init_chaos_bonus_package_type();

  init_chaos_deployable("combo_freeze", "alien_dpad_icon_freeze", ::give_combo_freeze);
  init_chaos_deployable("skill_upgrade", "alien_chaos_waypoint_skill", ::upgrade_all_skills);
  init_chaos_deployable("grace_period", "alien_chaos_waypoint_time", ::give_grace_period);
  init_chaos_deployable("bonus_score", "alien_chaos_waypoint_score", ::give_bonus_score);
  init_chaos_deployable("bonus_cash", "alien_dpad_icon_team_money", ::give_bonus_cash);
  init_chaos_deployable("trophy", "alien_chaos_waypoint_gift", ::give_trophy);
  init_chaos_deployable("flare", "alien_chaos_waypoint_gift", ::give_flare);
  init_chaos_deployable("pet_leash", "alien_chaos_waypoint_gift", ::give_pet_leash);
  init_chaos_deployable("soflam", "alien_chaos_waypoint_gift", ::give_soflam);
  init_chaos_deployable("self_revive", "alien_icon_laststand", ::give_self_revive);
  init_chaos_deployable("specialist_skill", "hud_alien_ammo_infinite", ::give_specalist_class_skill);
  init_chaos_deployable("tank_skill", "alien_dpad_icon_tank", ::give_tank_class_skill);
  init_chaos_deployable("engineer_skill", "alien_dpad_icon_engineer", ::give_engineer_class_skill);
  init_chaos_deployable("medic_skill", "alien_dpad_icon_medic", ::give_medic_class_skill);
  init_chaos_deployable("venom_x", "alien_chaos_waypoint_venomx", ::give_venom_x);
  init_chaos_deployable("venom_fire", "alien_chaos_waypoint_venomx", ::give_venom_fire);
  init_chaos_deployable("venom_lightning", "alien_chaos_waypoint_venomx", ::give_venom_lightning);
  init_chaos_deployable("tesla_trap", "alien_chaos_waypoint_tesla", ::give_tesla_trap);
  init_chaos_deployable("hypno_trap", "alien_chaos_waypoint_hypno", ::give_hypno_trap);

  add_special_ammo_dox_as_bonus_package();
}

add_special_ammo_dox_as_bonus_package() {
  add_to_chaos_bonus_package_type("deployable_specialammo");
  add_to_chaos_bonus_package_type("deployable_specialammo_in");
  add_to_chaos_bonus_package_type("deployable_specialammo_explo");
  add_to_chaos_bonus_package_type("deployable_specialammo_ap");
}

drop_bonus_package(boxType, loc) {
  VFX_CHARGING_STATE_TIME = 0.3;

  owner = get_random_player();
  fx = play_FX_on_package(loc, owner.angles);
  wait VFX_CHARGING_STATE_TIME;

  box = maps\mp\alien\_deployablebox::createBoxForPlayer(boxType, loc, owner);
  box.air_dropped = true;
  box maps\mp\alien\_deployablebox::box_setActive(true);
  fx thread clean_up_monitor(fx, box);
}

give_tesla_trap(boxent) {
  if(isDefined(level.tesla_trap_func)) {
    self thread[[level.tesla_trap_func]]("amolecular_nucleicbattery_wire");
  }
}

give_hypno_trap(boxent) {
  if(isDefined(level.hypno_trap_func)) {
    self thread[[level.hypno_trap_func]]("biolum_cellbattery_pressureplate");
  }
}

give_venom_x(boxent) {
  weapon_item = spawnStruct();
  weapon_item.item_ref = "weapon_iw6_aliendlc11_mp";
  weapon_item.data = [];
  weapon_item.data["cost"] = 0;
  self remove_special_weapon();
  self maps\mp\alien\_collectibles::give_weapon(weapon_item);
}

give_venom_fire(boxent) {
  weapon_item = spawnStruct();
  weapon_item.item_ref = "weapon_iw6_aliendlc11fi_mp";
  weapon_item.data = [];
  weapon_item.data["cost"] = 0;
  self remove_special_weapon();
  self maps\mp\alien\_collectibles::give_weapon(weapon_item);
}

give_venom_lightning(boxent) {
  weapon_item = spawnStruct();
  weapon_item.item_ref = "weapon_iw6_aliendlc11li_mp";
  weapon_item.data = [];
  weapon_item.data["cost"] = 0;
  self remove_special_weapon();
  self maps\mp\alien\_collectibles::give_weapon(weapon_item);
}

remove_special_weapon() {
  cur_weapon = self GetCurrentPrimaryWeapon();

  switch (cur_weapon) {
    case "iw6_alienminigun_mp":
    case "iw6_alienminigun1_mp":
    case "iw6_alienminigun2_mp":
    case "iw6_alienminigun3_mp":
    case "iw6_alienminigun4_mp":
    case "iw6_alienmk32_mp":
    case "iw6_alienmk321_mp":
    case "iw6_alienmk322_mp":
    case "iw6_alienmk323_mp":
    case "iw6_alienmk324_mp":
    case "iw6_alienmaaws_mp":
      self TakeWeapon(cur_weapon);
      wait 0.1;
      break;
  }
}

give_medic_class_skill(boxent) {
  maps\mp\alien\_hud::set_has_chaos_class_skill_bonus(self, 4);
  self.hasChaosClassSkill = true;
  self thread chaos_class_use_monitor(boxent, "medic");
}
give_engineer_class_skill(boxent) {
  maps\mp\alien\_hud::set_has_chaos_class_skill_bonus(self, 3);
  self.hasChaosClassSkill = true;
  self thread chaos_class_use_monitor(boxent, "engineer");
}
give_tank_class_skill(boxent) {
  maps\mp\alien\_hud::set_has_chaos_class_skill_bonus(self, 2);
  self.hasChaosClassSkill = true;
  self thread chaos_class_use_monitor(boxent, "tank");
}

give_specalist_class_skill(boxent) {
  maps\mp\alien\_hud::set_has_chaos_class_skill_bonus(self, 1);
  self.hasChaosClassSkill = true;
  self thread chaos_class_use_monitor(boxent, "specialist");
}

chaos_class_use_monitor(boxEnt, class) {
  level endon("game_ended");
  self endon("disconnect");

  self waittill(CONST_D_POD_UP_NOTIFY);
  self.chaosClassSkillInUse = true;
  self.hasChaosClassSkill = false;
  maps\mp\alien\_hud::set_has_chaos_class_skill_bonus(self, 0);
  refill_combo_meter();
  switch (class) {
    case "specialist":
      self thread activate_specialist_class_skill();
      break;
    case "tank":
      self thread activate_tank_class_skill();
      break;
    case "medic":
      self thread activate_medic_class_skill();
      break;
    case "engineer":
      self thread activate_engineer_class_skill();
      break;
  }
}

activate_engineer_class_skill() {
  self endon("disconnect");

  variables = [];
  variables["cooldown"] = 20;
  variables["cost"] = 0;
  variables["duration"] = 15;

  self thread sound_audio_weapon_activate();

  self maps\mp\alien\_music_and_dialog::playEngineerClassSkillVO(self);
  self engineer_slow_field(variables);
  self.chaosClassSkillInUse = undefined;
}

activate_medic_class_skill() {
  self endon("disconnect");

  variables = [];
  variables["cooldown"] = 20;
  variables["cost"] = 0;
  variables["duration"] = 15;

  selfmaps\mp\alien\_music_and_dialog::playMedicClassSkillVO(self);
  self create_heal_ring(variables);
  self.chaosClassSkillInUse = undefined;
}

activate_tank_class_skill() {
  self endon("disconnect");

  level.meleeStunRadius = 128;
  level.meleeStunMaxDamage = 1;
  level.meleeStunMinDamage = 1;

  variables = [];
  variables["cooldown"] = 20;
  variables["cost"] = 0;
  variables["duration"] = 15;

  self VisionSetNakedForPlayer("mp_alien_thermal_trinity", .5);

  self maps\mp\alien\_music_and_dialog::playTankClassSkillVO(self);

  self thread create_tank_ring(variables);
  self tank_skill_flare(variables);

  self VisionSetNakedForPlayer("", .5);
  self.chaosClassSkillInUse = undefined;
}

activate_specialist_class_skill() {
  self endon("disconnect");

  variables = [];
  variables["cooldown"] = 20;
  variables["cost"] = 0;
  variables["duration"] = 15;

  self thread sound_audio_weapon_activate();

  self maps\mp\alien\_music_and_dialog::playWeaponClassSkillVO(self);
  self.skill_in_use = true;
  self thread effect_on_fire(variables);
  self.camFX = SpawnFXForClient(LoadFX("vfx/gameplay/alien/vfx_alien_cskill_wspecial_01"), self.origin, self);
  TriggerFX(self.camFX);
  self maps\mp\alien\_deployablebox_functions::filllaunchers(undefined, 1);
  self specialist_boost(variables);

  self.skill_in_use = undefined;
  if(isDefined(self.camFX)) {
    self.camFX delete();
  }
  self.chaosClassSkillInUse = undefined;
}

give_combo_freeze(boxEnt) {
  maps\mp\alien\_hud::set_has_combo_freeze(self, true);
  self.hasComboFreeze = true;
  self thread combo_freeze_use_monitor();
}

combo_freeze_use_monitor(boxEnt) {
  level endon("game_ended");
  self endon("disconnect");

  self waittill(CONST_D_POD_DOWN_NOTIFY);
  self.hasComboFreeze = undefined;
  maps\mp\alien\_hud::set_has_combo_freeze(self, false);
  level thread activate_combo_freeze();
}

activate_combo_freeze() {
  level notify("activate_combo_freeze");

  level endon("activate_combo_freeze");
  level endon("game_ended");

  maps\mp\alien\_hud::freeze_combo_meter(COMBO_FREEZE_DURATION);
  common_scripts\utility::flag_set(CONST_COMBO_FREEZE_FLAG);

  wait COMBO_FREEZE_DURATION;

  maps\mp\alien\_hud::unfreeze_combo_meter();
  common_scripts\utility::flag_clear(CONST_COMBO_FREEZE_FLAG);
  refill_combo_meter();
}

upgrade_all_skills(boxEnt) {
  inc_num_skill_upgrade_earned();

  foreach(player in level.players) {
  upgrade_player_all_skills(player);
  }
}

upgrade_player_all_skills(player) {
  resource_type_list = ["defense", "offense"];

  foreach(resource_type in resource_type_list) {
  player notify("luinotifyserver", resource_type + "_try_upgrade");
  }
}

init_num_skill_upgrade_earned() {
  level.num_skill_upgrade_earned = 0;
}
inc_num_skill_upgrade_earned() {
  level.num_skill_upgrade_earned = min(MAX_NUM_SKILL_UPGRADE, level.num_skill_upgrade_earned + 1);
}
get_num_skill_upgrade_earned() {
  return int(level.num_skill_upgrade_earned);
}

init_grace_period_end_time() {
  level.grace_period_end_time = getTime();
}

start_grace_period(duration) {
  level notify("start_grace_period");

  level endon("start_grace_period");
  level endon("game_ended");

  current_time = getTime();
  grace_period_end_time = get_grace_period_end_time(current_time, duration);
  duration = (grace_period_end_time - current_time) / 1000;

  common_scripts\utility::flag_clear(CONST_GRACE_PERIOD_OVER_FLAG);
  maps\mp\alien\_hud::set_grace_period_clock(grace_period_end_time);

  wait duration;

  common_scripts\utility::flag_set(CONST_GRACE_PERIOD_OVER_FLAG);
  maps\mp\alien\_hud::unset_grace_period_clock();

  if(!common_scripts\utility::flag(CONST_COMBO_IS_ALIVE_FLAG)) {
    chaos_end_game();
  }
}

get_grace_period_end_time(current_time, duration) {
  duration *= 1000;

  if(level.grace_period_end_time <= current_time) {
    level.grace_period_end_time = current_time + duration;
  }
  else {
    level.grace_period_end_time += duration;
  }

  return level.grace_period_end_time;
}

give_grace_period(boxEnt) {
  level thread start_grace_period(BONUS_GRACE_PERIOD);
}

give_bonus_score(boxEnt) {
  process_chaos_event("bonus_score");
}

give_bonus_cash(boxEnt) {
  foreach(player in level.players) {
  player maps\mp\alien\_persistence::give_player_currency(BONUS_CASH);
  }
}

give_trophy(boxEnt) {
  give_chaos_offhand_item(self, "alientrophy_mp", "flash");
}

give_flare(boxEnt) {
  give_chaos_offhand_item(self, "alienflare_mp", "flash");
}

give_pet_leash(boxEnt) {
  give_chaos_offhand_item(self, "alienthrowingknife_mp", "throwingknife");
}

give_chaos_offhand_item(player, weapon_ref, offhand_class) {
  remove_other_chaos_offhand_item(player);

  player setOffhandSecondaryClass(offhand_class);
  player giveweapon(weapon_ref);
  player SetWeaponAmmoClip(weapon_ref, 1);
}

remove_other_chaos_offhand_item(player) {
  chaos_offhand_item_list = ["alienflare_mp", "alienthrowingknife_mp", "alientrophy_mp"];

  foreach(item in chaos_offhand_item_list) {
  player takeWeapon(item);
  }
}

give_soflam(boxEnt) {
  self maps\mp\_utility::setLowerMessage("chaos_soflam_hint", &"ALIEN_CHAOS_SOFLAM_HINT", 3);
  self giveweapon("aliensoflam_mp");
}

give_self_revive(boxEnt) {
  maps\mp\alien\_laststand::give_lastStand(self, 1);
}
refill_pistol_ammo() {
  self endon("death");
  self endon("disconnect");

  while(true) {
    self waittill("reload");
    current_weapon = self GetCurrentWeapon();
    weapon_class = maps\mp\_utility::getWeaponClass(current_weapon);
    if(weapon_class == "weapon_pistol") {
      ammo_to_replace = WeaponClipSize(current_weapon);
      start_ammo = WeaponStartAmmo(current_weapon);
      refill_stock = start_ammo - ammo_to_replace;
      for(i = 0; i < (ammo_to_replace); i++) {
        current_stock = self GetWeaponAmmoStock(current_weapon);
        self SetWeaponAmmoStock(current_weapon, current_stock + 1);
        wait 0.05;
      }

    }
  }
}

chaos_setup_op_weapons() {
  level.opWeaponsArray = [];
  level.opWeaponsArray[0] = "iw5_alienriotshield_mp";
  level.opWeaponsArray[1] = "iw5_alienriotshield1_mp";
  level.opWeaponsArray[2] = "iw5_alienriotshield2_mp";
  level.opWeaponsArray[3] = "iw5_alienriotshield3_mp";
  level.opWeaponsArray[4] = "iw5_alienriotshield4_mp";
  level.opWeaponsArray[5] = "iw6_alienminigun_mp";
  level.opWeaponsArray[6] = "iw6_alienminigun1_mp";
  level.opWeaponsArray[7] = "iw6_alienminigun2_mp";
  level.opWeaponsArray[8] = "iw6_alienminigun3_mp";
  level.opWeaponsArray[9] = "iw6_alienminigun4_mp";
  level.opWeaponsArray[10] = "iw6_alienmk32_mp";
  level.opWeaponsArray[11] = "iw6_alienmk321_mp";
  level.opWeaponsArray[12] = "iw6_alienmk322_mp";
  level.opWeaponsArray[13] = "iw6_alienmk323_mp";
  level.opWeaponsArray[14] = "iw6_alienmk324_mp";
  level.opWeaponsArray[15] = "iw6_alienmaaws_mp";
  level.opWeaponsArray[16] = "alienbomb_mp";
  level.opWeaponsArray[17] = "aliensoflam_mp";
}