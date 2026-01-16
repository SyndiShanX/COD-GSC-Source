/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_perk_random.gsc
*************************************************/

#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#namespace zm_perk_random;

function autoexec __init__sytem__() {
  system::register("zm_perk_random", & __init__, & __main__, undefined);
}

function __init__() {
  level._random_zombie_perk_cost = 1500;
  clientfield::register("scriptmover", "perk_bottle_cycle_state", 5000, 2, "int");
  clientfield::register("zbarrier", "set_client_light_state", 5000, 2, "int");
  clientfield::register("zbarrier", "client_stone_emmissive_blink", 5000, 1, "int");
  clientfield::register("zbarrier", "init_perk_random_machine", 5000, 1, "int");
  clientfield::register("scriptmover", "turn_active_perk_light_green", 5000, 1, "int");
  clientfield::register("scriptmover", "turn_on_location_indicator", 5000, 1, "int");
  clientfield::register("zbarrier", "lightning_bolt_FX_toggle", 10000, 1, "int");
  clientfield::register("scriptmover", "turn_active_perk_ball_light", 5000, 1, "int");
  clientfield::register("scriptmover", "zone_captured", 5000, 1, "int");
  level._effect["perk_machine_light_yellow"] = "dlc1/castle/fx_wonder_fizz_light_yellow";
  level._effect["perk_machine_light_red"] = "dlc1/castle/fx_wonder_fizz_light_red";
  level._effect["perk_machine_light_green"] = "dlc1/castle/fx_wonder_fizz_light_green";
  level._effect["perk_machine_location"] = "fx/zombie/fx_wonder_fizz_lightning_all";
  level flag::init("machine_can_reset");
}

function __main__() {
  if(!isdefined(level.perk_random_machine_count)) {
    level.perk_random_machine_count = 1;
  }
  if(!isdefined(level.perk_random_machine_state_func)) {
    level.perk_random_machine_state_func = & process_perk_random_machine_state;
  }
  level thread setup_devgui();
  level thread setup_perk_random_machines();
}

function private setup_perk_random_machines() {
  waittillframeend();
  level.perk_bottle_weapon_array = arraycombine(level.machine_assets, level._custom_perks, 0, 1);
  level.perk_random_machines = getentarray("perk_random_machine", "targetname");
  level.perk_random_machine_count = level.perk_random_machines.size;
  perk_random_machine_init();
}

function perk_random_machine_init() {
  foreach(machine in level.perk_random_machines) {
    if(!isdefined(machine.cost)) {
      machine.cost = 1500;
    }
    machine.current_perk_random_machine = 0;
    machine.uses_at_current_location = 0;
    machine create_perk_random_machine_unitrigger_stub();
    machine clientfield::set("init_perk_random_machine", 1);
    wait(0.5);
    machine thread set_perk_random_machine_state("power_off");
  }
  level.perk_random_machines = array::randomize(level.perk_random_machines);
  init_starting_perk_random_machine_location();
}

function private init_starting_perk_random_machine_location() {
  b_starting_machine_found = 0;
  for (i = 0; i < level.perk_random_machines.size; i++) {
    if(isdefined(level.perk_random_machines[i].script_noteworthy) && issubstr(level.perk_random_machines[i].script_noteworthy, "start_perk_random_machine") && (!(isdefined(b_starting_machine_found) && b_starting_machine_found))) {
      level.perk_random_machines[i].current_perk_random_machine = 1;
      level.perk_random_machines[i] thread machine_think();
      level.perk_random_machines[i] thread set_perk_random_machine_state("initial");
      b_starting_machine_found = 1;
      continue;
    }
    level.perk_random_machines[i] thread wait_for_power();
  }
}

