/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\craftables\_zm_craftables.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_craftables;

function autoexec __init__sytem__() {
  system::register("zm_craftables", &__init__, &__main__, undefined);
}

function __init__() {
  callback::on_finalize_initialization(&set_craftable_clientfield);
}

function init() {
  if(!isDefined(level.craftable_piece_swap_allowed)) {
    level.craftable_piece_swap_allowed = 1;
  }
  zombie_craftables_callbacks = [];
  level.craftablepickups = [];
  level.craftables_crafted = [];
  level.a_uts_craftables = [];
  if(!isDefined(level.craftable_piece_count)) {
    level.craftable_piece_count = 0;
  }
  level._effect["building_dust"] = "zombie/fx_crafting_dust_zmb";
  if(isDefined(level.init_craftables)) {
    [[level.init_craftables]]();
  }
  open_table = spawnStruct();
  open_table.name = "open_table";
  open_table.triggerthink = &opentablecraftable;
  open_table.custom_craftablestub_update_prompt = &open_craftablestub_update_prompt;
  include_zombie_craftable(open_table);
  add_zombie_craftable("open_table", &"");
  if(isDefined(level.use_swipe_protection)) {
    callback::on_connect(&craftables_watch_swipes);
  }
}

function __main__() {
  level thread think_craftables();
  level thread run_craftables_devgui();
}

function set_craftable_clientfield() {
  set_piece_count(level.zombie_craftablestubs.size);
}

function anystub_update_prompt(player) {
  if(player laststand::player_is_in_laststand() || player zm_utility::in_revive_trigger()) {
    self.hint_string = "";
    return false;
  }
  if(isDefined(player.is_drinking) && player.is_drinking > 0) {
    self.hint_string = "";
    return false;
  }
  if(isDefined(player.screecher_weapon)) {
    self.hint_string = "";
    return false;
  }
  initial_current_weapon = player getcurrentweapon();
  current_weapon = zm_weapons::get_nonalternate_weapon(initial_current_weapon);
  if(zm_equipment::is_equipment(current_weapon)) {
    self.hint_string = "";
    return false;
  }
  return true;
}

function anystub_get_unitrigger_origin() {
  if(isDefined(self.origin_parent)) {
    return self.origin_parent.origin;
  }
  return self.origin;
}

function anystub_on_spawn_trigger(trigger) {
  if(isDefined(self.link_parent)) {
    trigger enablelinkto();
    trigger linkto(self.link_parent);
    trigger setmovingplatformenabled(1);
  }
}

function craftables_watch_swipes() {
  self endon("disconnect");
  self notify("craftables_watch_swipes");
  self endon("craftables_watch_swipes");
  while(true) {
    self waittill("melee_swipe", zombie);
    if(distancesquared(zombie.origin, self.origin) > (zombie.meleeattackdist * zombie.meleeattackdist)) {
      continue;
    }
    trigger = level._unitriggers.trigger_pool[self getentitynumber()];
    if(isDefined(trigger) && isDefined(trigger.stub.piece)) {
      piece = trigger.stub.piece;
      if(!isDefined(piece.damage)) {
        piece.damage = 0;
      }
      piece.damage++;
      if(piece.damage > 12) {
        thread zm_equipment::disappear_fx(trigger.stub zm_unitrigger::unitrigger_origin());
        piece piece_unspawn();
        self zm_stats::increment_client_stat("cheat_total", 0);
        if(isalive(self)) {
          self playlocalsound(level.zmb_laugh_alias);
        }
      }
    }
  }
}

function explosiondamage(damage, pos) {
  println(((("" + damage) + "") + self.name) + "");
  self dodamage(damage, pos);
}

function make_zombie_craftable_open(str_craftable, str_model, v_angle_offset, v_origin_offset) {
  assert(isDefined(level.zombie_craftablestubs[str_craftable]), ("" + str_craftable) + "");
  s_craftable = level.zombie_craftablestubs[str_craftable];
  s_craftable.is_open_table = 1;
  s_craftable.str_model = str_model;
  s_craftable.v_angle_offset = v_angle_offset;
  s_craftable.v_origin_offset = v_origin_offset;
}

function add_zombie_craftable(craftable_name, str_to_craft, str_crafting, str_taken, onfullycrafted, need_all_pieces) {
  if(!isDefined(level.zombie_include_craftables)) {
    level.zombie_include_craftables = [];
  }
  if(isDefined(level.zombie_include_craftables) && !isDefined(level.zombie_include_craftables[craftable_name])) {
    return;
  }
  craftable_struct = level.zombie_include_craftables[craftable_name];
  if(!isDefined(level.zombie_craftablestubs)) {
    level.zombie_craftablestubs = [];
  }
  craftable_struct.str_to_craft = str_to_craft;
  craftable_struct.str_crafting = str_crafting;
  craftable_struct.str_taken = str_taken;
  craftable_struct.onfullycrafted = onfullycrafted;
  craftable_struct.need_all_pieces = need_all_pieces;
  println("" + craftable_struct.name);
  level.zombie_craftablestubs[craftable_struct.name] = craftable_struct;
}

function set_hide_model_if_unavailable(craftable_name, hide_when_unavailable) {
  if(isDefined(level.zombie_craftablestubs[craftable_name])) {
    level.zombie_craftablestubs[craftable_name].hide_when_unavailable = hide_when_unavailable;
  }
}

function get_hide_model_if_unavailable(craftable_name) {
  if(isDefined(level.zombie_craftablestubs[craftable_name])) {
    return isDefined(level.zombie_craftablestubs[craftable_name].hide_when_unavailable) && level.zombie_craftablestubs[craftable_name].hide_when_unavailable;
  }
  return 0;
}

function set_build_time(craftable_name, build_time) {
  if(isDefined(level.zombie_craftablestubs[craftable_name])) {
    level.zombie_craftablestubs[craftable_name].usetime = build_time;
  }
}

function set_piece_count(n_count) {
  bits = getminbitcountfornum(n_count);
  registerclientfield("toplayer", "craftable", 1, bits, "int");
}

function add_zombie_craftable_vox_category(craftable_name, vox_id) {
  craftable_struct = level.zombie_include_craftables[craftable_name];
  craftable_struct.vox_id = vox_id;
}

function include_zombie_craftable(craftablestub) {
  if(!isDefined(level.zombie_include_craftables)) {
    level.zombie_include_craftables = [];
  }
  if(!isDefined(level.craftableindex)) {
    level.craftableindex = 0;
  }
  println("" + craftablestub.name);
  level.zombie_include_craftables[craftablestub.name] = craftablestub;
  craftablestub.var_2c8ee667 = hashstring(craftablestub.name);
  level thread add_craftable_cheat(craftablestub);
}

function generate_zombie_craftable_piece(craftablename, piecename, radius, height, drop_offset, hud_icon, onpickup, ondrop, oncrafted, use_spawn_num, tag_name, can_reuse, client_field_value, is_shared = 0, vox_id, b_one_time_vo = 0, hint_string, slot = 0) {
  piecestub = spawnStruct();
  craftable_pieces = [];
  if(!isDefined(piecename)) {
    assertmsg("");
  }
  craftable_pieces_structs = struct::get_array((craftablename + "_") + piecename, "targetname");
  if(!isDefined(level.craftablepieceindex)) {
    level.craftablepieceindex = 0;
  }
  foreach(index, struct in craftable_pieces_structs) {
    craftable_pieces[index] = struct;
    craftable_pieces[index].hasspawned = 0;
  }
  piecestub.spawns = craftable_pieces;
  piecestub.craftablename = craftablename;
  piecestub.piecename = piecename;
  if(craftable_pieces.size) {
    piecestub.modelname = craftable_pieces[0].model;
  }
  piecestub.hud_icon = hud_icon;
  piecestub.radius = radius;
  piecestub.height = height;
  piecestub.tag_name = tag_name;
  piecestub.can_reuse = can_reuse;
  piecestub.drop_offset = drop_offset;
  piecestub.max_instances = 256;
  piecestub.onpickup = onpickup;
  piecestub.ondrop = ondrop;
  piecestub.oncrafted = oncrafted;
  piecestub.use_spawn_num = use_spawn_num;
  piecestub.is_shared = is_shared;
  piecestub.vox_id = vox_id;
  piecestub.hint_string = hint_string;
  piecestub.inventory_slot = slot;
  piecestub.var_2c8ee667 = hashstring(piecename);
  if(isDefined(b_one_time_vo) && b_one_time_vo) {
    piecestub.b_one_time_vo = b_one_time_vo;
  }
  if(isDefined(client_field_value)) {
    if(isDefined(is_shared) && is_shared) {
      assert(isstring(client_field_value), ("" + piecename) + "");
      piecestub.client_field_id = client_field_value;
    } else {
      piecestub.client_field_state = client_field_value;
    }
  }
  return piecestub;
}

function manage_multiple_pieces(max_instances) {
  self.max_instances = max_instances;
  self.managing_pieces = 1;
  self.piece_allocated = [];
}

function combine_craftable_pieces(piece1, piece2, piece3) {
  spawns1 = piece1.spawns;
  spawns2 = piece2.spawns;
  spawns = arraycombine(spawns1, spawns2, 1, 0);
  if(isDefined(piece3)) {
    spawns3 = piece3.spawns;
    spawns = arraycombine(spawns, spawns3, 1, 0);
    spawns = array::randomize(spawns);
    piece3.spawns = spawns;
  } else {
    spawns = array::randomize(spawns);
  }
  piece1.spawns = spawns;
  piece2.spawns = spawns;
}

function add_craftable_piece(piecestub, tag_name, can_reuse) {
  if(!isDefined(self.a_piecestubs)) {
    self.a_piecestubs = [];
  }
  if(isDefined(tag_name)) {
    piecestub.tag_name = tag_name;
  }
  if(isDefined(can_reuse)) {
    piecestub.can_reuse = can_reuse;
  }
  self.a_piecestubs[self.a_piecestubs.size] = piecestub;
  if(!isDefined(self.inventory_slot)) {
    self.inventory_slot = piecestub.inventory_slot;
  }
  /
  #
  assert(self.inventory_slot == piecestub.inventory_slot, "");
}

function player_drop_piece_on_downed(slot) {
  self endon("craftable_piece_released" + slot);
  self waittill("bled_out");
  onplayerlaststand();
}

function onplayerlaststand() {
  if(!isDefined(self.current_craftable_pieces)) {
    self.current_craftable_pieces = [];
  }
  foreach(index, piece in self.current_craftable_pieces) {
    if(isDefined(piece)) {
      return_to_start_pos = 0;
      if(isDefined(level.safe_place_for_craftable_piece)) {
        if(!self[[level.safe_place_for_craftable_piece]](piece)) {
          return_to_start_pos = 1;
        }
      }
      if(return_to_start_pos) {
        piece piece_spawn_at();
      } else {
        piece piece_spawn_at(self.origin + vectorscale((1, 1, 0), 5), self.angles);
      }
      if(isDefined(piece.ondrop)) {
        piece[[piece.ondrop]](self);
      }
      self clientfield::set_to_player("craftable", 0);
    }
    self.current_craftable_pieces[index] = undefined;
    self notify("craftable_piece_released" + index);
  }
}

function piecestub_get_unitrigger_origin() {
  if(isDefined(self.origin_parent)) {
    return self.origin_parent.origin + vectorscale((0, 0, 1), 12);
  }
  return self.origin;
}

function generate_piece_unitrigger(classname, origin, angles, flags, radius = 64, script_height = 64, hint_string, moving, b_nolook) {
  script_width = script_height;
  script_length = script_height;
  unitrigger_stub = spawnStruct();
  unitrigger_stub.origin = origin;
  if(isDefined(script_length)) {
    unitrigger_stub.script_length = script_length;
  } else {
    unitrigger_stub.script_length = 13.5;
  }
  if(isDefined(script_width)) {
    unitrigger_stub.script_width = script_width;
  } else {
    unitrigger_stub.script_width = 27.5;
  }
  if(isDefined(script_height)) {
    unitrigger_stub.script_height = script_height;
  } else {
    unitrigger_stub.script_height = 24;
  }
  unitrigger_stub.radius = radius;
  unitrigger_stub.cursor_hint = "HINT_NOICON";
  if(isDefined(hint_string)) {
    unitrigger_stub.hint_string_override = hint_string;
    unitrigger_stub.hint_string = unitrigger_stub.hint_string_override;
  } else {
    unitrigger_stub.hint_string = &"ZOMBIE_BUILD_PIECE_GRAB";
  }
  unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
  if(isDefined(b_nolook) && (isDefined(int(b_nolook)) && int(b_nolook))) {
    unitrigger_stub.require_look_toward = 0;
  }
  unitrigger_stub.require_look_at = 0;
  switch (classname) {
    case "trigger_radius": {
      unitrigger_stub.script_unitrigger_type = "unitrigger_radius";
      break;
    }
    case "trigger_radius_use": {
      unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
      break;
    }
    case "trigger_box": {
      unitrigger_stub.script_unitrigger_type = "unitrigger_box";
      break;
    }
    case "trigger_box_use": {
      unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
      break;
    }
  }
  zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
  unitrigger_stub.prompt_and_visibility_func = &piecetrigger_update_prompt;
  unitrigger_stub.originfunc = &piecestub_get_unitrigger_origin;
  unitrigger_stub.onspawnfunc = &anystub_on_spawn_trigger;
  if(isDefined(moving) && moving) {
    zm_unitrigger::register_unitrigger(unitrigger_stub, &piece_unitrigger_think);
  } else {
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &piece_unitrigger_think);
  }
  return unitrigger_stub;
}

