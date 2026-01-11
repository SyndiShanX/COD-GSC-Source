/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_perks.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;

init() {
  place_additionalprimaryweapon_machine();
  vending_triggers = getEntArray("zombie_vending", "targetname");
  vending_weapon_upgrade_trigger = getEntArray("zombie_vending_upgrade", "targetname");
  flag_init("pack_machine_in_use");
  flag_init("solo_game");
  if(level.mutators["mutator_noPerks"]) {
    for(i = 0; i < vending_triggers.size; i++) {
      vending_triggers[i] disable_trigger();
    }
    for(i = 0; i < vending_weapon_upgrade_trigger.size; i++) {
      vending_weapon_upgrade_trigger[i] disable_trigger();
    }
    return;
  }
  if(vending_triggers.size < 1) {
    return;
  }
  if(vending_weapon_upgrade_trigger.size >= 1) {
    array_thread(vending_weapon_upgrade_trigger, ::vending_weapon_upgrade);;
  }
  if(!isDefined(level.custom_vending_precaching)) {
    level.custom_vending_precaching = maps\_zombiemode_perks::default_vending_precaching;
  }
  [[level.custom_vending_precaching]]();
  if(!isDefined(level.packapunch_timeout)) {
    level.packapunch_timeout = 15;
  }
  set_zombie_var("zombie_perk_cost", 2000);
  if(level.mutators["mutator_susceptible"]) {
    set_zombie_var("zombie_perk_juggernaut_health", 80);
    set_zombie_var("zombie_perk_juggernaut_health_upgrade", 95);
  } else {
    set_zombie_var("zombie_perk_juggernaut_health", 160);
    set_zombie_var("zombie_perk_juggernaut_health_upgrade", 190);
  }
  array_thread(vending_triggers, ::vending_trigger_think);
  array_thread(vending_triggers, ::electric_perks_dialog);
  level thread turn_doubletap_on();
  if(is_true(level.zombiemode_using_marathon_perk)) {
    level thread turn_marathon_on();
  }
  if(is_true(level.zombiemode_using_divetonuke_perk)) {
    level thread turn_divetonuke_on();
    level.zombiemode_divetonuke_perk_func = ::divetonuke_explode;
    level._effect["divetonuke_groundhit"] = loadfx("maps/zombie/fx_zmb_phdflopper_exp");
    set_zombie_var("zombie_perk_divetonuke_radius", 300);
    set_zombie_var("zombie_perk_divetonuke_min_damage", 1000);
    set_zombie_var("zombie_perk_divetonuke_max_damage", 5000);
  }
  level thread turn_jugger_on();
  level thread turn_revive_on();
  level thread turn_sleight_on();
  if(is_true(level.zombiemode_using_deadshot_perk)) {
    level thread turn_deadshot_on();
  }
  if(is_true(level.zombiemode_using_additionalprimaryweapon_perk)) {
    level thread turn_additionalprimaryweapon_on();
  }
  level thread turn_PackAPunch_on();
  if(isDefined(level.quantum_bomb_register_result_func)) {
    [[level.quantum_bomb_register_result_func]]("give_nearest_perk", ::quantum_bomb_give_nearest_perk_result, 10, ::quantum_bomb_give_nearest_perk_validation);
  }
}

place_additionalprimaryweapon_machine() {
  if(!isDefined(level.zombie_additionalprimaryweapon_machine_origin)) {
    return;
  }
  machine = spawn("script_model", level.zombie_additionalprimaryweapon_machine_origin);
  machine.angles = level.zombie_additionalprimaryweapon_machine_angles;
  machine setModel("zombie_vending_three_gun");
  machine.targetname = "vending_additionalprimaryweapon";
  machine_trigger = spawn("trigger_radius_use", level.zombie_additionalprimaryweapon_machine_origin + (0, 0, 30), 0, 20, 70);
  machine_trigger.targetname = "zombie_vending";
  machine_trigger.target = "vending_additionalprimaryweapon";
  machine_trigger.script_noteworthy = "specialty_additionalprimaryweapon";
  if(isDefined(level.zombie_additionalprimaryweapon_machine_clip_origin)) {
    machine_clip = spawn("script_model", level.zombie_additionalprimaryweapon_machine_clip_origin);
    machine_clip.angles = level.zombie_additionalprimaryweapon_machine_clip_angles;
    machine_clip setModel("collision_geo_64x64x256");
    machine_clip hide();
  }
  if(isDefined(level.zombie_additionalprimaryweapon_machine_monkey_origins)) {
    machine.target = "vending_additionalprimaryweapon_monkey_structs";
    for(i = 0; i < level.zombie_additionalprimaryweapon_machine_monkey_origins.size; i++) {
      machine_monkey_struct = spawnStruct();
      machine_monkey_struct.origin = level.zombie_additionalprimaryweapon_machine_monkey_origins[i];
      machine_monkey_struct.angles = level.zombie_additionalprimaryweapon_machine_monkey_angles;
      machine_monkey_struct.script_int = i + 1;
      machine_monkey_struct.script_notetworthy = "cosmo_monkey_additionalprimaryweapon";
      machine_monkey_struct.targetname = "vending_additionalprimaryweapon_monkey_structs";
      if(!isDefined(level.struct_class_names["targetname"][machine_monkey_struct.targetname])) {
        level.struct_class_names["targetname"][machine_monkey_struct.targetname] = [];
      }
      size = level.struct_class_names["targetname"][machine_monkey_struct.targetname].size;
      level.struct_class_names["targetname"][machine_monkey_struct.targetname][size] = machine_monkey_struct;
    }
  }
  level.zombiemode_using_additionalprimaryweapon_perk = true;
}

