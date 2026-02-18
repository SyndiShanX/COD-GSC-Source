/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1e13c013927b6692.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;
#namespace namespace_fa39a5c3;

function private autoexec __init__system__() {
  system::register(#"hash_5a3be2f74ac4fe03", &preinit, undefined, undefined, undefined);
}

function preinit() {
  clientfield::register("toplayer", "" + # "hash_69dc133e22a2769f", 16000, 1, "int");
  level.var_5bfd847e = # "power_fasttravel";
  level.var_e9737821 = &function_c52e8ba;
  level.var_352c9e03 = &function_af65fe93;
  level.var_91171ae5 = &function_54a36ee5;
  level flag::set(#"hash_7735f4e5fdb1382b");
  callback::on_spawned(&on_player_spawned);
  level thread function_d467cf16();
}

function on_player_spawned() {
  if(is_true(self.is_hotjoining) || self util::is_spectating()) {
    return;
  }

  self thread function_bce9fcbe();
}

function function_d467cf16() {
  level waittill(#"all_players_spawned");
  level flag::set(#"power_fasttravel");
}

function function_c52e8ba(player, var_8d5d092c) {
  b_result = 0;

  if(!isDefined(self.hint_string)) {
    self.hint_string = [];
  }

  n_player_index = player getentitynumber();

  if(!self zm_fasttravel::function_d06e636b(player) || player isswitchingweapons() || level flag::get(#"hash_49e515cdcf4bb8db")) {
    self.hint_string[n_player_index] = # "";
  } else if(isDefined(self.stub.var_a92d1b24) && !level flag::get_all(self.stub.var_a92d1b24)) {
    switch (self.stub.script_string) {
      case # "village":
      case # "firebase":
        self.hint_string[n_player_index] = # "zombie/fasttravel_locked";
        break;
      default:
        break;
    }

    b_result = 1;
  } else if(is_true(player.var_9c7b96ed[var_8d5d092c])) {
    switch (self.stub.script_string) {
      case # "village":
        self.hint_string[n_player_index] = # "hash_1b9857d1769d3430";
        b_result = 1;
        break;
      case # "firebase":
        self.hint_string[n_player_index] = # "hash_6357eb67494da1b";
        b_result = 1;
        break;
    }
  } else if(isDefined(self.stub.delay) && !self.stub flag::get("delayed")) {
    switch (self.stub.script_string) {
      case # "village":
        self.hint_string[n_player_index] = # "hash_1b9857d1769d3430";
        b_result = 1;
        break;
      case # "firebase":
        self.hint_string[n_player_index] = # "hash_6357eb67494da1b";
        b_result = 1;
        break;
    }
  } else {
    switch (self.stub.script_string) {
      case # "village":
        if(level flag::get(#"hash_7752d012501cd222") || level flag::get(#"hash_7735f4e5fdb1382b")) {
          self.hint_string[n_player_index] = # "hash_1155071b36db5cc4";
        } else {
          self.hint_string[n_player_index] = # "hash_661484e87df6401d";

          if(!player zm_score::can_player_purchase(self.stub.zombie_cost)) {
            player globallogic::function_d1924f29(#"hash_6e3ae7967dc5d414");
          }
        }

        break;
      case # "firebase":
        if(level flag::get(#"hash_7752d012501cd222") || level flag::get(#"hash_7735f4e5fdb1382b")) {
          self.hint_string[n_player_index] = # "hash_6da21d98bf10aee5";
        } else {
          self.hint_string[n_player_index] = # "hash_3bd7d7def4239ab6";

          if(!player zm_score::can_player_purchase(self.stub.zombie_cost)) {
            player globallogic::function_d1924f29(#"hash_6e3ae7967dc5d414");
          }
        }

        break;
    }

    b_result = 1;
  }

  return b_result;
}

function function_af65fe93(t_teleporter) {
  if(!isPlayer(self) || !isDefined(t_teleporter)) {
    return;
  }

  str_loc = t_teleporter.stub.script_string;
  s_loc = struct::get(str_loc + "_end_" + zm_fasttravel::get_player_index(self));
  self util::create_streamer_hint(s_loc.origin, s_loc.angles, 1);
  self util::delay("fasttravel_over", "disconnect", &util::clear_streamer_hint);
}

function function_54a36ee5(e_unitrigger) {
  if(level flag::get(#"hash_7752d012501cd222") || level flag::get(#"hash_7735f4e5fdb1382b")) {
    n_cost = 0;
  } else if(isDefined(e_unitrigger.stub)) {
    n_cost = e_unitrigger.stub.zombie_cost;
  } else {
    n_cost = e_unitrigger.zombie_cost;
  }

  return n_cost;
}

function function_bce9fcbe() {
  level endon(#"end_game");
  self endon(#"disconnect", #"death");

  while(true) {
    var_e8178f0 = self zm_zonemgr::is_player_in_zone(["zone_portal_transfer", "zone_firebase2", "zone_firebase3"]);
    self clientfield::set_to_player("" + # "hash_69dc133e22a2769f", var_e8178f0);
    self waittill(#"zone_change");
  }
}