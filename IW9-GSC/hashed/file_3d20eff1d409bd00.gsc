/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3d20eff1d409bd00.gsc
***********************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "resurgence_mgl") {
    return;
  }
  _id_4A0D1F5F6BE0F8C7::init();
  _id_14183DF6F9AF8737::init();
  level thread initpostmain();
}

initpostmain() {
  waitframe();
  _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("onMarkPlayerAsEliminated");
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onMarkPlayerAsEliminated", ::_id_0F5CFF6DA44A3790);
  _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("playerWelcomeSplashes");
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerWelcomeSplashes", ::playerwelcomesplashes);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onResurgencePlayerWaitRespawn", ::_id_8EA21DE2739ECAD0);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("brPreMayConsiderPlayerDead", ::_id_752ABB6DA1E0F476);
  level._id_C04B5EDF3F9EA340 = [];
  _id_97B175CEC5B685BE("mp/classtable_br_resurgence_mgl.csv");
  _id_97B175CEC5B685BE("mp/classtable_br_resurgence_mgl_circle2.csv");
  _id_97B175CEC5B685BE("mp/classtable_br_resurgence_mgl_circle3.csv");
  level.brgametype._id_042B1E877AB187C6 = "splash_list_iw9_br_resurgence_mp_mgl";

  if(getdvarint("dvar_A0B3C27A59BBBBEC", 0) == 0)
    level.brgametype._id_B09B7AFE082A9239 = undefined;

  level.brgametype._id_5FFBEA0FD5D29E28 = 1;
}

_id_AA8A954D66BF39B4(_id_089688461C79EF11, table) {
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = tablelookup(table, 0, "loadoutPrimary", _id_089688461C79EF11 + 1);
  loadout["loadoutPrimaryAttachment"] = tablelookup(table, 0, "loadoutPrimaryAttachment1", _id_089688461C79EF11 + 1);
  loadout["loadoutPrimaryAttachment2"] = tablelookup(table, 0, "loadoutPrimaryAttachment2", _id_089688461C79EF11 + 1);
  loadout["loadoutPrimaryAttachment3"] = tablelookup(table, 0, "loadoutPrimaryAttachment3", _id_089688461C79EF11 + 1);
  loadout["loadoutPrimaryAttachment4"] = tablelookup(table, 0, "loadoutPrimaryAttachment4", _id_089688461C79EF11 + 1);
  loadout["loadoutPrimaryAttachment5"] = tablelookup(table, 0, "loadoutPrimaryAttachment5", _id_089688461C79EF11 + 1);
  loadout["loadoutPrimaryCamo"] = tablelookup(table, 0, "loadoutPrimaryCamo", _id_089688461C79EF11 + 1);
  loadout["loadoutPrimaryReticle"] = tablelookup(table, 0, "loadoutPrimaryReticle", _id_089688461C79EF11 + 1);
  loadout["loadoutSecondary"] = tablelookup(table, 0, "loadoutSecondary", _id_089688461C79EF11 + 1);
  loadout["loadoutSecondaryAttachment"] = tablelookup(table, 0, "loadoutSecondaryAttachment1", _id_089688461C79EF11 + 1);
  loadout["loadoutSecondaryAttachment2"] = tablelookup(table, 0, "loadoutSecondaryAttachment2", _id_089688461C79EF11 + 1);
  loadout["loadoutSecondaryAttachment3"] = tablelookup(table, 0, "loadoutSecondaryAttachment3", _id_089688461C79EF11 + 1);
  loadout["loadoutSecondaryAttachment4"] = tablelookup(table, 0, "loadoutSecondaryAttachment4", _id_089688461C79EF11 + 1);
  loadout["loadoutSecondaryAttachment5"] = tablelookup(table, 0, "loadoutSecondaryAttachment5", _id_089688461C79EF11 + 1);
  loadout["loadoutSecondaryCamo"] = tablelookup(table, 0, "loadoutSecondaryCamo", _id_089688461C79EF11 + 1);
  loadout["loadoutSecondaryReticle"] = tablelookup(table, 0, "loadoutSecondaryReticle", _id_089688461C79EF11 + 1);
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutEquipmentPrimary"] = tablelookup(table, 0, "loadoutEquipmentPrimary", _id_089688461C79EF11 + 1);
  loadout["loadoutEquipmentSecondary"] = tablelookup(table, 0, "loadoutEquipmentSecondary", _id_089688461C79EF11 + 1);
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = [tablelookup(table, 0, "loadoutPerk1", _id_089688461C79EF11 + 1), tablelookup(table, 0, "loadoutPerk2", _id_089688461C79EF11 + 1), tablelookup(table, 0, "loadoutPerk3", _id_089688461C79EF11 + 1), tablelookup(table, 0, "loadoutExtraPerk1", _id_089688461C79EF11 + 1), tablelookup(table, 0, "loadoutExtraPerk2", _id_089688461C79EF11 + 1), tablelookup(table, 0, "loadoutExtraPerk3", _id_089688461C79EF11 + 1)];
  loadout["loadoutGesture"] = "playerData";
  loadout["tableColumn"] = _id_089688461C79EF11;
  return loadout;
}

