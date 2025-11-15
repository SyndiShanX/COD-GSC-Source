/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2778.gsc
***************************************/

init() {
  level.passivemap = [];
  passiveparsetable();
}

passiveparsetable() {
  if(!isDefined(level.passivemap))
    level.passivemap = [];

  var_00 = 0;

  for(;;) {
    var_01 = tablelookupbyrow("mp\passivetable.csv", var_00, 0);

    if(var_01 == "") {
      break;
    }
    var_02 = tablelookupbyrow("mp\passivetable.csv", var_00, 1);
    var_03 = tablelookupbyrow("mp\passivetable.csv", var_00, 12);
    var_04 = tablelookupbyrow("mp\passivetable.csv", var_00, 13);
    var_05 = tablelookupbyrow("mp\passivetable.csv", var_00, 14);
    var_06 = spawnStruct();
    var_6.name = var_02;
    var_6.func_13CDE = scripts\engine\utility::ter_op(tablelookupbyrow("mp\passivetable.csv", var_00, 8) == "", 0, 1);
    var_6.killstreaktype = scripts\engine\utility::ter_op(tablelookupbyrow("mp\passivetable.csv", var_00, 9) == "", 0, 1);
    var_6.func_ABCA = scripts\engine\utility::ter_op(tablelookupbyrow("mp\passivetable.csv", var_00, 10) == "", 0, 1);
    var_6.func_113D1 = scripts\engine\utility::ter_op(tablelookupbyrow("mp\passivetable.csv", var_00, 11) == "", 0, 1);

    if(var_03 != "")
      var_6.attachmentroll = var_03;

    if(getdvar("ui_gametype") == "zombie") {
      var_07 = tablelookupbyrow("mp\passivetable.csv", var_00, 22);

      if(var_07 != "")
        var_6.attachmentroll = var_07;
    }

    if(var_04 != "")
      var_6.func_CA59 = var_04;

    if(var_05 != "")
      var_6.func_B689 = var_05;

    if(!isDefined(level.passivemap[var_02]))
      level.passivemap[var_02] = var_06;

    var_0++;
  }
}

getpassivestruct(var_00) {
  if(!isDefined(level.passivemap[var_00]))
    return undefined;

  var_01 = level.passivemap[var_00];
  return var_01;
}

getpassiveattachment(var_00) {
  var_01 = getpassivestruct(var_00);

  if(!isDefined(var_01) || !isDefined(var_1.attachmentroll))
    return undefined;

  return var_1.attachmentroll;
}

getpassivemessage(var_00) {
  var_01 = getpassivestruct(var_00);

  if(!isDefined(var_01) || !isDefined(var_1.func_CA59))
    return undefined;

  return var_1.func_CA59;
}

getpassivedeathwatching(var_00) {
  var_01 = getpassivestruct(var_00);

  if(!isDefined(var_01) || !isDefined(var_1.func_B689))
    return undefined;

  return var_1.func_B689;
}

_meth_8239() {
  var_00 = [];

  foreach(var_02 in level.passivemap) {
    if(var_2.func_13CDE)
      var_0[var_0.size] = var_2.name;
  }

  return var_00;
}

func_7F52() {
  var_00 = [];

  foreach(var_02 in level.passivemap) {
    if(var_2.killstreaktype)
      var_0[var_0.size] = var_2.name;
  }

  return var_00;
}

func_7F67() {
  var_00 = [];

  foreach(var_02 in level.passivemap) {
    if(var_2.func_ABCA)
      var_0[var_0.size] = var_2.name;
  }

  return var_00;
}

hudoutlineenableforclients() {
  var_00 = [];

  foreach(var_02 in level.passivemap) {
    if(var_2.func_113D1)
      var_0[var_0.size] = var_2.name;
  }

  return var_00;
}