function create_perk_random_machine_unitrigger_stub() {
  self.unitrigger_stub = spawnstruct();
  self.unitrigger_stub.script_width = 70;
  self.unitrigger_stub.script_height = 30;
  self.unitrigger_stub.script_length = 40;
  self.unitrigger_stub.origin = (self.origin + (anglestoright(self.angles) * self.unitrigger_stub.script_length)) + (anglestoup(self.angles) * (self.unitrigger_stub.script_height / 2));
  self.unitrigger_stub.angles = self.angles;
  self.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
  self.unitrigger_stub.trigger_target = self;
  zm_unitrigger::unitrigger_force_per_player_triggers(self.unitrigger_stub, 1);
  self.unitrigger_stub.prompt_and_visibility_func = & perk_random_machine_trigger_update_prompt;
  self.unitrigger_stub.script_int = self.script_int;
  thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, & perk_random_unitrigger_think);
}

function perk_random_machine_trigger_update_prompt(player) {
  can_use = self perk_random_machine_stub_update_prompt(player);
  if(isdefined(self.hint_string)) {
    if(isdefined(self.hint_parm1)) {
      self sethintstring(self.hint_string, self.hint_parm1);
    } else {
      self sethintstring(self.hint_string);
    }
  }
  return can_use;
}

function perk_random_machine_stub_update_prompt(player) {
  self setcursorhint("HINT_NOICON");
  if(!self trigger_visible_to_player(player)) {
    return false;
  }
  self.hint_parm1 = undefined;
  n_power_on = is_power_on(self.stub.script_int);
  if(!n_power_on) {
    self.hint_string = & "ZOMBIE_NEED_POWER";
    return false;
  }
  if(self.stub.trigger_target.state == "idle" || self.stub.trigger_target.state == "vending") {
    n_purchase_limit = player zm_utility::get_player_perk_purchase_limit();
    if(!player zm_utility::can_player_purchase_perk()) {
      self.hint_string = & "ZOMBIE_RANDOM_PERK_TOO_MANY";
      if(isdefined(n_purchase_limit)) {
        self.hint_parm1 = n_purchase_limit;
      }
      return false;
    }
    if(isdefined(self.stub.trigger_target.machine_user)) {
      if(isdefined(self.stub.trigger_target.grab_perk_hint) && self.stub.trigger_target.grab_perk_hint) {
        self.hint_string = & "ZOMBIE_RANDOM_PERK_PICKUP";
        return true;
      }
      self.hint_string = "";
      return false;
    }
    n_purchase_limit = player zm_utility::get_player_perk_purchase_limit();
    if(!player zm_utility::can_player_purchase_perk()) {
      self.hint_string = & "ZOMBIE_RANDOM_PERK_TOO_MANY";
      if(isdefined(n_purchase_limit)) {
        self.hint_parm1 = n_purchase_limit;
      }
      return false;
    }
    self.hint_string = & "ZOMBIE_RANDOM_PERK_BUY";
    self.hint_parm1 = level._random_zombie_perk_cost;
    return true;
  }
  self.hint_string = & "ZOMBIE_RANDOM_PERK_ELSEWHERE";
  return false;
}

function trigger_visible_to_player(player) {
  self setinvisibletoplayer(player);
  visible = 1;
  if(isdefined(self.stub.trigger_target.machine_user)) {
    if(player != self.stub.trigger_target.machine_user || zm_utility::is_placeable_mine(self.stub.trigger_target.machine_user getcurrentweapon())) {
      visible = 0;
    }
  } else if(!player can_buy_perk()) {
    visible = 0;
  }
  if(!visible) {
    return false;
  }
  if(player player_has_all_available_perks()) {
    return false;
  }
  self setvisibletoplayer(player);
  return true;
}

function player_has_all_available_perks() {
  for (i = 0; i < level._random_perk_machine_perk_list.size; i++) {
    if(!self hasperk(level._random_perk_machine_perk_list[i])) {
      return false;
    }
  }
  return true;
}

function can_buy_perk() {
  if(isdefined(self.is_drinking) && self.is_drinking > 0) {
    return false;
  }
  current_weapon = self getcurrentweapon();
  if(zm_utility::is_placeable_mine(current_weapon) || zm_equipment::is_equipment_that_blocks_purchase(current_weapon)) {
    return false;
  }
  if(self zm_utility::in_revive_trigger()) {
    return false;
  }
  if(current_weapon == level.weaponnone) {
    return false;
  }
  return true;
}

