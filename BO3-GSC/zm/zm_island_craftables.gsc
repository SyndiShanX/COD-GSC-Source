/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_craftables.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\craftables\_zm_craftables;
#using scripts\zm\zm_island;
#using scripts\zm\zm_island_main_ee_quest;
#using scripts\zm\zm_island_pap_quest;
#namespace zm_island_craftables;

function include_craftables() {
  level.craftable_piece_swap_allowed = 0;
  shared_pieces = getnumexpectedplayers() == 1;
  craftable_name = "gasmask";
  var_a2709918 = zm_craftables::generate_zombie_craftable_piece(craftable_name, "part_visor", 32, 64, 0, undefined, & function_aef4c63, undefined, & function_3e3b2e02, undefined, undefined, undefined, ("gasmask" + "_") + "part_visor", 1, undefined, undefined, & "ZOMBIE_BUILD_PIECE_GRAB", 0);
  var_f113dd3d = zm_craftables::generate_zombie_craftable_piece(craftable_name, "part_filter", 32, 64, 0, undefined, & function_aef4c63, undefined, & function_3e3b2e02, undefined, undefined, undefined, ("gasmask" + "_") + "part_filter", 1, undefined, undefined, & "ZOMBIE_BUILD_PIECE_GRAB", 0);
  var_c4ee7b63 = zm_craftables::generate_zombie_craftable_piece(craftable_name, "part_strap", 32, 64, 0, undefined, & function_aef4c63, undefined, & function_3e3b2e02, undefined, undefined, undefined, ("gasmask" + "_") + "part_strap", 1, undefined, undefined, & "ZOMBIE_BUILD_PIECE_GRAB", 0);
  var_a2709918.client_field_state = undefined;
  var_f113dd3d.client_field_state = undefined;
  var_c4ee7b63.client_field_state = undefined;
  gasmask = spawnStruct();
  gasmask.name = craftable_name;
  gasmask zm_craftables::add_craftable_piece(var_a2709918);
  gasmask zm_craftables::add_craftable_piece(var_f113dd3d);
  gasmask zm_craftables::add_craftable_piece(var_c4ee7b63);
  gasmask.triggerthink = & function_d2d29a1b;
  gasmask.no_challenge_stat = 1;
  zm_craftables::include_zombie_craftable(gasmask);
  level flag::init(((craftable_name + "_") + "part_visor") + "_found");
  level flag::init(((craftable_name + "_") + "part_filter") + "_found");
  level flag::init(((craftable_name + "_") + "part_strap") + "_found");
}

function init_craftables() {
  register_clientfields();
  zm_craftables::add_zombie_craftable("gasmask", & "ZM_ISLAND_CRAFT_GASMASK", "", & "ZM_ISLAND_TOOK_GASMASK", & function_4e02c665, 1);
  zm_craftables::make_zombie_craftable_open("gasmask", "", vectorscale((0, -1, 0), 90), (0, 0, 0));
}

function register_clientfields() {
  shared_bits = 1;
  registerclientfield("world", ("gasmask" + "_") + "part_visor", 9000, shared_bits, "int", undefined, 0);
  registerclientfield("world", ("gasmask" + "_") + "part_filter", 9000, shared_bits, "int", undefined, 0);
  registerclientfield("world", ("gasmask" + "_") + "part_strap", 9000, shared_bits, "int", undefined, 0);
  clientfield::register("toplayer", "ZMUI_GRAVITYSPIKE_PART_PICKUP", 9000, 1, "int");
  clientfield::register("toplayer", "ZMUI_GRAVITYSPIKE_CRAFTED", 9000, 1, "int");
}

function ondrop_common(player) {
  self.piece_owner = undefined;
}

function onpickup_common(player) {
  player thread function_9708cb71(self.piecename);
  self.piece_owner = player;
}

function function_9708cb71(piecename) {
  var_983a0e9b = "zmb_craftable_pickup";
  switch (piecename) {
    default: {
      var_983a0e9b = "zmb_craftable_pickup";
      break;
    }
  }
  self playSound(var_983a0e9b);
}

function show_infotext_for_duration(str_infotext, n_duration) {
  self clientfield::set_to_player(str_infotext, 1);
  wait(n_duration);
  self clientfield::set_to_player(str_infotext, 0);
}