_id_97B175CEC5B685BE(table) {
  if(!isDefined(level._id_C04B5EDF3F9EA340))
    level._id_C04B5EDF3F9EA340 = [];

  _id_A78225C464121E51 = level._id_C04B5EDF3F9EA340.size;
  _id_07D958726E11B327 = tablelookupgetnumcols(table) - 1;
  level._id_C04B5EDF3F9EA340[_id_A78225C464121E51] = [];

  for(_id_089688461C79EF11 = 0; _id_089688461C79EF11 < _id_07D958726E11B327; _id_089688461C79EF11++)
    level._id_C04B5EDF3F9EA340[_id_A78225C464121E51][level._id_C04B5EDF3F9EA340[_id_A78225C464121E51].size] = _id_AA8A954D66BF39B4(_id_089688461C79EF11, table);

  level._id_77C121D31E587BA8 = [];

  foreach(circleindex, _id_1A9E152363126A93 in level._id_C04B5EDF3F9EA340) {
    if(isDefined(level._id_C04B5EDF3F9EA340[circleindex]) && level._id_C04B5EDF3F9EA340[circleindex].size > 0)
      level._id_77C121D31E587BA8[circleindex] = randomintrange(0, level._id_C04B5EDF3F9EA340[circleindex].size);
  }
}

_id_8EA21DE2739ECAD0() {
  if(!istrue(level.brgametype._id_C42E40EC22A1F0D4)) {
    return;
  }
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("squad_wiped");
  player endon("force_stop_respawn");

  while(isDefined(player.respawndelay) && player.respawndelay > 0) {
    if(isalive(player)) {
      return;
    }
    if(player.respawndelay <= 5)
      player playsoundtoplayer("ui_mp_resurgence_timer_quarter_sec", player);
    else if(player.respawndelay <= 10)
      player playsoundtoplayer("ui_mp_resurgence_timer_half_sec", player);
    else if(player.respawndelay % 4 == 2)
      player playsoundtoplayer("ui_mp_resurgence_timer", player);
    else
      player playsoundtoplayer("ui_mp_resurgence_timer_tick", player);

    wait 1;
  }
}

_id_752ABB6DA1E0F476() {
  return _id_26CCBFE3954CACF4::_id_FB4771E79218146B(self);
}

_id_0F5CFF6DA44A3790(player) {
  _id_4A0D1F5F6BE0F8C7::_id_305F60799DC60D7C(player);
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(player.team, "players");

  foreach(_id_80EF668C09FFB70F in _id_E2B2BBD9E6539F11) {
    if(isalive(_id_80EF668C09FFB70F))
      return;
  }

  foreach(_id_80EF668C09FFB70F in _id_E2B2BBD9E6539F11) {
    if(isai(_id_80EF668C09FFB70F))
      _id_80EF668C09FFB70F thread _id_4A0D1F5F6BE0F8C7::_id_F6E88D354CB8D3CD();
  }
}

playerwelcomesplashes(data) {
  self endon("disconnect");
  self waittill("infil_move");
  scripts\mp\hud_message::showsplash("br_gametype_resurgence_match_introduction");

  if(!_id_7933519955F32C4E::_id_B4E9D46918F067BB())
    scripts\mp\flags::gameflagwait("infil_animatic_complete");

  if(istrue(self.isbrsquadleader))
    _id_2CEDCC356F1B9FC8::brleaderdialogplayer("deploy_squad_leader", self, 1, 0, 4.5);

  while(!self isonground())
    waitframe();

  if(getdvarint("dvar_4838B7C39021124C", 0) == 1)
    _id_2CEDCC356F1B9FC8::brleaderdialogplayer("primary_objective_solo", self, undefined, undefined, 1.5, undefined, level.brgametype._id_B09B7AFE082A9239);
  else
    _id_2CEDCC356F1B9FC8::brleaderdialogplayer("primary_objective", self, undefined, undefined, 1.5, undefined, level.brgametype._id_B09B7AFE082A9239);

  _id_715028F54BAD19A1::branalytics_landing(self);
}