default_vending_precaching() {
  PrecacheItem("zombie_perk_bottle_doubletap");
  PrecacheItem("zombie_perk_bottle_jugg");
  PrecacheItem("zombie_perk_bottle_revive");
  PrecacheItem("zombie_perk_bottle_sleight");
  PrecacheItem("zombie_knuckle_crack");
  PrecacheShader("specialty_doubletap_zombies");
  if(is_true(level.zombiemode_using_marathon_perk)) {
    PrecacheItem("zombie_perk_bottle_marathon");
    PrecacheShader("specialty_marathon_zombies");
  }
  if(is_true(level.zombiemode_using_divetonuke_perk)) {
    PrecacheItem("zombie_perk_bottle_nuke");
    PrecacheShader("specialty_divetonuke_zombies");
  }
  if(is_true(level.zombiemode_using_deadshot_perk)) {
    PreCacheItem("zombie_perk_bottle_deadshot");
    PrecacheShader("specialty_ads_zombies");
  }
  if(is_true(level.zombiemode_using_additionalprimaryweapon_perk)) {
    PrecacheItem("zombie_perk_bottle_additionalprimaryweapon");
    PrecacheShader("specialty_extraprimaryweapon_zombies");
  }
  PrecacheShader("specialty_juggernaut_zombies");
  PrecacheShader("specialty_quickrevive_zombies");
  PrecacheShader("specialty_fastreload_zombies");
  PrecacheShader("specialty_juggernaut_zombies_pro");
  PrecacheShader("specialty_quickrevive_zombies_pro");
  PrecacheShader("specialty_fastreload_zombies_pro");
  PrecacheShader("minimap_icon_juggernog");
  PrecacheShader("minimap_icon_revive");
  PrecacheShader("minimap_icon_reload");
  PrecacheModel("zombie_vending_doubletap_on");
  if(is_true(level.zombiemode_using_marathon_perk)) {
    PrecacheModel("zombie_vending_marathon_on");
  }
  if(is_true(level.zombiemode_using_divetonuke_perk)) {
    PrecacheModel("zombie_vending_nuke_on");
  }
  if(is_true(level.zombiemode_using_deadshot_perk)) {
    PrecacheModel("zombie_vending_ads_on");
  }
  if(is_true(level.zombiemode_using_additionalprimaryweapon_perk)) {
    PrecacheModel("zombie_vending_three_gun_on");
  }
  PreCacheModel("zombie_vending_jugg_on");
  PrecacheModel("zombie_vending_revive_on");
  PrecacheModel("zombie_vending_sleight_on");
  PrecacheModel("zombie_vending_packapunch_on");
  PrecacheString(&"ZOMBIE_PERK_DOUBLETAP");
  if(is_true(level.zombiemode_using_marathon_perk)) {
    PrecacheString(&"ZOMBIE_PERK_MARATHON");
  }
  if(is_true(level.zombiemode_using_divetonuke_perk)) {
    PrecacheString(&"ZOMBIE_PERK_DIVETONUKE");
  }
  if(is_true(level.zombiemode_using_additionalprimaryweapon_perk)) {
    PrecacheString(&"ZOMBIE_PERK_ADDITIONALWEAPONPERK");
  }
  PrecacheString(&"ZOMBIE_PERK_JUGGERNAUT");
  PrecacheString(&"ZOMBIE_PERK_QUICKREVIVE");
  PrecacheString(&"ZOMBIE_PERK_FASTRELOAD");
  PrecacheString(&"ZOMBIE_PERK_PACKAPUNCH");
  level._effect["doubletap_light"] = loadfx("misc/fx_zombie_cola_dtap_on");
  if(is_true(level.zombiemode_using_marathon_perk)) {
    level._effect["marathon_light"] = loadfx("maps/zombie/fx_zmb_cola_staminup_on");
  }
  if(is_true(level.zombiemode_using_divetonuke_perk)) {
    level._effect["divetonuke_light"] = loadfx("misc/fx_zombie_cola_dtap_on");
  }
  if(is_true(level.zombiemode_using_deadshot_perk)) {
    level._effect["deadshot_light"] = loadfx("misc/fx_zombie_cola_dtap_on");
  }
  if(is_true(level.zombiemode_using_additionalprimaryweapon_perk)) {
    level._effect["additionalprimaryweapon_light"] = loadfx("misc/fx_zombie_cola_arsenal_on");
  }
  level._effect["jugger_light"] = loadfx("misc/fx_zombie_cola_jugg_on");
  level._effect["revive_light"] = loadfx("misc/fx_zombie_cola_revive_on");
  level._effect["sleight_light"] = loadfx("misc/fx_zombie_cola_on");
  level._effect["packapunch_fx"] = loadfx("maps/zombie/fx_zombie_packapunch");
  level._effect["revive_light_flicker"] = loadfx("maps/zombie/fx_zmb_cola_revive_flicker");
}

third_person_weapon_upgrade(current_weapon, origin, angles, packa_rollers, perk_machine) {
  forward = anglesToForward(angles);
  interact_pos = origin + (forward * -25);
  playFX(level._effect["packapunch_fx"], origin + (0, 1, -34), forward);
  worldgun = spawn("script_model", interact_pos);
  worldgun.angles = self.angles;
  worldgun setModel(GetWeaponModel(current_weapon));
  worldgun useweaponhidetags(current_weapon);
  worldgun rotateto(angles + (0, 90, 0), 0.35, 0, 0);
  offsetdw = (3, 3, 3);
  worldgundw = undefined;
  if(maps\_zombiemode_weapons::weapon_is_dual_wield(current_weapon)) {
    worldgundw = spawn("script_model", interact_pos + offsetdw);
    worldgundw.angles = self.angles;
    worldgundw setModel(maps\_zombiemode_weapons::get_left_hand_weapon_model_name(current_weapon));
    worldgundw useweaponhidetags(current_weapon);
    worldgundw rotateto(angles + (0, 90, 0), 0.35, 0, 0);
  }
  wait(0.5);
  worldgun moveTo(origin, 0.5, 0, 0);
  if(isDefined(worldgundw)) {
    worldgundw moveTo(origin + offsetdw, 0.5, 0, 0);
  }
  self playSound("zmb_perks_packa_upgrade");
  if(isDefined(perk_machine.wait_flag)) {
    perk_machine.wait_flag rotateto(perk_machine.wait_flag.angles + (179, 0, 0), 0.25, 0, 0);
  }
  wait(0.35);
  worldgun delete();
  if(isDefined(worldgundw)) {
    worldgundw delete();
  }
  wait(3);
  self playSound("zmb_perks_packa_ready");
  worldgun = spawn("script_model", origin);
  worldgun.angles = angles + (0, 90, 0);
  worldgun setModel(GetWeaponModel(level.zombie_weapons[current_weapon].upgrade_name));
  worldgun useweaponhidetags(level.zombie_weapons[current_weapon].upgrade_name);
  worldgun moveTo(interact_pos, 0.5, 0, 0);
  worldgundw = undefined;
  if(maps\_zombiemode_weapons::weapon_is_dual_wield(level.zombie_weapons[current_weapon].upgrade_name)) {
    worldgundw = spawn("script_model", origin + offsetdw);
    worldgundw.angles = angles + (0, 90, 0);
    worldgundw setModel(maps\_zombiemode_weapons::get_left_hand_weapon_model_name(level.zombie_weapons[current_weapon].upgrade_name));
    worldgundw useweaponhidetags(level.zombie_weapons[current_weapon].upgrade_name);
    worldgundw moveTo(interact_pos + offsetdw, 0.5, 0, 0);
  }
  if(isDefined(perk_machine.wait_flag)) {
    perk_machine.wait_flag rotateto(perk_machine.wait_flag.angles - (179, 0, 0), 0.25, 0, 0);
  }
  wait(0.5);
  worldgun moveTo(origin, level.packapunch_timeout, 0, 0);
  if(isDefined(worldgundw)) {
    worldgundw moveTo(origin + offsetdw, level.packapunch_timeout, 0, 0);
  }
  worldgun.worldgundw = worldgundw;
  return worldgun;
}

