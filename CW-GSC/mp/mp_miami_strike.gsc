/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_miami_strike.gsc
***********************************************/

#using script_44b0b8420eabacad;
#using script_67ce8e728d8f37ba;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\oob;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#namespace mp_miami_strike;

function event_handler[level_init] main(eventstruct) {
  trigger = spawn("trigger_radius_out_of_bounds", (-5027, -2711, 60), 0, 330, 100);
  trigger thread oob::run_oob_trigger();
  clientfield::register("scriptmover", "neon_rob", 1, 1, "counter");
  callback::on_end_game(&on_end_game);
  killstreaks::function_257a5f13("straferun", 40);
  killstreaks::function_257a5f13("helicopter_comlink", 75);
  level.missileremotelaunchvert = 10000;
  load::main();
  compass::setupminimap("");
  level thread function_f92fe90c();
  level thread function_3fbfa2de();
}

function function_24198689() {
  var_780f74b5 = [];
  var_780f74b5[var_780f74b5.size] = "mp_spawn_point";
  var_780f74b5[var_780f74b5.size] = "mp_spawn_point_axis";
  var_780f74b5[var_780f74b5.size] = "mp_spawn_point_allies";
  spawning::move_spawn_point(var_780f74b5, (-5509.5, -767.549, -8.375), (-1211.33, -2559.36, 1.06126), (0, 158.654, 0));
  spawning::move_spawn_point(var_780f74b5, (-5508.32, -836.822, -8.375), (-1202.32, -2486.35, -1.99246), (0, 158.983, 0));
  spawning::move_spawn_point(var_780f74b5, (-5506.7, -902.819, -8.375), (-1202.32, -2417.14, 0), (0, 165.256, 0));
  spawning::move_spawn_point(var_780f74b5, (-5505.14, -965.254, -8.375), (-1193.67, -2335.03, 0), (0, 168.448, 0));
}

function function_f92fe90c() {
  level endon(#"game_ended");
  level flag::wait_till("first_player_spawned");
  waitframe(1);
  var_2555a1ec = getEntArray("neon_rob_sign", "targetname");
  var_2555a1ec = array::sort_by_script_int(var_2555a1ec, 1);
  level thread function_7858899c(var_2555a1ec);
}

function function_7858899c(var_37473ebc) {
  level endon(#"game_ended");

  while(!isDefined(level.var_58bc5d04)) {
    wait 1;
  }

  while(true) {
    foreach(sign in var_37473ebc) {
      if(!isDefined(sign)) {
        continue;
      }

      sign clientfield::increment("neon_rob", 1);
      wait 0.5;

      if(!isDefined(sign)) {
        continue;
      }

      sign clientfield::increment("neon_rob", 1);
    }

    wait 1;
  }
}

function function_3fbfa2de() {
  diving_board_trig = getent("diving_board_trig", "targetname");

  if(isDefined(diving_board_trig)) {
    diving_board_trig callback::on_trigger(&function_2e1e9186);
  }
}

function function_2e1e9186(info) {
  player = info.activator;
  trigger = self;

  if(isPlayer(player) && isDefined(trigger) && !is_true(trigger.var_7033e9)) {
    trigger.var_7033e9 = 1;
    self playSound("amb_diving_board");

    while(isPlayer(player) && isDefined(trigger) && player istouching(trigger)) {
      waitframe(1);
    }

    if(isDefined(trigger)) {
      trigger.var_7033e9 = 0;
    }
  }
}

function on_end_game() {}