function piecetrigger_update_prompt(player) {
  if(!isDefined(player.current_craftable_pieces)) {
    player.current_craftable_pieces = [];
  }
  can_use = self.stub piecestub_update_prompt(player);
  self setinvisibletoplayer(player, !can_use);
  self sethintstring(self.stub.hint_string);
  return can_use;
}

function piecestub_update_prompt(player, slot = self.piece.inventory_slot) {
  if(!self anystub_update_prompt(player)) {
    return false;
  }
  if(isDefined(player.current_craftable_pieces[slot]) && (!(isDefined(self.piece.is_shared) && self.piece.is_shared))) {
    if(!level.craftable_piece_swap_allowed) {
      self.hint_string = &"ZOMBIE_CRAFTABLE_NO_SWITCH";
    } else {
      spiece = self.piece;
      cpiece = player.current_craftable_pieces[slot];
      if(spiece.piecename == cpiece.piecename && spiece.craftablename == cpiece.craftablename) {
        self.hint_string = "";
        return false;
      }
      if(isDefined(self.hint_string_override)) {
        self.hint_string = self.hint_string_override;
      } else {
        self.hint_string = &"ZOMBIE_BUILD_PIECE_SWITCH";
      }
    }
  } else {
    if(isDefined(self.hint_string_override)) {
      self.hint_string = self.hint_string_override;
    } else {
      self.hint_string = &"ZOMBIE_BUILD_PIECE_GRAB";
    }
  }
  return true;
}

function piece_unitrigger_think() {
  self endon("kill_trigger");
  slot = self.stub.piece.inventory_slot;
  while(true) {
    self waittill("trigger", player);
    self.stub notify("trigger", player);
    if(player != self.parent_player) {
      continue;
    }
    if(isDefined(player.screecher_weapon)) {
      continue;
    }
    if(!level.craftable_piece_swap_allowed && isDefined(player.current_craftable_pieces[slot]) && (!(isDefined(self.stub.piece.is_shared) && self.stub.piece.is_shared))) {
      continue;
    }
    if(!zm_utility::is_player_valid(player)) {
      player thread zm_utility::ignore_triggers(0.5);
      continue;
    }
    status = player player_can_take_piece(self.stub.piece);
    if(!status) {
      self.stub.hint_string = "";
      self sethintstring(self.stub.hint_string);
    } else {
      player thread player_take_piece(self.stub.piece);
    }
  }
}

function player_can_take_piece(piece) {
  if(!isDefined(piece)) {
    return false;
  }
  return true;
}

function dbline(from, to) {
  time = 20;
  while(time > 0) {
    line(from, to, (0, 0, 1), 0, 1);
    time = time - 0.05;
    wait(0.05);
  }
}

function player_throw_piece(piece, origin, dir, return_to_spawn, return_time, endangles) {
  assert(isDefined(piece));
  if(isDefined(piece)) {
    thread dbline(origin, origin + dir);
    pass = 0;
    done = 0;
    altmodel = undefined;
    while(pass < 2 && !done) {
      grenade = self magicgrenadetype("buildable_piece", origin, dir, 30000);
      grenade thread watch_hit_players();
      grenade ghost();
      if(!isDefined(altmodel)) {
        altmodel = spawn("script_model", grenade.origin);
        altmodel setModel(piece.modelname);
      }
      altmodel.origin = grenade.angles;
      altmodel.angles = grenade.angles;
      altmodel linkto(grenade, "", (0, 0, 0), (0, 0, 0));
      grenade.altmodel = altmodel;
      grenade waittill("stationary");
      grenade_origin = grenade.origin;
      grenade_angles = grenade.angles;
      landed_on = grenade getgroundent();
      grenade delete();
      if(isDefined(landed_on) && landed_on == level) {
        done = 1;
      } else {
        origin = grenade_origin;
        dir = ((dir[0] * -1) / 10, (dir[1] * -1) / 10, -1);
        pass++;
      }
    }
    if(!isDefined(endangles)) {
      endangles = grenade_angles;
    }
    piece piece_spawn_at(grenade_origin, endangles);
    if(isDefined(altmodel)) {
      altmodel delete();
    }
    if(isDefined(piece.ondrop)) {
      piece[[piece.ondrop]](self);
    }
    if(isDefined(return_to_spawn) && return_to_spawn) {
      piece piece_wait_and_return(return_time);
    }
  }
}

function watch_hit_players() {
  self endon("death");
  self endon("stationary");
  while(isDefined(self)) {
    self waittill("grenade_bounce", pos, normal, ent);
    if(isPlayer(ent)) {
      ent explosiondamage(25, pos);
    }
  }
}

function piece_wait_and_return(return_time) {
  self endon("pickup");
  wait(0.15);
  if(isDefined(level.exploding_jetgun_fx)) {
    playFXOnTag(level.exploding_jetgun_fx, self.model, "tag_origin");
  } else {
    playFXOnTag(level._effect["powerup_on"], self.model, "tag_origin");
  }
  wait(return_time - 6);
  self piece_hide();
  wait(1);
  self piece_show();
  wait(1);
  self piece_hide();
  wait(1);
  self piece_show();
  wait(1);
  self piece_hide();
  wait(1);
  self piece_show();
  wait(1);
  self notify("respawn");
  self piece_unspawn();
  self piece_spawn_at();
}

function player_return_piece_to_original_spawn(slot = 0) {
  self notify("craftable_piece_released" + slot);
  piece = self.current_craftable_pieces[slot];
  self.current_craftable_pieces[slot] = undefined;
  if(isDefined(piece)) {
    piece piece_spawn_at();
    self clientfield::set_to_player("craftable", 0);
  }
}

function player_drop_piece_on_death(slot = 0) {
  self notify("craftable_piece_released" + slot);
  self endon("craftable_piece_released" + slot);
  self thread player_drop_piece_on_downed(slot);
  origin = self.origin;
  angles = self.angles;
  piece = self.current_craftable_pieces[slot];
  if(isDefined(piece) && isDefined(piece.start_origin)) {
    origin = piece.start_origin;
    angles = piece.start_angles;
  }
  self waittill("disconnect");
  piece piece_spawn_at(origin, angles);
  if(isDefined(self)) {
    self clientfield::set_to_player("craftable", 0);
  }
}

function player_drop_piece(piece = self.current_craftable_pieces[slot], slot) {
  if(isDefined(piece)) {
    piece.damage = 0;
    piece piece_spawn_at(self.origin, self.angles);
    self clientfield::set_to_player("craftable", 0);
    if(isDefined(piece.ondrop)) {
      piece[[piece.ondrop]](self);
    }
  }
  self.current_craftable_pieces[slot] = undefined;
  self notify("craftable_piece_released" + slot);
}

function player_take_piece(piecespawn) {
  piecestub = piecespawn.piecestub;
  slot = piecestub.inventory_slot;
  damage = piecespawn.damage;
  if(!isDefined(self.current_craftable_pieces)) {
    self.current_craftable_pieces = [];
  }
  self notify("player_got_craftable_piece_for_" + piecespawn.craftablename);
  if(!(isDefined(piecestub.is_shared) && piecestub.is_shared) && isDefined(self.current_craftable_pieces[slot])) {
    other_piece = self.current_craftable_pieces[slot];
    self player_drop_piece(self.current_craftable_piece, slot);
    other_piece.damage = damage;
    self zm_utility::do_player_general_vox("general", "craft_swap");
  }
  if(isDefined(piecestub.onpickup)) {
    piecespawn[[piecestub.onpickup]](self);
  }
  if(isDefined(piecestub.is_shared) && piecestub.is_shared) {
    if(isDefined(piecestub.client_field_id)) {
      level clientfield::set(piecestub.client_field_id, 1);
    }
  } else if(isDefined(piecestub.client_field_state)) {
    self clientfield::set_to_player("craftable", piecestub.client_field_state);
  }
  piecespawn piece_unspawn();
  piecespawn notify("pickup");
  if(isDefined(piecestub.is_shared) && piecestub.is_shared) {
    piecespawn.in_shared_inventory = 1;
  } else {
    slot = piecespawn.inventory_slot;
    self.current_craftable_pieces[slot] = piecespawn;
    self thread player_drop_piece_on_death(slot);
  }
  self track_craftable_piece_pickedup(piecespawn);
}

function player_destroy_piece(piece = self.current_craftable_pieces[slot], slot) {
  if(isDefined(piece)) {
    self clientfield::set_to_player("craftable", 0);
  }
  self.current_craftable_pieces[slot] = undefined;
  self notify("craftable_piece_released" + slot);
}

function claim_location(location) {
  if(!isDefined(level.craftable_claimed_locations)) {
    level.craftable_claimed_locations = [];
  }
  if(!isDefined(level.craftable_claimed_locations[location])) {
    level.craftable_claimed_locations[location] = 1;
    return true;
  }
  return false;
}

function is_point_in_craft_trigger(point) {
  candidate_list = [];
  foreach(zone in level.zones) {
    if(isDefined(zone.unitrigger_stubs)) {
      candidate_list = arraycombine(candidate_list, zone.unitrigger_stubs, 1, 0);
    }
  }
  valid_range = 128;
  closest = zm_unitrigger::get_closest_unitriggers(point, candidate_list, valid_range);
  for(index = 0; index < closest.size; index++) {
    if(isDefined(closest[index].registered) && closest[index].registered && isDefined(closest[index].piece)) {
      return true;
    }
  }
  return false;
}

function piece_allocate_spawn(piecestub) {
  self.current_spawn = 0;
  self.managed_spawn = 1;
  self.piecestub = piecestub;
  if(self.spawns.size >= 1 && self.spawns.size > 1) {
    any_good = 0;
    any_okay = 0;
    totalweight = 0;
    spawnweights = [];
    for(i = 0; i < self.spawns.size; i++) {
      if(isDefined(piecestub.piece_allocated[i]) && piecestub.piece_allocated[i]) {
        spawnweights[i] = 0;
      } else {
        if(is_point_in_craft_trigger(self.spawns[i].origin)) {
          any_okay = 1;
          spawnweights[i] = 0.01;
        } else {
          any_good = 1;
          spawnweights[i] = 1;
        }
      }
      totalweight = totalweight + spawnweights[i];
    }
    /
    #
    assert(any_good || any_okay, "");
    if(any_good) {
      totalweight = float(int(totalweight));
    }
    r = randomfloat(totalweight);
    for(i = 0; i < self.spawns.size; i++) {
      if(!any_good || spawnweights[i] >= 1) {
        r = r - spawnweights[i];
        if(r < 0) {
          self.current_spawn = i;
          piecestub.piece_allocated[self.current_spawn] = 1;
          return;
        }
      }
    }
    self.current_spawn = randomint(self.spawns.size);
    piecestub.piece_allocated[self.current_spawn] = 1;
  }
}

function piece_deallocate_spawn() {
  if(isDefined(self.current_spawn)) {
    self.piecestub.piece_allocated[self.current_spawn] = 0;
    self.current_spawn = undefined;
  }
  self.start_origin = undefined;
}

function piece_pick_random_spawn() {
  self.current_spawn = 0;
  if(self.spawns.size >= 1 && self.spawns.size > 1) {
    self.current_spawn = randomint(self.spawns.size);
    while(isDefined(self.spawns[self.current_spawn].claim_location) && !claim_location(self.spawns[self.current_spawn].claim_location)) {
      arrayremoveindex(self.spawns, self.current_spawn);
      if(self.spawns.size < 1) {
        self.current_spawn = 0;
        println("");
        return;
      }
      self.current_spawn = randomint(self.spawns.size);
    }
  }
}

function piece_set_spawn(num) {
  self.current_spawn = 0;
  if(self.spawns.size >= 1 && self.spawns.size > 1) {
    self.current_spawn = int(min(num, self.spawns.size - 1));
  }
}

