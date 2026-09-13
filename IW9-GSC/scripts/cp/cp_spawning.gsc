/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_spawning.gsc
***********************************************/

coopspawning_init() {}

killremainingagents() {
  foreach(guy in level.spawned_enemies)
  guy dodamage(guy.health + 990, guy.origin, guy, guy, "MOD_SUICIDE");
}

getvolumebasenamefromlinkname(volume) {
  _id_9D68A5FD6A22178C = strtok(volume.script_linkname, "_");

  if(_id_9D68A5FD6A22178C.size < 2)
    basename = _id_9D68A5FD6A22178C[0];
  else if(scripts\engine\utility::string_starts_with(_id_9D68A5FD6A22178C[0], "pf")) {
    basename = _id_9D68A5FD6A22178C[1];

    for(_id_AC0E594AC96AA3A8 = 2; _id_AC0E594AC96AA3A8 < _id_9D68A5FD6A22178C.size; _id_AC0E594AC96AA3A8++)
      basename = basename + "_" + _id_9D68A5FD6A22178C[_id_AC0E594AC96AA3A8];
  } else
    basename = volume.script_linkname;

  return basename;
}

moveagenttospawnerpos(spawner) {
  pos = getclosestpointonnavmesh(spawner.origin);
  self dontinterpolate();
  self setOrigin(spawner.origin, 1);
  self setgoalpos(spawner.origin);
  self.ignoreall = 0;
}

generatenearbyspawner(_id_1ECF3CFC40D95539, _id_6283413F177B37CE) {
  _id_9144D7624BDE5628 = 50;
  _id_001D9C4D4330643F = 50;
  spawner = spawnStruct();
  spawner.angles = _id_6283413F177B37CE;
  _id_E0CBA2B0A5510D09 = spawner.origin;
  found = 0;

  while(!found) {
    _id_BCFEC646853A95C1 = randomintrange(_id_9144D7624BDE5628 * -1, _id_9144D7624BDE5628);
    _id_BCFEC546853A938E = randomintrange(_id_001D9C4D4330643F * -1, _id_001D9C4D4330643F);
    _id_E0CBA2B0A5510D09 = getclosestpointonnavmesh((_id_1ECF3CFC40D95539[0] + _id_BCFEC646853A95C1, _id_1ECF3CFC40D95539[1] + _id_BCFEC546853A938E, _id_1ECF3CFC40D95539[2]));
    found = 1;

    foreach(player in level.players) {
      if(positionwouldtelefrag(_id_E0CBA2B0A5510D09))
        found = 0;
    }

    if(!found)
      wait 0.1;
  }

  spawner.origin = _id_E0CBA2B0A5510D09 + (0, 0, 5);
  return spawner;
}