/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_24b31fe025ef8ed3.gsc
***********************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "aladdin") {
    return;
  }
  init();
}

init() {
  level._id_7D43CCDC62F43DB3 = _id_40E63DD222434655::_id_81A10B74BFE305A9;
  level.bots_gametype_handles_class_choice = !istrue(level._id_66113AA6FC12BE57);
  _id_3408B3BE04FF0639 = getdvarint("dvar_4C8E33496C92CD2E", 0);

  if(_id_3408B3BE04FF0639 == 1)
    _id_362C58E8BB39BCDA::disablefeature("drogBagLoadout");

  _id_362C58E8BB39BCDA::registerbrgametypefunc("onSpawnPlayer", _id_4A0D1F5F6BE0F8C7::onspawnplayer);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("modifyPlayerDamage", _id_4A0D1F5F6BE0F8C7::modifyplayerdamage);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("getBestSpectateCandidate", _id_4A0D1F5F6BE0F8C7::getbestspectatecandidate);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("isValidSpectateTarget", _id_4A0D1F5F6BE0F8C7::isvalidspectatetarget);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("mayConsiderPlayerDead", _id_26CCBFE3954CACF4::_id_FB4771E79218146B);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onMarkPlayerAsEliminated", _id_4A0D1F5F6BE0F8C7::_id_0F5CFF6DA44A3790);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onUnmarkPlayerAsEliminated", _id_4A0D1F5F6BE0F8C7::_id_6029066AB0D7003B);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("getDefaultLoadout", _id_4A0D1F5F6BE0F8C7::_id_391B372CD3C0DDDC);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("kioskRevivePlayer", _id_4A0D1F5F6BE0F8C7::_id_B8CE7E76DC2DC587);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerWelcomeSplashes", _id_4A0D1F5F6BE0F8C7::playerwelcomesplashes);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("GetRandomLoadout", _id_4A0D1F5F6BE0F8C7::_id_A6C8F6E16F9ACACC);

  if(_id_26CCBFE3954CACF4::_id_E60552DD6ABCC4AA()) {
    _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerConnect", _id_26CCBFE3954CACF4::onplayerconnect);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerDisconnect", _id_26CCBFE3954CACF4::onplayerdisconnect);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("isTeamEliminated", _id_26CCBFE3954CACF4::isteameliminated);
  }

  level._id_BDD92C05D3032F65 = _id_4A0D1F5F6BE0F8C7::_id_BDD92C05D3032F65;
  level._id_CB87DB3F189CF3F1 = _id_4A0D1F5F6BE0F8C7::_id_3363DE115C63751D;

  if(scripts\mp\utility\game::matchmakinggame())
    level thread _id_40E63DD222434655::_id_F4CD8D89E37B4888();

  thread _id_4A0D1F5F6BE0F8C7::_id_CED5973479A0E03B();
}

_id_7E904FF184E6794C(_id_9F4A3632D9F75D32, _id_D4884966C59032E3, spawnorigin, spawnangle, _id_5623FEABB8673FA2) {
  _id_060B36839D21113F = _id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF();
  _id_580C0AB2F1D761BE = getdvarint("dvar_25AD2925D6075C8F", 0);

  if(_id_580C0AB2F1D761BE != 0) {
    level.skipprematch = 1;

    if(_id_580C0AB2F1D761BE == 2) {
      level.skipprematchdropspawn = 1;
      level.br_infils_disabled = 1;
      level thread _id_4A0D1F5F6BE0F8C7::_id_F6E343C0B9912601();
      spawnangle = scripts\engine\utility::_id_53C4C53197386572(spawnangle, (0, 60, 0));
      _id_29D9D2428185616D = [];
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn_start", spawnorigin, spawnangle);
      scripts\mp\spawnlogic::addscriptedspawnpoints(_id_29D9D2428185616D);
    }
  } else {
    _id_D9D6C656A9FD19AC = 150.0;
    _id_054401A32BF2A02B = _id_1E4A61DB11011446::_id_CB40F77C51717EA1();
    _id_32C7D201A42335FF = _id_D9D6C656A9FD19AC / _id_054401A32BF2A02B;
    _id_78DE90A02FD7622B = _id_26CCBFE3954CACF4::_id_D6D3F0E8A701880F();
    level._id_2F78F22EDF92FAA9 = ceil(_id_78DE90A02FD7622B / _id_32C7D201A42335FF);
  }

  level.br_level._id_61321B51908D55CB = "classtable:classtable_br_bot_loadouts_phase1";
  level.br_level._id_61321C51908D57FE = "classtable:classtable_br_bot_loadouts_phase2";
  level._id_5623FEABB8673FA2 = _id_5623FEABB8673FA2;
  _id_4A0D1F5F6BE0F8C7::_id_900EFE56E44A6C12();
  _id_26CCBFE3954CACF4::initialize(_id_9F4A3632D9F75D32);

  if(isDefined(_id_D4884966C59032E3) && _id_D4884966C59032E3 > 0)
    setDvar("dvar_749412E5DB698400", _id_D4884966C59032E3);

  level thread _id_40E63DD222434655::_id_C38398385AFC10FC();
}