function perk_random_unitrigger_think(player) {
  self endon("kill_trigger");
  while (true) {
    self waittill("trigger", player);
    self.stub.trigger_target notify("trigger", player);
  }
}

function machine_think() {
  level notify("machine_think");
  level endon("machine_think");
  self.num_time_used = 0;
  self.num_til_moved = randomintrange(3, 7);
  if(self.state !== "initial" || "idle") {
    self thread set_perk_random_machine_state("arrive");
    self waittill("arrived");
    self thread set_perk_random_machine_state("initial");
    wait(1);
  }
  if(isdefined(level.zm_custom_perk_random_power_flag)) {
    level flag::wait_till(level.zm_custom_perk_random_power_flag);
  } else {
    while (!is_power_on(self.script_int)) {
      wait(1);
    }
  }
  self thread set_perk_random_machine_state("idle");
  if(isdefined(level.bottle_spawn_location)) {
    level.bottle_spawn_location delete();
  }
  level.bottle_spawn_location = spawn("script_model", self.origin);
  level.bottle_spawn_location setmodel("tag_origin");
  level.bottle_spawn_location.angles = self.angles;
  level.bottle_spawn_location.origin = level.bottle_spawn_location.origin + vectorscale((0, 0, 1), 65);
  while (true) {
    self waittill("trigger", player);
    level flag::clear("machine_can_reset");
    if(!player zm_score::can_player_purchase(level._random_zombie_perk_cost)) {
      self playsound("evt_perk_deny");
      continue;
    }
    self.machine_user = player;
    self.num_time_used++;
    player zm_stats::increment_client_stat("use_perk_random");
    player zm_stats::increment_player_stat("use_perk_random");
    player zm_score::minus_to_player_score(level._random_zombie_perk_cost);
    self thread set_perk_random_machine_state("vending");
    if(isdefined(level.perk_random_vo_func_usemachine) && isdefined(player)) {
      player thread[[level.perk_random_vo_func_usemachine]]();
    }
    while (true) {
      random_perk = get_weighted_random_perk(player);
      self playsound("zmb_rand_perk_start");
      self playloopsound("zmb_rand_perk_loop", 1);
      wait(1);
      self notify("bottle_spawned");
      self thread start_perk_bottle_cycling();
      self thread perk_bottle_motion();
      model = get_perk_weapon_model(random_perk);
      wait(3);
      self notify("done_cycling");
      if(self.num_time_used >= self.num_til_moved && level.perk_random_machine_count > 1) {
        level.bottle_spawn_location setmodel("wpn_t7_zmb_perk_bottle_bear_world");
        self stoploopsound(0.5);
        self thread set_perk_random_machine_state("leaving");
        wait(3);
        player zm_score::add_to_player_score(level._random_zombie_perk_cost);
        level.bottle_spawn_location setmodel("tag_origin");
        self thread machine_selector();
        self clientfield::set("lightning_bolt_FX_toggle", 0);
        self.machine_user = undefined;
        break;
      } else {
        level.bottle_spawn_location setmodel(model);
      }
      self playsound("zmb_rand_perk_bottle");
      self.grab_perk_hint = 1;
      self thread grab_check(player, random_perk);
      self thread time_out_check();
      self util::waittill_either("grab_check", "time_out_check");
      self.grab_perk_hint = 0;
      self playsound("zmb_rand_perk_stop");
      self stoploopsound(0.5);
      self.machine_user = undefined;
      level.bottle_spawn_location setmodel("tag_origin");
      self thread set_perk_random_machine_state("idle");
      break;
    }
    level flag::wait_till("machine_can_reset");
  }
}

