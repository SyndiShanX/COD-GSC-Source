/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\tutorial\br_tut_ui.gsc
***********************************************/

function hud_message_wait_duration(var_0, var_1) {
  level.player sethudtutorialmessage(var_0);
  wait var_1;
  level.player clearhudtutorialmessage();
}

function hud_message_wait_notify(var_0, var_1) {
  level.player sethudtutorialmessage(var_0);
  self waittill(var_1);
  level.player clearhudtutorialmessage();
}

function process_vo_queue(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "dx_bra_uktl_";
  }

  if(!isDefined(var_1)) {
    var_1 = 10;
  }

  level.ref_14304 = [];
  level.ref_14303 = var_0;
  level.ref_14308 = var_1;

  for(;;) {
    if(level.ref_14304.size) {
      var_2 = [];

      foreach(var_4 in level.ref_14304) {
        ref_1243A(var_4);
        var_2 = var_4;
      }

      level.ref_14304 = scripts\engine\utility::array_remove_array(level.ref_14304, var_2);
    }

    waitframe();
  }
}

function ref_1243A(var_0) {
  if(isDefined(self.watch_for_players_touching_ground)) {
    while(player_is_shooting()) {
      waitframe();
    }
  }

  self playSound(var_0);
  wait lookupsoundlength(var_0) / 1000;
  self notify(var_0);
}

function player_is_shooting() {
  return gettime() - self.watch_for_players_touching_ground < 400;
}

function ref_143A2() {
  while(level.ref_14304.size) {
    wait 0.1;
  }
}

function vo_queue_is_empty() {
  return !level.ref_14304.size;
}

function create_nag_array(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = level.ref_14308;
  }

  var_3 = [];

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_5 = var_0 + var_2;
    var_3 = var_5;
    var_2 += level.ref_14308;
  }

  return var_3;
}

function nags_til_flag(var_0, var_1, var_2) {
  self endon(var_1);

  if(!isDefined(var_2)) {
    var_2 = 10;
  }

  var_3 = 1;

  for(;;) {
    foreach(var_5 in var_0) {
      if(!var_3) {
        wait var_2;
      }

      var_3 = 0;

      if(scripts\engine\utility::flag_exist(var_1) && scripts\engine\utility::flag(var_1)) {
        return;
      }

      play_till_complete(var_5);
    }
  }
}

function nags_explicit_til_flag(var_0, var_1, var_2) {
  self endon(var_1);
  jumpiftrue(isDefined(var_2)) LOC_00000010;
  var_2 = 10;

  for(;;) {
    foreach(var_4 in var_0) {
      play_explicit_till_complete(var_4);
      wait var_2;
    }

    waitframe();
  }
}

function start_nagging_internal(var_0, var_1, var_2) {
  self endon("NAG_STOP");

  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 10;
  }

  if(!isDefined(var_2)) {
    var_2 = 10;
  }

  wait var_2;
  thread nags_explicit_til_flag(var_0, "NAG_STOP", var_1);
}

function start_nagging(var_0, var_1, var_2) {
  stop_nagging();
  waitframe();
  thread start_nagging_internal(level.player, var_0, var_1);
}

function stop_nagging() {
  level.player notify("NAG_STOP");
}

function add_to_vo_queue(var_0) {
  level.ref_14304[level.ref_14304.size] = level.ref_14303 + var_0;
}

function add_alias_array_to_queue(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0.3;
  }

  foreach(var_3 in var_0) {
    add_to_vo_queue(var_3);
  }
}

function add_explicit_to_vo_queue(var_0) {
  level.ref_14304[level.ref_14304.size] = var_0;
}

function add_explicit_array_to_vo_queue(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0.3;
  }

  foreach(var_3 in var_0) {
    add_explicit_to_vo_queue(var_3);
  }
}

function ref_143EC(var_0) {
  while(scripts\engine\utility::array_contains(level.ref_14304, level.ref_14303 + var_0)) {
    waitframe();
  }
}

function waittill_explicit_vo_plays(var_0) {
  while(scripts\engine\utility::array_contains(level.ref_14304, var_0)) {
    waitframe();
  }
}

function play_till_complete(var_0) {
  add_to_vo_queue(var_0);
  self waittill(level.ref_14303 + var_0);
}

function play_explicit_till_complete(var_0) {
  add_explicit_to_vo_queue(var_0);
  self waittill(var_0);
}

function bot_speaks(var_0, var_1, var_2) {
  var_3 = level.bots["players"][var_0];
  var_4 = var_1 + var_3.operatorcustomization.voice + "_" + var_2;
  var_3 playSound(var_4);
}

function infil_sfx() {
  level.player setclienttriggeraudiozone("donetsk_ext_ac130_infil", 1);
  wait 3;
  level.player playlocalsound("scr_br_infil_ac130_klaxon", undefined, undefined, 1);
  wait 0.8;
  add_explicit_array_to_vo_queue(["dx_brm_sola_gametype_tut_warzone_10", "dx_brm_sola_intro_greet_10", "dx_brm_sola_objective_tut_10"]);
  level.player clearclienttriggeraudiozone(3);
}