vending_machine_trigger_think() {
  self endon("death");
  while(1) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(players[i] hacker_active()) {
        self SetInvisibleToPlayer(players[i], true);
      } else {
        self SetInvisibleToPlayer(players[i], false);
      }
    }
    wait(0.1);
  }
}

vending_weapon_upgrade() {
  perk_machine = getEnt(self.target, "targetname");
  perk_machine_sound = getEntArray("perksacola", "targetname");
  packa_rollers = spawn("script_origin", self.origin);
  packa_timer = spawn("script_origin", self.origin);
  packa_rollers LinkTo(self);
  packa_timer LinkTo(self);
  if(isDefined(perk_machine.target)) {
    perk_machine.wait_flag = getEnt(perk_machine.target, "targetname");
  }
  self UseTriggerRequireLookAt();
  self SetHintString(&"ZOMBIE_NEED_POWER");
  self SetCursorHint("HINT_NOICON");
  level waittill("Pack_A_Punch_on");
  self thread vending_machine_trigger_think();
  self thread maps\_zombiemode_weapons::decide_hide_show_hint();
  perk_machine playLoopSound("zmb_perks_packa_loop");
  self thread vending_weapon_upgrade_cost();
  for(;;) {
    self waittill("trigger", player);
    index = maps\_zombiemode_weapons::get_player_index(player);
    plr = "zmb_vox_plr_" + index + "_";
    current_weapon = player getCurrentWeapon();
    if("microwavegun_zm" == current_weapon) {
      current_weapon = "microwavegundw_zm";
    }
    if(!player maps\_zombiemode_weapons::can_buy_weapon() ||
      player maps\_laststand::player_is_in_laststand() ||
      is_true(player.intermission) ||
      player isThrowingGrenade() ||
      player maps\_zombiemode_weapons::is_weapon_upgraded(current_weapon)) {
      wait(0.1);
      continue;
    }
    if(is_true(level.pap_moving)) {
      continue;
    }
    if(player isSwitchingWeapons()) {
      wait(0.1);
      continue;
    }
    if(!isDefined(level.zombie_include_weapons[current_weapon])) {
      continue;
    }
    if(player.score < self.cost) {
      self playSound("deny");
      player maps\_zombiemode_audio::create_and_play_dialog("general", "perk_deny", undefined, 0);
      continue;
    }
    flag_set("pack_machine_in_use");
    player maps\_zombiemode_score::minus_to_player_score(self.cost);
    sound = "evt_bottle_dispense";
    playsoundatposition(sound, self.origin);
    self thread maps\_zombiemode_audio::play_jingle_or_stinger("mus_perks_packa_sting");
    player maps\_zombiemode_audio::create_and_play_dialog("weapon_pickup", "upgrade_wait");
    origin = self.origin;
    angles = self.angles;
    if(isDefined(perk_machine)) {
      origin = perk_machine.origin + (0, 0, 35);
      angles = perk_machine.angles + (0, 90, 0);
    }
    self disable_trigger();
    player thread do_knuckle_crack();
    self.current_weapon = current_weapon;
    weaponmodel = player third_person_weapon_upgrade(current_weapon, origin, angles, packa_rollers, perk_machine);
    self enable_trigger();
    self SetHintString(&"ZOMBIE_GET_UPGRADED");
    self setvisibletoplayer(player);
    self thread wait_for_player_to_take(player, current_weapon, packa_timer);
    self thread wait_for_timeout(current_weapon, packa_timer);
    self waittill_either("pap_timeout", "pap_taken");
    self.current_weapon = "";
    if(isDefined(weaponmodel.worldgundw)) {
      weaponmodel.worldgundw delete();
    }
    weaponmodel delete();
    self SetHintString(&"ZOMBIE_PERK_PACKAPUNCH", self.cost);
    self setvisibletoall();
    flag_clear("pack_machine_in_use");
  }
}

vending_weapon_upgrade_cost() {
  while(1) {
    self.cost = 5000;
    self SetHintString(&"ZOMBIE_PERK_PACKAPUNCH", self.cost);
    level waittill("powerup bonfire sale");
    self.cost = 1000;
    self SetHintString(&"ZOMBIE_PERK_PACKAPUNCH", self.cost);
    level waittill("bonfire_sale_off");
  }
}

wait_for_player_to_take(player, weapon, packa_timer) {
  AssertEx(isDefined(level.zombie_weapons[weapon]), "wait_for_player_to_take: weapon does not exist");
  AssertEx(isDefined(level.zombie_weapons[weapon].upgrade_name), "wait_for_player_to_take: upgrade_weapon does not exist");
  upgrade_weapon = level.zombie_weapons[weapon].upgrade_name;
  self endon("pap_timeout");
  while(true) {
    packa_timer playLoopSound("zmb_perks_packa_ticktock");
    self waittill("trigger", trigger_player);
    packa_timer stopLoopSound(.05);
    if(trigger_player == player) {
      current_weapon = player GetCurrentWeapon();
      if(is_player_valid(player) && !player is_drinking() && !is_placeable_mine(current_weapon) && !is_equipment(current_weapon) && "syrette_sp" != current_weapon && "none" != current_weapon && !player hacker_active()) {
        self notify("pap_taken");
        player notify("pap_taken");
        player.pap_used = true;
        weapon_limit = 2;
        if(player HasPerk("specialty_additionalprimaryweapon")) {
          weapon_limit = 3;
        }
        primaries = player GetWeaponsListPrimaries();
        if(isDefined(primaries) && primaries.size >= weapon_limit) {
          player maps\_zombiemode_weapons::weapon_give(upgrade_weapon);
        } else {
          player GiveWeapon(upgrade_weapon, 0, player maps\_zombiemode_weapons::get_pack_a_punch_weapon_options(upgrade_weapon));
          player GiveStartAmmo(upgrade_weapon);
        }
        player SwitchToWeapon(upgrade_weapon);
        player maps\_zombiemode_weapons::play_weapon_vo(upgrade_weapon);
        return;
      }
    }
    wait(0.05);
  }
}

wait_for_timeout(weapon, packa_timer) {
  self endon("pap_taken");
  wait(level.packapunch_timeout);
  self notify("pap_timeout");
  packa_timer stopLoopSound(.05);
  packa_timer playSound("zmb_perks_packa_deny");
  maps\_zombiemode_weapons::unacquire_weapon_toggle(weapon);
}

do_knuckle_crack() {
  gun = self upgrade_knuckle_crack_begin();
  self waittill_any("fake_death", "death", "player_downed", "weapon_change_complete");
  self upgrade_knuckle_crack_end(gun);
}

