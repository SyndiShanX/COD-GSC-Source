/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_hostmigration.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\hostmigration_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\hud_util_shared;
#namespace hostmigration;

function callback_hostmigrationsave() {}

function callback_prehostmigrationsave() {}

function callback_hostmigration() {
  setslowmotion(1, 1, 0);
  level.hostmigrationreturnedplayercount = 0;
  if(level.inprematchperiod) {
    level waittill("prematch_over");
  }
  if(level.gameended) {
    println(("" + gettime()) + "");
    return;
  }
  println("" + gettime());
  level.hostmigrationtimer = 1;
  sethostmigrationstatus(1);
  level notify("host_migration_begin");
  thread locktimer();
  players = level.players;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    player thread hostmigrationtimerthink();
  }
  level endon("host_migration_begin");
  hostmigrationwait();
  level.hostmigrationtimer = undefined;
  sethostmigrationstatus(0);
  println("" + gettime());
  recordmatchbegin();
  level notify("host_migration_end");
}