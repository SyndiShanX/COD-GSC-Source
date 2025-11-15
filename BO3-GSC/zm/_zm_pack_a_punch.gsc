/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_pack_a_punch.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\aat_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_pack_a_punch_util;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_power;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace _zm_pack_a_punch;

function autoexec __init__sytem__() {
  system::register("zm_pack_a_punch", & __init__, & __main__, undefined);
}

function __init__() {
  zm_pap_util::init_parameters();
  clientfield::register("zbarrier", "pap_working_FX", 5000, 1, "int");
}

function __main__() {
  if(!isDefined(level.pap_zbarrier_state_func)) {
    level.pap_zbarrier_state_func = & process_pap_zbarrier_state;
  }
  spawn_init();
  vending_weapon_upgrade_trigger = zm_pap_util::get_triggers();
  if(vending_weapon_upgrade_trigger.size >= 1) {
    array::thread_all(vending_weapon_upgrade_trigger, & vending_weapon_upgrade);
  }
  old_packs = getEntArray("zombie_vending_upgrade", "targetname");
  for(i = 0; i < old_packs.size; i++) {
    vending_weapon_upgrade_trigger[vending_weapon_upgrade_trigger.size] = old_packs[i];
  }
  level flag::init("pack_machine_in_use");
}

function private spawn_init() {
  zbarriers = getEntArray("zm_pack_a_punch", "targetname");
  for(i = 0; i < zbarriers.size; i++) {
    if(!zbarriers[i] iszbarrier()) {
      continue;
    }
    if(!isDefined(level.pack_a_punch.interaction_height)) {
      level.pack_a_punch.interaction_height = 35;
    }
    if(!isDefined(level.pack_a_punch.interaction_trigger_radius)) {
      level.pack_a_punch.interaction_trigger_radius = 40;
    }
    if(!isDefined(level.pack_a_punch.interaction_trigger_height)) {
      level.pack_a_punch.interaction_trigger_height = 70;
    }
    use_trigger = spawn("trigger_radius_use", zbarriers[i].origin + (0, 0, level.pack_a_punch.interaction_height), 0, level.pack_a_punch.interaction_trigger_radius, level.pack_a_punch.interaction_trigger_height);
    use_trigger.script_noteworthy = "pack_a_punch";
    use_trigger triggerignoreteam();
    use_trigger thread pap_trigger_hintstring_monitor();
    use_trigger flag::init("pap_offering_gun");
    collision = spawn("script_model", zbarriers[i].origin, 1);
    collision.angles = zbarriers[i].angles;
    collision setModel("zm_collision_perks1");
    collision.script_noteworthy = "clip";
    collision disconnectpaths();
    use_trigger.clip = collision;
    use_trigger.zbarrier = zbarriers[i];
    use_trigger.script_sound = "mus_perks_packa_jingle";
    use_trigger.script_label = "mus_perks_packa_sting";
    use_trigger.longjinglewait = 1;
    use_trigger.target = "vending_packapunch";
    use_trigger.zbarrier.targetname = "vending_packapunch";
    powered_on = get_start_state();
    use_trigger.powered = zm_power::add_powered_item( & turn_on, & turn_off, & get_range, & cost_func, 0, powered_on, use_trigger);
    if(isDefined(level.pack_a_punch.custom_power_think)) {
      use_trigger thread[[level.pack_a_punch.custom_power_think]](powered_on);
    } else {
      use_trigger thread toggle_think(powered_on);
    }
    if(!isDefined(level.pack_a_punch.triggers)) {
      level.pack_a_punch.triggers = [];
    } else if(!isarray(level.pack_a_punch.triggers)) {
      level.pack_a_punch.triggers = array(level.pack_a_punch.triggers);
    }
    level.pack_a_punch.triggers[level.pack_a_punch.triggers.size] = use_trigger;
  }
}

function private pap_trigger_hintstring_monitor() {
  level endon("pack_a_punch_off");
  level waittill("pack_a_punch_on");
  self thread pap_trigger_hintstring_monitor_reset();
  while(true) {
    foreach(e_player in level.players) {
      if(e_player istouching(self)) {
        self zm_pap_util::update_hint_string(e_player);
      }
    }
    wait(0.05);
  }
}