function piece_spawn_in(piecestub) {
  if(self.spawns.size < 1) {
    return;
  }
  if(isDefined(self.managed_spawn) && self.managed_spawn) {
    if(!isDefined(self.current_spawn)) {
      self piece_allocate_spawn(self.piecestub);
    }
  }
  if(!isDefined(self.current_spawn)) {
    self.current_spawn = 0;
  }
  spawndef = self.spawns[self.current_spawn];
  self.unitrigger = generate_piece_unitrigger("trigger_radius_use", spawndef.origin + vectorscale((0, 0, 1), 12), spawndef.angles, 0, piecestub.radius, piecestub.height, piecestub.hint_string, 0, spawndef.script_string);
  self.unitrigger.piece = self;
  self.radius = piecestub.radius;
  self.height = piecestub.height;
  self.craftablename = piecestub.craftablename;
  self.piecename = piecestub.piecename;
  self.modelname = piecestub.modelname;
  self.hud_icon = piecestub.hud_icon;
  self.tag_name = piecestub.tag_name;
  self.drop_offset = piecestub.drop_offset;
  self.start_origin = spawndef.origin;
  self.start_angles = spawndef.angles;
  self.client_field_state = piecestub.client_field_state;
  self.is_shared = piecestub.is_shared;
  self.inventory_slot = piecestub.inventory_slot;
  self.model = spawn("script_model", self.start_origin);
  if(isDefined(self.start_angles)) {
    self.model.angles = self.start_angles;
  }
  self.model setModel(piecestub.modelname);
  if(isDefined(piecestub.onspawn)) {
    self[[piecestub.onspawn]]();
  }
  self.model ghostindemo();
  self.model.hud_icon = piecestub.hud_icon;
  self.piecestub = piecestub;
  self.unitrigger.origin_parent = self.model;
}

function piece_spawn_at(origin, angles, use_random_start) {
  if(self.spawns.size < 1) {
    return;
  }
  if(isDefined(self.managed_spawn) && self.managed_spawn) {
    if(!isDefined(self.current_spawn) && !isDefined(origin)) {
      self piece_allocate_spawn(self.piecestub);
      spawndef = self.spawns[self.current_spawn];
      self.start_origin = spawndef.origin;
      self.start_angles = spawndef.angles;
    }
  } else if(!isDefined(self.current_spawn)) {
    self.current_spawn = 0;
  }
  unitrigger_offset = vectorscale((0, 0, 1), 12);
  if(isDefined(use_random_start) && use_random_start) {
    self piece_pick_random_spawn();
    spawndef = self.spawns[self.current_spawn];
    self.start_origin = spawndef.origin;
    self.start_angles = spawndef.angles;
    origin = spawndef.origin;
    angles = spawndef.angles;
  } else {
    if(!isDefined(origin)) {
      origin = self.start_origin;
    } else {
      origin = origin + (0, 0, self.drop_offset);
      unitrigger_offset = unitrigger_offset - (0, 0, self.drop_offset);
    }
    if(!isDefined(angles)) {
      angles = self.start_angles;
    }
    if(!isDefined(level.drop_offset)) {
      level.drop_offset = 0;
    }
    origin = origin + (0, 0, level.drop_offset);
    unitrigger_offset = unitrigger_offset - (0, 0, level.drop_offset);
  }
  self.model = spawn("script_model", origin);
  if(isDefined(angles)) {
    self.model.angles = angles;
  }
  self.model setModel(self.modelname);
  if(isDefined(level.equipment_safe_to_drop)) {
    if(![[level.equipment_safe_to_drop]](self.model)) {
      origin = self.start_origin;
      angles = self.start_angles;
      self.model.origin = origin;
      self.model.angles = angles;
    }
  }
  if(isDefined(self.onspawn)) {
    self[[self.onspawn]]();
  }
  self.unitrigger = generate_piece_unitrigger("trigger_radius_use", origin + unitrigger_offset, angles, 0, self.radius, self.height, self.piecestub.hint_string, isDefined(self.model.canmove) && self.model.canmove);
  self.unitrigger.piece = self;
  self.model.hud_icon = self.hud_icon;
  self.unitrigger.origin_parent = self.model;
}

function piece_unspawn() {
  if(isDefined(self.managed_spawn) && self.managed_spawn) {
    self piece_deallocate_spawn();
  }
  if(isDefined(self.model)) {
    self.model delete();
  }
  self.model = undefined;
  if(isDefined(self.unitrigger)) {
    thread zm_unitrigger::unregister_unitrigger(self.unitrigger);
  }
  self.unitrigger = undefined;
}

function piece_hide() {
  if(isDefined(self.model)) {
    self.model ghost();
  }
}

function piece_show() {
  if(isDefined(self.model)) {
    self.model show();
  }
}

function generate_piece(piecestub) {
  piecespawn = spawnStruct();
  piecespawn.spawns = piecestub.spawns;
  if(isDefined(piecestub.managing_pieces) && piecestub.managing_pieces) {
    piecespawn piece_allocate_spawn(piecestub);
  } else {
    if(isDefined(piecestub.use_spawn_num)) {
      piecespawn piece_set_spawn(piecestub.use_spawn_num);
    } else {
      piecespawn piece_pick_random_spawn();
    }
  }
  if(isDefined(piecestub.special_spawn_func)) {
    piecespawn[[piecestub.special_spawn_func]](piecestub);
  } else {
    piecespawn piece_spawn_in(piecestub);
  }
  if(piecespawn.spawns.size >= 1) {
    piecespawn.hud_icon = piecestub.hud_icon;
  }
  if(isDefined(piecestub.onpickup)) {
    piecespawn.onpickup = piecestub.onpickup;
  } else {
    piecespawn.onpickup = &onpickuputs;
  }
  if(isDefined(piecestub.ondrop)) {
    piecespawn.ondrop = piecestub.ondrop;
  } else {
    piecespawn.ondrop = &ondroputs;
  }
  if(isDefined(piecestub.oncrafted)) {
    piecespawn.oncrafted = piecestub.oncrafted;
  }
  return piecespawn;
}

function craftable_piece_unitriggers(craftable_name, origin) {
  assert(isDefined(craftable_name));
  assert(isDefined(level.zombie_craftablestubs[craftable_name]), "" + craftable_name);
  craftable = level.zombie_craftablestubs[craftable_name];
  if(!isDefined(craftable.a_piecestubs)) {
    craftable.a_piecestubs = [];
  }
  level flag::wait_till("start_zombie_round_logic");
  craftablespawn = spawnStruct();
  craftablespawn.craftable_name = craftable_name;
  if(!isDefined(craftablespawn.a_piecespawns)) {
    craftablespawn.a_piecespawns = [];
  }
  craftablepickups = [];
  foreach(piecestub in craftable.a_piecestubs) {
    if(!isDefined(craftablespawn.inventory_slot)) {
      craftablespawn.inventory_slot = piecestub.inventory_slot;
    }
    /
    #
    assert(craftablespawn.inventory_slot == piecestub.inventory_slot, "");
    if(!isDefined(piecestub.generated_instances)) {
      piecestub.generated_instances = 0;
    }
    if(isDefined(piecestub.piecespawn) && (isDefined(piecestub.can_reuse) && piecestub.can_reuse)) {
      piece = piecestub.piecespawn;
    } else {
      if(piecestub.generated_instances >= piecestub.max_instances) {
        piece = piecestub.piecespawn;
      } else {
        piece = generate_piece(piecestub);
        piecestub.piecespawn = piece;
        piecestub.generated_instances++;
      }
    }
    craftablespawn.a_piecespawns[craftablespawn.a_piecespawns.size] = piece;
  }
  craftablespawn.stub = self;
  return craftablespawn;
}

function hide_craftable_table_model(trigger_targetname) {
  trig = getent(trigger_targetname, "targetname");
  if(!isDefined(trig)) {
    return;
  }
  if(isDefined(trig.target)) {
    model = getent(trig.target, "targetname");
    if(isDefined(model)) {
      model ghost();
      model notsolid();
    }
  }
}

function setup_unitrigger_craftable(trigger_targetname, equipname, weaponname, trigger_hintstring, delete_trigger, persistent) {
  trig = getent(trigger_targetname, "targetname");
  if(!isDefined(trig)) {
    return;
  }
  return setup_unitrigger_craftable_internal(trig, equipname, weaponname, trigger_hintstring, delete_trigger, persistent);
}

function setup_unitrigger_craftable_array(trigger_targetname, equipname, weaponname, trigger_hintstring, delete_trigger, persistent) {
  triggers = getEntArray(trigger_targetname, "targetname");
  stubs = [];
  foreach(trig in triggers) {
    stubs[stubs.size] = setup_unitrigger_craftable_internal(trig, equipname, weaponname, trigger_hintstring, delete_trigger, persistent);
  }
  return stubs;
}

function setup_unitrigger_craftable_internal(trig, equipname, weaponname, trigger_hintstring, delete_trigger, persistent) {
  if(!isDefined(trig)) {
    return;
  }
  unitrigger_stub = spawnStruct();
  unitrigger_stub.craftablestub = level.zombie_include_craftables[equipname];
  angles = trig.script_angles;
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }
  unitrigger_stub.origin = trig.origin + (anglestoright(angles) * -6);
  unitrigger_stub.angles = trig.angles;
  if(isDefined(trig.script_angles)) {
    unitrigger_stub.angles = trig.script_angles;
  }
  unitrigger_stub.equipname = equipname;
  unitrigger_stub.weaponname = getweapon(weaponname);
  unitrigger_stub.trigger_hintstring = trigger_hintstring;
  unitrigger_stub.delete_trigger = delete_trigger;
  unitrigger_stub.crafted = 0;
  unitrigger_stub.persistent = persistent;
  unitrigger_stub.usetime = int(3000);
  if(isDefined(self.usetime)) {
    unitrigger_stub.usetime = self.usetime;
  } else if(isDefined(trig.usetime)) {
    unitrigger_stub.usetime = trig.usetime;
  }
  unitrigger_stub.onbeginuse = &onbeginuseuts;
  unitrigger_stub.onenduse = &onenduseuts;
  unitrigger_stub.onuse = &onuseplantobjectuts;
  unitrigger_stub.oncantuse = &oncantuseuts;
  tmins = trig getmins();
  tmaxs = trig getmaxs();
  tsize = tmaxs - tmins;
  if(isDefined(trig.script_depth)) {
    unitrigger_stub.script_length = trig.script_depth;
  } else {
    unitrigger_stub.script_length = tsize[1];
  }
  if(isDefined(trig.script_width)) {
    unitrigger_stub.script_width = trig.script_width;
  } else {
    unitrigger_stub.script_width = tsize[0];
  }
  if(isDefined(trig.script_height)) {
    unitrigger_stub.script_height = trig.script_height;
  } else {
    unitrigger_stub.script_height = tsize[2];
  }
  unitrigger_stub.target = trig.target;
  unitrigger_stub.targetname = trig.targetname;
  unitrigger_stub.script_noteworthy = trig.script_noteworthy;
  unitrigger_stub.script_parameters = trig.script_parameters;
  unitrigger_stub.cursor_hint = "HINT_NOICON";
  if(isDefined(level.zombie_craftablestubs[equipname].str_to_craft)) {
    unitrigger_stub.hint_string = level.zombie_craftablestubs[equipname].str_to_craft;
  }
  unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
  unitrigger_stub.require_look_at = 1;
  unitrigger_stub.require_look_toward = 0;
  zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
  if(isDefined(unitrigger_stub.craftablestub.custom_craftablestub_update_prompt)) {
    unitrigger_stub.custom_craftablestub_update_prompt = unitrigger_stub.craftablestub.custom_craftablestub_update_prompt;
  }
  unitrigger_stub.prompt_and_visibility_func = &craftabletrigger_update_prompt;
  zm_unitrigger::register_static_unitrigger(unitrigger_stub, &craftable_place_think);
  unitrigger_stub.piece_trigger = trig;
  trig.trigger_stub = unitrigger_stub;
  if(isDefined(trig.zombie_weapon_upgrade)) {
    unitrigger_stub.zombie_weapon_upgrade = getweapon(trig.zombie_weapon_upgrade);
  }
  if(isDefined(unitrigger_stub.target)) {
    unitrigger_stub.model = getent(unitrigger_stub.target, "targetname");
    if(isDefined(unitrigger_stub.model)) {
      if(isDefined(unitrigger_stub.zombie_weapon_upgrade)) {
        unitrigger_stub.model useweaponhidetags(unitrigger_stub.zombie_weapon_upgrade);
      }
      if(isDefined(unitrigger_stub.model.script_parameters)) {
        a_utm_params = strtok(unitrigger_stub.model.script_parameters, " ");
        foreach(param in a_utm_params) {
          if(param == "starts_visible") {
            b_start_visible = 1;
            continue;
            continue;
          }
          if(param == "starts_empty") {
            b_start_empty = 1;
          }
        }
      }
      if(b_start_visible !== 1) {
        unitrigger_stub.model ghost();
        unitrigger_stub.model notsolid();
      }
    }
  }
  if(unitrigger_stub.equipname == "open_table") {
    unitrigger_stub.a_uts_open_craftables_available = [];
    unitrigger_stub.n_open_craftable_choice = -1;
    unitrigger_stub.b_open_craftable_checking_input = 0;
  }
  unitrigger_stub.craftablespawn = unitrigger_stub craftable_piece_unitriggers(equipname, unitrigger_stub.origin);
  if(isDefined(unitrigger_stub.model) && b_start_empty === 1) {
    for(i = 0; i < unitrigger_stub.craftablespawn.a_piecespawns.size; i++) {
      if(isDefined(unitrigger_stub.craftablespawn.a_piecespawns[i].tag_name)) {
        if(unitrigger_stub.craftablespawn.a_piecespawns[i].crafted !== 1) {
          unitrigger_stub.model hidepart(unitrigger_stub.craftablespawn.a_piecespawns[i].tag_name);
          continue;
        }
        unitrigger_stub.model showpart(unitrigger_stub.craftablespawn.a_piecespawns[i].tag_name);
      }
    }
  }
  if(delete_trigger) {
    trig delete();
  }
  level.a_uts_craftables[level.a_uts_craftables.size] = unitrigger_stub;
  return unitrigger_stub;
}

