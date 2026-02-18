/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_miami.gsc
***********************************************/

#using script_67ce8e728d8f37ba;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#namespace mp_miami;

function event_handler[level_init] main(eventstruct) {
  clientfield::register("scriptmover", "neon_rob", 1, 1, "counter");
  namespace_66d6aa44::function_3f3466c9();
  callback::on_end_game(&on_end_game);
  scene::function_497689f6(#"cin_mp_miami_intro_cia", "intro_kgb_van", "tag_probe_attach", "probe_miami_van_igc");
  killstreaks::function_257a5f13("straferun", 40);
  killstreaks::function_257a5f13("helicopter_comlink", 75);
  level.missileremotelaunchvert = 10000;
  load::main();
  compass::setupminimap("");
  level thread function_f92fe90c();
  level thread function_3fbfa2de();
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