function grab_check(player, random_perk) {
  self endon("time_out_check");
  perk_is_bought = 0;
  while (!perk_is_bought) {
    self waittill("trigger", e_triggerer);
    if(e_triggerer == player) {
      if(isdefined(player.is_drinking) && player.is_drinking > 0) {
        wait(0.1);
        continue;
      }
      if(player zm_utility::can_player_purchase_perk()) {
        perk_is_bought = 1;
      } else {
        self playsound("evt_perk_deny");
        self notify("time_out_or_perk_grab");
        return;
      }
    }
  }
  player zm_stats::increment_client_stat("grabbed_from_perk_random");
  player zm_stats::increment_player_stat("grabbed_from_perk_random");
  player thread monitor_when_player_acquires_perk();
  self notify("grab_check");
  self notify("time_out_or_perk_grab");
  player notify("perk_purchased", random_perk);
  gun = player zm_perks::perk_give_bottle_begin(random_perk);
  evt = player util::waittill_any_ex("fake_death", "death", "player_downed", "weapon_change_complete", self, "time_out_check");
  if(evt == "weapon_change_complete") {
    player thread zm_perks::wait_give_perk(random_perk, 1);
  }
  player zm_perks::perk_give_bottle_end(gun, random_perk);
  if(!(isdefined(player.has_drunk_wunderfizz) && player.has_drunk_wunderfizz)) {
    player.has_drunk_wunderfizz = 1;
  }
}

function monitor_when_player_acquires_perk() {
  self util::waittill_any("perk_acquired", "death_or_disconnect", "player_downed");
  level flag::set("machine_can_reset");
}

function time_out_check() {
  self endon("grab_check");
  wait(10);
  self notify("time_out_check");
  level flag::set("machine_can_reset");
}

function wait_for_power() {
  if(isdefined(self.script_int)) {
    str_wait = "power_on" + self.script_int;
    level flag::wait_till(str_wait);
  } else {
    if(isdefined(level.zm_custom_perk_random_power_flag)) {
      level flag::wait_till(level.zm_custom_perk_random_power_flag);
    } else {
      level flag::wait_till("power_on");
    }
  }
  self thread set_perk_random_machine_state("away");
}

function machine_selector() {
  if(level.perk_random_machines.size == 1) {
    new_machine = level.perk_random_machines[0];
    new_machine thread machine_think();
  } else {
    do {
      new_machine = level.perk_random_machines[randomint(level.perk_random_machines.size)];
    }
    while (new_machine.current_perk_random_machine == 1);
    new_machine.current_perk_random_machine = 1;
    self.current_perk_random_machine = 0;
    wait(10);
    new_machine thread machine_think();
  }
}

function include_perk_in_random_rotation(perk) {
  if(!isdefined(level._random_perk_machine_perk_list)) {
    level._random_perk_machine_perk_list = [];
  }
  if(!isdefined(level._random_perk_machine_perk_list)) {
    level._random_perk_machine_perk_list = [];
  } else if(!isarray(level._random_perk_machine_perk_list)) {
    level._random_perk_machine_perk_list = array(level._random_perk_machine_perk_list);
  }
  level._random_perk_machine_perk_list[level._random_perk_machine_perk_list.size] = perk;
}

function get_weighted_random_perk(player) {
  keys = array::randomize(getarraykeys(level._random_perk_machine_perk_list));
  if(isdefined(level.custom_random_perk_weights)) {
    keys = player[[level.custom_random_perk_weights]]();
  }
  forced_perk = getdvarstring("");
  if(forced_perk != "" && isdefined(level._random_perk_machine_perk_list[forced_perk])) {
    arrayinsert(keys, forced_perk, 0);
  }
  for (i = 0; i < keys.size; i++) {
    if(player hasperk(level._random_perk_machine_perk_list[keys[i]])) {
      continue;
      continue;
    }
    return level._random_perk_machine_perk_list[keys[i]];
  }
  return level._random_perk_machine_perk_list[keys[0]];
}

