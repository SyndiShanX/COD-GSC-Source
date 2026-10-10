/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_29ec5691a72b84d4.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\perk;
#namespace namespace_702fb5f6d0e65edf;

function init() {
  setdvarifuninitialized(@ "hash_db219318c57c207c", 2);
  setdvarifuninitialized(@ "hash_5503b6abe9a578ef", 5);
  setdvarifuninitialized(@ "hash_514e71a29fd848df", 25);
  setdvarifuninitialized(@ "hash_d91cb66b19053d12", 10);
  setdvarifuninitialized(@ "hash_269a7fb521925fa5", 25);
  thread onplayerspawned();
  callback::add("player_death", &onplayerdeath);
}

function rewardassistpoints() {
  killstreakpoints = setkillstreakpoints(getdvarint(@ "hash_db219318c57c207c"));
  scripts\mp\killstreaks\killstreaks::givestreakpoints(#"assist", killstreakpoints, getdvarint(@ "hash_d91cb66b19053d12"));
}

function function_c3dfa7a42967be85() {
  killstreakpoints = setkillstreakpoints(getdvarint(@ "hash_5503b6abe9a578ef"));
  scripts\mp\killstreaks\killstreaks::givestreakpoints(#"kill", killstreakpoints, getdvarint(@ "hash_269a7fb521925fa5"));
}

function setkillstreakpoints(var_6ab5606da9634c9a) {
  self setclientomnvar("ui_score_streak_assist_progress", 1);

  if(!isDefined(self.var_efc98476d30e7d4c)) {
    self.var_efc98476d30e7d4c = var_6ab5606da9634c9a;
  } else {
    self.var_efc98476d30e7d4c += var_6ab5606da9634c9a;
  }

  killstreakpoints = 0;

  while(self.var_efc98476d30e7d4c >= getdvarint(@ "hash_514e71a29fd848df")) {
    self.var_efc98476d30e7d4c -= getdvarint(@ "hash_514e71a29fd848df");
    killstreakpoints += 1;
  }

  if(killstreakpoints >= 1) {
    self setclientomnvar("ui_score_streak_assist_progress", 0);
  }

  return killstreakpoints;
}

function onplayerspawned() {
  level endon("game_ended");

  while(true) {
    level waittill("player_spawned", player);
    player scripts\mp\utility\perk::giveperk("specialty_chain_killstreaks");
  }
}

function onplayerdeath(params) {
  self.var_efc98476d30e7d4c = 0;
  self setclientomnvar("ui_score_streak_assist_progress", 0);
}