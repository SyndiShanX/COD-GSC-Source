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

    var0 = scripts\engine\trace::ray_trace(self getEye(), self getEye() + anglesToForward(self getplayerangles()) * 16000);
    var1 = getclosestpointonnavmesh(var0["position"]);
    var2 = scripts\mp\mp_agent::spawnnewagentaitype("actor_enemy_cp_rus_desert_shotgun", var1, (0, 0, 0));
    var2.ignoreall = 1;
    var2.ignoreme = 1;
    var2.fixednode = 1;
    var2 scripts\asm\asm_bb::bb_setanimScripted();
    var2.goalradius = 8;
    thread traversal_test_think(var2);
    thread kill_traversal_test_guy(var2);
    var2 waittill("death");
  }
}

function kill_traversal_test_guy(var0) {
  while(!level.players[0] meleeButtonPressed()) {
    wait 0.05;
  }

  var0 dodamage(var0.health + 100, var0.origin);
}

function traversal_test_think(var0) {
  for(;;) {
    self waittill("weapon_fired");
    var1 = scripts\engine\trace::ray_trace(self getEye(), self getEye() + anglesToForward(self getplayerangles()) * 16000);
    var2 = getclosestpointonnavmesh(var1["position"]);
    var0 setgoalpos(var2);
  }
}