function perk_bottle_motion() {
  putouttime = 3;
  putbacktime = 10;
  v_float = (anglestoforward(self.angles - (0, 90, 0))) * 10;
  level.bottle_spawn_location.origin = self.origin + (0, 0, 53);
  level.bottle_spawn_location.angles = self.angles;
  level.bottle_spawn_location.origin = level.bottle_spawn_location.origin - v_float;
  level.bottle_spawn_location moveto(level.bottle_spawn_location.origin + v_float, putouttime, putouttime * 0.5);
  level.bottle_spawn_location.angles = level.bottle_spawn_location.angles + (0, 0, 10);
  level.bottle_spawn_location rotateyaw(720, putouttime, putouttime * 0.5);
  self waittill("done_cycling");
  level.bottle_spawn_location.angles = self.angles;
  level.bottle_spawn_location moveto(level.bottle_spawn_location.origin - v_float, putbacktime, putbacktime * 0.5);
  level.bottle_spawn_location rotateyaw(90, putbacktime, putbacktime * 0.5);
}

function start_perk_bottle_cycling() {
  self endon("done_cycling");
  array_key = getarraykeys(level.perk_bottle_weapon_array);
  timer = 0;
  while (true) {
    for (i = 0; i < array_key.size; i++) {
      if(isdefined(level.perk_bottle_weapon_array[array_key[i]].weapon)) {
        model = getweaponmodel(level.perk_bottle_weapon_array[array_key[i]].weapon);
      } else {
        model = getweaponmodel(level.perk_bottle_weapon_array[array_key[i]].perk_bottle_weapon);
      }
      level.bottle_spawn_location setmodel(model);
      wait(0.2);
    }
  }
}

function get_perk_weapon_model(perk) {
  weapon = level.machine_assets[perk].weapon;
  if(isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].perk_bottle_weapon)) {
    weapon = level._custom_perks[perk].perk_bottle_weapon;
  }
  return getweaponmodel(weapon);
}

function perk_random_vending() {
  self clientfield::set("client_stone_emmissive_blink", 1);
  self thread perk_random_loop_anim(5, "opening", "opening");
  self thread perk_random_loop_anim(3, "closing", "closing");
  self thread perk_random_vend_sfx();
  self notify("vending");
  self waittill("bottle_spawned");
  self setzbarrierpiecestate(4, "opening");
}

function perk_random_loop_anim(n_piece, s_anim_1, s_anim_2) {
  self endon("zbarrier_state_change");
  current_state = self.state;
  while (self.state == current_state) {
    self setzbarrierpiecestate(n_piece, s_anim_1);
    while (self getzbarrierpiecestate(n_piece) == s_anim_1) {
      wait(0.05);
    }
    self setzbarrierpiecestate(n_piece, s_anim_2);
    while (self getzbarrierpiecestate(n_piece) == s_anim_2) {
      wait(0.05);
    }
  }
}

function perk_random_vend_sfx() {
  self playloopsound("zmb_rand_perk_sparks");
  level.bottle_spawn_location playloopsound("zmb_rand_perk_vortex");
  self waittill("zbarrier_state_change");
  self stoploopsound();
  level.bottle_spawn_location stoploopsound();
}

function perk_random_initial() {
  self setzbarrierpiecestate(3, "opening");
}

function perk_random_idle() {
  self clientfield::set("client_stone_emmissive_blink", 0);
  if(isdefined(level.perk_random_idle_effects_override)) {
    self[[level.perk_random_idle_effects_override]]();
  } else {
    self clientfield::set("lightning_bolt_FX_toggle", 1);
    while (self.state == "idle") {
      wait(0.05);
    }
    self clientfield::set("lightning_bolt_FX_toggle", 0);
  }
}

function perk_random_arrive() {
  while (self getzbarrierpiecestate(0) == "opening") {
    wait(0.05);
  }
  self notify("arrived");
}

function perk_random_leaving() {
  while (self getzbarrierpiecestate(0) == "closing") {
    wait(0.05);
  }
  wait(0.05);
  self thread set_perk_random_machine_state("away");
}

function set_perk_random_machine_state(state) {
  wait(0.1);
  for (i = 0; i < self getnumzbarrierpieces(); i++) {
    self hidezbarrierpiece(i);
  }
  self notify("zbarrier_state_change");
  self[[level.perk_random_machine_state_func]](state);
}