upgrade_knuckle_crack_begin() {
  self increment_is_drinking();
  self AllowLean(false);
  self AllowAds(false);
  self AllowSprint(false);
  self AllowCrouch(true);
  self AllowProne(false);
  self AllowMelee(false);
  if(self GetStance() == "prone") {
    self SetStance("crouch");
  }
  primaries = self GetWeaponsListPrimaries();
  gun = self GetCurrentWeapon();
  weapon = "zombie_knuckle_crack";
  if(gun != "none" && !is_placeable_mine(gun) && !is_equipment(gun)) {
    self notify("zmb_lost_knife");
    self TakeWeapon(gun);
  } else {
    return;
  }
  self GiveWeapon(weapon);
  self SwitchToWeapon(weapon);
  return gun;
}

upgrade_knuckle_crack_end(gun) {
  assert(gun != "zombie_perk_bottle_doubletap");
  assert(gun != "zombie_perk_bottle_jugg");
  assert(gun != "zombie_perk_bottle_revive");
  assert(gun != "zombie_perk_bottle_sleight");
  assert(gun != "zombie_perk_bottle_marathon");
  assert(gun != "zombie_perk_bottle_nuke");
  assert(gun != "zombie_perk_bottle_deadshot");
  assert(gun != "zombie_perk_bottle_additionalprimaryweapon");
  assert(gun != "syrette_sp");
  self AllowLean(true);
  self AllowAds(true);
  self AllowSprint(true);
  self AllowProne(true);
  self AllowMelee(true);
  weapon = "zombie_knuckle_crack";
  if(self maps\_laststand::player_is_in_laststand() || is_true(self.intermission)) {
    self TakeWeapon(weapon);
    return;
  }
  self decrement_is_drinking();
  self TakeWeapon(weapon);
  primaries = self GetWeaponsListPrimaries();
  if(self is_drinking()) {
    return;
  } else if(isDefined(primaries) && primaries.size > 0) {
    self SwitchToWeapon(primaries[0]);
  } else {
    self SwitchToWeapon(level.laststandpistol);
  }
}

turn_PackAPunch_on() {
  level waittill("Pack_A_Punch_on");
  vending_weapon_upgrade_trigger = getEntArray("zombie_vending_upgrade", "targetname");
  for(i = 0; i < vending_weapon_upgrade_trigger.size; i++) {
    perk = getEnt(vending_weapon_upgrade_trigger[i].target, "targetname");
    if(isDefined(perk)) {
      perk thread activate_PackAPunch();
    }
  }
}

activate_PackAPunch() {
  self setModel("zombie_vending_packapunch_on");
  self playSound("zmb_perks_power_on");
  self vibrate((0, -100, 0), 0.3, 0.4, 3);
  timer = 0;
  duration = 0.05;
  level notify("Carpenter_On");
}

turn_sleight_on() {
  machine = getEntArray("vending_sleight", "targetname");
  level waittill("sleight_on");
  for(i = 0; i < machine.size; i++) {
    machine[i] setModel("zombie_vending_sleight_on");
    machine[i] vibrate((0, -100, 0), 0.3, 0.4, 3);
    machine[i] playSound("zmb_perks_power_on");
    machine[i] thread perk_fx("sleight_light");
  }
  level notify("specialty_fastreload_power_on");
}

turn_revive_on() {
  machine = getEntArray("vending_revive", "targetname");
  machine_model = undefined;
  machine_clip = undefined;
  flag_wait("all_players_connected");
  players = GetPlayers();
  if(players.size == 1) {
    for(i = 0; i < machine.size; i++) {
      if(isDefined(machine[i].script_noteworthy) && machine[i].script_noteworthy == "clip") {
        machine_clip = machine[i];
      } else {
        machine[i] setModel("zombie_vending_revive_on");
        machine_model = machine[i];
      }
    }
    wait_network_frame();
    if(isDefined(machine_model)) {
      machine_model thread revive_solo_fx(machine_clip);
    }
  } else {
    level waittill("revive_on");
    for(i = 0; i < machine.size; i++) {
      if(isDefined(machine[i].classname) && machine[i].classname == "script_model") {
        machine[i] setModel("zombie_vending_revive_on");
        machine[i] playSound("zmb_perks_power_on");
        machine[i] vibrate((0, -100, 0), 0.3, 0.4, 3);
        machine[i] thread perk_fx("revive_light");
      }
    }
    level notify("specialty_quickrevive_power_on");
  }
}

revive_solo_fx(machine_clip) {
  flag_init("solo_revive");
  self.fx = spawn("script_model", self.origin);
  self.fx.angles = self.angles;
  self.fx setModel("tag_origin");
  self.fx LinkTo(self);
  playFXOnTag(level._effect["revive_light"], self.fx, "tag_origin");
  playFXOnTag(level._effect["revive_light_flicker"], self.fx, "tag_origin");
  flag_wait("solo_revive");
  if(isDefined(level.revive_solo_fx_func)) {
    level thread[[level.revive_solo_fx_func]]();
  }
  wait(2.0);
  self playSound("zmb_box_move");
  playsoundatposition("zmb_whoosh", self.origin);
  self moveTo(self.origin + (0, 0, 40), 3);
  if(isDefined(level.custom_vibrate_func)) {
    [[level.custom_vibrate_func]](self);
  } else {
    direction = self.origin;
    direction = (direction[1], direction[0], 0);
    if(direction[1] < 0 || (direction[0] > 0 && direction[1] > 0)) {
      direction = (direction[0], direction[1] * -1, 0);
    } else if(direction[0] < 0) {
      direction = (direction[0] * -1, direction[1], 0);
    }
    self Vibrate(direction, 10, 0.5, 5);
  }
  self waittill("movedone");
  playFX(level._effect["poltergeist"], self.origin);
  playsoundatposition("zmb_box_poof", self.origin);
  level clientNotify("drb");
  self.fx Unlink();
  self.fx delete();
  self Delete();
  machine_clip trigger_off();
  machine_clip ConnectPaths();
  machine_clip Delete();
}

turn_jugger_on() {
  machine = getEntArray("vending_jugg", "targetname");
  level waittill("juggernog_on");
  for(i = 0; i < machine.size; i++) {
    machine[i] setModel("zombie_vending_jugg_on");
    machine[i] vibrate((0, -100, 0), 0.3, 0.4, 3);
    machine[i] playSound("zmb_perks_power_on");
    machine[i] thread perk_fx("jugger_light");
  }
  level notify("specialty_armorvest_power_on");
}

turn_doubletap_on() {
  machine = getEntArray("vending_doubletap", "targetname");
  level waittill("doubletap_on");
  for(i = 0; i < machine.size; i++) {
    machine[i] setModel("zombie_vending_doubletap_on");
    machine[i] vibrate((0, -100, 0), 0.3, 0.4, 3);
    machine[i] playSound("zmb_perks_power_on");
    machine[i] thread perk_fx("doubletap_light");
  }
  level notify("specialty_rof_power_on");
}

