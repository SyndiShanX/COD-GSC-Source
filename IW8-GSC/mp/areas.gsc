/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\areas.gsc
***********************************************/

init() {
  level.softlandingtriggers = getEntArray("_encstr_85E11D47392DEC3B599C7DDAD51B474B07B195D79BB7CCA38D589B192DCDCE", "_encstr_AC110A7F14873B5B3D073009");
  var_0 = getEntArray("_encstr_AF801532B2CD8EE4D5B13A4B8936CABEB3B21A2D361BCA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in level.softlandingtriggers) {
    if(var_2.script_type != "_encstr_AF1904AFE326") {
      continue;
    }
    foreach(var_4 in var_0) {
      if(distance(var_2.origin, var_4.origin) > 64.0) {
        continue;
      }
      var_2.destructible = var_4;
    }
  }

  thread onplayerconnect();
}

onplayerconnect() {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0.softlanding = undefined;
    var_0 thread softlandingwaiter();
  }
}

playerentersoftlanding(var_0) {
  self.softlanding = var_0;
}

playerleavesoftlanding(var_0) {
  self.softlanding = undefined;
}

softlandingwaiter() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_872F0D0B92FB65A14D31958951B518", var_0, var_1);

    if(!isDefined(var_0.destructible))
      continue;
  }
}