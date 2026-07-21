/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_strike_debug.gsc
***********************************************/

traversal_test() {
  while(!isDefined(level.players) || level.players.size < 1)
    wait 1;

  level.players[0] thread traversal_test_logic();
}

traversal_test_logic() {
  for(;;) {
    if(getdvarint("_encstr_B89813B91BE4EBE8E4583B2B279B2C63AFD1CA373A") < 1) {
      wait 1;
      continue;
    }

    while(!self useButtonPressed())
      wait 0.05;

    while(self useButtonPressed())
      wait 0.05;

    var_0 = scripts\engine\trace::ray_trace(self getEye(), self getEye() + anglesToForward(self getplayerangles()) * 16000);
    var_1 = getclosestpointonnavmesh(var_0["_encstr_BD260953AA97E3F014279D"]);
    var_2 = scripts\mp\mp_agent::spawnnewagentaitype("_encstr_B801227E96C1DA42DE10FBDF38723742612002F3066FA29D6308F38391EBC84A31444BAD", var_1, (0, 0, 0));
    var_2.ignoreall = 1;
    var_2.ignoreme = 1;
    var_2.fixednode = 1;
    var_2 scripts\asm\asm_bb::bb_setanimScripted();
    var_2.goalradius = 8;
    thread traversal_test_think(var_2);
    thread kill_traversal_test_guy(var_2);
    var_2 waittill("_encstr_AD75063D571AE108");
  }
}

kill_traversal_test_guy(var_0) {
  while(!level.players[0] meleeButtonPressed())
    wait 0.05;

  var_0 dodamage(var_0.health + 100, var_0.origin);
}

traversal_test_think(var_0) {
  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19");
    var_1 = scripts\engine\trace::ray_trace(self getEye(), self getEye() + anglesToForward(self getplayerangles()) * 16000);
    var_2 = getclosestpointonnavmesh(var_1["_encstr_BD260953AA97E3F014279D"]);
    var_0 setgoalpos(var_2);
  }
}