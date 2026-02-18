/***************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_cranked_pause.gsc
***************************************************/

#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#namespace namespace_65320816;

function private autoexec __init__system__() {
  system::register(#"hash_2209575d9ead0b63", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  zombie_utility::set_zombie_var(#"zombie_powerup_cranked_pause_on", 0, 0, 1);
  zombie_utility::set_zombie_var(#"zombie_powerup_cranked_pause_time", 10, 0, 1);
  zm_powerups::register_powerup("cranked_pause", &function_1202eaf8);

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("cranked_pause", #"p9_zm_powerup_clock", #"hash_4beb7d0e9dfb41f4", &zm_powerups::func_should_always_drop, 0, 0, 0, undefined, "powerup_cranked_pause", "zombie_powerup_cranked_pause_time", "zombie_powerup_cranked_pause_on");
    zm_vo::function_2cf4b07f(#"cranked_pause", #"hash_6f3de1197858ca4b");

    adddebugcommand("<dev string:x38>");

    adddebugcommand("<dev string:x8b>");
  }
}

function function_1202eaf8(player) {
  if(!isPlayer(player)) {
    return;
  }

  level thread function_4ee6dbc3(self, player);
}

function private function_4ee6dbc3(drop_item, player) {
  self notify("72f8f7c4edceaa36");
  self endon("72f8f7c4edceaa36");
  level endon(#"end_game");
  team = player.team;
  level thread zm_powerups::show_on_hud(team, "cranked_pause", 10);
  players = getplayers();

  foreach(e_player in players) {
    if(isDefined(e_player) && isPlayer(e_player) && isDefined(drop_item.hint)) {
      e_player zm_utility::function_846eb7dd(#"hash_1d757d99eb407952", drop_item.hint);
    }
  }

  level flag::set("cranked_pause");
  playsoundatposition(#"hash_6add4f54cc6f196a", (0, 0, 0));
  wait 10;
  level flag::clear("cranked_pause");
  playsoundatposition(#"hash_54a9a9f2c8be8a9d", (0, 0, 0));
}