function function_aef4c63(player) {
  str_piece = (self.craftablename + "_") + self.piecename;
  level flag::set(str_piece + "_found");
  player thread function_9708cb71(self.piecename);
  player notify("player_got_gasmask_part");
  level thread function_f34bd805(str_piece);
}

function function_f34bd805(str_piece) {
  a_players = [];
  if(self == level) {
    a_players = level.players;
  } else {
    if(isplayer(self)) {
      a_players = array(self);
    } else {
      return;
    }
  }
  switch (str_piece) {
    case "gasmask_part_visor": {
      foreach(player in a_players) {
        player thread clientfield::set_to_player("gaskmask_part_visor", 1);
        player thread zm_craftables::player_show_craftable_parts_ui("zmInventory.gaskmask_part_visor", "zmInventory.widget_gasmask_parts", 0);
      }
      break;
    }
    case "gasmask_part_strap": {
      foreach(player in a_players) {
        player thread clientfield::set_to_player("gaskmask_part_strap", 1);
        player thread zm_craftables::player_show_craftable_parts_ui("zmInventory.gaskmask_part_strap", "zmInventory.widget_gasmask_parts", 0);
      }
      break;
    }
    case "gasmask_part_filter": {
      foreach(player in a_players) {
        player thread clientfield::set_to_player("gaskmask_part_filter", 1);
        player thread zm_craftables::player_show_craftable_parts_ui("zmInventory.gaskmask_part_filter", "zmInventory.widget_gasmask_parts", 0);
      }
      break;
    }
  }
}

function function_3e3b2e02(player) {
  iprintlnbold(((self.craftablename + "_") + self.piecename) + "_crafted");
}

function function_4e02c665(player) {
  function_aa4f440c(self.origin, self.angles);
  var_6796a7a4 = getent("mask_display", "targetname");
  var_6796a7a4 setscale(1.5);
  var_6796a7a4 moveto((self.origin + anglesToForward(self.angles)) + (-5, 0, -105), 0.05);
  var_6796a7a4 rotateto(self.angles + vectorscale((0, 1, 0), 90), 0.05);
  var_6796a7a4 waittill("movedone");
  return true;
}

function function_aa4f440c(v_origin, v_angles) {
  width = 128;
  height = 128;
  length = 128;
  unitrigger_stub = spawnStruct();
  unitrigger_stub.origin = v_origin;
  unitrigger_stub.angles = v_angles;
  unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
  unitrigger_stub.cursor_hint = "HINT_NOICON";
  unitrigger_stub.script_width = width;
  unitrigger_stub.script_height = height;
  unitrigger_stub.script_length = length;
  unitrigger_stub.require_look_at = 1;
  unitrigger_stub.prompt_and_visibility_func = & function_dbc8e9c0;
  zm_unitrigger::register_static_unitrigger(unitrigger_stub, & function_272fcc74);
}

function function_dbc8e9c0(player) {
  if(!player.var_df4182b1) {
    self sethintstring(&"ZM_ISLAND_GASMASK_PICKUP");
  } else {
    self sethintstring(&"ZOMBIE_BUILD_PIECE_HAVE_ONE");
  }
  return true;
}

function function_272fcc74() {
  while(true) {
    self waittill("trigger", player);
    if(player zm_utility::in_revive_trigger()) {
      continue;
    }
    if(player.is_drinking > 0) {
      continue;
    }
    if(!zm_utility::is_player_valid(player)) {
      continue;
    }
    if(!player.var_df4182b1) {
      level thread function_b4c30297(self.stub, player);
    }
    break;
  }
}

function function_b4c30297(trig_stub, player) {
  player.var_df4182b1 = 1;
  player notify("player_has_gasmask");
}

function init_craftable_choke() {
  level.craftables_spawned_this_frame = 0;
  while(true) {
    util::wait_network_frame();
    level.craftables_spawned_this_frame = 0;
  }
}

function craftable_wait_your_turn() {
  if(!isDefined(level.craftables_spawned_this_frame)) {
    level thread init_craftable_choke();
  }
  while(level.craftables_spawned_this_frame >= 2) {
    util::wait_network_frame();
  }
  level.craftables_spawned_this_frame++;
}

function function_d2d29a1b() {
  craftable_wait_your_turn();
  zm_craftables::craftable_trigger_think("gasmask_zm_craftable_trigger", "gasmask", "gasmask", "", 1, 0);
}

function in_game_map_quest_item_picked_up(str_partname) {}

function in_game_map_quest_item_dropped(str_partname) {}