function private pap_trigger_hintstring_monitor_reset() {
  level waittill("pack_a_punch_off");
  self thread pap_trigger_hintstring_monitor();
}

function private third_person_weapon_upgrade(current_weapon, upgrade_weapon, packa_rollers, pap_machine, trigger) {
  level endon("pack_a_punch_off");
  trigger endon("pap_player_disconnected");
  current_weapon = self getbuildkitweapon(current_weapon, 0);
  upgrade_weapon = self getbuildkitweapon(upgrade_weapon, 1);
  trigger.current_weapon = current_weapon;
  trigger.current_weapon_options = self getbuildkitweaponoptions(trigger.current_weapon);
  trigger.current_weapon_acvi = self getbuildkitattachmentcosmeticvariantindexes(trigger.current_weapon, 0);
  trigger.upgrade_weapon = upgrade_weapon;
  upgrade_weapon.pap_camo_to_use = zm_weapons::get_pack_a_punch_camo_index(upgrade_weapon.pap_camo_to_use);
  trigger.upgrade_weapon_options = self getbuildkitweaponoptions(trigger.upgrade_weapon, upgrade_weapon.pap_camo_to_use);
  trigger.upgrade_weapon_acvi = self getbuildkitattachmentcosmeticvariantindexes(trigger.upgrade_weapon, 1);
  trigger.zbarrier setweapon(trigger.current_weapon);
  trigger.zbarrier setweaponoptions(trigger.current_weapon_options);
  trigger.zbarrier setattachmentcosmeticvariantindexes(trigger.current_weapon_acvi);
  trigger.zbarrier set_pap_zbarrier_state("take_gun");
  rel_entity = trigger.pap_machine;
  origin_offset = (0, 0, 0);
  angles_offset = (0, 0, 0);
  origin_base = self.origin;
  angles_base = self.angles;
  if(isDefined(rel_entity)) {
    origin_offset = (0, 0, level.pack_a_punch.interaction_height);
    angles_offset = vectorscale((0, 1, 0), 90);
    origin_base = rel_entity.origin;
    angles_base = rel_entity.angles;
  } else {
    rel_entity = self;
  }
  forward = anglesToForward(angles_base + angles_offset);
  interact_offset = origin_offset + (forward * -25);
  offsetdw = vectorscale((1, 1, 1), 3);
  pap_machine[[level.pack_a_punch.move_in_func]](self, trigger, origin_offset, angles_offset);
  self playSound("zmb_perks_packa_upgrade");
  wait(0.35);
  wait(3);
  trigger.zbarrier setweapon(upgrade_weapon);
  trigger.zbarrier setweaponoptions(trigger.upgrade_weapon_options);
  trigger.zbarrier setattachmentcosmeticvariantindexes(trigger.upgrade_weapon_acvi);
  trigger.zbarrier set_pap_zbarrier_state("eject_gun");
  if(isDefined(self)) {
    self playSound("zmb_perks_packa_ready");
  } else {
    return;
  }
  rel_entity thread[[level.pack_a_punch.move_out_func]](self, trigger, origin_offset, interact_offset);
}

function private can_pack_weapon(weapon) {
  if(weapon.isriotshield) {
    return false;
  }
  if(level flag::get("pack_machine_in_use")) {
    return true;
  }
  if(!(isDefined(level.b_allow_idgun_pap) && level.b_allow_idgun_pap) && isDefined(level.idgun_weapons)) {
    if(isinarray(level.idgun_weapons, weapon)) {
      return false;
    }
  }
  weapon = self zm_weapons::get_nonalternate_weapon(weapon);
  if(!zm_weapons::is_weapon_or_base_included(weapon)) {
    return false;
  }
  if(!self zm_weapons::can_upgrade_weapon(weapon)) {
    return false;
  }
  return true;
}

function private player_use_can_pack_now() {
  if(self laststand::player_is_in_laststand() || (isDefined(self.intermission) && self.intermission) || self isthrowinggrenade()) {
    return false;
  }
  if(!self zm_magicbox::can_buy_weapon() || self bgb::is_enabled("zm_bgb_disorderly_combat")) {
    return false;
  }
  if(self zm_equipment::hacker_active()) {
    return false;
  }
  current_weapon = self getcurrentweapon();
  if(!self can_pack_weapon(current_weapon) && !zm_weapons::weapon_supports_aat(current_weapon)) {
    return false;
  }
  return true;
}