turn_marathon_on() {
  machine = getEntArray("vending_marathon", "targetname");
  level waittill("marathon_on");
  for(i = 0; i < machine.size; i++) {
    machine[i] setModel("zombie_vending_marathon_on");
    machine[i] vibrate((0, -100, 0), 0.3, 0.4, 3);
    machine[i] playSound("zmb_perks_power_on");
    machine[i] thread perk_fx("marathon_light");
  }
  level notify("specialty_longersprint_power_on");
}

turn_divetonuke_on() {
  machine = getEntArray("vending_divetonuke", "targetname");
  level waittill("divetonuke_on");
  for(i = 0; i < machine.size; i++) {
    machine[i] setModel("zombie_vending_nuke_on");
    machine[i] vibrate((0, -100, 0), 0.3, 0.4, 3);
    machine[i] playSound("zmb_perks_power_on");
    machine[i] thread perk_fx("divetonuke_light");
  }
  level notify("specialty_flakjacket_power_on");
}

divetonuke_explode(attacker, origin) {
  radius = level.zombie_vars["zombie_perk_divetonuke_radius"];
  min_damage = level.zombie_vars["zombie_perk_divetonuke_min_damage"];
  max_damage = level.zombie_vars["zombie_perk_divetonuke_max_damage"];
  RadiusDamage(origin, radius, max_damage, min_damage, attacker, "MOD_GRENADE_SPLASH");
  playFX(level._effect["divetonuke_groundhit"], origin);
  attacker playSound("zmb_phdflop_explo");
  attacker SetClientFlag(level._ZOMBIE_PLAYER_FLAG_DIVE2NUKE_VISION);
  wait_network_frame();
  wait_network_frame();
  attacker ClearClientFlag(level._ZOMBIE_PLAYER_FLAG_DIVE2NUKE_VISION);
}

turn_deadshot_on() {
  machine = getEntArray("vending_deadshot", "targetname");
  level waittill("deadshot_on");
  for(i = 0; i < machine.size; i++) {
    machine[i] setModel("zombie_vending_ads_on");
    machine[i] vibrate((0, -100, 0), 0.3, 0.4, 3);
    machine[i] playSound("zmb_perks_power_on");
    machine[i] thread perk_fx("deadshot_light");
  }
  level notify("specialty_deadshot_power_on");
}

turn_additionalprimaryweapon_on() {
  machine = getEntArray("vending_additionalprimaryweapon", "targetname");
  if("zombie_cod5_prototype" != level.script && "zombie_cod5_sumpf" != level.script) {
    flag_wait("power_on");
  }
  wait(3);
  for(i = 0; i < machine.size; i++) {
    machine[i] setModel("zombie_vending_three_gun_on");
    machine[i] vibrate((0, -100, 0), 0.3, 0.4, 3);
    machine[i] playSound("zmb_perks_power_on");
    machine[i] thread perk_fx("additionalprimaryweapon_light");
  }
  level notify("specialty_additionalprimaryweapon_power_on");
}

perk_fx(fx) {
  wait(3);
  playFXOnTag(level._effect[fx], self, "tag_origin");
}

electric_perks_dialog() {
  flag_wait("all_players_connected");
  players = GetPlayers();
  if(players.size == 1) {
    return;
  }
  self endon("warning_dialog");
  level endon("switch_flipped");
  timer = 0;
  while(1) {
    wait(0.5);
    players = get_players();
    for(i = 0; i < players.size; i++) {
      dist = distancesquared(players[i].origin, self.origin);
      if(dist > 70 * 70) {
        timer = 0;
        continue;
      }
      if(dist < 70 * 70 && timer < 3) {
        wait(0.5);
        timer++;
      }
      if(dist < 70 * 70 && timer == 3) {
        players[i] thread do_player_vo("vox_start", 5);
        wait(3);
        self notify("warning_dialog");
      }
    }
  }
}

