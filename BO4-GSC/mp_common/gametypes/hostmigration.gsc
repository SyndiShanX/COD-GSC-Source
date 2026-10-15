/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\hostmigration.gsc
*************************************************/

#include scripts\core_common\hostmigration_shared;

#namespace hostmigration;

callback_hostmigrationsave() {}

callback_prehostmigrationsave() {}

callback_hostmigration() {
  setslowmotion(1, 1, 0);
  level.hostmigrationreturnedplayercount = 0;

  if(level.inprematchperiod) {
    level waittill(#"prematch_over");
  }

  if(level.gameended) {
    println("<dev string:x38>" + gettime() + "<dev string:x56>");
    return;
  }

  println("<dev string:x38>" + gettime());
  level.hostmigrationtimer = 1;
  sethostmigrationstatus(1);
  level notify(#"host_migration_begin");
  thread locktimer();
  players = level.players;

  for(i = 0; i < players.size; i++) {
    player = players[i];
    player thread hostmigrationtimerthink();
  }

  level endon(#"host_migration_begin");
  hostmigrationwait();
  level.hostmigrationtimer = undefined;
  sethostmigrationstatus(0);
  println("<dev string:x7f>" + gettime());
  level notify(#"host_migration_end");
}