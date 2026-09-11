/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\tutorial\br_tut_ui.gsc
***********************************************/

function hud_message_wait_duration(var0, var1) {
  level.player sethudtutorialmessage(var0);
  wait var1;
  level.player clearhudtutorialmessage();
}

function hud_message_wait_notify(var0, var1) {
  level.player sethudtutorialmessage(var0);
  self waittill(var1);
  level.player clearhudtutorialmessage();
}

function process_vo_queue(var0, var1) {
  if(!isDefined(var0)) {
    var0 = "dx_bra_uktl_";
  }

  if(!isDefined(var1)) {
    var1 = 10;
  }

  level.ref_14304 = [];
  level.ref_14303 = var0;
  level.ref_14308 = var1;

  for(;;) {
    if(level.ref_14304.size) {
      var2 = [];

      foreach(var4 in level.ref_14304) {
        ref_1243a(var4);
        var2 = var4;
      }

      level.ref_14304 = scripts\engine\utility::array_remove_array(level.ref_14304, var2);
    }

    waitframe();
  }
}

function ref_1243a(var0) {
  if(isDefined(self.watch_for_players_touching_ground)) {
    while(player_is_shooting()) {
      waitframe();
    }
  }

  self playSound(var0);
  wait lookupsoundlength(var0) / 1000;
  self notify(var0);
}

function player_is_shooting() {
  return gettime() - self.watch_for_players_touching_ground < 400;
}

function ref_143a2() {
  while(level.ref_14304.size) {
    wait 0.1;
  }
}

function vo_queue_is_empty() {
  return !level.ref_14304.size;
}

function create_nag_array(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = level.ref_14308;
  }

  var3 = [];

  for(var4 = 0; var4 < var1; var4++) {
    var5 = var0 + var2;
    var3 = var5;
    var2 += level.ref_14308;
  }

  return var3;
}

function nags_til_flag(var0, var1, var2) {
  self endon(var1);

  if(!isDefined(var2)) {
    var2 = 10;
  }

  var3 = 1;

  for(;;) {
    foreach(var5 in var0) {
      if(!var3) {
        wait var2;
      }

      var3 = 0;

      if(scripts\engine\utility::flag_exist(var1) && scripts\engine\utility::flag(var1)) {
        return;
      }

      play_till_complete(var5);
    }
  }
}

function nags_explicit_til_flag(var0, var1, var2) {
  self endon(var1);
  jumpiftrue(isDefined(var2)) LOC_00000010;
  var2 = 10;

  for(;;) {
    foreach(var4 in var0) {
      play_explicit_till_complete(var4);
      wait var2;
    }

    waitframe();
  }
}

function start_nagging_internal(var0, var1, var2) {
  self endon("NAG_STOP");

  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 10;
  }

  if(!isDefined(var2)) {
    var2 = 10;
  }

  wait var2;
  thread nags_explicit_til_flag(var0, "NAG_STOP", var1);
}

function start_nagging(var0, var1, var2) {
  stop_nagging();
  waitframe();
  thread start_nagging_internal(level.player, var0, var1);
}

function stop_nagging() {
  level.player notify("NAG_STOP");
}

function add_to_vo_queue(var0) {
  level.ref_14304[level.ref_14304.size] = level.ref_14303 + var0;
}

function add_alias_array_to_queue(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 0.3;
  }

  foreach(var3 in var0) {
    add_to_vo_queue(var3);
  }
}

function add_explicit_to_vo_queue(var0) {
  level.ref_14304[level.ref_14304.size] = var0;
}

function add_explicit_array_to_vo_queue(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 0.3;
  }

  foreach(var3 in var0) {
    add_explicit_to_vo_queue(var3);
  }
}

function ref_143ec(var0) {
  while(scripts\engine\utility::array_contains(level.ref_14304, level.ref_14303 + var0)) {
    waitframe();
  }
}

function waittill_explicit_vo_plays(var0) {
  while(scripts\engine\utility::array_contains(level.ref_14304, var0)) {
    waitframe();
  }
}

function play_till_complete(var0) {
  add_to_vo_queue(var0);
  self waittill(level.ref_14303 + var0);
}

function play_explicit_till_complete(var0) {
  add_explicit_to_vo_queue(var0);
  self waittill(var0);
}

function bot_speaks(var0, var1, var2) {
  var3 = level.bots["players"][var0];
  var4 = var1 + var3.operatorcustomization.voice + "_" + var2;
  var3 playSound(var4);
}

function infil_sfx() {
  level.player setclienttriggeraudiozone("donetsk_ext_ac130_infil", 1);
  wait 3;
  level.player playlocalsound("scr_br_infil_ac130_klaxon", undefined, undefined, 1);
  wait 0.8;
  add_explicit_array_to_vo_queue(["dx_brm_sola_gametype_tut_warzone_10", "dx_brm_sola_intro_greet_10", "dx_brm_sola_objective_tut_10"]);
  level.player clearclienttriggeraudiozone(3);
}