/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2778.gsc
***************************************/

init() {
  level.passivemap = [];
  passiveparsetable();
}

passiveparsetable() {
  if(!isDefined(level.passivemap)) {
    level.passivemap = [];
  }

  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("mp\passivetable.csv", var_0, 0);

    if(var_1 == "") {
      break;
    }
    var_2 = tablelookupbyrow("mp\passivetable.csv", var_0, 1);
    var_3 = tablelookupbyrow("mp\passivetable.csv", var_0, 12);
    var_4 = tablelookupbyrow("mp\passivetable.csv", var_0, 13);
    var_5 = tablelookupbyrow("mp\passivetable.csv", var_0, 14);
    var_6 = spawnStruct();
    var_6.name = var_2;
    var_6.var_13CDE = scripts\engine\utility::ter_op(tablelookupbyrow("mp\passivetable.csv", var_0, 8) == "", 0, 1);
    var_6.killstreaktype = scripts\engine\utility::ter_op(tablelookupbyrow("mp\passivetable.csv", var_0, 9) == "", 0, 1);
    var_6.var_ABCA = scripts\engine\utility::ter_op(tablelookupbyrow("mp\passivetable.csv", var_0, 10) == "", 0, 1);
    var_6.var_113D1 = scripts\engine\utility::ter_op(tablelookupbyrow("mp\passivetable.csv", var_0, 11) == "", 0, 1);

    if(var_3 != "") {
      var_6.attachmentroll = var_3;
    }

    if(getdvar("ui_gametype") == "zombie") {
      var_7 = tablelookupbyrow("mp\passivetable.csv", var_0, 22);

      if(var_7 != "") {
        var_6.attachmentroll = var_7;
      }
    }

    if(var_4 != "") {
      var_6.var_CA59 = var_4;
    }

    if(var_5 != "") {
      var_6.var_B689 = var_5;
    }

    if(!isDefined(level.passivemap[var_2])) {
      level.passivemap[var_2] = var_6;
    }

    var_0++;
  }
}

getpassivestruct(var_0) {
  if(!isDefined(level.passivemap[var_0])) {
    return undefined;
  }

  var_1 = level.passivemap[var_0];
  return var_1;
}

getpassiveattachment(var_0) {
  var_1 = getpassivestruct(var_0);

  if(!isDefined(var_1) || !isDefined(var_1.attachmentroll)) {
    return undefined;
  }

  return var_1.attachmentroll;
}

getpassivemessage(var_0) {
  var_1 = getpassivestruct(var_0);

  if(!isDefined(var_1) || !isDefined(var_1.var_CA59)) {
    return undefined;
  }

  return var_1.var_CA59;
}

getpassivedeathwatching(var_0) {
  var_1 = getpassivestruct(var_0);

  if(!isDefined(var_1) || !isDefined(var_1.var_B689)) {
    return undefined;
  }

  return var_1.var_B689;
}

_meth_8239() {
  var_0 = [];

  foreach(var_2 in level.passivemap) {
    if(var_2.var_13CDE) {
      var_0[var_0.size] = var_2.name;
    }
  }

  return var_0;
}

func_7F52() {
  var_0 = [];

  foreach(var_2 in level.passivemap) {
    if(var_2.killstreaktype) {
      var_0[var_0.size] = var_2.name;
    }
  }

  return var_0;
}

func_7F67() {
  var_0 = [];

  foreach(var_2 in level.passivemap) {
    if(var_2.var_ABCA) {
      var_0[var_0.size] = var_2.name;
    }
  }

  return var_0;
}

hudoutlineenableforclients() {
  var_0 = [];

  foreach(var_2 in level.passivemap) {
    if(var_2.var_113D1) {
      var_0[var_0.size] = var_2.name;
    }
  }

  return var_0;
}