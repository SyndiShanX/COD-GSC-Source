/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_strike_debug.gsc
***********************************************/

function traversal_test() {
  while(!isDefined(level.players) || level.players.size < 1) {
    wait 1;
  }

  thread traversal_test_logic();
}

function traversal_test_logic() {
  for(;;) {
    if(getdvarint("scr_traversal_test") < 1) {
      wait 1;
      continue;
    }

    while(!self useButtonPressed()) {
      wait 0.05;
    }

    while(self useButtonPressed()) {
      wait 0.05;
    }

    var_0 = scripts\engine\trace::ray_trace(self getEye(), self getEye() + anglesToForward(self getplayerangles()) * 16000);
    var_1 = getclosestpointonnavmesh(var_0["position"]);
    var_2 = scripts\mp\mp_agent::spawnnewagentaitype("actor_enemy_cp_rus_desert_shotgun", var_1, (0, 0, 0));
    var_2.ignoreall = 1;
    var_2.ignoreme = 1;
    var_2.fixednode = 1;
    var_2 scripts\asm\asm_bb::bb_setanimScripted();
    var_2.goalradius = 8;
    thread traversal_test_think(var_2);
    thread kill_traversal_test_guy(var_2);
    var_2 waittill("death");
  }
}

function kill_traversal_test_guy(var_0) {
  while(!level.players[0] meleeButtonPressed()) {
    wait 0.05;
  }

  var_0 dodamage(var_0.health + 100, var_0.origin);
}

function traversal_test_think(var_0) {
  for(;;) {
    self waittill("weapon_fired");
    var_1 = scripts\engine\trace::ray_trace(self getEye(), self getEye() + anglesToForward(self getplayerangles()) * 16000);
    var_2 = getclosestpointonnavmesh(var_1["position"]);
    var_0 setgoalpos(var_2);
  }
}