vending_trigger_think() {
  perk = self.script_noteworthy;
  solo = false;
  flag_init("_start_zm_pistol_rank");
  if(isDefined(perk) &&
    (perk == "specialty_quickrevive" || perk == "specialty_quickrevive_upgrade")) {
    flag_wait("all_players_connected");
    players = GetPlayers();
    if(players.size == 1) {
      solo = true;
      flag_set("solo_game");
      level.solo_lives_given = 0;
      players[0].lives = 0;
      level maps\_zombiemode::zombiemode_solo_last_stand_pistol();
    }
  }
  flag_set("_start_zm_pistol_rank");
  if(!solo) {
    self SetHintString(&"ZOMBIE_NEED_POWER");
  }
  self SetCursorHint("HINT_NOICON");
  self UseTriggerRequireLookAt();
  cost = level.zombie_vars["zombie_perk_cost"];
  switch (perk) {
    case "specialty_armorvest_upgrade":
    case "specialty_armorvest":
      cost = 2500;
      break;
    case "specialty_quickrevive_upgrade":
    case "specialty_quickrevive":
      if(solo) {
        cost = 500;
      } else {
        cost = 1500;
      }
      break;
    case "specialty_fastreload_upgrade":
    case "specialty_fastreload":
      cost = 3000;
      break;
    case "specialty_rof_upgrade":
    case "specialty_rof":
      cost = 2000;
      break;
    case "specialty_longersprint_upgrade":
    case "specialty_longersprint":
      cost = 2000;
      break;
    case "specialty_flakjacket_upgrade":
    case "specialty_flakjacket":
      cost = 2000;
      break;
    case "specialty_deadshot_upgrade":
    case "specialty_deadshot":
      cost = 1500;
      break;
    case "specialty_additionalprimaryweapon_upgrade":
    case "specialty_additionalprimaryweapon":
      cost = 4000;
      break;
  }
  self.cost = cost;
  if(!solo) {
    notify_name = perk + "_power_on";
    level waittill(notify_name);
  }
  if(!isDefined(level._perkmachinenetworkchoke)) {
    level._perkmachinenetworkchoke = 0;
  } else {
    level._perkmachinenetworkchoke++;
  }
  for(i = 0; i < level._perkmachinenetworkchoke; i++) {
    wait_network_frame();
  }
  self thread maps\_zombiemode_audio::perks_a_cola_jingle_timer();
  perk_hum = spawn("script_origin", self.origin);
  perk_hum playLoopSound("zmb_perks_machine_loop");
  self thread check_player_has_perk(perk);
  switch (perk) {
    case "specialty_armorvest_upgrade":
    case "specialty_armorvest":
      self SetHintString(&"ZOMBIE_PERK_JUGGERNAUT", cost);
      break;
    case "specialty_quickrevive_upgrade":
    case "specialty_quickrevive":
      if(solo) {
        self SetHintString(&"ZOMBIE_PERK_QUICKREVIVE_SOLO", cost);
      } else {
        self SetHintString(&"ZOMBIE_PERK_QUICKREVIVE", cost);
      }
      break;
    case "specialty_fastreload_upgrade":
    case "specialty_fastreload":
      self SetHintString(&"ZOMBIE_PERK_FASTRELOAD", cost);
      break;
    case "specialty_rof_upgrade":
    case "specialty_rof":
      self SetHintString(&"ZOMBIE_PERK_DOUBLETAP", cost);
      break;
    case "specialty_longersprint_upgrade":
    case "specialty_longersprint":
      self SetHintString(&"ZOMBIE_PERK_MARATHON", cost);
      break;
    case "specialty_flakjacket_upgrade":
    case "specialty_flakjacket":
      self SetHintString(&"ZOMBIE_PERK_DIVETONUKE", cost);
      break;
    case "specialty_deadshot_upgrade":
    case "specialty_deadshot":
      self SetHintString(&"ZOMBIE_PERK_DEADSHOT", cost);
      break;
    case "specialty_additionalprimaryweapon_upgrade":
    case "specialty_additionalprimaryweapon":
      self SetHintString(&"ZOMBIE_PERK_ADDITIONALPRIMARYWEAPON", cost);
      break;
    default:
      self SetHintString(perk + " Cost: " + level.zombie_vars["zombie_perk_cost"]);
  }
  for(;;) {
    self waittill("trigger", player);
    index = maps\_zombiemode_weapons::get_player_index(player);
    if(player maps\_laststand::player_is_in_laststand() || is_true(player.intermission)) {
      continue;
    }
    if(player in_revive_trigger()) {
      continue;
    }
    if(player isThrowingGrenade()) {
      wait(0.1);
      continue;
    }
    if(player isSwitchingWeapons()) {
      wait(0.1);
      continue;
    }
    if(player is_drinking()) {
      wait(0.1);
      continue;
    }
    if(player HasPerk(perk)) {
      cheat = false;
      if(cheat != true) {
        self playSound("deny");
        player maps\_zombiemode_audio::create_and_play_dialog("general", "perk_deny", undefined, 1);
        continue;
      }
    }
    if(player.score < cost) {
      self playSound("evt_perk_deny");
      player maps\_zombiemode_audio::create_and_play_dialog("general", "perk_deny", undefined, 0);
      continue;
    }
    if(player.num_perks >= 4) {
      self playSound("evt_perk_deny");
      player maps\_zombiemode_audio::create_and_play_dialog("general", "sigh");
      continue;
    }
    sound = "evt_bottle_dispense";
    playsoundatposition(sound, self.origin);
    player maps\_zombiemode_score::minus_to_player_score(cost);
    player.perk_purchased = perk;
    switch (perk) {
      case "specialty_armorvest_upgrade":
      case "specialty_armorvest":
        sound = "mus_perks_jugger_sting";
        break;
      case "specialty_quickrevive_upgrade":
      case "specialty_quickrevive":
        sound = "mus_perks_revive_sting";
        break;
      case "specialty_fastreload_upgrade":
      case "specialty_fastreload":
        sound = "mus_perks_speed_sting";
        break;
      case "specialty_rof_upgrade":
      case "specialty_rof":
        sound = "mus_perks_doubletap_sting";
        break;
      case "specialty_longersprint_upgrade":
      case "specialty_longersprint":
        sound = "mus_perks_phd_sting";
        break;
      case "specialty_flakjacket_upgrade":
      case "specialty_flakjacket":
        sound = "mus_perks_stamin_sting";
        break;
      case "specialty_deadshot_upgrade":
      case "specialty_deadshot":
        sound = "mus_perks_jugger_sting";
        break;
      case "specialty_additionalprimaryweapon_upgrade":
      case "specialty_additionalprimaryweapon":
        sound = "mus_perks_mulekick_sting";
        break;
      default:
        sound = "mus_perks_jugger_sting";
        break;
    }
    self thread maps\_zombiemode_audio::play_jingle_or_stinger(self.script_label);
    gun = player perk_give_bottle_begin(perk);
    player waittill_any("fake_death", "death", "player_downed", "weapon_change_complete");
    player perk_give_bottle_end(gun, perk);
    if(player maps\_laststand::player_is_in_laststand() || is_true(player.intermission)) {
      continue;
    }
    if(isDefined(level.perk_bought_func)) {
      player[[level.perk_bought_func]](perk);
    }
    player.perk_purchased = undefined;
    player give_perk(perk, true);
    bbPrint("zombie_uses: playername %s playerscore %d teamscore %d round %d cost %d name %s x %f y %f z %f type perk",
      player.playername, player.score, level.team_pool[player.team_num].score, level.round_number, cost, perk, self.origin);
  }
}

solo_revive_buy_trigger_move(revive_trigger_noteworthy) {
  self endon("death");
  revive_perk_trigger = getEnt(revive_trigger_noteworthy, "script_noteworthy");
  revive_perk_trigger trigger_off();
  if(level.solo_lives_given >= 3) {
    if(isDefined(level._solo_revive_machine_expire_func)) {
      revive_perk_trigger[[level._solo_revive_machine_expire_func]]();
    }
    return;
  }
  while(self.lives > 0) {
    wait(0.1);
  }
  revive_perk_trigger trigger_on();
}

unlocked_perk_upgrade(perk) {
  ch_ref = string(tablelookup("mp/challengeTable_zmPerk.csv", 12, perk, 7));
  ch_max = int(tablelookup("mp/challengeTable_zmPerk.csv", 12, perk, 4));
  ch_progress = self getdstat("challengeStats", ch_ref, "challengeProgress");
  if(ch_progress >= ch_max) {
    return true;
  }
  return false;
}

give_perk(perk, bought) {
  self SetPerk(perk);
  self.num_perks++;
  if(is_true(bought)) {
    self thread maps\_zombiemode_audio::perk_vox(perk);
    self setblur(4, 0.1);
    wait(0.1);
    self setblur(0, 0.1);
    self notify("perk_bought", perk);
  }
  if(perk == "specialty_armorvest") {
    self.preMaxHealth = self.maxhealth;
    self SetMaxHealth(level.zombie_vars["zombie_perk_juggernaut_health"]);
  } else if(perk == "specialty_armorvest_upgrade") {
    self.preMaxHealth = self.maxhealth;
    self SetMaxHealth(level.zombie_vars["zombie_perk_juggernaut_health_upgrade"]);
  }
  if(perk == "specialty_deadshot") {
    self SetClientFlag(level._ZOMBIE_PLAYER_FLAG_DEADSHOT_PERK);
  } else if(perk == "specialty_deadshot_upgrade") {
    self SetClientFlag(level._ZOMBIE_PLAYER_FLAG_DEADSHOT_PERK);
  }
  players = getplayers();
  if(players.size == 1 && perk == "specialty_quickrevive") {
    self.lives = 1;
    level.solo_lives_given++;
    if(level.solo_lives_given >= 3) {
      flag_set("solo_revive");
    }
    self thread solo_revive_buy_trigger_move(perk);
  }
  self perk_hud_create(perk);
  self.stats["perks"]++;
  self thread perk_think(perk);
}