function private pack_a_punch_machine_trigger_think() {
  self endon("death");
  self endon("pack_a_punch_off");
  self notify("pack_a_punch_trigger_think");
  self endon("pack_a_punch_trigger_think");
  while(true) {
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      if(isDefined(self.pack_player) && self.pack_player != players[i] || !players[i] player_use_can_pack_now() || players[i] bgb::is_active("zm_bgb_ephemeral_enhancement")) {
        self setinvisibletoplayer(players[i], 1);
        continue;
      }
      self setinvisibletoplayer(players[i], 0);
    }
    wait(0.1);
  }
}

function private vending_weapon_upgrade() {
  level endon("pack_a_punch_off");
  pap_machine = getent(self.target, "targetname");
  self.pap_machine = pap_machine;
  pap_machine_sound = getEntArray("perksacola", "targetname");
  packa_rollers = spawn("script_origin", self.origin);
  packa_timer = spawn("script_origin", self.origin);
  packa_rollers linkto(self);
  packa_timer linkto(self);
  self usetriggerrequirelookat();
  self sethintstring(&"ZOMBIE_NEED_POWER");
  self setcursorhint("HINT_NOICON");
  power_off = !self is_on();
  if(power_off) {
    pap_array = [];
    pap_array[0] = pap_machine;
    level waittill("pack_a_punch_on");
  }
  self triggerenable(1);
  if(isDefined(level.pack_a_punch.power_on_callback)) {
    pap_machine thread[[level.pack_a_punch.power_on_callback]]();
  }
  self thread pack_a_punch_machine_trigger_think();
  pap_machine playLoopSound("zmb_perks_packa_loop");
  self thread shutoffpapsounds(pap_machine, packa_rollers, packa_timer);
  self thread vending_weapon_upgrade_cost();
  for(;;) {
    self.pack_player = undefined;
    self waittill("trigger", player);
    if(isDefined(pap_machine.state) && pap_machine.state == "leaving") {
      continue;
    }
    index = zm_utility::get_player_index(player);
    current_weapon = player getcurrentweapon();
    current_weapon = player zm_weapons::switch_from_alt_weapon(current_weapon);
    if(isDefined(level.pack_a_punch.custom_validation)) {
      valid = self[[level.pack_a_punch.custom_validation]](player);
      if(!valid) {
        continue;
      }
    }
    if(!player zm_magicbox::can_buy_weapon() || player laststand::player_is_in_laststand() || (isDefined(player.intermission) && player.intermission) || player isthrowinggrenade() || (!player zm_weapons::can_upgrade_weapon(current_weapon) && !zm_weapons::weapon_supports_aat(current_weapon))) {
      wait(0.1);
      continue;
    }
    if(player isswitchingweapons()) {
      wait(0.1);
      if(player isswitchingweapons()) {
        continue;
      }
    }
    if(!zm_weapons::is_weapon_or_base_included(current_weapon)) {
      continue;
    }
    current_cost = self.cost;
    player.restore_ammo = undefined;
    player.restore_clip = undefined;
    player.restore_stock = undefined;
    player_restore_clip_size = undefined;
    player.restore_max = undefined;
    b_weapon_supports_aat = zm_weapons::weapon_supports_aat(current_weapon);
    isrepack = 0;
    currentaathashid = -1;
    if(b_weapon_supports_aat) {
      current_cost = self.aat_cost;
      currentaat = player aat::getaatonweapon(current_weapon);
      if(isDefined(currentaat)) {
        currentaathashid = currentaat.var_2c8ee667;
      }
      player.restore_ammo = 1;
      player.restore_clip = player getweaponammoclip(current_weapon);
      player.restore_clip_size = current_weapon.clipsize;
      player.restore_stock = player getweaponammostock(current_weapon);
      player.restore_max = current_weapon.maxammo;
      isrepack = 1;
    }
    if(player zm_pers_upgrades_functions::is_pers_double_points_active()) {
      current_cost = player zm_pers_upgrades_functions::pers_upgrade_double_points_cost(current_cost);
    }
    if(!player zm_score::can_player_purchase(current_cost)) {
      self playSound("zmb_perks_packa_deny");
      if(isDefined(level.pack_a_punch.custom_deny_func)) {
        player[[level.pack_a_punch.custom_deny_func]]();
      } else {
        player zm_audio::create_and_play_dialog("general", "outofmoney", 0);
      }
      continue;
    }
    self.pack_player = player;
    level flag::set("pack_machine_in_use");
    demo::bookmark("zm_player_use_packapunch", gettime(), player);
    player zm_stats::increment_client_stat("use_pap");
    player zm_stats::increment_player_stat("use_pap");
    weaponidx = undefined;
    if(isDefined(current_weapon)) {
      weaponidx = matchrecordgetweaponindex(current_weapon);
    }
    if(isDefined(weaponidx)) {
      if(!isrepack) {
        player recordmapevent(19, gettime(), player.origin, level.round_number, weaponidx, current_cost);
        player zm_stats::increment_challenge_stat("ZM_DAILY_PACK_5_WEAPONS");
        player zm_stats::increment_challenge_stat("ZM_DAILY_PACK_10_WEAPONS");
      } else {
        player recordmapevent(25, gettime(), player.origin, level.round_number, weaponidx, currentaathashid);
        player zm_stats::increment_challenge_stat("ZM_DAILY_REPACK_WEAPONS");
      }
    }
    self thread destroy_weapon_in_blackout(player);
    player zm_score::minus_to_player_score(current_cost);
    self thread zm_audio::sndperksjingles_player(1);
    player zm_audio::create_and_play_dialog("general", "pap_wait");
    self triggerenable(0);
    player thread do_knuckle_crack();
    self.current_weapon = current_weapon;
    upgrade_weapon = zm_weapons::get_upgrade_weapon(current_weapon, b_weapon_supports_aat);
    player third_person_weapon_upgrade(current_weapon, upgrade_weapon, packa_rollers, pap_machine, self);
    self triggerenable(1);
    self setcursorhint("HINT_WEAPON", upgrade_weapon);
    self flag::set("pap_offering_gun");
    if(isDefined(player)) {
      self setinvisibletoall();
      self setvisibletoplayer(player);
      self thread wait_for_player_to_take(player, current_weapon, packa_timer, b_weapon_supports_aat, isrepack);
      self thread wait_for_timeout(current_weapon, packa_timer, player, isrepack);
      self util::waittill_any("pap_timeout", "pap_taken", "pap_player_disconnected");
    } else {
      self wait_for_timeout(current_weapon, packa_timer, player, isrepack);
    }
    self.zbarrier set_pap_zbarrier_state("powered");
    self setcursorhint("HINT_NOICON");
    self.current_weapon = level.weaponnone;
    self flag::clear("pap_offering_gun");
    self thread pack_a_punch_machine_trigger_think();
    self.pack_player = undefined;
    level flag::clear("pack_machine_in_use");
  }
}

