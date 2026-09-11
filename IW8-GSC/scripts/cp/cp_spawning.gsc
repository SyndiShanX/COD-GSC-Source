/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_spawning.gsc
***********************************************/

function coopspawning_init() {}

function killremainingagents() {
  foreach(var_1 in level.spawned_enemies) {
    var_1 dodamage(var_1.health + 990, var_1.origin, var_1, var_1, "MOD_SUICIDE");
  }
}

function getvolumebasenamefromlinkname(var_0) {
  var_1 = strtok(var_0.script_linkname, "_");

  if(var_1.size < 2) {
    var_2 = var_1[0];
  } else if(scripts\engine\utility::string_starts_with(var_2[0], "pf")) {
    var_2 = var_2[1];

    for(var_3 = 2; var_3 < var_2.size; var_3++) {
      var_2 = var_2 + "_" + var_2[var_3];
    }
  } else {
    var_2 = var_2.script_linkname;
  }

  return var_2;
}

function moveagenttospawnerpos(var_0) {
  var_1 = getclosestpointonnavmesh(var_0.origin);
  self dontinterpolate();
  self setOrigin(var_0.origin, 1);
  self scragentsetgoalpos(var_0.origin);
  self.ignoreall = 0;
}

function generatenearbyspawner(var_0, var_1) {
  var_2 = 50;
  var_3 = 50;
  var_4 = spawnStruct();
  var_4.angles = var_1;
  var_5 = var_4.origin;
  var_6 = 0;

  while(!var_6) {
    var_7 = randomintrange(var_2 * -1, var_2);
    var_8 = randomintrange(var_3 * -1, var_3);
    var_5 = getclosestpointonnavmesh((var_0[0] + var_7, var_0[1] + var_8, var_0[2]));
    var_6 = 1;

    foreach(var_10 in level.players) {
      if(positionwouldtelefrag(var_5)) {
        var_6 = 0;
      }
    }

    if(!var_6) {
      wait 0.1;
    }
  }

  var_4.origin = var_5 + (0, 0, 5);
  return var_4;
}