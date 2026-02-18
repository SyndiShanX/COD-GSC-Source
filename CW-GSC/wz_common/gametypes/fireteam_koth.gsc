/*************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\gametypes\fireteam_koth.gsc
*************************************************/

#using script_1435f3c9fc699e04;
#using script_335d0650ed05d36d;
#using script_46192c58ea066d7f;
#using script_50d0f08de978328d;
#using script_b9a55edd207e4ca;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic_score;
#namespace fireteam_koth;

function private autoexec __init__system__() {
  system::register(#"hash_4fa9618bfd8085ac", &function_62730899, undefined, undefined, #"territory");
}

function event_handler[gametype_init] main(eventstruct) {
  level.var_71f9a7ea = # "hash_7ef67720e2eb965a";
  level.var_84a07819 = &onstartgametype;
  namespace_2938acdc::init();
  namespace_d150537f::init();
  namespace_234f0efc::init();
  spawning::addsupportedspawnpointtype("tdm");
  level.var_5747998d = # "insertion_begin_completed";
  level.var_bc5a3eed = 1;
  callback::on_player_killed(&on_player_killed);
  level.var_ce6749e3 = 1;
  clientfield::register_clientuimodel("hud_items_fireteam_percontroller.waypoint_friendly_count_0", 20000, 3, "int");
  clientfield::register_clientuimodel("hud_items_fireteam_percontroller.waypoint_friendly_count_1", 20000, 3, "int");
  clientfield::register_clientuimodel("hud_items_fireteam_percontroller.waypoint_friendly_count_2", 20000, 3, "int");
  clientfield::register_clientuimodel("hud_items_fireteam_percontroller.waypoint_enemy_count_0", 20000, 3, "int");
  clientfield::register_clientuimodel("hud_items_fireteam_percontroller.waypoint_enemy_count_1", 20000, 3, "int");
  clientfield::register_clientuimodel("hud_items_fireteam_percontroller.waypoint_enemy_count_2", 20000, 3, "int");
  level.var_b9f31e66 = isDefined(getgametypesetting(#"hash_3eeecb0a77c21db1")) ? getgametypesetting(#"hash_3eeecb0a77c21db1") : 100;
  level.var_8c05a764 = isDefined(getgametypesetting(#"hash_2e824e2ee213574d")) ? getgametypesetting(#"hash_2e824e2ee213574d") : 10;
  level.var_89a6bd00 = isDefined(getgametypesetting(#"hash_7b5af9a43263b4a9")) ? getgametypesetting(#"hash_7b5af9a43263b4a9") : 15;
  level.var_65a0fe4d = isDefined(getgametypesetting(#"hash_7b3feba4324cd527")) ? getgametypesetting(#"hash_7b3feba4324cd527") : 30;
  level thread namespace_234f0efc::function_8d066de9(level.var_b9f31e66, level.var_89a6bd00, level.var_65a0fe4d, level.var_8c05a764);
  level.var_574cc797 = &namespace_234f0efc::function_588a586d;
}

function on_player_killed(params) {
  if(params.eattacker util::isenemyplayer(self)) {
    if(isDefined(params.eattacker namespace_d150537f::function_2ff26e21()) || isDefined(self namespace_d150537f::function_2ff26e21())) {
      params.eattacker globallogic_score::giveteamscoreforobjective(params.eattacker.team, level.var_ce6749e3);
    }
  }

  self namespace_234f0efc::drop_all_items();
}

function onstartgametype() {
  for(i = 0; i < level.zones.size; i++) {
    level.zones[i].var_e00488aa = i % 3;
  }

  level thread function_ee028271();
}

function function_ee028271() {
  level endon(#"game_ended");
  level.var_7a88cb07 = [];

  while(true) {
    waitframe(1);

    foreach(zone in level.active_zones) {
      if(isDefined(zone.gameobject.objectiveid)) {
        objective_setgamemodeflags(zone.gameobject.objectiveid, zone.var_e00488aa + 1);
      }

      foreach(team in level.teams) {
        if(!isDefined(level.var_7a88cb07)) {
          level.var_7a88cb07 = [];
        }

        level.var_7a88cb07[team][zone.var_e00488aa] = zone.gameobject gameobjects::get_num_touching(team);
      }
    }

    foreach(team in level.teams) {
      var_c4576842 = [];

      for(i = 0; i < 3; i++) {
        var_c4576842[i] = 0;
      }

      foreach(enemyteam, enemyplayers in level.var_7a88cb07) {
        if(enemyteam == team) {
          continue;
        }

        for(i = 0; i < level.var_7a88cb07[enemyteam].size; i++) {
          var_c4576842[i] += level.var_7a88cb07[enemyteam][i];
        }
      }

      teamplayers = getplayers(team);

      foreach(player in teamplayers) {
        player clientfield::set_player_uimodel("hud_items_fireteam_percontroller.waypoint_friendly_count_0", isDefined(level.var_7a88cb07[team][2]) ? level.var_7a88cb07[team][2] : 0);
        player clientfield::set_player_uimodel("hud_items_fireteam_percontroller.waypoint_friendly_count_1", isDefined(level.var_7a88cb07[team][0]) ? level.var_7a88cb07[team][0] : 0);
        player clientfield::set_player_uimodel("hud_items_fireteam_percontroller.waypoint_friendly_count_2", isDefined(level.var_7a88cb07[team][1]) ? level.var_7a88cb07[team][1] : 0);
        player clientfield::set_player_uimodel("hud_items_fireteam_percontroller.waypoint_enemy_count_0", isDefined(var_c4576842[2]) ? var_c4576842[2] : 0);
        player clientfield::set_player_uimodel("hud_items_fireteam_percontroller.waypoint_enemy_count_1", isDefined(var_c4576842[0]) ? var_c4576842[0] : 0);
        player clientfield::set_player_uimodel("hud_items_fireteam_percontroller.waypoint_enemy_count_2", isDefined(var_c4576842[1]) ? var_c4576842[1] : 0);
      }
    }
  }
}

function private function_62730899() {
  if(isDefined(level.territory) && level.territory.name != "zoo") {
    namespace_2938acdc::function_4212369d();
    namespace_2938acdc::function_20d09030();
  }
}