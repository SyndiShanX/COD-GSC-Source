/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\passives.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace passives;

function init() {
  level.passivemap = [];
  passiveparsetable();
}

function passiveparsetable() {
  if(!isDefined(level.passivemap)) {
    level.passivemap = [];
  }

  for(row = 0; true; row++) {
    id = tablelookupbyrow("mp/passivetable.csv", row, 0);

    if(id == "") {
      break;
    }

    var_9f77fa0224fd3b6b = tablelookupbyrow("mp/passivetable.csv", row, 1);
    attachmentref = tablelookupbyrow("mp/passivetable.csv", row, 12);
    perkref = tablelookupbyrow("mp/passivetable.csv", row, 13);
    messageref = tablelookupbyrow("mp/passivetable.csv", row, 14);
    struct = spawnStruct();
    struct.name = var_9f77fa0224fd3b6b;
    struct.weapontype = ter_op(tablelookupbyrow("mp/passivetable.csv", row, 8) == "", 0, 1);
    struct.killstreaktype = ter_op(tablelookupbyrow("mp/passivetable.csv", row, 9) == "", 0, 1);
    struct.lethaltype = ter_op(tablelookupbyrow("mp/passivetable.csv", row, 10) == "", 0, 1);
    struct.tacticaltype = ter_op(tablelookupbyrow("mp/passivetable.csv", row, 11) == "", 0, 1);

    if(attachmentref != "") {
      struct.attachmentref = attachmentref;
    }

    if(getDvar(@ "ui_gametype") == "zombie") {
      var_4c1a232672db4b7f = tablelookupbyrow("mp/passivetable.csv", row, 22);

      if(var_4c1a232672db4b7f != "") {
        struct.attachmentref = var_4c1a232672db4b7f;
      }
    }

    if(perkref != "") {
      struct.perkref = perkref;
    }

    if(messageref != "") {
      struct.messageref = messageref;
    }

    if(!isDefined(level.passivemap[var_9f77fa0224fd3b6b])) {
      level.passivemap[var_9f77fa0224fd3b6b] = struct;
    }
  }
}

function getpassivestruct(passive) {
  if(!isDefined(level.passivemap[passive])) {
    return undefined;
  }

  struct = level.passivemap[passive];
  return struct;
}

function getpassiveattachment(passive) {
  struct = getpassivestruct(passive);

  if(!isDefined(struct) || !isDefined(struct.attachmentref)) {
    return undefined;
  }

  return struct.attachmentref;
}

function getpassiveperk(passive) {
  struct = getpassivestruct(passive);

  if(!isDefined(struct) || !isDefined(struct.perkref)) {
    return undefined;
  }

  return struct.perkref;
}

function getpassivemessage(passive) {
  struct = getpassivestruct(passive);

  if(!isDefined(struct) || !isDefined(struct.messageref)) {
    return undefined;
  }

  return struct.messageref;
}

function getweapontypepassives() {
  passives = [];

  foreach(passive in level.passivemap) {
    if(passive.weapontype) {
      passives[passives.size] = passive.name;
    }
  }

  return passives;
}

function getkillstreaktypepassives() {
  passives = [];

  foreach(passive in level.passivemap) {
    if(passive.killstreaktype) {
      passives[passives.size] = passive.name;
    }
  }

  return passives;
}

function getlethaltypepassives() {
  passives = [];

  foreach(passive in level.passivemap) {
    if(passive.lethaltype) {
      passives[passives.size] = passive.name;
    }
  }

  return passives;
}

function gettacticaltypepassives() {
  passives = [];

  foreach(passive in level.passivemap) {
    if(passive.tacticaltype) {
      passives[passives.size] = passive.name;
    }
  }

  return passives;
}