check_player_has_perk(perk) {
  self endon("death");
  dist = 128 * 128;
  while(true) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(distanceSquared(players[i].origin, self.origin) < dist) {
        if(!players[i] hasperk(perk) && !(players[i] in_revive_trigger()) && (!players[i] hacker_active())) {
          self setinvisibletoplayer(players[i], false);
        } else {
          self SetInvisibleToPlayer(players[i], true);
        }
      }
    }
    wait(0.1);
  }
}

vending_set_hintstring(perk) {
  switch (perk) {
    case "specialty_armorvest_upgrade":
    case "specialty_armorvest":
      break;
  }
}

perk_think(perk) {
  perk_str = perk + "_stop";
  result = self waittill_any_return("fake_death", "death", "player_downed", perk_str);
  do_retain = true;
  if((get_players().size == 1) && perk == "specialty_quickrevive") {
    do_retain = false;
  }
  if(do_retain && isDefined(self._retain_perks) && self._retain_perks) {
    return;
  }
  self UnsetPerk(perk);
  self.num_perks--;
  switch (perk) {
    case "specialty_armorvest":
      self SetMaxHealth(100);
      break;
    case "specialty_additionalprimaryweapon":
      if(result == perk_str) {
        self maps\_zombiemode::take_additionalprimaryweapon();
      }
      break;
    case "specialty_deadshot":
      self ClearClientFlag(level._ZOMBIE_PLAYER_FLAG_DEADSHOT_PERK);
      break;
    case "specialty_deadshot_upgrade":
      self ClearClientFlag(level._ZOMBIE_PLAYER_FLAG_DEADSHOT_PERK);
      break;
  }
  self perk_hud_destroy(perk);
  self.perk_purchased = undefined;
  if(isDefined(level.perk_lost_func)) {
    self[[level.perk_lost_func]](perk);
  }
  self notify("perk_lost");
}

perk_hud_create(perk) {
  if(!isDefined(self.perk_hud)) {
    self.perk_hud = [];
  }
  shader = "";
  switch (perk) {
    case "specialty_armorvest_upgrade":
      shader = "specialty_juggernaut_zombies_pro";
      break;
    case "specialty_armorvest":
      shader = "specialty_juggernaut_zombies";
      break;
    case "specialty_quickrevive_upgrade":
      shader = "specialty_quickrevive_zombies_pro";
      break;
    case "specialty_quickrevive":
      shader = "specialty_quickrevive_zombies";
      break;
    case "specialty_fastreload_upgrade":
      shader = "specialty_fastreload_zombies_pro";
      break;
    case "specialty_fastreload":
      shader = "specialty_fastreload_zombies";
      break;
    case "specialty_rof_upgrade":
    case "specialty_rof":
      shader = "specialty_doubletap_zombies";
      break;
    case "specialty_longersprint_upgrade":
    case "specialty_longersprint":
      shader = "specialty_marathon_zombies";
      break;
    case "specialty_flakjacket_upgrade":
    case "specialty_flakjacket":
      shader = "specialty_divetonuke_zombies";
      break;
    case "specialty_deadshot_upgrade":
    case "specialty_deadshot":
      shader = "specialty_ads_zombies";
      break;
    case "specialty_additionalprimaryweapon_upgrade":
    case "specialty_additionalprimaryweapon":
      shader = "specialty_extraprimaryweapon_zombies";
      break;
    default:
      shader = "";
      break;
  }
  hud = create_simple_hud(self);
  hud.foreground = true;
  hud.sort = 1;
  hud.hidewheninmenu = false;
  hud.alignX = "left";
  hud.alignY = "bottom";
  hud.horzAlign = "user_left";
  hud.vertAlign = "user_bottom";
  hud.x = self.perk_hud.size * 30;
  hud.y = hud.y - 70;
  hud.alpha = 1;
  hud SetShader(shader, 24, 24);
  self.perk_hud[perk] = hud;
}

perk_hud_destroy(perk) {
  self.perk_hud[perk] destroy_hud();
  self.perk_hud[perk] = undefined;
}

perk_hud_flash() {
  self endon("death");
  self.flash = 1;
  self ScaleOverTime(0.05, 32, 32);
  wait(0.3);
  self ScaleOverTime(0.05, 24, 24);
  wait(0.3);
  self.flash = 0;
}

perk_flash_audio(perk) {
  alias = undefined;
  switch (perk) {
    case "specialty_armorvest":
      alias = "zmb_hud_flash_jugga";
      break;
    case "specialty_quickrevive":
      alias = "zmb_hud_flash_revive";
      break;
    case "specialty_fastreload":
      alias = "zmb_hud_flash_speed";
      break;
    case "specialty_longersprint":
      alias = "zmb_hud_flash_stamina";
      break;
    case "specialty_flakjacket":
      alias = "zmb_hud_flash_phd";
      break;
    case "specialty_deadshot":
      alias = "zmb_hud_flash_deadshot";
      break;
    case "specialty_additionalprimaryweapon":
      alias = "zmb_hud_flash_additionalprimaryweapon";
      break;
  }
  if(isDefined(alias)) {
    self PlayLocalSound(alias);
  }
}

perk_hud_start_flash(perk) {
  if(self HasPerk(perk) && isDefined(self.perk_hud)) {
    hud = self.perk_hud[perk];
    if(isDefined(hud)) {
      if(!is_true(hud.flash)) {
        hud thread perk_hud_flash();
        self thread perk_flash_audio(perk);
      }
    }
  }
}

perk_hud_stop_flash(perk, taken) {
  if(self HasPerk(perk) && isDefined(self.perk_hud)) {
    hud = self.perk_hud[perk];
    if(isDefined(hud)) {
      hud.flash = undefined;
      if(isDefined(taken)) {
        hud notify("stop_flash_perk");
      }
    }
  }
}