function private shutoffpapsounds(ent1, ent2, ent3) {
  while(true) {
    level waittill("pack_a_punch_off");
    level thread turnonpapsounds(ent1);
    ent1 stoploopsound(0.1);
    ent2 stoploopsound(0.1);
    ent3 stoploopsound(0.1);
  }
}

function private turnonpapsounds(ent) {
  level waittill("pack_a_punch_on");
  ent playLoopSound("zmb_perks_packa_loop");
}

function private vending_weapon_upgrade_cost() {
  level endon("pack_a_punch_off");
  while(true) {
    self.cost = 5000;
    self.aat_cost = 2500;
    level waittill("hash_ab83a4db");
    self.cost = 1000;
    self.aat_cost = 500;
    level waittill("bonfire_sale_off");
  }
}

function private wait_for_player_to_take(player, weapon, packa_timer, b_weapon_supports_aat, isrepack) {
  current_weapon = self.current_weapon;
  upgrade_weapon = self.upgrade_weapon;
  assert(isDefined(current_weapon), "");
  assert(isDefined(upgrade_weapon), "");
  self endon("pap_timeout");
  level endon("pack_a_punch_off");
  while(isDefined(player)) {
    packa_timer playLoopSound("zmb_perks_packa_ticktock");
    self waittill("trigger", trigger_player);
    if(level.pack_a_punch.grabbable_by_anyone) {
      player = trigger_player;
    }
    packa_timer stoploopsound(0.05);
    if(trigger_player == player) {
      player zm_stats::increment_client_stat("pap_weapon_grabbed");
      player zm_stats::increment_player_stat("pap_weapon_grabbed");
      current_weapon = player getcurrentweapon();
      if(level.weaponnone == current_weapon) {
        iprintlnbold("");
      }
      if(zm_utility::is_player_valid(player) && !(player.is_drinking > 0) && !zm_utility::is_placeable_mine(current_weapon) && !zm_equipment::is_equipment(current_weapon) && !player zm_utility::is_player_revive_tool(current_weapon) && level.weaponnone != current_weapon && !player zm_equipment::hacker_active()) {
        demo::bookmark("zm_player_grabbed_packapunch", gettime(), player);
        self notify("pap_taken");
        player notify("pap_taken");
        player.pap_used = 1;
        weapon_limit = zm_utility::get_player_weapon_limit(player);
        player zm_weapons::take_fallback_weapon();
        primaries = player getweaponslistprimaries();
        if(isDefined(primaries) && primaries.size >= weapon_limit) {
          upgrade_weapon = player zm_weapons::weapon_give(upgrade_weapon);
        } else {
          upgrade_weapon = player zm_weapons::give_build_kit_weapon(upgrade_weapon);
          player givestartammo(upgrade_weapon);
        }
        player notify("weapon_give", upgrade_weapon);
        aatid = -1;
        if(isDefined(b_weapon_supports_aat) && b_weapon_supports_aat) {
          player thread aat::acquire(upgrade_weapon);
          aatobj = player aat::getaatonweapon(upgrade_weapon);
          if(isDefined(aatobj)) {
            aatid = aatobj.var_2c8ee667;
          }
        } else {
          player thread aat::remove(upgrade_weapon);
        }
        weaponidx = undefined;
        if(isDefined(weapon)) {
          weaponidx = matchrecordgetweaponindex(weapon);
        }
        if(isDefined(weaponidx)) {
          if(!isrepack) {
            player recordmapevent(27, gettime(), player.origin, level.round_number, weaponidx, aatid);
          } else {
            player recordmapevent(28, gettime(), player.origin, level.round_number, weaponidx, aatid);
          }
        }
        player switchtoweapon(upgrade_weapon);
        if(isDefined(player.restore_ammo) && player.restore_ammo) {
          new_clip = player.restore_clip + (upgrade_weapon.clipsize - player.restore_clip_size);
          new_stock = player.restore_stock + (upgrade_weapon.maxammo - player.restore_max);
          player setweaponammostock(upgrade_weapon, new_stock);
          player setweaponammoclip(upgrade_weapon, new_clip);
        }
        player.restore_ammo = undefined;
        player.restore_clip = undefined;
        player.restore_stock = undefined;
        player.restore_max = undefined;
        player.restore_clip_size = undefined;
        player zm_weapons::play_weapon_vo(upgrade_weapon);
        return;
      }
    }
    wait(0.05);
  }
}

