/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\passives.gsc
***********************************************/

init() {
  level.passivemap = [];
  passiveparsetable();
}

passiveparsetable() {
  if(!isDefined(level.passivemap))
    level.passivemap = [];

  _id_CB89110314447B2F = 0;

  for(;;) {
    id = tablelookupbyrow("mp/passivetable.csv", _id_CB89110314447B2F, 0);

    if(id == "") {
      break;
    }

    _id_9F77FA0224FD3B6B = tablelookupbyrow("mp/passivetable.csv", _id_CB89110314447B2F, 1);
    attachmentref = tablelookupbyrow("mp/passivetable.csv", _id_CB89110314447B2F, 12);
    perkref = tablelookupbyrow("mp/passivetable.csv", _id_CB89110314447B2F, 13);
    messageref = tablelookupbyrow("mp/passivetable.csv", _id_CB89110314447B2F, 14);
    struct = spawnStruct();
    struct.name = _id_9F77FA0224FD3B6B;
    struct.weapontype = scripts\engine\utility::ter_op(tablelookupbyrow("mp/passivetable.csv", _id_CB89110314447B2F, 8) == "", 0, 1);
    struct.killstreaktype = scripts\engine\utility::ter_op(tablelookupbyrow("mp/passivetable.csv", _id_CB89110314447B2F, 9) == "", 0, 1);
    struct.lethaltype = scripts\engine\utility::ter_op(tablelookupbyrow("mp/passivetable.csv", _id_CB89110314447B2F, 10) == "", 0, 1);
    struct.tacticaltype = scripts\engine\utility::ter_op(tablelookupbyrow("mp/passivetable.csv", _id_CB89110314447B2F, 11) == "", 0, 1);

    if(attachmentref != "")
      struct.attachmentref = attachmentref;

    if(getDvar("ui_gametype") == "zombie") {
      _id_4C1A232672DB4B7F = tablelookupbyrow("mp/passivetable.csv", _id_CB89110314447B2F, 22);

      if(_id_4C1A232672DB4B7F != "")
        struct.attachmentref = _id_4C1A232672DB4B7F;
    }

    if(perkref != "")
      struct.perkref = perkref;

    if(messageref != "")
      struct.messageref = messageref;

    if(!isDefined(level.passivemap[_id_9F77FA0224FD3B6B]))
      level.passivemap[_id_9F77FA0224FD3B6B] = struct;

    _id_CB89110314447B2F++;
  }
}

getpassivestruct(_id_F8B2E6BF3F40AB02) {
  if(!isDefined(level.passivemap[_id_F8B2E6BF3F40AB02]))
    return undefined;

  struct = level.passivemap[_id_F8B2E6BF3F40AB02];
  return struct;
}

getpassiveattachment(_id_F8B2E6BF3F40AB02) {
  struct = getpassivestruct(_id_F8B2E6BF3F40AB02);

  if(!isDefined(struct) || !isDefined(struct.attachmentref))
    return undefined;

  return struct.attachmentref;
}

getpassiveperk(_id_F8B2E6BF3F40AB02) {
  struct = getpassivestruct(_id_F8B2E6BF3F40AB02);

  if(!isDefined(struct) || !isDefined(struct.perkref))
    return undefined;

  return struct.perkref;
}

getpassivemessage(_id_F8B2E6BF3F40AB02) {
  struct = getpassivestruct(_id_F8B2E6BF3F40AB02);

  if(!isDefined(struct) || !isDefined(struct.messageref))
    return undefined;

  return struct.messageref;
}

getweapontypepassives() {
  passives = [];

  foreach(_id_F8B2E6BF3F40AB02 in level.passivemap) {
    if(_id_F8B2E6BF3F40AB02.weapontype)
      passives[passives.size] = _id_F8B2E6BF3F40AB02.name;
  }

  return passives;
}

getkillstreaktypepassives() {
  passives = [];

  foreach(_id_F8B2E6BF3F40AB02 in level.passivemap) {
    if(_id_F8B2E6BF3F40AB02.killstreaktype)
      passives[passives.size] = _id_F8B2E6BF3F40AB02.name;
  }

  return passives;
}

getlethaltypepassives() {
  passives = [];

  foreach(_id_F8B2E6BF3F40AB02 in level.passivemap) {
    if(_id_F8B2E6BF3F40AB02.lethaltype)
      passives[passives.size] = _id_F8B2E6BF3F40AB02.name;
  }

  return passives;
}

gettacticaltypepassives() {
  passives = [];

  foreach(_id_F8B2E6BF3F40AB02 in level.passivemap) {
    if(_id_F8B2E6BF3F40AB02.tacticaltype)
      passives[passives.size] = _id_F8B2E6BF3F40AB02.name;
  }

  return passives;
}