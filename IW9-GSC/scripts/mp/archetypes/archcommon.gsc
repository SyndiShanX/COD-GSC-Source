/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\archetypes\archcommon.gsc
************************************************/

init() {
  level.archetypes = [];
  level.archetypeids = [];
  _id_CB89110314447B2F = 0;

  for(;;) {
    index = tablelookupbyrow("mp/battleRigTable.csv", _id_CB89110314447B2F, 0);

    if(!isDefined(index) || index == "") {
      break;
    }

    index = int(index);
    ref = tablelookupbyrow("mp/battleRigTable.csv", _id_CB89110314447B2F, 1);
    level.archetypes[index] = ref;
    level.archetypeids[ref] = index;
    _id_CB89110314447B2F++;
  }
}

removearchetype(loadoutarchetype) {
  if(!isDefined(loadoutarchetype)) {
    return;
  }
  _id_F3297D3D4075DCB7 = undefined;

  switch (loadoutarchetype) {
    case "archetype_assault":
      _id_F3297D3D4075DCB7 = scripts\mp\archetypes\archassault::removearchetype;
      break;
    default:
      return;
  }

  if(isDefined(_id_F3297D3D4075DCB7))
    self[[_id_F3297D3D4075DCB7]]();
}

_allowbattleslide(_id_CD187E38E3DF8F36) {
  if(_id_CD187E38E3DF8F36)
    scripts\mp\utility\perk::giveperk("specialty_battleslide");
  else
    self notify("battleslide_unset");
}

getrigindexfromarchetyperef(_id_C156D240D6457E18) {
  if(!isDefined(_id_C156D240D6457E18) || _id_C156D240D6457E18 == "none")
    return 0;

  for(rigindex = 0; rigindex < level.archetypes.size; rigindex++) {
    if(level.archetypes[rigindex] == _id_C156D240D6457E18)
      return rigindex;
  }

  return 0;
}