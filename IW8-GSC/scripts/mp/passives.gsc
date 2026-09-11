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

  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("mp/passivetable.csv", var0, 0);

    if(var1 == "") {
      break;
    }

    var2 = tablelookupbyrow("mp/passivetable.csv", var0, 1);
    var3 = tablelookupbyrow("mp/passivetable.csv", var0, 12);
    var4 = tablelookupbyrow("mp/passivetable.csv", var0, 13);
    var5 = tablelookupbyrow("mp/passivetable.csv", var0, 14);
    var6 = spawnStruct();
    var6.name = var2;
    var6.weapontype = scripts\engine\utility::ter_op(tablelookupbyrow("mp/passivetable.csv", var0, 8) == "", 0, 1);
    var6.killstreaktype = scripts\engine\utility::ter_op(tablelookupbyrow("mp/passivetable.csv", var0, 9) == "", 0, 1);
    var6.lethaltype = scripts\engine\utility::ter_op(tablelookupbyrow("mp/passivetable.csv", var0, 10) == "", 0, 1);
    var6.tacticaltype = scripts\engine\utility::ter_op(tablelookupbyrow("mp/passivetable.csv", var0, 11) == "", 0, 1);

    if(var3 != "") {
      var6.attachmentref = var3;
    }

    if(getDvar("MOLPOSLOMO") == "zombie") {
      var7 = tablelookupbyrow("mp/passivetable.csv", var0, 22);

      if(var7 != "") {
        var6.attachmentref = var7;
      }
    }

    if(var4 != "") {
      var6.perkref = var4;
    }

    if(var5 != "") {
      var6.messageref = var5;
    }

    if(!isDefined(level.passivemap[var2])) {
      level.passivemap[var2] = var6;
    }
  }
}

function getpassivestruct(var0) {
  if(!isDefined(level.passivemap[var0])) {
    return undefined;
  }

  var1 = level.passivemap[var0];
  return var1;
}

function getpassiveattachment(var0) {
  var1 = getpassivestruct(var0);

  if(!isDefined(var1) || !isDefined(var1.attachmentref)) {
    return undefined;
  }

  return var1.attachmentref;
}

function getpassiveperk(var0) {
  var1 = getpassivestruct(var0);

  if(!isDefined(var1) || !isDefined(var1.perkref)) {
    return undefined;
  }

  return var1.perkref;
}

function getpassivemessage(var0) {
  var1 = getpassivestruct(var0);

  if(!isDefined(var1) || !isDefined(var1.messageref)) {
    return undefined;
  }

  return var1.messageref;
}

function getweapontypepassives() {
  var0 = [];

  foreach(var2 in level.passivemap) {
    if(var2.weapontype) {
      var0 = var2.name;
    }
  }

  return var0;
}

function getkillstreaktypepassives() {
  var0 = [];

  foreach(var2 in level.passivemap) {
    if(var2.killstreaktype) {
      var0 = var2.name;
    }
  }

  return var0;
}

function getlethaltypepassives() {
  var0 = [];

  foreach(var2 in level.passivemap) {
    if(var2.lethaltype) {
      var0 = var2.name;
    }
  }

  return var0;
}

function gettacticaltypepassives() {
  var0 = [];

  foreach(var2 in level.passivemap) {
    if(var2.tacticaltype) {
      var0 = var2.name;
    }
  }

  return var0;
}