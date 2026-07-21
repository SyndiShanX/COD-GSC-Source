/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_spawning.gsc
***********************************************/

coopspawning_init() {}

killremainingagents() {
  foreach(var_1 in level.spawned_enemies)
  var_1 dodamage(var_1.health + 990, var_1.origin, var_1, var_1, "_encstr_AB590C99ED78875F650F3951034D");
}

getvolumebasenamefromlinkname(var_0) {
  var_1 = strtok(var_0.script_linkname, "_encstr_BA4C02DF");

  if(var_1.size < 2)
    var_2 = var_1[0];
  else if(scripts\engine\utility::string_starts_with(var_1[0], "_encstr_8A0703BBD2")) {
    var_2 = var_1[1];

    for(var_3 = 2; var_3 < var_1.size; var_3++)
      var_2 = var_2 + "_encstr_BA4C02DF" + var_1[var_3];
  } else
    var_2 = var_0.script_linkname;

  return var_2;
}

moveagenttospawnerpos(var_0) {
  var_1 = getclosestpointonnavmesh(var_0.origin);
  self dontinterpolate();
  self setOrigin(var_0.origin, 1);
  self scragentsetgoalpos(var_0.origin);
  self.ignoreall = 0;
}

generatenearbyspawner(var_0, var_1) {
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
      if(positionwouldtelefrag(var_5))
        var_6 = 0;
    }

    if(!var_6)
      wait 0.1;
  }

  var_4.origin = var_5 + (0, 0, 5);
  return var_4;
}