function private wait_for_timeout(weapon, packa_timer, player, isrepack) {
  self endon("pap_taken");
  self endon("pap_player_disconnected");
  self thread wait_for_disconnect(player);
  wait(level.pack_a_punch.timeout);
  self notify("pap_timeout");
  packa_timer stoploopsound(0.05);
  packa_timer playSound("zmb_perks_packa_deny");
  if(isDefined(player)) {
    player zm_stats::increment_client_stat("pap_weapon_not_grabbed");
    player zm_stats::increment_player_stat("pap_weapon_not_grabbed");
    weaponidx = undefined;
    if(isDefined(weapon)) {
      weaponidx = matchrecordgetweaponindex(weapon);
    }
    if(isDefined(weaponidx)) {
      if(!isrepack) {
        player recordmapevent(20, gettime(), player.origin, level.round_number, weaponidx);
      } else {
        aatonweapon = player aat::getaatonweapon(weapon);
        aathash = -1;
        if(isDefined(aatonweapon)) {
          aathash = aatonweapon.var_2c8ee667;
        }
        player recordmapevent(26, gettime(), player.origin, level.round_number, weaponidx, aathash);
      }
    }
  }
}

function private wait_for_disconnect(player) {
  self endon("pap_taken");
  self endon("pap_timeout");
  while(isDefined(player)) {
    wait(0.1);
  }
  println("");
  self notify("pap_player_disconnected");
}