function setup_craftable_pieces() {
  unitrigger_stub = spawnStruct();
  unitrigger_stub.craftablestub = level.zombie_include_craftables[self.name];
  unitrigger_stub.equipname = self.name;
  unitrigger_stub.craftablespawn = unitrigger_stub craftable_piece_unitriggers(self.name, unitrigger_stub.origin);
  level.a_uts_craftables[level.a_uts_craftables.size] = unitrigger_stub;
  return unitrigger_stub;
}

function craftable_has_piece(piece) {
  for(i = 0; i < self.a_piecespawns.size; i++) {
    if(self.a_piecespawns[i].piecename == piece.piecename && self.a_piecespawns[i].craftablename == piece.craftablename) {
      return true;
    }
  }
  return false;
}

function get_actual_uts_craftable() {
  if(self.craftable_name == "open_table" && self.n_open_craftable_choice != -1) {
    return self.stub.a_uts_open_craftables_available[self.n_open_craftable_choice];
  }
  return self.stub;
}

function get_actual_craftablespawn() {
  if(self.craftable_name == "open_table" && self.stub.n_open_craftable_choice != -1 && isDefined(self.stub.a_uts_open_craftables_available[self.stub.n_open_craftable_choice].craftablespawn)) {
    return self.stub.a_uts_open_craftables_available[self.stub.n_open_craftable_choice].craftablespawn;
  }
  return self;
}

function craftable_can_use_shared_piece() {
  uts_craftable = self.stub;
  if(isDefined(uts_craftable.n_open_craftable_choice) && uts_craftable.n_open_craftable_choice != -1 && isDefined(uts_craftable.a_uts_open_craftables_available[uts_craftable.n_open_craftable_choice])) {
    return true;
  }
  if(isDefined(uts_craftable.craftablestub.need_all_pieces) && uts_craftable.craftablestub.need_all_pieces) {
    foreach(piece in self.a_piecespawns) {
      if(!(isDefined(piece.in_shared_inventory) && piece.in_shared_inventory)) {
        return false;
      }
    }
    return true;
  }
  foreach(piece in self.a_piecespawns) {
    if(!(isDefined(piece.crafted) && piece.crafted) && (isDefined(piece.in_shared_inventory) && piece.in_shared_inventory)) {
      return true;
    }
  }
  return false;
}

function craftable_set_piece_crafted(piecespawn_check, player) {
  craftablespawn_check = get_actual_craftablespawn();
  foreach(piecespawn in craftablespawn_check.a_piecespawns) {
    if(isDefined(piecespawn_check)) {
      if(piecespawn.piecename == piecespawn_check.piecename && piecespawn.craftablename == piecespawn_check.craftablename) {
        piecespawn.crafted = 1;
        if(isDefined(piecespawn.oncrafted)) {
          piecespawn thread[[piecespawn.oncrafted]](player);
        }
        continue;
      }
    }
    if(isDefined(piecespawn.is_shared) && piecespawn.is_shared && (isDefined(piecespawn.in_shared_inventory) && piecespawn.in_shared_inventory)) {
      piecespawn.crafted = 1;
      if(isDefined(piecespawn.oncrafted)) {
        piecespawn thread[[piecespawn.oncrafted]](player);
      }
      piecespawn.in_shared_inventory = 0;
    }
  }
}

function craftable_set_piece_crafting(piecespawn_check) {
  craftablespawn_check = get_actual_craftablespawn();
  foreach(piecespawn in craftablespawn_check.a_piecespawns) {
    if(isDefined(piecespawn_check)) {
      if(piecespawn.piecename == piecespawn_check.piecename && piecespawn.craftablename == piecespawn_check.craftablename) {
        piecespawn.crafting = 1;
      }
    }
    if(isDefined(piecespawn.is_shared) && piecespawn.is_shared && (isDefined(piecespawn.in_shared_inventory) && piecespawn.in_shared_inventory)) {
      piecespawn.crafting = 1;
    }
  }
}

function craftable_clear_piece_crafting(piecespawn_check) {
  if(isDefined(piecespawn_check)) {
    piecespawn_check.crafting = 0;
  }
  craftablespawn_check = get_actual_craftablespawn();
  foreach(piecespawn in craftablespawn_check.a_piecespawns) {
    if(isDefined(piecespawn.is_shared) && piecespawn.is_shared && (isDefined(piecespawn.in_shared_inventory) && piecespawn.in_shared_inventory)) {
      piecespawn.crafting = 0;
    }
  }
}

function craftable_is_piece_crafted(piece) {
  for(i = 0; i < self.a_piecespawns.size; i++) {
    if(self.a_piecespawns[i].piecename == piece.piecename && self.a_piecespawns[i].craftablename == piece.craftablename) {
      return isDefined(self.a_piecespawns[i].crafted) && self.a_piecespawns[i].crafted;
    }
  }
  return 0;
}

function start_crafting_shared_piece() {
  if(!isDefined(level.shared_crafting_in_progress)) {
    level.shared_crafting_in_progress = self;
  }
}

function finish_crafting_shared_piece() {
  if(self === level.shared_crafting_in_progress) {
    level.shared_crafting_in_progress = undefined;
  }
}

function can_craft_shared_piece(continuing) {
  if(continuing) {
    return self === level.shared_crafting_in_progress;
  }
  return !isDefined(level.shared_crafting_in_progress);
}

function craftable_is_piece_crafting(piecespawn_check) {
  craftablespawn_check = get_actual_craftablespawn();
  foreach(piecespawn in craftablespawn_check.a_piecespawns) {
    if(isDefined(piecespawn_check)) {
      if(piecespawn.piecename == piecespawn_check.piecename && piecespawn.craftablename == piecespawn_check.craftablename) {
        return piecespawn.crafting;
      }
    }
    if(isDefined(piecespawn.is_shared) && piecespawn.is_shared && (isDefined(piecespawn.in_shared_inventory) && piecespawn.in_shared_inventory) && (isDefined(piecespawn.crafting) && piecespawn.crafting)) {
      return 1;
    }
  }
  return 0;
}

function craftable_is_piece_crafted_or_crafting(piece) {
  for(i = 0; i < self.a_piecespawns.size; i++) {
    if(self.a_piecespawns[i].piecename == piece.piecename && self.a_piecespawns[i].craftablename == piece.craftablename) {
      return isDefined(self.a_piecespawns[i].crafted) && self.a_piecespawns[i].crafted || (isDefined(self.a_piecespawns[i].crafting) && self.a_piecespawns[i].crafting);
    }
  }
  return 0;
}

function craftable_all_crafted() {
  if(isDefined(self.stub.craftablestub.need_all_pieces) && self.stub.craftablestub.need_all_pieces) {
    foreach(piece in self.a_piecespawns) {
      if(!(isDefined(piece.in_shared_inventory) && piece.in_shared_inventory) && !piece.crafted) {
        return false;
      }
    }
    return true;
  }
  for(i = 0; i < self.a_piecespawns.size; i++) {
    if(!(isDefined(self.a_piecespawns[i].crafted) && self.a_piecespawns[i].crafted)) {
      return false;
    }
  }
  return true;
}

function waittill_crafted(craftable_name) {
  level waittill(craftable_name + "_crafted", player);
  return player;
}

function player_can_craft(craftablespawn, continuing, slot) {
  if(!isDefined(craftablespawn)) {
    return false;
  }
  if(!isDefined(slot)) {
    slot = craftablespawn.inventory_slot;
  }
  if(!craftablespawn craftable_can_use_shared_piece()) {
    if(!isDefined(slot)) {
      return false;
    }
    if(!isDefined(self.current_craftable_pieces[slot])) {
      return false;
    }
    if(!craftablespawn craftable_has_piece(self.current_craftable_pieces[slot])) {
      return false;
    }
    if(isDefined(continuing) && continuing) {
      if(craftablespawn craftable_is_piece_crafted(self.current_craftable_pieces[slot])) {
        return false;
      }
    } else if(craftablespawn craftable_is_piece_crafted_or_crafting(self.current_craftable_pieces[slot])) {
      return false;
    }
  } else {
    if(isDefined(craftablespawn.stub.crafted) && craftablespawn.stub.crafted && !continuing) {
      return false;
    }
    if(craftablespawn.stub.usetime > 0 && !self can_craft_shared_piece(continuing)) {
      return false;
    }
  }
  if(isDefined(craftablespawn.stub) && isDefined(craftablespawn.stub.custom_craftablestub_update_prompt) && isDefined(craftablespawn.stub.playertrigger[0]) && isDefined(craftablespawn.stub.playertrigger[0].stub) && !craftablespawn.stub.playertrigger[0].stub[[craftablespawn.stub.custom_craftablestub_update_prompt]](self, 1, craftablespawn.stub.playertrigger[self getentitynumber()])) {
    return false;
  }
  return true;
}

function craftable_transfer_data() {
  uts_craftable = self.stub;
  if(uts_craftable.n_open_craftable_choice == -1 || !isDefined(uts_craftable.a_uts_open_craftables_available[uts_craftable.n_open_craftable_choice])) {
    return;
  }
  uts_source = uts_craftable.a_uts_open_craftables_available[uts_craftable.n_open_craftable_choice];
  uts_target = uts_craftable;
  uts_target.craftablestub = uts_source.craftablestub;
  uts_target.craftablespawn = uts_source.craftablespawn;
  uts_target.crafted = uts_source.crafted;
  uts_target.cursor_hint = uts_source.cursor_hint;
  uts_target.custom_craftable_update_prompt = uts_source.custom_craftable_update_prompt;
  uts_target.equipname = uts_source.equipname;
  uts_target.hint_string = uts_source.hint_string;
  uts_target.persistent = uts_source.persistent;
  uts_target.prompt_and_visibility_func = uts_source.prompt_and_visibility_func;
  uts_target.trigger_func = uts_source.trigger_func;
  uts_target.trigger_hintstring = uts_source.trigger_hintstring;
  uts_target.weaponname = uts_source.weaponname;
  uts_target.craftablespawn.stub = uts_target;
  thread zm_unitrigger::unregister_unitrigger(uts_source);
  uts_source craftablestub_remove();
  return uts_target;
}

function player_craft(craftablespawn, slot = craftablespawn.inventory_slot) {
  if(!isDefined(self.current_craftable_pieces)) {
    self.current_craftable_pieces = [];
  }
  if(isDefined(slot)) {
    craftablespawn craftable_set_piece_crafted(self.current_craftable_pieces[slot], self);
  }
  if(isDefined(slot) && isDefined(self.current_craftable_pieces[slot]) && (isDefined(self.current_craftable_pieces[slot].crafted) && self.current_craftable_pieces[slot].crafted)) {
    player_destroy_piece(self.current_craftable_pieces[slot], slot);
  }
  if(isDefined(craftablespawn.stub.n_open_craftable_choice)) {
    uts_craftable = craftablespawn craftable_transfer_data();
    craftablespawn = uts_craftable.craftablespawn;
    update_open_table_status();
  } else {
    uts_craftable = craftablespawn.stub;
  }
  if(!isDefined(uts_craftable.model) && isDefined(uts_craftable.craftablestub.str_model)) {
    craftablestub = uts_craftable.craftablestub;
    s_model = struct::get(uts_craftable.target, "targetname");
    if(isDefined(s_model)) {
      m_spawn = spawn("script_model", s_model.origin);
      if(isDefined(craftablestub.v_origin_offset)) {
        m_spawn.origin = m_spawn.origin + craftablestub.v_origin_offset;
      }
      m_spawn.angles = s_model.angles;
      if(isDefined(craftablestub.v_angle_offset)) {
        m_spawn.angles = m_spawn.angles + craftablestub.v_angle_offset;
      }
      m_spawn setModel(craftablestub.str_model);
      uts_craftable.model = m_spawn;
    }
  }
  if(isDefined(uts_craftable.model)) {
    for(i = 0; i < craftablespawn.a_piecespawns.size; i++) {
      if(isDefined(craftablespawn.a_piecespawns[i].tag_name)) {
        uts_craftable.model notsolid();
        if(!(isDefined(craftablespawn.a_piecespawns[i].crafted) && craftablespawn.a_piecespawns[i].crafted)) {
          uts_craftable.model hidepart(craftablespawn.a_piecespawns[i].tag_name);
          continue;
        }
        uts_craftable.model show();
        uts_craftable.model showpart(craftablespawn.a_piecespawns[i].tag_name);
      }
    }
  }
  self track_craftable_pieces_crafted(craftablespawn);
  if(craftablespawn craftable_all_crafted()) {
    self player_finish_craftable(craftablespawn);
    self track_craftables_crafted(craftablespawn);
    if(isDefined(level.craftable_crafted_custom_func)) {
      self thread[[level.craftable_crafted_custom_func]](craftablespawn);
    }
  } else {
    self playSound("zmb_buildable_piece_add");
    assert(isDefined(level.zombie_craftablestubs[craftablespawn.craftable_name].str_crafting), "");
    if(isDefined(level.zombie_craftablestubs[craftablespawn.craftable_name].str_crafting)) {
      return level.zombie_craftablestubs[craftablespawn.craftable_name].str_crafting;
    }
  }
  return "";
}

