/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_attraction_gulag.gsc
********************************************************/

init() {
  level.brattractions["gulag"] = spawnStruct();
  level.brattractions["gulag"].locations = [];
  registerlocations();
}

registerlocations() {
  switch (level.script) {
    case "mp_donetsk":
    case "mp_donetsk2":
    case "mp_don3":
      registerlocation((51075, -39283, 1123), 400);
      registerlocation((-7677, 13727, -231), 400);
      registerlocation((1543, -29029, 89), 400);
      break;
    case "mp_br_mechanics":
      registerlocation((0, 0, 0), 400);
    default:
      break;
  }
}

registerlocation(origin, _id_CCB00530D7A24EE3) {
  _id_F98843815888EA41 = 50;
  _id_9B6C8BE6B3C1724F = 40;
  _id_94E49A1D99BFD258 = level.brattractions["gulag"].locations.size;
  level.brattractions["gulag"].locations[_id_94E49A1D99BFD258] = spawnStruct();
  location = level.brattractions["gulag"].locations[_id_94E49A1D99BFD258];
  location.icontrigger = _id_6731BE38C3B94FF7::createattractionicontrigger("gulag", 0, origin, _id_F98843815888EA41, "ui_mp_br_mapmenu_icon_poi_sb_gulag", _id_CCB00530D7A24EE3, undefined, undefined, "br_attraction_gulag");
  location.icontrigger _id_6731BE38C3B94FF7::triggeraddobjectivetext(&"MP_BR_INGAME/ATTRACT_GULAG_AREA");
  location.prompt = spawn("script_model", origin + (0, 0, _id_9B6C8BE6B3C1724F));
  location.prompt setModel("tag_origin");
  location.prompt thread triggerpromptthink();
}

triggerpromptthink(location) {
  self makeusable();
  self setHintString(&"MP_BR_INGAME/ATTRACT_GULAG_PROMPT");
  self setusepriority(-1);

  for(;;) {
    self waittill("trigger", player);
    player thread _id_67708F418B1FAC79::initplayerjail();
  }
}