function private destroy_weapon_in_blackout(player) {
  self endon("pap_timeout");
  self endon("pap_taken");
  self endon("pap_player_disconnected");
  level waittill("pack_a_punch_off");
  self.zbarrier set_pap_zbarrier_state("take_gun");
  player playlocalsound(level.zmb_laugh_alias);
  wait(1.5);
  self.zbarrier set_pap_zbarrier_state("power_off");
}

function private do_knuckle_crack() {
  self endon("disconnect");
  self upgrade_knuckle_crack_begin();
  self util::waittill_any("fake_death", "death", "player_downed", "weapon_change_complete");
  self upgrade_knuckle_crack_end();
}

function private upgrade_knuckle_crack_begin() {
  self zm_utility::increment_is_drinking();
  self zm_utility::disable_player_move_states(1);
  primaries = self getweaponslistprimaries();
  original_weapon = self getcurrentweapon();
  weapon = getweapon("zombie_knuckle_crack");
  if(original_weapon != level.weaponnone && !zm_utility::is_placeable_mine(original_weapon) && !zm_equipment::is_equipment(original_weapon)) {
    self notify("zmb_lost_knife");
    self takeweapon(original_weapon);
  } else {
    return;
  }
  self giveweapon(weapon);
  self switchtoweapon(weapon);
}

function private upgrade_knuckle_crack_end() {
  self zm_utility::enable_player_move_states();
  weapon = getweapon("zombie_knuckle_crack");
  if(self laststand::player_is_in_laststand() || (isDefined(self.intermission) && self.intermission)) {
    self takeweapon(weapon);
    return;
  }
  self zm_utility::decrement_is_drinking();
  self takeweapon(weapon);
  primaries = self getweaponslistprimaries();
  if(self.is_drinking > 0) {
    return;
  }
  self zm_weapons::switch_back_primary_weapon();
}

function private get_range(delta, origin, radius) {
  if(isDefined(self.target)) {
    paporigin = self.target.origin;
    if(isDefined(self.target.trigger_off) && self.target.trigger_off) {
      paporigin = self.target.realorigin;
    } else if(isDefined(self.target.disabled) && self.target.disabled) {
      paporigin = paporigin + vectorscale((0, 0, 1), 10000);
    }
    if(distancesquared(paporigin, origin) < (radius * radius)) {
      return true;
    }
  }
  return false;
}

function private turn_on(origin, radius) {
  println("");
  level notify("pack_a_punch_on");
}

function private turn_off(origin, radius) {
  println("");
  level notify("pack_a_punch_off");
  self.target notify("death");
  self.target thread vending_weapon_upgrade();
}

function private is_on() {
  if(isDefined(self.powered)) {
    return self.powered.power;
  }
  return 0;
}

function private get_start_state() {
  if(isDefined(level.vending_machines_powered_on_at_start) && level.vending_machines_powered_on_at_start) {
    return true;
  }
  return false;
}

function private cost_func() {
  if(isDefined(self.one_time_cost)) {
    cost = self.one_time_cost;
    self.one_time_cost = undefined;
    return cost;
  }
  if(isDefined(level._power_global) && level._power_global) {
    return 0;
  }
  if(isDefined(self.self_powered) && self.self_powered) {
    return 0;
  }
  return 1;
}

function private toggle_think(powered_on) {
  if(!powered_on) {
    self.zbarrier set_pap_zbarrier_state("initial");
    level waittill("pack_a_punch_on");
  }
  for(;;) {
    self.zbarrier set_pap_zbarrier_state("power_on");
    level waittill("pack_a_punch_off");
    self.zbarrier set_pap_zbarrier_state("power_off");
    level waittill("pack_a_punch_on");
  }
}

function private pap_initial() {
  self zbarrierpieceuseattachweapon(3);
  self setzbarrierpiecestate(0, "closed");
}

function private pap_power_off() {
  self setzbarrierpiecestate(0, "closing");
}

