/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\archetypes\archcommon.gsc
***********************************************/

init() {
  level.archetypes = [];
  level.archetypeids = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_974E16AD38CB13B0E8D1B1AC25B49D5116C41BB2E2C6CDD9", var_0, 0);

    if(!isDefined(var_1) || var_1 == "_encstr_B40101") {
      break;
    }

    var_1 = int(var_1);
    var_2 = tablelookupbyrow("_encstr_974E16AD38CB13B0E8D1B1AC25B49D5116C41BB2E2C6CDD9", var_0, 1);
    level.archetypes[var_1] = var_2;
    level.archetypeids[var_2] = var_1;
    var_0++;
  }
}

removearchetype(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D":
      var_1 = scripts\mp\archetypes\archassault::removearchetype;
      break;
    default:
      return;
  }

  if(isDefined(var_1))
    self[[var_1]]();
}

_allowbattleslide(var_0) {
  if(var_0)
    scripts\mp\utility\perk::giveperk("_encstr_8CA016D0132B9B40F66A70638F5219197BE049E8BDE0A183");
  else
    self notify("_encstr_A345120E2193CB91176338282A2F3F2323DB05FD");
}

getrigindexfromarchetyperef(var_0) {
  if(!isDefined(var_0) || var_0 == "_encstr_8BBA05185F8B99")
    return 0;

  for(var_1 = 0; var_1 < level.archetypes.size; var_1++) {
    if(level.archetypes[var_1] == var_0)
      return var_1;
  }

  return 0;
}