function process_perk_random_machine_state(state) {
  switch (state) {
    case "arrive": {
      self showzbarrierpiece(0);
      self showzbarrierpiece(1);
      self setzbarrierpiecestate(0, "opening");
      self setzbarrierpiecestate(1, "opening");
      self clientfield::set("set_client_light_state", 1);
      self thread perk_random_arrive();
      self.state = "arrive";
      break;
    }
    case "idle": {
      self showzbarrierpiece(5);
      self showzbarrierpiece(2);
      self setzbarrierpiecestate(2, "opening");
      self clientfield::set("set_client_light_state", 1);
      self.state = "idle";
      self thread perk_random_idle();
      break;
    }
    case "power_off": {
      self showzbarrierpiece(2);
      self setzbarrierpiecestate(2, "closing");
      self clientfield::set("set_client_light_state", 0);
      self.state = "power_off";
      break;
    }
    case "vending": {
      self showzbarrierpiece(5);
      self showzbarrierpiece(3);
      self showzbarrierpiece(4);
      self clientfield::set("set_client_light_state", 1);
      self.state = "vending";
      self thread perk_random_vending();
      break;
    }
    case "leaving": {
      self showzbarrierpiece(1);
      self showzbarrierpiece(0);
      self setzbarrierpiecestate(0, "closing");
      self setzbarrierpiecestate(1, "closing");
      self clientfield::set("set_client_light_state", 3);
      self thread perk_random_leaving();
      self.state = "leaving";
      break;
    }
    case "away": {
      self showzbarrierpiece(2);
      self setzbarrierpiecestate(2, "closing");
      self clientfield::set("set_client_light_state", 3);
      self.state = "away";
      break;
    }
    case "initial": {
      self showzbarrierpiece(3);
      self setzbarrierpiecestate(3, "opening");
      self showzbarrierpiece(5);
      self clientfield::set("set_client_light_state", 0);
      self.state = "initial";
      break;
    }
    default: {
      if(isdefined(level.custom_perk_random_state_handler)) {
        self[[level.custom_perk_random_state_handler]](state);
      }
      break;
    }
  }
}

function machine_sounds() {
  level endon("machine_think");
  while (true) {
    level waittill("pmstrt");
    rndprk_ent = spawn("script_origin", self.origin);
    rndprk_ent stopsounds();
    state_switch = level util::waittill_any_return("pmstop", "pmmove", "machine_think");
    rndprk_ent stoploopsound(1);
    if(state_switch == "pmstop") {}
    rndprk_ent delete();
  }
}

function getweaponmodel(weapon) {
  return weapon.worldmodel;
}

function is_power_on(n_power_index) {
  if(isdefined(n_power_index)) {
    str_power = "power_on" + n_power_index;
    n_power_on = level flag::get(str_power);
  } else {
    if(isdefined(level.zm_custom_perk_random_power_flag)) {
      n_power_on = level flag::get(level.zm_custom_perk_random_power_flag);
    } else {
      n_power_on = level flag::get("power_on");
    }
  }
  return n_power_on;
}

function setup_devgui() {
  level.perk_random_devgui_callback = & wunderfizz_devgui_callback;
}

function wunderfizz_devgui_callback(cmd) {
  players = getplayers();
  a_e_wunderfizzes = getentarray("", "");
  e_wunderfizz = arraygetclosest(getplayers()[0].origin, a_e_wunderfizzes);
  switch (cmd) {
    case "": {
      e_wunderfizz thread set_perk_random_machine_state("");
      break;
    }
    case "": {
      e_wunderfizz thread set_perk_random_machine_state("");
      break;
    }
    case "": {
      e_wunderfizz thread set_perk_random_machine_state("");
      e_wunderfizz notify("bottle_spawned");
      break;
    }
    case "": {
      e_wunderfizz thread set_perk_random_machine_state("");
      break;
    }
    case "": {
      e_wunderfizz thread set_perk_random_machine_state("");
      break;
    }
    case "": {
      e_wunderfizz thread set_perk_random_machine_state("");
      break;
    }
    case "": {
      e_wunderfizz thread set_perk_random_machine_state("");
      break;
    }
  }
}