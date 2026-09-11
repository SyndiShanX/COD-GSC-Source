/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_spawning.gsc
***********************************************/

function coopspawning_init() {}

function killremainingagents() {
  foreach(var1 in level.spawned_enemies) {
    var1 dodamage(var1.health + 990, var1.origin, var1, var1, "MOD_SUICIDE");
  }
}

function getvolumebasenamefromlinkname(var0) {
  var1 = strtok(var0.script_linkname, "_");

  if(var1.size < 2) {
    var2 = var1[0];
  } else if(scripts\engine\utility::string_starts_with(var2[0], "pf")) {
    var2 = var2[1];

    for(var3 = 2; var3 < var2.size; var3++) {
      var2 = var2 + "_" + var2[var3];
    }
  } else {
    var2 = var2.script_linkname;
  }

  return var2;
}

function moveagenttospawnerpos(var0) {
  var1 = getclosestpointonnavmesh(var0.origin);
  self dontinterpolate();
  self setOrigin(var0.origin, 1);
  self scragentsetgoalpos(var0.origin);
  self.ignoreall = 0;
}

function generatenearbyspawner(var0, var1) {
  var2 = 50;
  var3 = 50;
  var4 = spawnStruct();
  var4.angles = var1;
  var5 = var4.origin;
  var6 = 0;

  while(!var6) {
    var7 = randomintrange(var2 * -1, var2);
    var8 = randomintrange(var3 * -1, var3);
    var5 = getclosestpointonnavmesh((var0[0] + var7, var0[1] + var8, var0[2]));
    var6 = 1;

    foreach(var10 in level.players) {
      if(positionwouldtelefrag(var5)) {
        var6 = 0;
      }
    }

    if(!var6) {
      wait 0.1;
    }
  }

  var4.origin = var5 + (0, 0, 5);
  return var4;
}