function update_open_table_status() {
  b_open_craftables_remaining = 0;
  foreach(uts_craftable in level.a_uts_craftables) {
    if(isDefined(level.zombie_include_craftables[uts_craftable.equipname]) && (isDefined(level.zombie_include_craftables[uts_craftable.equipname].is_open_table) && level.zombie_include_craftables[uts_craftable.equipname].is_open_table)) {
      b_piece_crafted = 0;
      foreach(piecespawn in uts_craftable.craftablespawn.a_piecespawns) {
        if(isDefined(piecespawn.crafted) && piecespawn.crafted) {
          b_piece_crafted = 1;
          break;
        }
      }
      if(!b_piece_crafted) {
        b_open_craftables_remaining = 1;
      }
    }
  }
  if(!b_open_craftables_remaining) {
    foreach(uts_craftable in level.a_uts_craftables) {
      if(uts_craftable.equipname == "open_table") {
        thread zm_unitrigger::unregister_unitrigger(uts_craftable);
      }
    }
  }
}

function player_finish_craftable(craftablespawn) {
  craftablespawn.crafted = 1;
  craftablespawn.stub.crafted = 1;
  craftablespawn notify("crafted", self);
  level.craftables_crafted[craftablespawn.craftable_name] = 1;
  level notify(craftablespawn.craftable_name + "_crafted", self);
}

function complete_craftable(str_craftable_name) {
  foreach(uts_craftable in level.a_uts_craftables) {
    if(uts_craftable.craftablestub.name == str_craftable_name) {
      player = getplayers()[0];
      player player_finish_craftable(uts_craftable.craftablespawn);
      thread zm_unitrigger::unregister_unitrigger(uts_craftable);
      if(isDefined(uts_craftable.craftablestub.onfullycrafted)) {
        uts_craftable[[uts_craftable.craftablestub.onfullycrafted]]();
      }
      return;
    }
  }
}

function craftablestub_remove() {
  arrayremovevalue(level.a_uts_craftables, self);
}

function craftabletrigger_update_prompt(player) {
  can_use = self.stub craftablestub_update_prompt(player);
  self sethintstring(self.stub.hint_string);
  return can_use;
}

function craftablestub_update_prompt(player, unitrigger, slot = self.craftablestub.inventory_slot) {
  if(!isDefined(player.current_craftable_pieces)) {
    player.current_craftable_pieces = [];
  }
  if(!self anystub_update_prompt(player)) {
    return false;
  }
  if(player bgb::is_enabled("zm_bgb_disorderly_combat")) {
    self.hint_string = "";
    return false;
  }
  if(isDefined(self.is_locked) && self.is_locked) {
    return true;
  }
  can_use = 1;
  if(isDefined(self.custom_craftablestub_update_prompt) && !self[[self.custom_craftablestub_update_prompt]](player)) {
    return false;
  }
  initial_current_weapon = player getcurrentweapon();
  current_weapon = zm_weapons::get_nonalternate_weapon(initial_current_weapon);
  if(current_weapon.isheroweapon || current_weapon.isgadget) {
    self.hint_string = "";
    return false;
  }
  if(!(isDefined(self.crafted) && self.crafted)) {
    if(!self.craftablespawn craftable_can_use_shared_piece()) {
      if(!isDefined(player.current_craftable_pieces[slot])) {
        self.hint_string = &"ZOMBIE_BUILD_PIECE_MORE";
        return false;
      }
      if(!self.craftablespawn craftable_has_piece(player.current_craftable_pieces[slot])) {
        self.hint_string = &"ZOMBIE_BUILD_PIECE_WRONG";
        return false;
      }
    }
    assert(isDefined(level.zombie_craftablestubs[self.equipname].str_to_craft), "");
    self.hint_string = level.zombie_craftablestubs[self.equipname].str_to_craft;
  } else {
    if(self.persistent == 1) {
      if(zm_equipment::is_limited(self.weaponname) && zm_equipment::limited_in_use(self.weaponname)) {
        self.hint_string = &"ZOMBIE_BUILD_PIECE_ONLY_ONE";
        return false;
      }
      if(player zm_equipment::has_player_equipment(self.weaponname)) {
        self.hint_string = &"ZOMBIE_BUILD_PIECE_HAVE_ONE";
        return false;
      }
      self.hint_string = self.trigger_hintstring;
    } else {
      if(self.persistent == 2) {
        if(!zm_weapons::limited_weapon_below_quota(self.weaponname, undefined)) {
          self.hint_string = &"ZOMBIE_GO_TO_THE_BOX_LIMITED";
          return false;
        }
        if(isDefined(self.str_taken) && self.str_taken) {
          self.hint_string = &"ZOMBIE_GO_TO_THE_BOX";
          return false;
        }
        self.hint_string = self.trigger_hintstring;
      } else {
        self.hint_string = "";
        return false;
      }
    }
  }
  return true;
}

function choose_open_craftable(player) {
  self endon("kill_choose_open_craftable");
  n_playernum = player getentitynumber();
  self.b_open_craftable_checking_input = 1;
  b_got_input = 1;
  hinttexthudelem = newclienthudelem(player);
  hinttexthudelem.alignx = "center";
  hinttexthudelem.aligny = "middle";
  hinttexthudelem.horzalign = "center";
  hinttexthudelem.vertalign = "middle";
  hinttexthudelem.y = 95;
  if(player issplitscreen()) {
    hinttexthudelem.y = -50;
  }
  hinttexthudelem.foreground = 1;
  hinttexthudelem.font = "default";
  hinttexthudelem.fontscale = 1.1;
  hinttexthudelem.alpha = 1;
  hinttexthudelem.color = (1, 1, 1);
  hinttexthudelem settext(&"ZOMBIE_CRAFTABLE_CHANGE_BUILD");
  if(!isDefined(self.opencraftablehudelem)) {
    self.opencraftablehudelem = [];
  }
  self.opencraftablehudelem[n_playernum] = hinttexthudelem;
  while(isDefined(self.playertrigger[n_playernum]) && !self.crafted) {
    if(player actionslotonebuttonpressed()) {
      self.n_open_craftable_choice++;
      b_got_input = 1;
    } else if(player actionslottwobuttonpressed()) {
      self.n_open_craftable_choice--;
      b_got_input = 1;
    }
    if(self.n_open_craftable_choice >= self.a_uts_open_craftables_available.size) {
      self.n_open_craftable_choice = 0;
    } else if(self.n_open_craftable_choice < 0) {
      self.n_open_craftable_choice = self.a_uts_open_craftables_available.size - 1;
    }
    if(b_got_input) {
      self.equipname = self.a_uts_open_craftables_available[self.n_open_craftable_choice].equipname;
      self.hint_string = self.a_uts_open_craftables_available[self.n_open_craftable_choice].hint_string;
      self.playertrigger[n_playernum] sethintstring(self.hint_string);
      b_got_input = 0;
      wait(0.5);
    }
    if(player util::is_player_looking_at(self.playertrigger[n_playernum].origin, 0.76)) {
      self.opencraftablehudelem[n_playernum].alpha = 1;
    } else {
      self.opencraftablehudelem[n_playernum].alpha = 0;
    }
    wait(0.05);
  }
  self.b_open_craftable_checking_input = 0;
  self.opencraftablehudelem[n_playernum] destroy();
  self.opencraftablehudelem[n_playernum] = undefined;
}

function open_craftablestub_update_prompt(player, slot = 0) {
  if(!(isDefined(self.crafted) && self.crafted)) {
    self.a_uts_open_craftables_available = [];
    foreach(uts_craftable in level.a_uts_craftables) {
      if(isDefined(uts_craftable.craftablestub.is_open_table) && uts_craftable.craftablestub.is_open_table && (!(isDefined(uts_craftable.crafted) && uts_craftable.crafted)) && uts_craftable.craftablespawn.craftable_name != "open_table" && uts_craftable.craftablespawn craftable_can_use_shared_piece()) {
        self.a_uts_open_craftables_available[self.a_uts_open_craftables_available.size] = uts_craftable;
      }
    }
    if(self.a_uts_open_craftables_available.size < 2) {
      self notify("kill_choose_open_craftable");
      self.b_open_craftable_checking_input = 0;
      n_entitynum = player getentitynumber();
      if(isDefined(self.opencraftablehudelem) && isDefined(self.opencraftablehudelem[n_entitynum])) {
        self.opencraftablehudelem[n_entitynum] destroy();
        self.opencraftablehudelem[n_entitynum] = undefined;
      }
    }
    switch (self.a_uts_open_craftables_available.size) {
      case 0: {
        if(!isDefined(player.current_craftable_pieces[slot])) {
          self.hint_string = &"ZOMBIE_BUILD_PIECE_MORE";
          self.n_open_craftable_choice = -1;
          return false;
        }
        break;
      }
      case 1: {
        self.n_open_craftable_choice = 0;
        self.equipname = self.a_uts_open_craftables_available[self.n_open_craftable_choice].equipname;
        return true;
      }
      default: {
        if(!self.b_open_craftable_checking_input) {
          thread choose_open_craftable(player);
        }
        return true;
      }
    }
  } else {
    if(self.persistent == 2) {
      if(!zm_weapons::limited_weapon_below_quota(self.weaponname, undefined)) {
        self.hint_string = &"ZOMBIE_GO_TO_THE_BOX_LIMITED";
        return false;
      }
      if(isDefined(self.bought) && self.bought) {
        self.hint_string = &"ZOMBIE_GO_TO_THE_BOX";
        return false;
      }
      if(isDefined(self.str_taken) && self.str_taken) {
        self.hint_string = &"ZOMBIE_GO_TO_THE_BOX";
        return false;
      }
      self.hint_string = self.trigger_hintstring;
      return true;
    }
    if(self.persistent == 1) {
      return true;
    }
  }
  return false;
}

function player_continue_crafting(craftablespawn, slot) {
  if(self laststand::player_is_in_laststand() || self zm_utility::in_revive_trigger()) {
    return false;
  }
  if(!self player_can_craft(craftablespawn, 1)) {
    return false;
  }
  if(isDefined(self.screecher)) {
    return false;
  }
  if(!self usebuttonpressed()) {
    return false;
  }
  if(craftablespawn.stub.usetime > 0 && isDefined(slot) && !craftablespawn craftable_is_piece_crafting(self.current_craftable_pieces[slot])) {
    return false;
  }
  trigger = craftablespawn.stub zm_unitrigger::unitrigger_trigger(self);
  if(craftablespawn.stub.script_unitrigger_type == "unitrigger_radius_use") {
    torigin = craftablespawn.stub zm_unitrigger::unitrigger_origin();
    porigin = self getEye();
    radius_sq = (2.25 * craftablespawn.stub.radius) * craftablespawn.stub.radius;
    if(distance2dsquared(torigin, porigin) > radius_sq) {
      return false;
    }
  } else if(!isDefined(trigger) || !trigger istouching(self)) {
    return false;
  }
  if(isDefined(craftablespawn.stub.require_look_at) && craftablespawn.stub.require_look_at && !self util::is_player_looking_at(trigger.origin, 0.76)) {
    return false;
  }
  return true;
}

function player_progress_bar_update(start_time, craft_time) {
  self endon("entering_last_stand");
  self endon("death");
  self endon("disconnect");
  self endon("craftable_progress_end");
  while(isDefined(self) && (gettime() - start_time) < craft_time) {
    progress = (gettime() - start_time) / craft_time;
    if(progress < 0) {
      progress = 0;
    }
    if(progress > 1) {
      progress = 1;
    }
    self.usebar hud::updatebar(progress);
    wait(0.05);
  }
}

function player_progress_bar(start_time, craft_time) {
  self.usebar = self hud::createprimaryprogressbar();
  self.usebartext = self hud::createprimaryprogressbartext();
  self.usebartext settext(&"ZOMBIE_BUILDING");
  if(isDefined(self) && isDefined(start_time) && isDefined(craft_time)) {
    self player_progress_bar_update(start_time, craft_time);
  }
  self.usebartext hud::destroyelem();
  self.usebar hud::destroyelem();
}

