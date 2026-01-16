/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_talisman.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\match_record;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm_common\util;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_stats;

#namespace zm_talisman;

init() {
  callback::on_connect(&on_player_connect);
  callback::on_disconnect(&on_player_disconnect);
}

on_player_connect() {
  var_e18c5d7 = self zm_loadout::get_loadout_item("talisman1");
  s_talisman = getunlockableiteminfofromindex(var_e18c5d7, 4);
  var_ea4558f5 = function_b143666d(var_e18c5d7, 4);
  n_remaining = 0;

  if(isDefined(s_talisman)) {
    if(!isDefined(var_ea4558f5.talismanrarity)) {
      var_ea4558f5.talismanrarity = 0;
    }

    s_talisman.rarity = var_ea4558f5.talismanrarity;
    n_remaining = self function_bd6a3188(s_talisman.namehash);
  }

  var_88049519 = 0;

  if(isDefined(s_talisman) && zm_custom::function_ff4557dc(s_talisman) && n_remaining > 0) {
    str_talisman = s_talisman.namehash;

    if(isDefined(level.var_e1074d3e[str_talisman])) {
      if(isDefined(level.var_e1074d3e[str_talisman].activate_talisman) && !(isDefined(level.var_e1074d3e[str_talisman].is_activated[self.clientid]) && level.var_e1074d3e[str_talisman].is_activated[self.clientid])) {
        self thread function_954b9083(str_talisman);
        self thread[[level.var_e1074d3e[str_talisman].activate_talisman]]();
        level.var_e1074d3e[str_talisman].is_activated[self.clientid] = 1;
        self recordmapevent(30, gettime(), self.origin, level.round_number, s_talisman.var_2f8e25b8, isDefined(self.health) ? self.health : 0);
        var_88049519 = 1;
      }
    }
  } else if(isDefined(s_talisman)) {
    if(n_remaining > 0) {
      self thread zm_custom::function_2717f4b3();
    } else {
      self match_record::set_player_stat("boas_no_talisman", 1);
    }
  }

  self clientfield::set_player_uimodel("ZMInvTalisman.show", var_88049519 ? 1 : 0);
}

on_player_disconnect() {
  if(!isDefined(self.clientid)) {
    return;
  }

  var_e18c5d7 = self zm_loadout::get_loadout_item("talisman1");
  s_talisman = getunlockableiteminfofromindex(var_e18c5d7, 4);
  var_ea4558f5 = function_b143666d(var_e18c5d7, 4);

  if(isDefined(s_talisman)) {
    str_talisman = s_talisman.namehash;

    if(isDefined(level.var_e1074d3e[str_talisman])) {
      if(isDefined(level.var_e1074d3e[str_talisman].activate_talisman) && isDefined(level.var_e1074d3e[str_talisman].is_activated[self.clientid]) && level.var_e1074d3e[str_talisman].is_activated[self.clientid]) {
        level.var_e1074d3e[str_talisman].is_activated[self.clientid] = 0;
      }
    }
  }
}

register_talisman(str_talisman, activate_talisman) {
  assert(isDefined(str_talisman), "<dev string:x38>");
  assert(isDefined(activate_talisman), "<dev string:x75>");

  if(!isDefined(level.var_e1074d3e)) {
    level.var_e1074d3e = [];
  }

  if(!isDefined(level.var_e1074d3e[str_talisman])) {
    level.var_e1074d3e[str_talisman] = spawnStruct();
    level.var_e1074d3e[str_talisman].activate_talisman = activate_talisman;
    level.var_e1074d3e[str_talisman].is_activated = array();
  }
}

private function_954b9083(str_talisman) {
  level endon(#"game_ended");
  self endon(#"disconnect");
  level waittill(#"start_zombie_round_logic");
  wait getdvarint(#"hash_4e0eefe07702cb87", 60);
  self stats::inc_stat(#"talisman_stats", str_talisman, #"used", #"statvalue", 1);
  self zm_stats::increment_challenge_stat(#"talisman_used");
  self reportlootconsume(str_talisman, 1);
}