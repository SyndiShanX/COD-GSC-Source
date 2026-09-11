/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\passives.gsc
***********************************************/

function init() {
  level.passivemap = [];
  passiveparsetable();
}

function passiveparsetable() {
  if(!isDefined(level.passivemap)) {
    level.passivemap = [];
  }

  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("mp/passivetable.csv", var_0, 0);

    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp/passivetable.csv", var_0, 1);
    var_3 = tablelookupbyrow("mp/passivetable.csv", var_0, 12);
    var_4 = tablelookupbyrow("mp/passivetable.csv", var_0, 13);
    var_5 = tablelookupbyrow("mp/passivetable.csv", var_0, 14);
    var_6 = spawnStruct();
    var_6.name = var_2;
    var_6.weapontype = scripts\engine\utility::ter_op(tablelookupbyrow("mp/passivetable.csv", var_0, 8) == "", 0, 1);
    var_6.killstreaktype = scripts\engine\utility::ter_op(tablelookupbyrow("mp/passivetable.csv", var_0, 9) == "", 0, 1);
    var_6.lethaltype = scripts\engine\utility::ter_op(tablelookupbyrow("mp/passivetable.csv", var_0, 10) == "", 0, 1);
    var_6.tacticaltype = scripts\engine\utility::ter_op(tablelookupbyrow("mp/passivetable.csv", var_0, 11) == "", 0, 1);

    if(var_3 != "") {
      var_6.attachmentref = var_3;
    }

    if(getDvar("MOLPOSLOMO") == "zombie") {
      var_7 = tablelookupbyrow("mp/passivetable.csv", var_0, 22);

      if(var_7 != "") {
        var_6.attachmentref = var_7;
      }
    }

    if(var_4 != "") {
      var_6.perkref = var_4;
    }

    if(var_5 != "") {
      var_6.messageref = var_5;
    }

    if(!isDefined(level.passivemap[var_2])) {
      level.passivemap[var_2] = var_6;
    }
  }
}

function getpassivestruct(var_0) {
  if(!isDefined(level.passivemap[var_0])) {
    return undefined;
  }

  var_1 = level.passivemap[var_0];
  return var_1;
}

function getpassiveattachment(var_0) {
  var_1 = getpassivestruct(var_0);

  if(!isDefined(var_1) || !isDefined(var_1.attachmentref)) {
    return undefined;
  }

  return var_1.attachmentref;
}

function getpassiveperk(var_0) {
  var_1 = getpassivestruct(var_0);

  if(!isDefined(var_1) || !isDefined(var_1.perkref)) {
    return undefined;
  }

  return var_1.perkref;
}

function getpassivemessage(var_0) {
  var_1 = getpassivestruct(var_0);

  if(!isDefined(var_1) || !isDefined(var_1.messageref)) {
    return undefined;
  }

  return var_1.messageref;
}

function getweapontypepassives() {
  var_0 = [];

  foreach(var_2 in level.passivemap) {
    if(var_2.weapontype) {
      var_0 = var_2.name;
    }
  }

  return var_0;
}

function getkillstreaktypepassives() {
  var_0 = [];

  foreach(var_2 in level.passivemap) {
    if(var_2.killstreaktype) {
      var_0 = var_2.name;
    }
  }

  return var_0;
}

function getlethaltypepassives() {
  var_0 = [];

  foreach(var_2 in level.passivemap) {
    if(var_2.lethaltype) {
      var_0 = var_2.name;
    }
  }

  return var_0;
}

function gettacticaltypepassives() {
  var_0 = [];

  foreach(var_2 in level.passivemap) {
    if(var_2.tacticaltype) {
      var_0 = var_2.name;
    }
  }

  return var_0;
}