function craftable_use_hold_think_internal(player, slot = self.stub.craftablespawn.inventory_slot) {
  wait(0.01);
  if(!isDefined(self)) {
    if(isDefined(player.craftableaudio)) {
      player.craftableaudio delete();
      player.craftableaudio = undefined;
    }
    return;
  }
  if(self.stub.craftablespawn craftable_can_use_shared_piece()) {
    slot = undefined;
  }
  if(!isDefined(self.usetime)) {
    self.usetime = int(3000);
  }
  self.craft_time = self.usetime;
  self.craft_start_time = gettime();
  craft_time = self.craft_time;
  craft_start_time = self.craft_start_time;
  if(craft_time > 0) {
    player zm_utility::disable_player_move_states(1);
    player zm_utility::increment_is_drinking();
    orgweapon = player getcurrentweapon();
    build_weapon = getweapon("zombie_builder");
    player giveweapon(build_weapon);
    player switchtoweapon(build_weapon);
    if(isDefined(slot)) {
      self.stub.craftablespawn craftable_set_piece_crafting(player.current_craftable_pieces[slot]);
    } else {
      player start_crafting_shared_piece();
    }
    player thread player_progress_bar(craft_start_time, craft_time);
    if(isDefined(level.craftable_craft_custom_func)) {
      player thread[[level.craftable_craft_custom_func]](self.stub);
    }
    while(isDefined(self) && player player_continue_crafting(self.stub.craftablespawn, slot) && (gettime() - self.craft_start_time) < self.craft_time) {
      wait(0.05);
    }
    player notify("craftable_progress_end");
    player zm_weapons::switch_back_primary_weapon(orgweapon);
    player takeweapon(build_weapon);
    if(isDefined(player.is_drinking) && player.is_drinking) {
      player zm_utility::decrement_is_drinking();
    }
    player zm_utility::enable_player_move_states();
  }
  if(isDefined(self) && player player_continue_crafting(self.stub.craftablespawn, slot) && (self.craft_time <= 0 || (gettime() - self.craft_start_time) >= self.craft_time)) {
    if(isDefined(slot)) {
      self.stub.craftablespawn craftable_clear_piece_crafting(player.current_craftable_pieces[slot]);
    } else {
      player finish_crafting_shared_piece();
    }
    self notify("craft_succeed");
  } else {
    if(isDefined(player.craftableaudio)) {
      player.craftableaudio delete();
      player.craftableaudio = undefined;
    }
    if(isDefined(slot)) {
      self.stub.craftablespawn craftable_clear_piece_crafting(player.current_craftable_pieces[slot]);
    } else {
      player finish_crafting_shared_piece();
    }
    self notify("craft_failed");
  }
}

function craftable_play_craft_fx(player) {
  self endon("kill_trigger");
  self endon("craft_succeed");
  self endon("craft_failed");
  while(true) {
    playFX(level._effect["building_dust"], player getplayercamerapos(), player.angles);
    wait(0.5);
  }
}

function craftable_use_hold_think(player) {
  self thread craftable_play_craft_fx(player);
  self thread craftable_use_hold_think_internal(player);
  retval = self util::waittill_any_return("craft_succeed", "craft_failed");
  if(retval == "craft_succeed") {
    return true;
  }
  return false;
}

function craftable_place_think() {
  self notify("craftable_place_think");
  self endon("craftable_place_think");
  self endon("kill_trigger");
  player_crafted = undefined;
  while(!(isDefined(self.stub.crafted) && self.stub.crafted)) {
    self waittill("trigger", player);
    if(isDefined(level.custom_craftable_validation)) {
      valid = self[[level.custom_craftable_validation]](player);
      if(!valid) {
        continue;
      }
    }
    if(player != self.parent_player) {
      continue;
    }
    if(isDefined(player.screecher_weapon)) {
      continue;
    }
    if(!zm_utility::is_player_valid(player)) {
      player thread zm_utility::ignore_triggers(0.5);
      continue;
    }
    status = player player_can_craft(self.stub.craftablespawn, 0);
    if(!status) {
      self.stub.hint_string = "";
      self sethintstring(self.stub.hint_string);
      if(isDefined(self.stub.oncantuse)) {
        self.stub[[self.stub.oncantuse]](player);
      }
    } else {
      if(isDefined(self.stub.onbeginuse)) {
        self.stub[[self.stub.onbeginuse]](player);
      }
      result = self craftable_use_hold_think(player);
      team = player.pers["team"];
      if(isDefined(self.stub.onenduse)) {
        self.stub[[self.stub.onenduse]](team, player, result);
      }
      if(!result) {
        continue;
      }
      if(isDefined(self.stub.onuse)) {
        self.stub[[self.stub.onuse]](player);
      }
      prompt = player player_craft(self.stub.craftablespawn);
      player_crafted = player;
      self.stub.hint_string = prompt;
      self sethintstring(self.stub.hint_string);
    }
  }
  if(isDefined(self.stub.craftablestub.onfullycrafted)) {
    b_result = self.stub[[self.stub.craftablestub.onfullycrafted]]();
    if(!b_result) {
      return;
    }
  }
  if(isDefined(player_crafted)) {
    player_crafted playSound("zmb_craftable_complete");
  }
  if(self.stub.persistent == 0) {
    self.stub craftablestub_remove();
    thread zm_unitrigger::unregister_unitrigger(self.stub);
    return;
  }
  if(self.stub.persistent == 3) {
    stub_uncraft_craftable(self.stub, 1);
    return;
  }
  if(self.stub.persistent == 2) {
    if(isDefined(player_crafted)) {
      self craftabletrigger_update_prompt(player_crafted);
    }
    if(!zm_weapons::limited_weapon_below_quota(self.stub.weaponname, undefined)) {
      self.stub.hint_string = &"ZOMBIE_GO_TO_THE_BOX_LIMITED";
      self sethintstring(self.stub.hint_string);
      return;
    }
    if(isDefined(self.stub.str_taken) && self.stub.str_taken) {
      self.stub.hint_string = &"ZOMBIE_GO_TO_THE_BOX";
      self sethintstring(self.stub.hint_string);
      return;
    }
    if(isDefined(self.stub.model)) {
      self.stub.model notsolid();
      self.stub.model show();
    }
    while(self.stub.persistent == 2) {
      self waittill("trigger", player);
      if(isDefined(self.stub.bought) && self.stub.bought == 1) {
        continue;
      }
      if(isDefined(player.screecher_weapon)) {
        continue;
      }
      current_weapon = player getcurrentweapon();
      if(zm_utility::is_placeable_mine(current_weapon) || zm_equipment::is_equipment_that_blocks_purchase(current_weapon)) {
        continue;
      }
      if(current_weapon.isheroweapon || current_weapon.isgadget) {
        continue;
      }
      if(player bgb::is_enabled("zm_bgb_disorderly_combat")) {
        continue;
      }
      if(isDefined(level.custom_craftable_validation)) {
        valid = self[[level.custom_craftable_validation]](player);
        if(!valid) {
          continue;
        }
      }
      if(!(isDefined(self.stub.crafted) && self.stub.crafted)) {
        self.stub.hint_string = "";
        self sethintstring(self.stub.hint_string);
        return;
      }
      if(player != self.parent_player) {
        continue;
      }
      if(!zm_utility::is_player_valid(player)) {
        player thread zm_utility::ignore_triggers(0.5);
        continue;
      }
      self.stub.bought = 1;
      if(isDefined(self.stub.model)) {
        self.stub.model thread model_fly_away(self);
      }
      if(zm_weapons::limited_weapon_below_quota(self.stub.weaponname, undefined)) {
        player zm_weapons::weapon_give(self.stub.weaponname);
        if(isDefined(level.zombie_include_craftables[self.stub.equipname].onbuyweapon)) {
          self[[level.zombie_include_craftables[self.stub.equipname].onbuyweapon]](player);
        }
      }
      if(!zm_weapons::limited_weapon_below_quota(self.stub.weaponname, undefined)) {
        self.stub.hint_string = &"ZOMBIE_GO_TO_THE_BOX_LIMITED";
      } else {
        self.stub.hint_string = &"ZOMBIE_GO_TO_THE_BOX";
      }
      self sethintstring(self.stub.hint_string);
      player track_craftables_pickedup(self.stub.craftablespawn);
    }
  } else if(!isDefined(player_crafted) || self craftabletrigger_update_prompt(player_crafted)) {
    visible = 1;
    hide = get_hide_model_if_unavailable(self.stub.equipname);
    if(hide && isDefined(level.custom_craftable_validation)) {
      visible = self[[level.custom_craftable_validation]](player);
    }
    if(visible && isDefined(self.stub.model)) {
      self.stub.model notsolid();
      self.stub.model show();
    }
    while(self.stub.persistent == 1) {
      self waittill("trigger", player);
      if(isDefined(player.screecher_weapon)) {
        continue;
      }
      if(isDefined(level.custom_craftable_validation)) {
        valid = self[[level.custom_craftable_validation]](player);
        if(!valid) {
          continue;
        }
      }
      if(!(isDefined(self.stub.crafted) && self.stub.crafted)) {
        self.stub.hint_string = "";
        self sethintstring(self.stub.hint_string);
        return;
      }
      if(player != self.parent_player) {
        continue;
      }
      if(!zm_utility::is_player_valid(player)) {
        player thread zm_utility::ignore_triggers(0.5);
        continue;
      }
      if(player zm_equipment::has_player_equipment(self.stub.weaponname)) {
        continue;
      }
      if(player bgb::is_enabled("zm_bgb_disorderly_combat")) {
        continue;
      }
      if(isDefined(level.zombie_craftable_persistent_weapon)) {
        if(self[[level.zombie_craftable_persistent_weapon]](player)) {
          continue;
        }
      }
      if(isDefined(level.zombie_custom_equipment_setup)) {
        if(self[[level.zombie_custom_equipment_setup]](player)) {
          continue;
        }
      }
      if(!zm_equipment::is_limited(self.stub.weaponname) || !zm_equipment::limited_in_use(self.stub.weaponname)) {
        player zm_equipment::buy(self.stub.weaponname);
        player giveweapon(self.stub.weaponname);
        player zm_equipment::start_ammo(self.stub.weaponname);
        player notify(self.stub.weaponname.name + "_pickup_from_table");
        if(isDefined(level.zombie_include_craftables[self.stub.equipname].onbuyweapon)) {
          self[[level.zombie_include_craftables[self.stub.equipname].onbuyweapon]](player);
        } else if(self.stub.weaponname != "keys_zm") {
          player setactionslot(1, "weapon", self.stub.weaponname);
        }
        if(isDefined(level.zombie_craftablestubs[self.stub.equipname].str_taken)) {
          self.stub.hint_string = level.zombie_craftablestubs[self.stub.equipname].str_taken;
        } else {
          self.stub.hint_string = "";
        }
        self sethintstring(self.stub.hint_string);
        player track_craftables_pickedup(self.stub.craftablespawn);
      } else {
        self.stub.hint_string = "";
        self sethintstring(self.stub.hint_string);
      }
    }
  }
}

function model_fly_away(unitrigger) {
  self moveto(self.origin + vectorscale((0, 0, 1), 40), 3);
  direction = self.origin;
  direction = (direction[1], direction[0], 0);
  if(direction[1] < 0 || (direction[0] > 0 && direction[1] > 0)) {
    direction = (direction[0], direction[1] * -1, 0);
  } else if(direction[0] < 0) {
    direction = (direction[0] * -1, direction[1], 0);
  }
  self vibrate(direction, 10, 0.5, 4);
  self waittill("movedone");
  self ghost();
  playFX(level._effect["poltergeist"], self.origin);
}

function find_craftable_stub(equipname) {
  foreach(stub in level.a_uts_craftables) {
    if(stub.equipname == equipname) {
      return stub;
    }
  }
  return undefined;
}

function uncraft_craftable(equipname, return_pieces, origin, angles) {
  stub = find_craftable_stub(equipname);
  stub_uncraft_craftable(stub, return_pieces, origin, angles);
}

function stub_uncraft_craftable(stub, return_pieces, origin, angles, use_random_start) {
  if(isDefined(stub)) {
    craftable = stub.craftablespawn;
    craftable.crafted = 0;
    craftable.stub.crafted = 0;
    craftable notify("uncrafted");
    level.craftables_crafted[craftable.craftable_name] = 0;
    level notify(craftable.craftable_name + "_uncrafted");
    for(i = 0; i < craftable.a_piecespawns.size; i++) {
      craftable.a_piecespawns[i].crafted = 0;
      if(isDefined(craftable.a_piecespawns[i].tag_name)) {
        craftable.stub.model notsolid();
        if(!(isDefined(craftable.a_piecespawns[i].crafted) && craftable.a_piecespawns[i].crafted)) {
          craftable.stub.model hidepart(craftable.a_piecespawns[i].tag_name);
        } else {
          craftable.stub.model show();
          craftable.stub.model showpart(craftable.a_piecespawns[i].tag_name);
        }
      }
      if(isDefined(return_pieces) && return_pieces) {
        craftable.a_piecespawns[i] piece_spawn_at(origin, angles, use_random_start);
      }
    }
    if(isDefined(craftable.stub.model)) {
      craftable.stub.model ghost();
    }
  }
}