function private pap_power_on() {
  self endon("zbarrier_state_change");
  self setzbarrierpiecestate(0, "opening");
  while(self getzbarrierpiecestate(0) == "opening") {
    wait(0.05);
  }
  self playSound("zmb_perks_power_on");
  self thread set_pap_zbarrier_state("powered");
}

function private pap_powered() {
  self endon("zbarrier_state_change");
  self setzbarrierpiecestate(4, "closed");
  if(self.classname === "zbarrier_zm_castle_packapunch" || self.classname === "zbarrier_zm_tomb_packapunch") {
    self clientfield::set("pap_working_FX", 0);
  }
  while(true) {
    wait(randomfloatrange(180, 1800));
    self setzbarrierpiecestate(4, "opening");
    wait(randomfloatrange(180, 1800));
    self setzbarrierpiecestate(4, "closing");
  }
}

function private pap_take_gun() {
  self setzbarrierpiecestate(1, "opening");
  self setzbarrierpiecestate(2, "opening");
  self setzbarrierpiecestate(3, "opening");
  wait(0.1);
  if(self.classname === "zbarrier_zm_castle_packapunch" || self.classname === "zbarrier_zm_tomb_packapunch") {
    self clientfield::set("pap_working_FX", 1);
  }
}

function private pap_eject_gun() {
  self setzbarrierpiecestate(1, "closing");
  self setzbarrierpiecestate(2, "closing");
  self setzbarrierpiecestate(3, "closing");
}

function private pap_leaving() {
  self setzbarrierpiecestate(5, "closing");
  do {
    wait(0.05);
  }
  while(self getzbarrierpiecestate(5) == "closing");
  self setzbarrierpiecestate(5, "closed");
  self notify("leave_anim_done");
}

function private pap_arriving() {
  self endon("zbarrier_state_change");
  self setzbarrierpiecestate(0, "opening");
  while(self getzbarrierpiecestate(0) == "opening") {
    wait(0.05);
  }
  self playSound("zmb_perks_power_on");
  self thread set_pap_zbarrier_state("powered");
}

function private get_pap_zbarrier_state() {
  return self.state;
}

function private set_pap_zbarrier_state(state) {
  for(i = 0; i < self getnumzbarrierpieces(); i++) {
    self hidezbarrierpiece(i);
  }
  self notify("zbarrier_state_change");
  self[[level.pap_zbarrier_state_func]](state);
}

function private process_pap_zbarrier_state(state) {
  switch (state) {
    case "initial": {
      self showzbarrierpiece(0);
      self thread pap_initial();
      self.state = "initial";
      break;
    }
    case "power_off": {
      self showzbarrierpiece(0);
      self thread pap_power_off();
      self.state = "power_off";
      break;
    }
    case "power_on": {
      self showzbarrierpiece(0);
      self thread pap_power_on();
      self.state = "power_on";
      break;
    }
    case "powered": {
      self showzbarrierpiece(4);
      self thread pap_powered();
      self.state = "powered";
      break;
    }
    case "take_gun": {
      self showzbarrierpiece(1);
      self showzbarrierpiece(2);
      self showzbarrierpiece(3);
      self thread pap_take_gun();
      self.state = "take_gun";
      break;
    }
    case "eject_gun": {
      self showzbarrierpiece(1);
      self showzbarrierpiece(2);
      self showzbarrierpiece(3);
      self thread pap_eject_gun();
      self.state = "eject_gun";
      break;
    }
    case "leaving": {
      self showzbarrierpiece(5);
      self thread pap_leaving();
      self.state = "leaving";
      break;
    }
    case "arriving": {
      self showzbarrierpiece(0);
      self thread pap_arriving();
      self.state = "arriving";
      break;
    }
    case "hidden": {
      self.state = "hidden";
      break;
    }
    default: {
      if(isDefined(level.custom_pap_state_handler)) {
        self[[level.custom_pap_state_handler]](state);
      }
      break;
    }
  }
}

function set_state_initial() {
  self set_pap_zbarrier_state("initial");
}

function set_state_leaving() {
  self set_pap_zbarrier_state("leaving");
}

function set_state_arriving() {
  self set_pap_zbarrier_state("arriving");
}

function set_state_power_on() {
  self set_pap_zbarrier_state("power_on");
}

function set_state_hidden() {
  self set_pap_zbarrier_state("hidden");
}