perk_give_bottle_begin(perk) {
  self increment_is_drinking();
  self AllowLean(false);
  self AllowAds(false);
  self AllowSprint(false);
  self AllowCrouch(true);
  self AllowProne(false);
  self AllowMelee(false);
  wait(0.05);
  if(self GetStance() == "prone") {
    self SetStance("crouch");
  }
  gun = self GetCurrentWeapon();
  weapon = "";
  switch (perk) {
    case " _upgrade":
    case "specialty_armorvest":
      weapon = "zombie_perk_bottle_jugg";
      break;
    case "specialty_quickrevive_upgrade":
    case "specialty_quickrevive":
      weapon = "zombie_perk_bottle_revive";
      break;
    case "specialty_fastreload_upgrade":
    case "specialty_fastreload":
      weapon = "zombie_perk_bottle_sleight";
      break;
    case "specialty_rof_upgrade":
    case "specialty_rof":
      weapon = "zombie_perk_bottle_doubletap";
      break;
    case "specialty_longersprint_upgrade":
    case "specialty_longersprint":
      weapon = "zombie_perk_bottle_marathon";
      break;
    case "specialty_flakjacket_upgrade":
    case "specialty_flakjacket":
      weapon = "zombie_perk_bottle_nuke";
      break;
    case "specialty_deadshot_upgrade":
    case "specialty_deadshot":
      weapon = "zombie_perk_bottle_deadshot";
      break;
    case "specialty_additionalprimaryweapon_upgrade":
    case "specialty_additionalprimaryweapon":
      weapon = "zombie_perk_bottle_additionalprimaryweapon";
      break;
  }
  self GiveWeapon(weapon);
  self SwitchToWeapon(weapon);
  return gun;
}

perk_give_bottle_end(gun, perk) {
  assert(gun != "zombie_perk_bottle_doubletap");
  assert(gun != "zombie_perk_bottle_jugg");
  assert(gun != "zombie_perk_bottle_revive");
  assert(gun != "zombie_perk_bottle_sleight");
  assert(gun != "zombie_perk_bottle_marathon");
  assert(gun != "zombie_perk_bottle_nuke");
  assert(gun != "zombie_perk_bottle_deadshot");
  assert(gun != "zombie_perk_bottle_additionalprimaryweapon");
  assert(gun != "syrette_sp");
  self AllowLean(true);
  self AllowAds(true);
  self AllowSprint(true);
  self AllowProne(true);
  self AllowMelee(true);
  weapon = "";
  switch (perk) {
    case "specialty_rof_upgrade":
    case "specialty_rof":
      weapon = "zombie_perk_bottle_doubletap";
      break;
    case "specialty_longersprint_upgrade":
    case "specialty_longersprint":
      weapon = "zombie_perk_bottle_marathon";
      break;
    case "specialty_flakjacket_upgrade":
    case "specialty_flakjacket":
      weapon = "zombie_perk_bottle_nuke";
      break;
    case "specialty_armorvest_upgrade":
    case "specialty_armorvest":
      weapon = "zombie_perk_bottle_jugg";
      self.jugg_used = true;
      break;
    case "specialty_quickrevive_upgrade":
    case "specialty_quickrevive":
      weapon = "zombie_perk_bottle_revive";
      break;
    case "specialty_fastreload_upgrade":
    case "specialty_fastreload":
      weapon = "zombie_perk_bottle_sleight";
      self.speed_used = true;
      break;
    case "specialty_deadshot_upgrade":
    case "specialty_deadshot":
      weapon = "zombie_perk_bottle_deadshot";
      break;
    case "specialty_additionalprimaryweapon_upgrade":
    case "specialty_additionalprimaryweapon":
      weapon = "zombie_perk_bottle_additionalprimaryweapon";
      break;
  }
  if(self maps\_laststand::player_is_in_laststand() || is_true(self.intermission)) {
    self TakeWeapon(weapon);
    return;
  }
  self TakeWeapon(weapon);
  if(self is_multiple_drinking()) {
    self decrement_is_drinking();
    return;
  } else if(gun != "none" && !is_placeable_mine(gun) && !is_equipment(gun)) {
    self SwitchToWeapon(gun);
    if(is_melee_weapon(gun)) {
      self decrement_is_drinking();
      return;
    }
  } else {
    primaryWeapons = self GetWeaponsListPrimaries();
    if(isDefined(primaryWeapons) && primaryWeapons.size > 0) {
      self SwitchToWeapon(primaryWeapons[0]);
    }
  }
  self waittill("weapon_change_complete");
  if(!self maps\_laststand::player_is_in_laststand() && !is_true(self.intermission)) {
    self decrement_is_drinking();
  }
}

give_random_perk() {
  vending_triggers = getEntArray("zombie_vending", "targetname");
  perks = [];
  for(i = 0; i < vending_triggers.size; i++) {
    perk = vending_triggers[i].script_noteworthy;
    if(isDefined(self.perk_purchased) && self.perk_purchased == perk) {
      continue;
    }
    if(!self HasPerk(perk)) {
      perks[perks.size] = perk;
    }
  }
  if(perks.size > 0) {
    perks = array_randomize(perks);
    self give_perk(perks[0]);
  }
}

lose_random_perk() {
  vending_triggers = getEntArray("zombie_vending", "targetname");
  perks = [];
  for(i = 0; i < vending_triggers.size; i++) {
    perk = vending_triggers[i].script_noteworthy;
    if(isDefined(self.perk_purchased) && self.perk_purchased == perk) {
      continue;
    }
    if(self HasPerk(perk)) {
      perks[perks.size] = perk;
    }
  }
  if(perks.size > 0) {
    perks = array_randomize(perks);
    perk = perks[0];
    perk_str = perk + "_stop";
    self notify(perk_str);
    if(flag("solo_game") && perk == "specialty_quickrevive") {
      self.lives--;
    }
  }
}

update_perk_hud() {
  if(isDefined(self.perk_hud)) {
    keys = getarraykeys(self.perk_hud);
    for(i = 0; i < self.perk_hud.size; i++) {
      self.perk_hud[keys[i]].x = i * 30;
    }
  }
}

quantum_bomb_give_nearest_perk_validation(position) {
  vending_triggers = getEntArray("zombie_vending", "targetname");
  range_squared = 180 * 180;
  for(i = 0; i < vending_triggers.size; i++) {
    if(distanceSquared(vending_triggers[i].origin, position) < range_squared) {
      return true;
    }
  }
  return false;
}

quantum_bomb_give_nearest_perk_result(position) {
  [[level.quantum_bomb_play_mystery_effect_func]](position);
  vending_triggers = getEntArray("zombie_vending", "targetname");
  nearest = 0;
  for(i = 1; i < vending_triggers.size; i++) {
    if(distanceSquared(vending_triggers[i].origin, position) < distanceSquared(vending_triggers[nearest].origin, position)) {
      nearest = i;
    }
  }
  players = getplayers();
  perk = vending_triggers[nearest].script_noteworthy;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(player.sessionstate == "spectator" || player maps\_laststand::player_is_in_laststand()) {
      continue;
    }
    if(!player HasPerk(perk) && (!isDefined(player.perk_purchased) || player.perk_purchased != perk) && randomInt(5)) {
      if(player == self) {
        self thread maps\_zombiemode_audio::create_and_play_dialog("kill", "quant_good");
      }
      player give_perk(perk);
      player[[level.quantum_bomb_play_player_effect_func]]();
    }
  }
}