function player_explode_craftable(equipname, origin, speed, return_to_spawn, return_time) {
  self explosiondamage(50, origin);
  stub = find_craftable_stub(equipname);
  if(isDefined(stub)) {
    craftable = stub.craftablespawn;
    craftable.crafted = 0;
    craftable.stub.crafted = 0;
    craftable notify("uncrafted");
    level.craftables_crafted[craftable.craftable_name] = 0;
    level notify(craftable.craftable_name + "_uncrafted");
    for(i = 0; i < craftable.a_piecespawns.size; i++) {
      craftable.a_piecespawns[i].crafted = 0;
      if(isDefined(craftable.a_piecespawns[i].tag_name)) {
        craftable.stub.model notsolid();
        if(!(isDefined(craftable.a_piecespawns[i].crafted) && craftable.a_piecespawns[i].crafted)) {
          craftable.stub.model hidepart(craftable.a_piecespawns[i].tag_name);
        } else {
          craftable.stub.model show();
          craftable.stub.model showpart(craftable.a_piecespawns[i].tag_name);
        }
      }
      ang = randomfloat(360);
      h = 0.25 + randomfloat(0.5);
      dir = (sin(ang), cos(ang), h);
      self thread player_throw_piece(craftable.a_piecespawns[i], origin, speed * dir, return_to_spawn, return_time);
    }
    craftable.stub.model ghost();
  }
}

function think_craftables() {
  foreach(craftable in level.zombie_include_craftables) {
    if(isDefined(craftable.triggerthink)) {
      craftable[[craftable.triggerthink]]();
    }
  }
}

function opentablecraftable() {
  a_trigs = getEntArray("open_craftable_trigger", "targetname");
  foreach(trig in a_trigs) {
    unitrigger_stub = setup_unitrigger_craftable_internal(trig, "open_table", "", "OPEN_CRAFTABLE", 1, 0);
    unitrigger_stub.require_look_at = 0;
    unitrigger_stub.require_look_toward = 1;
  }
}

function craftable_trigger_think(trigger_targetname, equipname, weaponname, trigger_hintstring, delete_trigger, persistent) {
  return setup_unitrigger_craftable(trigger_targetname, equipname, weaponname, trigger_hintstring, delete_trigger, persistent);
}

function craftable_trigger_think_array(trigger_targetname, equipname, weaponname, trigger_hintstring, delete_trigger, persistent) {
  return setup_unitrigger_craftable_array(trigger_targetname, equipname, weaponname, trigger_hintstring, delete_trigger, persistent);
}

function setup_vehicle_unitrigger_craftable(parent, trigger_targetname, equipname, weaponname, trigger_hintstring, delete_trigger, persistent) {
  trig = getent(trigger_targetname, "targetname");
  if(!isDefined(trig)) {
    return;
  }
  unitrigger_stub = spawnStruct();
  unitrigger_stub.craftablestub = level.zombie_include_craftables[equipname];
  unitrigger_stub.link_parent = parent;
  unitrigger_stub.origin_parent = trig;
  unitrigger_stub.trigger_targetname = trigger_targetname;
  unitrigger_stub.originfunc = &anystub_get_unitrigger_origin;
  unitrigger_stub.onspawnfunc = &anystub_on_spawn_trigger;
  unitrigger_stub.origin = trig.origin;
  unitrigger_stub.angles = trig.angles;
  unitrigger_stub.equipname = equipname;
  unitrigger_stub.weaponname = weaponname;
  unitrigger_stub.trigger_hintstring = trigger_hintstring;
  unitrigger_stub.delete_trigger = delete_trigger;
  unitrigger_stub.crafted = 0;
  unitrigger_stub.persistent = persistent;
  unitrigger_stub.usetime = int(3000);
  unitrigger_stub.onbeginuse = &onbeginuseuts;
  unitrigger_stub.onenduse = &onenduseuts;
  unitrigger_stub.onuse = &onuseplantobjectuts;
  unitrigger_stub.oncantuse = &oncantuseuts;
  tmins = trig getmins();
  tmaxs = trig getmaxs();
  tsize = tmaxs - tmins;
  if(isDefined(trig.script_length)) {
    unitrigger_stub.script_length = trig.script_length;
  } else {
    unitrigger_stub.script_length = tsize[1];
  }
  if(isDefined(trig.script_width)) {
    unitrigger_stub.script_width = trig.script_width;
  } else {
    unitrigger_stub.script_width = tsize[0];
  }
  if(isDefined(trig.script_height)) {
    unitrigger_stub.script_height = trig.script_height;
  } else {
    unitrigger_stub.script_height = tsize[2];
  }
  if(isDefined(trig.radius)) {
    unitrigger_stub.radius = trig.radius;
  } else {
    unitrigger_stub.radius = 64;
  }
  unitrigger_stub.target = trig.target;
  unitrigger_stub.targetname = trig.targetname + "_trigger";
  unitrigger_stub.script_noteworthy = trig.script_noteworthy;
  unitrigger_stub.script_parameters = trig.script_parameters;
  unitrigger_stub.cursor_hint = "HINT_NOICON";
  if(isDefined(level.zombie_craftablestubs[equipname].str_to_craft)) {
    unitrigger_stub.hint_string = level.zombie_craftablestubs[equipname].str_to_craft;
  }
  unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
  unitrigger_stub.require_look_at = 1;
  zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
  unitrigger_stub.prompt_and_visibility_func = &craftabletrigger_update_prompt;
  zm_unitrigger::register_unitrigger(unitrigger_stub, &craftable_place_think);
  unitrigger_stub.piece_trigger = trig;
  trig.trigger_stub = unitrigger_stub;
  unitrigger_stub.craftablespawn = unitrigger_stub craftable_piece_unitriggers(equipname, unitrigger_stub.origin);
  if(delete_trigger) {
    trig delete();
  }
  level.a_uts_craftables[level.a_uts_craftables.size] = unitrigger_stub;
  return unitrigger_stub;
}

function vehicle_craftable_trigger_think(vehicle, trigger_targetname, equipname, weaponname, trigger_hintstring, delete_trigger, persistent) {
  return setup_vehicle_unitrigger_craftable(vehicle, trigger_targetname, equipname, weaponname, trigger_hintstring, delete_trigger, persistent);
}

function onpickuputs(player) {
  if(isDefined(player) && isDefined(player.name)) {
    println("" + player.name);
  }
}

function ondroputs(player) {
  if(isDefined(player) && isDefined(player.name)) {
    println("" + player.name);
  }
  player notify("event_ended");
}

function onbeginuseuts(player) {
  if(isDefined(player) && isDefined(player.name)) {
    println("" + player.name);
  }
  if(isDefined(self.craftablestub.onbeginuse)) {
    self[[self.craftablestub.onbeginuse]](player);
  }
  if(isDefined(player) && !isDefined(player.craftableaudio)) {
    player.craftableaudio = spawn("script_origin", player.origin);
    player.craftableaudio playLoopSound("zmb_craftable_loop");
  }
}

function onenduseuts(team, player, result) {
  if(isDefined(player) && isDefined(player.name)) {
    println("" + player.name);
  }
  if(!isDefined(player)) {
    return;
  }
  if(isDefined(player.craftableaudio)) {
    player.craftableaudio delete();
    player.craftableaudio = undefined;
  }
  if(isDefined(self.craftablestub.onenduse)) {
    self[[self.craftablestub.onenduse]](team, player, result);
  }
  player notify("event_ended");
}

function oncantuseuts(player) {
  if(isDefined(player) && isDefined(player.name)) {
    println("" + player.name);
  }
  if(isDefined(self.craftablestub.oncantuse)) {
    self[[self.craftablestub.oncantuse]](player);
  }
}

function onuseplantobjectuts(player) {
  if(isDefined(player) && isDefined(player.name)) {
    println("" + player.name);
  }
  if(isDefined(self.craftablestub.onuseplantobject)) {
    self[[self.craftablestub.onuseplantobject]](player);
  }
  player notify("bomb_planted");
}

function is_craftable() {
  if(!isDefined(level.zombie_craftablestubs)) {
    return false;
  }
  if(isDefined(self.zombie_weapon_upgrade) && isDefined(level.zombie_craftablestubs[self.zombie_weapon_upgrade])) {
    return true;
  }
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "specialty_weapupgrade") {
    if(isDefined(level.craftables_crafted["pap"]) && level.craftables_crafted["pap"]) {
      return false;
    }
    return true;
  }
  return false;
}

function craftable_crafted() {
  self.a_piecespawns--;
}

function craftable_complete() {
  if(self.a_piecespawns <= 0) {
    return true;
  }
  return false;
}

function get_craftable_hint(craftable_name) {
  assert(isDefined(level.zombie_craftablestubs[craftable_name]), craftable_name + "");
  return level.zombie_craftablestubs[craftable_name].str_to_craft;
}

function delete_on_disconnect(craftable, self_notify, skip_delete) {
  craftable endon("death");
  self waittill("disconnect");
  if(isDefined(self_notify)) {
    self notify(self_notify);
  }
  if(!(isDefined(skip_delete) && skip_delete)) {
    if(isDefined(craftable.stub)) {
      thread zm_unitrigger::unregister_unitrigger(craftable.stub);
      craftable.stub = undefined;
    }
    if(isDefined(craftable)) {
      craftable delete();
    }
  }
}

function is_holding_part(craftable_name, piece_name, slot = 0) {
  if(isDefined(self.current_craftable_pieces) && isDefined(self.current_craftable_pieces[slot])) {
    if(self.current_craftable_pieces[slot].craftablename == craftable_name && self.current_craftable_pieces[slot].modelname == piece_name) {
      return true;
    }
  }
  if(isDefined(level.a_uts_craftables)) {
    foreach(craftable_stub in level.a_uts_craftables) {
      if(craftable_stub.craftablestub.name == craftable_name) {
        foreach(piece in craftable_stub.craftablespawn.a_piecespawns) {
          if(piece.piecename == piece_name) {
            if(isDefined(piece.in_shared_inventory) && piece.in_shared_inventory) {
              return true;
            }
          }
        }
      }
    }
  }
  return false;
}

function is_part_crafted(craftable_name, piece_name) {
  if(isDefined(level.a_uts_craftables)) {
    foreach(craftable_stub in level.a_uts_craftables) {
      if(craftable_stub.craftablestub.name == craftable_name) {
        if(isDefined(craftable_stub.crafted) && craftable_stub.crafted) {
          return true;
        }
        foreach(piece in craftable_stub.craftablespawn.a_piecespawns) {
          if(piece.piecename == piece_name) {
            if(isDefined(piece.crafted) && piece.crafted) {
              return true;
            }
          }
        }
      }
    }
  }
  return false;
}

function track_craftable_piece_pickedup(piece) {
  if(!isDefined(piece) || !isDefined(piece.craftablename)) {
    println("");
    return;
  }
  self add_map_craftable_stat(piece.craftablename, "pieces_pickedup", 1);
  if(isDefined(piece.piecestub) && isDefined(piece.piecestub.var_2c8ee667)) {
    self recordmapevent(13, gettime(), self.origin, level.round_number, piece.piecestub.var_2c8ee667);
  }
  if(isDefined(piece.piecestub.vox_id)) {
    if(isDefined(piece.piecestub.b_one_time_vo) && piece.piecestub.b_one_time_vo) {
      if(!isDefined(self.a_one_time_piece_pickup_vo)) {
        self.a_one_time_piece_pickup_vo = [];
      }
      if(isDefined(self.dontspeak) && self.dontspeak) {
        return;
      }
      if(isinarray(self.a_one_time_piece_pickup_vo, piece.piecestub.vox_id)) {
        return;
      }
      self.a_one_time_piece_pickup_vo[self.a_one_time_piece_pickup_vo.size] = piece.piecestub.vox_id;
    }
    self thread zm_utility::do_player_general_vox("general", piece.piecestub.vox_id + "_pickup");
  } else {
    self thread zm_utility::do_player_general_vox("general", "build_pickup");
  }
}

function track_craftable_pieces_crafted(craftable) {
  if(!isDefined(craftable) || !isDefined(craftable.craftable_name)) {
    println("");
    return;
  }
  bname = craftable.craftable_name;
  if(isDefined(craftable.stat_name)) {
    bname = craftable.stat_name;
  }
  self add_map_craftable_stat(bname, "pieces_built", 1);
  if(!craftable craftable_all_crafted()) {
    self thread zm_utility::do_player_general_vox("general", "build_add");
  }
  level notify(bname + "_crafted", self);
}

function track_craftables_crafted(craftable) {
  if(!isDefined(craftable) || !isDefined(craftable.craftable_name)) {
    println("");
    return;
  }
  bname = craftable.craftable_name;
  if(isDefined(craftable.stat_name)) {
    bname = craftable.stat_name;
  }
  self add_map_craftable_stat(bname, "buildable_built", 1);
  self zm_stats::increment_client_stat("buildables_built", 0);
  self zm_stats::increment_player_stat("buildables_built");
  if(isDefined(craftable.stub) && isDefined(craftable.stub.craftablestub) && isDefined(craftable.stub.craftablestub.var_2c8ee667)) {
    self recordmapevent(14, gettime(), self.origin, level.round_number, craftable.stub.craftablestub.var_2c8ee667);
  }
  if(!isDefined(craftable.stub.craftablestub.no_challenge_stat) || craftable.stub.craftablestub.no_challenge_stat == 0) {
    self zm_stats::increment_challenge_stat("SURVIVALIST_CRAFTABLE");
  }
  if(isDefined(craftable.stub.craftablestub.vox_id)) {
    if(isDefined(level.zombie_custom_craftable_built_vo)) {
      self thread[[level.zombie_custom_craftable_built_vo]](craftable.stub);
    }
    self thread zm_utility::do_player_general_vox("general", craftable.stub.craftablestub.vox_id + "_final");
  }
}

