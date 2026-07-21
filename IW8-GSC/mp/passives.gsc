/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\passives.gsc
***********************************************/

init() {
  level.passivemap = [];
  passiveparsetable();
}

passiveparsetable() {
  if(!isDefined(level.passivemap))
    level.passivemap = [];

  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_BA0814D583F2F892C69FD7B3AB6D5A2250899DDE9B50", var_0, 0);

    if(var_1 == "_encstr_B40101") {
      break;
    }

    var_2 = tablelookupbyrow("_encstr_BA0814D583F2F892C69FD7B3AB6D5A2250899DDE9B50", var_0, 1);
    var_3 = tablelookupbyrow("_encstr_BA0814D583F2F892C69FD7B3AB6D5A2250899DDE9B50", var_0, 12);
    var_4 = tablelookupbyrow("_encstr_BA0814D583F2F892C69FD7B3AB6D5A2250899DDE9B50", var_0, 13);
    var_5 = tablelookupbyrow("_encstr_BA0814D583F2F892C69FD7B3AB6D5A2250899DDE9B50", var_0, 14);
    var_6 = spawnStruct();
    var_6.name = var_2;
    var_6.weapontype = scripts\engine\utility::ter_op(tablelookupbyrow("_encstr_BA0814D583F2F892C69FD7B3AB6D5A2250899DDE9B50", var_0, 8) == "_encstr_B40101", 0, 1);
    var_6.killstreaktype = scripts\engine\utility::ter_op(tablelookupbyrow("_encstr_BA0814D583F2F892C69FD7B3AB6D5A2250899DDE9B50", var_0, 9) == "_encstr_B40101", 0, 1);
    var_6.lethaltype = scripts\engine\utility::ter_op(tablelookupbyrow("_encstr_BA0814D583F2F892C69FD7B3AB6D5A2250899DDE9B50", var_0, 10) == "_encstr_B40101", 0, 1);
    var_6.tacticaltype = scripts\engine\utility::ter_op(tablelookupbyrow("_encstr_BA0814D583F2F892C69FD7B3AB6D5A2250899DDE9B50", var_0, 11) == "_encstr_B40101", 0, 1);

    if(var_3 != "_encstr_B40101")
      var_6.attachmentref = var_3;

    if(getDvar("_encstr_ADE50BEB2F7C519F9918E82B68") == "_encstr_BACB074025B01AAA28") {
      var_7 = tablelookupbyrow("_encstr_BA0814D583F2F892C69FD7B3AB6D5A2250899DDE9B50", var_0, 22);

      if(var_7 != "_encstr_B40101")
        var_6.attachmentref = var_7;
    }

    if(var_4 != "_encstr_B40101")
      var_6.perkref = var_4;

    if(var_5 != "_encstr_B40101")
      var_6.messageref = var_5;

    if(!isDefined(level.passivemap[var_2]))
      level.passivemap[var_2] = var_6;

    var_0++;
  }
}

getpassivestruct(var_0) {
  if(!isDefined(level.passivemap[var_0]))
    return undefined;

  var_1 = level.passivemap[var_0];
  return var_1;
}

getpassiveattachment(var_0) {
  var_1 = getpassivestruct(var_0);

  if(!isDefined(var_1) || !isDefined(var_1.attachmentref))
    return undefined;

  return var_1.attachmentref;
}

getpassiveperk(var_0) {
  var_1 = getpassivestruct(var_0);

  if(!isDefined(var_1) || !isDefined(var_1.perkref))
    return undefined;

  return var_1.perkref;
}

getpassivemessage(var_0) {
  var_1 = getpassivestruct(var_0);

  if(!isDefined(var_1) || !isDefined(var_1.messageref))
    return undefined;

  return var_1.messageref;
}

getweapontypepassives() {
  var_0 = [];

  foreach(var_2 in level.passivemap) {
    if(var_2.weapontype)
      var_0[var_0.size] = var_2.name;
  }

  return var_0;
}

getkillstreaktypepassives() {
  var_0 = [];

  foreach(var_2 in level.passivemap) {
    if(var_2.killstreaktype)
      var_0[var_0.size] = var_2.name;
  }

  return var_0;
}

getlethaltypepassives() {
  var_0 = [];

  foreach(var_2 in level.passivemap) {
    if(var_2.lethaltype)
      var_0[var_0.size] = var_2.name;
  }

  return var_0;
}

gettacticaltypepassives() {
  var_0 = [];

  foreach(var_2 in level.passivemap) {
    if(var_2.tacticaltype)
      var_0[var_0.size] = var_2.name;
  }

  return var_0;
}