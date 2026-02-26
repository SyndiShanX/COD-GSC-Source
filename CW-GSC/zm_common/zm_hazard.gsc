/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_hazard.gsc
***********************************************/

#using script_36f4be19da8eb6d0;
#using scripts\core_common\ai\zombie_eye_glow;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_aoe;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_utility;
#namespace zm_hazard;

function init() {
  if(is_true(level.var_9377a535)) {
    return;
  }

  level.var_9377a535 = 1;

  if(!isDefined(level.var_95198344)) {
    level.var_95198344 = [];
  }

  callback::on_spawned(&on_player_spawned);

  level thread function_b5cd0ae5();
}

function function_6b39d9c5(count) {
  spawnpoints = struct::get_array("radiation_hazard", "targetname");
  spawnpoints = array::randomize(spawnpoints);
  var_baa683fe = arraycopy(level.var_95198344);
  var_3d3c8738 = [];

  foreach(point in spawnpoints) {
    if(!isinarray(var_baa683fe, point) && zm_utility::check_point_in_enabled_zone(point.origin) && zm_utility::check_point_in_playable_area(point.origin)) {
      a_e_players = function_a1ef346b(undefined, point.origin, 275);
      var_68298325 = 0;

      foreach(e_player in a_e_players) {
        if(!e_player laststand::player_is_in_laststand()) {
          var_68298325 = 1;
          break;
        }
      }

      if(var_68298325) {
        continue;
      }

      if(var_baa683fe.size > 0) {
        foreach(var_10e462a8 in var_baa683fe) {
          if(distancesquared(point.origin, var_10e462a8.origin) >= 250000) {
            if(!isDefined(var_3d3c8738)) {
              var_3d3c8738 = [];
            } else if(!isarray(var_3d3c8738)) {
              var_3d3c8738 = array(var_3d3c8738);
            }

            var_3d3c8738[var_3d3c8738.size] = point;

            if(!isDefined(var_baa683fe)) {
              var_baa683fe = [];
            } else if(!isarray(var_baa683fe)) {
              var_baa683fe = array(var_baa683fe);
            }

            var_baa683fe[var_baa683fe.size] = point;
            break;
          }
        }
      } else {
        if(!isDefined(var_3d3c8738)) {
          var_3d3c8738 = [];
        } else if(!isarray(var_3d3c8738)) {
          var_3d3c8738 = array(var_3d3c8738);
        }

        var_3d3c8738[var_3d3c8738.size] = point;

        if(!isDefined(var_baa683fe)) {
          var_baa683fe = [];
        } else if(!isarray(var_baa683fe)) {
          var_baa683fe = array(var_baa683fe);
        }

        var_baa683fe[var_baa683fe.size] = point;
      }

      if(var_3d3c8738.size >= count) {
        break;
      }
    }
  }

  foreach(point in var_3d3c8738) {
    level thread function_47187ffc(point);
  }
}

function function_47187ffc(point) {
  zm_aoe::function_371b4147(1, "zm_aoe_radiation_hazard", point.origin, point, &function_b8a8955, &function_252d8295);

  if(!isDefined(level.var_95198344)) {
    level.var_95198344 = [];
  } else if(!isarray(level.var_95198344)) {
    level.var_95198344 = array(level.var_95198344);
  }

  level.var_95198344[level.var_95198344.size] = point;
}

function on_player_spawned() {
  self thread function_1c2829b5();
}

function private function_1c2829b5() {
  self endon(#"death");

  while(true) {
    s_waitresult = self waittill(#"aoe_damage");

    if(s_waitresult.str_source == "zm_aoe_radiation_hazard") {
      self status_effect::status_effect_apply(getstatuseffect(#"hash_48bb9c4c96e64c3d"), undefined, self);
    }
  }
}

function private function_6fa1e587() {
  self endon(#"hash_3913004963ca6fe4");
  self.trigger_damage = spawn("trigger_damage", self.position + (0, 0, 30), 4194304, 75, 175);
  self.trigger_damage.owner = self;
  self.trigger_damage.health = 99999;
  self.trigger_damage.var_22cea3da = &function_4685c5f8;
  self.trigger_damage endon(#"death");

  while(true) {
    s_result = self.trigger_damage waittill(#"damage");

    if(isPlayer(s_result.attacker)) {
      if(isDefined(s_result.weapon) && namespace_b376a999::function_5fef4201(s_result.weapon)) {
        level notify(#"hash_4a62d4959b0dbb0e", {
          #e_player: s_result.attacker
        });

        if(namespace_b376a999::function_7c292369(s_result.weapon)) {
          zm_aoe::function_389bf7bf(self, 1);
          println("<dev string:x38>");
          s_result.attacker notify(#"hash_7f30d2acb25cc4d9");
          return;
        }
      }
    }
  }
}

function function_4685c5f8(attacker, time) {
  if(time >= 4000) {
    if(isDefined(self.owner)) {
      zm_aoe::function_389bf7bf(self.owner, 1);
      println("<dev string:x6b>");
      attacker notify(#"hash_7f30d2acb25cc4d9");
    }
  }
}

function function_b8a8955(aoe) {
  aoe thread function_6fa1e587();
}

function function_252d8295(aoe) {
  if(isDefined(aoe.userdata)) {
    arrayremovevalue(level.var_95198344, aoe.userdata);
  }

  if(isDefined(aoe.trigger_damage)) {
    aoe.trigger_damage delete();
  }
}

function function_9e3de60() {
  level.var_95198344 = [];
  zm_aoe::function_3690781e();
}

function function_b5cd0ae5() {
  adddebugcommand("<dev string:x9b>");
  adddebugcommand("<dev string:xf4>");
  level flag::wait_till("<dev string:x150>");
  zm_devgui::add_custom_devgui_callback(&function_2499fe1b);
}

function function_eccc5dbd() {
  player = getplayers()[0];
  v_direction = player getplayerangles();
  v_direction = anglesToForward(v_direction) * 500;
  eye = player getEye();
  trace = bulletTrace(eye, eye + v_direction, 0, undefined);
  var_770ed480 = positionquery_source_navigation(trace[#"position"], 64, 256, 512, 20);
  spot = spawn("<dev string:x16c>", player.origin);
  spot setModel("<dev string:x17c>");

  if(isDefined(var_770ed480) && var_770ed480.data.size > 0) {
    spot.origin = var_770ed480.data[0].origin;
  }

  println("<dev string:x18a>" + spot.origin);
  level thread function_47187ffc(spot);
}

function function_2499fe1b(cmd) {
  switch (cmd) {
    case # "hash_1a5bda29acd157fd":
      function_eccc5dbd();
      break;
    case # "hash_55c4e53689e598c3":
      function_9e3de60();
      level notify(#"hash_7e539f4178c9c27c");
      break;
    default:
      break;
  }
}