function track_craftables_pickedup(craftable) {
  if(!isDefined(craftable)) {
    println("");
    return;
  }
  stat_name = get_craftable_stat_name(craftable.craftable_name);
  if(isDefined(craftable.stub) && isDefined(craftable.stub.craftablestub) && isDefined(craftable.stub.craftablestub.var_2c8ee667)) {
    self recordmapevent(16, gettime(), self.origin, level.round_number, craftable.stub.craftablestub.var_2c8ee667);
  }
  if(!isDefined(stat_name)) {
    println(("" + craftable.craftable_name) + "");
    return;
  }
  self add_map_craftable_stat(stat_name, "buildable_pickedup", 1);
  if(isDefined(craftable.stub.craftablestub.vox_id)) {
    self thread zm_utility::do_player_general_vox("general", craftable.stub.craftablestub.vox_id + "_plc");
  }
  self say_pickup_craftable_vo(craftable, 0);
}

function track_craftables_planted(equipment) {
  if(!isDefined(equipment)) {
    println("");
    return;
  }
  craftable_name = undefined;
  if(isDefined(equipment.name)) {
    craftable_name = get_craftable_stat_name(equipment.name);
  }
  if(!isDefined(craftable_name)) {
    println(("" + equipment.name) + "");
    return;
  }
  demo::bookmark("zm_player_buildable_placed", gettime(), self);
  self add_map_craftable_stat(craftable_name, "buildable_placed", 1);
  if(isDefined(equipment.stub) && isDefined(equipment.stub.craftablestub) && isDefined(equipment.stub.craftablestub.var_2c8ee667)) {
    self recordmapevent(15, gettime(), self.origin, level.round_number, equipment.stub.craftablestub.var_2c8ee667);
  }
}

function placed_craftable_vo_timer() {
  self endon("disconnect");
  self.craftable_timer = 1;
  wait(60);
  self.craftable_timer = 0;
}

function craftable_pickedup_timer() {
  self endon("disconnect");
  self.craftable_pickedup_timer = 1;
  wait(60);
  self.craftable_pickedup_timer = 0;
}

function track_planted_craftables_pickedup(equipment) {
  if(!isDefined(equipment)) {
    return;
  }
  if(equipment == "equip_turbine_zm" || equipment == "equip_turret_zm" || equipment == "equip_electrictrap_zm" || equipment == "riotshield_zm" || equipment == "alcatraz_shield_zm" || equipment == "tomb_shield_zm") {
    self zm_stats::increment_client_stat("planted_buildables_pickedup", 0);
    self zm_stats::increment_player_stat("planted_buildables_pickedup");
  }
  if(!(isDefined(self.craftable_pickedup_timer) && self.craftable_pickedup_timer)) {
    self say_pickup_craftable_vo(equipment, 1);
    self thread craftable_pickedup_timer();
  }
}

function track_placed_craftables(craftable_name) {
  if(!isDefined(craftable_name)) {
    return;
  }
  self add_map_craftable_stat(craftable_name, "buildable_placed", 1);
  vo_name = undefined;
  if(craftable_name == level.riotshield_name) {
    vo_name = "craft_plc_shield";
  }
  if(!isDefined(vo_name)) {
    return;
  }
  self thread zm_utility::do_player_general_vox("general", vo_name);
}

function zombie_craftable_set_record_stats(str_craftable, b_record) {
  if(!isDefined(level.craftables_stats_recorded)) {
    level.craftables_stats_recorded = [];
  }
  level.craftables_stats_recorded[str_craftable] = b_record;
}

function add_map_craftable_stat(piece_name, stat_name, value) {
  if(!isDefined(piece_name) || piece_name == "sq_common" || piece_name == "keys_zm") {
    return;
  }
  if(isDefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats || (isDefined(level.zm_disable_recording_buildable_stats) && level.zm_disable_recording_buildable_stats)) {
    return;
  }
  if(!isDefined(level.craftables_stats_recorded)) {
    level.craftables_stats_recorded = [];
  }
  if(!(isDefined(level.craftables_stats_recorded[piece_name]) && level.craftables_stats_recorded[piece_name])) {
    return;
  }
  self adddstat("buildables", piece_name, stat_name, value);
}

function say_pickup_craftable_vo(craftable_name, b_world) {}

function get_craftable_vo_name(craftable_name) {}

function get_craftable_stat_name(craftable_name) {
  if(isDefined(craftable_name)) {
    switch (craftable_name) {
      case "equip_riotshield_zm": {
        return "riotshield_zm";
      }
      case "equip_turbine_zm": {
        return "turbine";
      }
      case "equip_turret_zm": {
        return "turret";
      }
      case "equip_electrictrap_zm": {
        return "electric_trap";
      }
      case "equip_springpad_zm": {
        return "springpad_zm";
      }
      case "equip_slipgun_zm": {
        return "slipgun_zm";
      }
    }
  }
  return craftable_name;
}

function get_craftable_model(str_craftable) {
  foreach(uts_craftable in level.a_uts_craftables) {
    if(uts_craftable.craftablestub.name == str_craftable) {
      if(isDefined(uts_craftable.model)) {
        return uts_craftable.model;
      }
      break;
    }
  }
  return undefined;
}

function get_craftable_piece(str_craftable, str_piece) {
  foreach(uts_craftable in level.a_uts_craftables) {
    if(uts_craftable.craftablestub.name == str_craftable) {
      foreach(piecespawn in uts_craftable.craftablespawn.a_piecespawns) {
        if(piecespawn.piecename == str_piece) {
          return piecespawn;
        }
      }
      break;
    }
  }
  return undefined;
}

function player_get_craftable_piece(str_craftable, str_piece) {
  piecespawn = get_craftable_piece(str_craftable, str_piece);
  if(isDefined(piecespawn)) {
    self player_take_piece(piecespawn);
  }
}

function player_remove_craftable_piece(str_craftable, str_piece) {
  piecespawn = get_craftable_piece(str_craftable, str_piece);
  if(isDefined(piecespawn)) {
    self player_remove_piece(piecespawn);
  }
}

function player_remove_piece(piece_to_remove) {
  if(!isDefined(self.current_craftable_pieces)) {
    self.current_craftable_pieces = [];
  }
  foreach(slot, self_piece in self.current_craftable_pieces) {
    if(piece_to_remove.piecename === self_piece.piecename && piece_to_remove.craftablename === self_piece.craftablename) {
      self clientfield::set_to_player("craftable", 0);
      self.current_craftable_pieces[slot] = undefined;
      self notify("craftable_piece_released" + slot);
    }
  }
}

function get_craftable_piece_model(str_craftable, str_piece) {
  foreach(uts_craftable in level.a_uts_craftables) {
    if(uts_craftable.craftablestub.name == str_craftable) {
      foreach(piecespawn in uts_craftable.craftablespawn.a_piecespawns) {
        if(piecespawn.piecename == str_piece && isDefined(piecespawn.model)) {
          return piecespawn.model;
        }
      }
      break;
    }
  }
  return undefined;
}

function player_show_craftable_parts_ui(str_crafted_clientuimodel, str_widget_clientuimodel, b_is_crafted) {
  self notify("player_show_craftable_parts_ui");
  self endon("player_show_craftable_parts_ui");
  if(b_is_crafted) {
    if(isDefined(str_crafted_clientuimodel)) {
      self thread clientfield::set_player_uimodel(str_crafted_clientuimodel, 1);
    }
    n_show_ui_duration = 3.5;
  } else {
    n_show_ui_duration = 3.5;
  }
  self thread player_hide_craftable_parts_ui_after_duration(str_widget_clientuimodel, n_show_ui_duration);
}

function player_hide_craftable_parts_ui_after_duration(str_widget_clientuimodel, n_show_ui_duration) {
  self endon("disconnect");
  self thread clientfield::set_player_uimodel(str_widget_clientuimodel, 1);
  wait(n_show_ui_duration);
  self thread clientfield::set_player_uimodel(str_widget_clientuimodel, 0);
}

function run_craftables_devgui() {
  setDvar("", "");
  setDvar("", "");
  setDvar("", "");
  setDvar("", "");
  while(true) {
    craftable_id = getdvarstring("");
    if(craftable_id != "") {
      a_toks = strtok(craftable_id, "");
      craftable_id = a_toks[0];
      n_player = (isDefined(a_toks[1]) ? int(a_toks[1]) : 0);
      piece_spawn = level.cheat_craftables[craftable_id].piecespawn;
      if(isDefined(piece_spawn)) {
        player = level.players[n_player];
        if(isDefined(player)) {
          player thread player_take_piece(piece_spawn);
        }
      }
      setDvar("", "");
    }
    equipment_id = getdvarstring("");
    if(equipment_id != "") {
      foreach(player in getplayers()) {
        if(zm_equipment::is_included(equipment_id)) {
          player zm_equipment::buy(equipment_id);
        }
      }
      setDvar("", "");
    }
    craftable_id = getdvarstring("", "");
    if(craftable_id != "") {
      piece_spawn = level.cheat_craftables[craftable_id].piecespawn;
      if(isDefined(piece_spawn.model)) {
        v_pos = piece_spawn.model.origin;
      } else {
        v_pos = piece_spawn.start_origin;
      }
      queryresult = positionquery_source_navigation(v_pos, 100, 200, 200, 15);
      if(queryresult.data.size) {
        point = arraygetclosest(v_pos, queryresult.data);
        level.players[0] setorigin(point.origin);
        level.players[0] setplayerangles(vectortoangles(v_pos - point.origin));
      } else {
        iprintlnbold("");
      }
      setDvar("", "");
    }
    craftable_id = getdvarstring("", "");
    if(craftable_id != "") {
      a_tables = [];
      foreach(unitrigger_stub in level.a_uts_craftables) {
        if(unitrigger_stub.equipname === craftable_id) {
          if(!isDefined(a_tables)) {
            a_tables = [];
          } else if(!isarray(a_tables)) {
            a_tables = array(a_tables);
          }
          a_tables[a_tables.size] = unitrigger_stub;
        }
      }
      if(a_tables.size) {
        v_pos = arraygetclosest(level.players[0].origin, a_tables).origin;
        queryresult = positionquery_source_navigation(v_pos, 100, 200, 200, 15);
        if(queryresult.data.size) {
          point = arraygetclosest(v_pos, queryresult.data);
          level.players[0] setorigin(point.origin);
          level.players[0] setplayerangles(vectortoangles(v_pos - point.origin));
        } else {
          iprintlnbold("");
        }
        setDvar("", "");
      }
    }
    wait(0.05);
  }
}

function add_craftable_cheat(craftable) {
  wait(0.05);
  level flag::wait_till("");
  wait(0.05);
  if(!isDefined(level.cheat_craftables)) {
    level.cheat_craftables = [];
  }
  if(isDefined(craftable.weaponname)) {
    str_cmd = ((("" + craftable.name) + "") + craftable.weaponname) + "";
    adddebugcommand(str_cmd);
  }
  if(!isDefined(craftable.a_piecestubs)) {
    return;
  }
  foreach(s_piece in craftable.a_piecestubs) {
    id_string = undefined;
    client_field_val = undefined;
    if(isDefined(s_piece.client_field_id)) {
      id_string = s_piece.client_field_id;
      client_field_val = id_string;
    } else {
      if(isDefined(s_piece.piecename)) {
        id_string = s_piece.piecename;
        client_field_val = s_piece.piecename;
      } else {
        if(isDefined(s_piece.client_field_state)) {
          id_string = "";
          client_field_val = s_piece.client_field_state;
        } else {
          continue;
        }
      }
    }
    tokens = strtok(id_string, "");
    display_string = "";
    foreach(token in tokens) {
      if(token != "" && token != "") {
        display_string = (display_string + "") + token;
      }
    }
    level.cheat_craftables["" + client_field_val] = s_piece;
    str_cmd = ((((("" + craftable.name) + "") + display_string) + "") + client_field_val) + "";
    adddebugcommand(str_cmd);
    str_cmd = ((((("" + craftable.name) + "") + display_string) + "") + client_field_val) + "";
    adddebugcommand(str_cmd);
    str_cmd = ((((("" + craftable.name) + "") + display_string) + "") + client_field_val) + "";
    adddebugcommand(str_cmd);
    str_cmd = ((((("" + craftable.name) + "") + display_string) + "") + client_field_val) + "";
    adddebugcommand(str_cmd);
    str_cmd = ((((("" + craftable.name) + "") + display_string) + "") + client_field_val) + "";
    adddebugcommand(str_cmd);
    str_cmd = ((((("" + craftable.name) + "") + display_string) + "") + s_piece.craftablename) + "";
    adddebugcommand(str_cmd);
    s_piece.waste = "";
  }
}