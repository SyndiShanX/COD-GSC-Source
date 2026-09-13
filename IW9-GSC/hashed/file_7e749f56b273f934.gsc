/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7e749f56b273f934.gsc
***********************************************/

traversal_test() {
  while(!isDefined(level.players) || level.players.size < 1)
    wait 1;

  level.players[0] thread traversal_test_logic();
}

traversal_test_logic() {
  for(;;) {
    if(getdvarint("dvar_0EE095CA95D44710") < 1) {
      wait 1;
      continue;
    }

    while(!self useButtonPressed())
      wait 0.05;

    while(self useButtonPressed())
      wait 0.05;

    trace = scripts\engine\trace::ray_trace(self getEye(), self getEye() + anglesToForward(self getplayerangles()) * 16000);
    pos = getclosestpointonnavmesh(trace["position"]);
    guy = scripts\mp\mp_agent::spawnnewagentaitype("actor_enemy_cp_rus_desert_shotgun", pos, (0, 0, 0));
    guy.ignoreall = 1;
    guy.ignoreme = 1;
    guy.fixednode = 1;
    guy scripts\asm\asm_bb::bb_setanimScripted();
    guy.goalradius = 8;
    thread traversal_test_think(guy);
    thread kill_traversal_test_guy(guy);
    guy waittill("death");
  }
}

kill_traversal_test_guy(guy) {
  while(!level.players[0] meleeButtonPressed())
    wait 0.05;

  guy dodamage(guy.health + 100, guy.origin);
}

traversal_test_think(guy) {
  for(;;) {
    self waittill("weapon_fired");
    trace = scripts\engine\trace::ray_trace(self getEye(), self getEye() + anglesToForward(self getplayerangles()) * 16000);
    pos = getclosestpointonnavmesh(trace["position"]);
    guy setgoalpos(pos);
  }
}