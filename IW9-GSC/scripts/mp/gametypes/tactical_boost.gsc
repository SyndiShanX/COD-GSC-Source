/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\tactical_boost.gsc
***************************************************/

_id_1610B6BB7C7587F8(origin, angles, _id_6C8B8AC0C7274797) {
  _id_A9AE1AAF5B5D91C3 = spawn("script_model", origin + (0, 0, 20));
  _id_A9AE1AAF5B5D91C3 setModel("accessory_trophy_arrow");
  _id_A9AE1AAF5B5D91C3 showonlytoplayer(self);
  _id_A9AE1AAF5B5D91C3 makeusable();
  _id_A9AE1AAF5B5D91C3 sethintdisplayrange(128);
  _id_A9AE1AAF5B5D91C3 sethintdisplayfov(75);
  _id_A9AE1AAF5B5D91C3 setuserange(128);
  _id_A9AE1AAF5B5D91C3 setusefov(75);
  _id_A9AE1AAF5B5D91C3 setHintString(&"MP/USE_TACTICAL_BOOST");
  _id_A9AE1AAF5B5D91C3 sethintstringparams(_id_6C8B8AC0C7274797);
  _id_A9AE1AAF5B5D91C3 setscriptablepartstate("iw9_mp_tactical_boost", "visible");
  _id_11480C3089472E41(_id_A9AE1AAF5B5D91C3, angles);
  _id_A9AE1AAF5B5D91C3 thread _id_6CA11E13594FE287(self, _id_6C8B8AC0C7274797);
}

_id_11480C3089472E41(_id_A9AE1AAF5B5D91C3, angles) {
  _id_6768A915ED3C9351 = (0, randomfloatrange(-30, 30), 0);
  _id_431B710342C04983 = vectorNormalize(anglestoleft(angles + _id_6768A915ED3C9351));
  endpoint = _id_A9AE1AAF5B5D91C3.origin + _id_431B710342C04983 * 30;
  _id_A9AE1AAF5B5D91C3 rotatevelocity((0, randomfloatrange(45, 135) * scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1), 0), 9999);
  destination = _id_647342BFC61363BE(endpoint, endpoint + (0, 0, -1000)) + (0, 0, 18);
  _id_A9AE1AAF5B5D91C3 _id_02FA955D4B0A2471(_id_A9AE1AAF5B5D91C3.origin, destination, 0.5);
}

_id_647342BFC61363BE(start, end) {
  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1);
  _id_C59C5C63BF590651 = scripts\engine\trace::ray_trace(start, end, self, contentoverride);
  destination = start;

  if(_id_C59C5C63BF590651["hittype"] != "hittype_none" && isDefined(_id_C59C5C63BF590651["position"]))
    destination = _id_C59C5C63BF590651["position"];

  return destination;
}

_id_02FA955D4B0A2471(_id_9C19496CE8106E6B, _id_B809B8F732448A84, time) {
  gravity = getdvarint("bg_gravity");
  dist = distance(_id_9C19496CE8106E6B, _id_B809B8F732448A84);
  _id_3777ECE6A73EADA5 = _id_B809B8F732448A84 - _id_9C19496CE8106E6B;
  _id_920F4173513EB6B8 = 0.5 * gravity * squared(time) * -1;
  vel = (_id_3777ECE6A73EADA5[0] / time, _id_3777ECE6A73EADA5[1] / time, (_id_3777ECE6A73EADA5[2] - _id_920F4173513EB6B8) / time);
  self movegravity(vel, time);
}

_id_6CA11E13594FE287(targetplayer, _id_6C8B8AC0C7274797) {
  level endon("game_end");
  _id_6029710E4CAB57FF = getdvarint("dvar_069E1DE1258D6CA0", 20);
  msg = scripts\engine\utility::waittill_notify_or_timeout_return("trigger", _id_6029710E4CAB57FF);
  self delete();

  if(msg == "trigger") {
    targetplayer thread _id_509A21C5F4CEA6AE::_id_4C8D860C9E17FA76(_id_6C8B8AC0C7274797);
    targetplayer playlocalsound("br_tactical_boost_pickup");
  }
}