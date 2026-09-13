/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_public.gsc
***********************************************/

iswaitingtoentergulag(player) {
  return istrue(player.entergulagwait);
}

isloadinggulag(player) {
  return istrue(player.gulagloading);
}

isrespawningfromtoken(player) {
  return istrue(player.respawningfromtoken);
}

isplayeringulag() {
  player = self;
  return isDefined(player) && (istrue(player.jailed) || istrue(player.gulagarena));
}

isplayerinorgoingtogulag() {
  player = self;
  return isDefined(player) && (istrue(player.jailed) || istrue(player.gulagarena) || istrue(player.gulag));
}

_id_F1918F2FCE663B2C() {
  player = self;
  return isDefined(player) && istrue(player.wasingulag);
}

_id_8F0E6614368F64C2() {
  player = self;
  return isDefined(player) && isDefined(player.respawndelay) && player.respawndelay > 0;
}

iseligibleforteamrevive() {
  player = self;
  return (istrue(player.br_iseliminated) && !isalive(player) || player playeriszombie()) && !istrue(player.gulag);
}

playeriszombie() {
  return istrue(self.iszombie);
}

_id_F5446040A93792C3() {
  return istrue(self._id_7F788F4B6412959C);
}

watchhealend() {
  self endon("heal_end");
  self endon("death_or_disconnect");
  self endon("armor_plate_done");
  level endon("game_ended");
  childthread heal_removeonplayernotifies();
  childthread heal_removeondamage();
}

heal_removeonplayernotifies() {
  self notifyonplayercommand("try_heal_cancel", "+weapnext");
  self notifyonplayercommand("try_heal_cancel", "+attack");
  self notifyonplayercommand("try_heal_cancel", "+breath_sprint");
  scripts\engine\utility::waittill_any_2("death", "try_heal_cancel");
  healend();
}

heal_removeondamage() {
  for(;;) {
    self waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, _id_9E834FE6754A9C98, _id_1D3F20A69CED2DD5, _id_920FF4456CE9A2FC, idflags, objweapon);

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && (smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_UNKNOWN")) {
      continue;
    }
    healend();
  }
}

healend() {
  self notifyonplayercommandremove("try_heal_cancel", "+weapnext");
  self notifyonplayercommandremove("try_heal_cancel", "+attack");
  self notifyonplayercommandremove("try_heal_cancel", "+breath_sprint");
  self notify("heal_end");
}

removeitemfrominventory(slot) {
  self.br_inventory_slots[slot] = undefined;
}

ishelmet(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "armor" && issubstr(scriptablename, "helmet");
}

isarmor(scriptablename) {
  return ishelmet(scriptablename);
}

isarmorplate(scriptablename) {
  return scriptablename == "brloot_armor_plate";
}

_id_4AA12E0ED3F6B745(scriptablename) {
  return issubstr(scriptablename, "brloot_plate_carrier") || isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "plate_carrier";
}

_id_692C3DF266580DF6(scriptablename) {
  if(!isDefined(scriptablename))
    return 1;

  if(issubstr(scriptablename, "brloot_plate_carrier_2"))
    return 2;

  if(issubstr(scriptablename, "brloot_plate_carrier_3") || scriptablename == "brloot_plate_carrier_tempered" || scriptablename == "brloot_plate_carrier_high_capacity")
    return 3;

  return 1;
}

_id_C2F2BB9E0AE9A454(_id_D1FC2132CD825D26) {
  if(!isDefined(_id_D1FC2132CD825D26) || _id_D1FC2132CD825D26 <= 1)
    return undefined;

  if(_id_D1FC2132CD825D26 == 2)
    return "brloot_plate_carrier_2";

  if(_id_D1FC2132CD825D26 == 3)
    return "brloot_plate_carrier_3";

  return undefined;
}

ishealitem(scriptablename) {
  return scriptablename == "brloot_health_bandages" || scriptablename == "brloot_health_firstaid" || scriptablename == "brloot_health_adrenaline";
}

_id_12D9A293931F0455(scriptablename) {
  return scriptablename == "brloot_offhand_heartbeatsensor";
}

isequipment(scriptablename) {
  return isarmorplate(scriptablename) || ishealitem(scriptablename) || isDefined(level.br_pickups.br_itemtype[scriptablename]) && (level.br_pickups.br_itemtype[scriptablename] == "lethal" || level.br_pickups.br_itemtype[scriptablename] == "tactical");
}

isequipmentlethal(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "lethal";
}

isequipmenttactical(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "tactical";
}

isammo(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "ammo";
}

_id_7897CA6463069464(scriptablename) {
  return isDefined(scriptablename) && (scriptablename == "br_plunder_box" || scriptablename == "br_plunder_box_high_tier" || scriptablename == "drone_deployable_kiosk");
}

_id_0600D1AB3A9FF61F(scriptablename) {
  return isDefined(scriptablename) && scriptablename == "br_workbench";
}

_id_A84A6ACB3C2EDCAE(scriptablename) {
  return isDefined(scriptablename) && scriptablename == "br_plunder_box_stronghold";
}

_id_63D8455B2C1455EB(scriptablename) {
  return isDefined(level.br_pickups._id_688C9B0A44E4A8CA[scriptablename]) && level.br_pickups._id_688C9B0A44E4A8CA[scriptablename];
}

playercanplaynotcriticalgesture() {
  if(self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isPlayerADS")]]() || istrue(self.insertingarmorplate))
    return 0;

  _id_04A8F5643E919524 = self getcurrentweapon();

  if(isnullweapon(_id_04A8F5643E919524))
    return 0;

  return 1;
}

playerplaygestureweaponanim(weaponref, _id_EB5B1F36E255152D, variantid) {
  self endon("death_or_disconnect");
  _id_A7408DBFED49F3F9 = makeweapon(weaponref, [], undefined, undefined, scripts\engine\utility::ter_op(isDefined(variantid), variantid, undefined));
  self giveandfireoffhand(_id_A7408DBFED49F3F9);
  wait(_id_EB5B1F36E255152D);

  if(self hasweapon(_id_A7408DBFED49F3F9))
    self takeweapon(_id_A7408DBFED49F3F9);
}

hasrespawntoken() {
  player = self;
  return istrue(player.hasrespawntoken);
}

_id_15DA77DC195BD80A() {
  player = self;
  return istrue(player._id_15DA77DC195BD80A);
}

_id_8B2396647673BE50() {
  return !istrue(level.br_pickups._id_174664C71517F679) || istrue(level.br_pickups._id_5609DE5240E42E84) && isDefined(level.gulag) && istrue(level.gulag.shutdown);
}

hasselfrevivetoken() {
  player = self;
  return isDefined(player._id_6C05B62D5521A0B2);
}

_id_038A924A5F3D8CA8(player) {
  return player hasselfrevivetoken() && player._id_6C05B62D5521A0B2.name == "brloot_battlerage_self_revive";
}

_id_723BD1AB3BB16B2B(player, scriptablename) {
  if(!isDefined(player) || !isDefined(scriptablename))
    return 0;

  _id_87F79E2FDE6F6049 = _id_791E72676CD7B544(player);
  return isDefined(_id_87F79E2FDE6F6049) && _id_87F79E2FDE6F6049 == scriptablename;
}

_id_791E72676CD7B544(player) {
  if(!isDefined(player) || !player hasselfrevivetoken())
    return undefined;

  return player._id_6C05B62D5521A0B2.name;
}

_id_7285C46EE8B26043(player) {
  if(!isDefined(player) || !player hasselfrevivetoken())
    return undefined;

  return player._id_6C05B62D5521A0B2.perk;
}

_id_1E141AD1F7106373(player) {
  if(!isDefined(player) || !player hasselfrevivetoken())
    return undefined;

  return player._id_6C05B62D5521A0B2.type;
}

_id_56733D929B67A814(scriptablename) {
  if(!isDefined(scriptablename))
    return 0;

  switch (scriptablename) {
    case "brloot_battlerage_self_revive":
      return 1;
    default:
      return 0;
  }
}

_id_8E65095B82C19D04(scriptablename) {
  if(!isDefined(scriptablename))
    return undefined;

  switch (scriptablename) {
    case "brloot_battlerage_self_revive":
      return "specialty_br_faster_revive";
    default:
      return undefined;
  }
}

hasplatepouch() {
  player = self;
  return istrue(player.hasplatepouch);
}

hasspecialistbonus() {
  player = self;
  return istrue(player.hasbrspecialistbonus);
}

hasaccesscard(_id_F6AFD1D56892DC8D) {
  player = self;

  if(!isDefined(_id_F6AFD1D56892DC8D) || !isDefined(player.accesscard))
    return isDefined(player.accesscard);
  else
    return _id_F6AFD1D56892DC8D == player.accesscard;
}

_id_3BB38B68CD07463E(lootid) {
  return _id_2D9D24F7C63AC143::_id_36B1968BFE78916B(lootid);
}

cleanac130struct(_id_2C43414FF4583B64) {
  if(isDefined(_id_2C43414FF4583B64.playerslot1)) {
    if(isDefined(_id_2C43414FF4583B64.playerslot1.head))
      _id_2C43414FF4583B64.playerslot1.head delete();

    if(isDefined(_id_2C43414FF4583B64.playerslot1.helmet))
      _id_2C43414FF4583B64.playerslot1.helmet delete();

    _id_2C43414FF4583B64.playerslot1 delete();
  }

  if(isDefined(_id_2C43414FF4583B64.playerslot2)) {
    if(isDefined(_id_2C43414FF4583B64.playerslot2.head))
      _id_2C43414FF4583B64.playerslot2.head delete();

    _id_2C43414FF4583B64.playerslot2 delete();
  }

  if(isDefined(_id_2C43414FF4583B64.playerslot3))
    _id_2C43414FF4583B64.playerslot3 delete();

  if(isDefined(_id_2C43414FF4583B64.playerslot4))
    _id_2C43414FF4583B64.playerslot4 delete();

  if(isDefined(_id_2C43414FF4583B64.aidoorchief))
    _id_2C43414FF4583B64.aidoorchief delete();

  if(isDefined(_id_2C43414FF4583B64.cameraent))
    _id_2C43414FF4583B64.cameraent delete();

  if(isDefined(_id_2C43414FF4583B64.cameraentmoving))
    _id_2C43414FF4583B64.cameraentmoving delete();

  if(isDefined(_id_2C43414FF4583B64.playerpositionents)) {
    foreach(ent in _id_2C43414FF4583B64.playerpositionents)
    ent delete();
  }

  if(isDefined(_id_2C43414FF4583B64.cloudcoverfx))
    _id_2C43414FF4583B64.cloudcoverfx delete();

  if(isDefined(_id_2C43414FF4583B64.staticc130) && istrue(_id_2C43414FF4583B64.staticc130.cleanme))
    _id_2C43414FF4583B64.staticc130 delete();

  if(isDefined(_id_2C43414FF4583B64.movingc130) && istrue(_id_2C43414FF4583B64.movingc130.cleanme)) {
    if(istrue(_id_2C43414FF4583B64.movingc130.innards.cleanme))
      _id_2C43414FF4583B64.movingc130.innards delete();

    _id_2C43414FF4583B64.movingc130 delete();
  }
}

_id_64FA4C213439177F() {
  player = self;
  player _meth_9B5704D0633B87FA();
}

updatebrscoreboardstat(_id_629757F5C9E770D8, value) {
  player = self;
  _id_64571E3AECCD1A07 = 0;
  _id_8534515023AFC188 = 0;
  _id_5737E53FA9CDBABF = 0;

  switch (_id_629757F5C9E770D8) {
    case "reviveCount":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_5737E53FA9CDBABF] = [0, 8, 0];
      break;
    case "matchPoints":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_5737E53FA9CDBABF] = [0, 12, 0];
      break;
    case "longestLife":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_5737E53FA9CDBABF] = [0, 12, 0];
      break;
    case "agentKills":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_5737E53FA9CDBABF] = [0, 8, 1];
      break;
    case "respawnInSeconds":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_5737E53FA9CDBABF] = [0, 7, 1];
      break;
    case "lootCachesOpened":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_5737E53FA9CDBABF] = [0, 8, 1];
      break;
    case "armorHealthRatio":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_5737E53FA9CDBABF] = [0, 8, 2];
      break;
    case "missionsCompleted":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_5737E53FA9CDBABF] = [8, 4, 2];
      break;
    case "bunkerKeycardType":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_5737E53FA9CDBABF] = [12, 3, 2];
      break;
    case "isInInfilPlane":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_5737E53FA9CDBABF] = [15, 1, 2];
      break;
    case "damageDealt":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_5737E53FA9CDBABF] = [0, 16, 3];
      break;
    case "longestScoreStreak":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_5737E53FA9CDBABF] = [0, 10, 4];
      break;
    case "zombieKills":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_5737E53FA9CDBABF] = [0, 10, 4];
      break;
    case "numVaccine":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_5737E53FA9CDBABF] = [10, 3, 4];
      break;
    case "isDowned":
    case "activeSpectators":
    case "isRespawning":
    case "cleanups":
    case "playersDowned":
    case "isBeingRevived":
    case "jumpMasterState":
      break;
    default:
      return;
  }

  player packstatintoextrainfo(value, _id_64571E3AECCD1A07, _id_8534515023AFC188, _id_5737E53FA9CDBABF);
}

packstatintoextrainfo(value, _id_64571E3AECCD1A07, _id_8534515023AFC188, _id_5737E53FA9CDBABF) {
  player = self;
  _id_3742F6EA342282FF = [player.extrascore0, player.extrascore1, player.extrascore2, player.extrascore3, player.extrascore4];
  mask = int(pow(2, _id_8534515023AFC188)) - 1;
  _id_A463992091F1D483 = (value &mask) << _id_64571E3AECCD1A07;
  _id_F8F977081D3DA8B4 = ~(mask << _id_64571E3AECCD1A07);
  _id_EE27F3F198276535 = _id_3742F6EA342282FF[_id_5737E53FA9CDBABF];
  _id_ED711AEAF5E8CB76 = _id_EE27F3F198276535 &_id_F8F977081D3DA8B4;
  _id_82A90E56E416FA55 = _id_ED711AEAF5E8CB76 + _id_A463992091F1D483;

  switch (_id_5737E53FA9CDBABF) {
    case 0:
      player.extrascore0 = _id_82A90E56E416FA55;
      break;
    case 1:
      player.extrascore1 = _id_82A90E56E416FA55;
      break;
    case 2:
      player.extrascore2 = _id_82A90E56E416FA55;
      break;
    case 3:
      player.extrascore3 = _id_82A90E56E416FA55;
      break;
    case 4:
      player.extrascore4 = _id_82A90E56E416FA55;
      break;
    default:
      break;
  }
}

setplayerdownedextrainfo(value) {
  if(istrue(value))
    self.game_extrainfo = self.game_extrainfo | 2048;
  else
    self.game_extrainfo = self.game_extrainfo &~2048;
}

_id_CC20F0C1304019D9(value) {
  if(istrue(value))
    self.game_extrainfo = self.game_extrainfo | 262144;
  else
    self.game_extrainfo = self.game_extrainfo &~262144;
}

_id_0EB28F4724F0F14B(value) {
  if(istrue(value))
    self.game_extrainfo = self.game_extrainfo | 524288;
  else
    self.game_extrainfo = self.game_extrainfo &~524288;
}

setplayerbeingrevivedextrainfo(value) {
  if(istrue(value))
    self.game_extrainfo = self.game_extrainfo | 4096;
  else
    self.game_extrainfo = self.game_extrainfo &~4096;
}

setplayerselfrevivingextrainfo(value) {
  if(istrue(value))
    self.game_extrainfo = self.game_extrainfo | 8192;
  else
    self.game_extrainfo = self.game_extrainfo &~8192;
}

setplayermostwantedextrainfo(value) {
  if(istrue(value))
    self.game_extrainfo = self.game_extrainfo | 32768;
  else
    self.game_extrainfo = self.game_extrainfo &~32768;
}

sethasselfrevivetokenextrainfo(value) {
  if(istrue(value))
    self.game_extrainfo = self.game_extrainfo | 65536;
  else
    self.game_extrainfo = self.game_extrainfo &~65536;
}

sethasrespawntokenextrainfo(value) {
  if(istrue(value))
    self.game_extrainfo = self.game_extrainfo | 131072;
  else
    self.game_extrainfo = self.game_extrainfo &~131072;
}

incrementplayersdownedstat() {
  player = self;

  if(!isDefined(player.br_playersdowned))
    player.br_playersdowned = 0;

  player.br_playersdowned++;
  player updatebrscoreboardstat("playersDowned", player.br_playersdowned);
  player scripts\mp\utility\stats::incpersstat("downs", 1);
  player scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(16, 1);
}

_id_E58801ACF7ADCDC8(value) {
  if(istrue(value))
    self.game_extrainfo = self.game_extrainfo | 1048576;
  else
    self.game_extrainfo = self.game_extrainfo &~1048576;
}

_id_C2AFA687BC871D71(value) {
  if(istrue(value))
    self.game_extrainfo = self.game_extrainfo | 2097152;
  else
    self.game_extrainfo = self.game_extrainfo &~2097152;
}

_id_9552337123064304(value) {
  if(istrue(value))
    self.game_extrainfo = self.game_extrainfo | 4194304;
  else
    self.game_extrainfo = self.game_extrainfo &~4194304;
}

isplayerbrsquadleader() {
  player = self;
  return istrue(player.isbrsquadleader) && player.game_extrainfo & 256;
}

brbroadcastplayercardsplash(_id_1B4ADA49A21B51CA, optionalnumber) {
  foreach(player in level.players) {
    if(!isPlayer(player)) {
      continue;
    }
    if(player isplayeringulag()) {
      continue;
    }
    player thread scripts\mp\hud_message::showsplash(_id_1B4ADA49A21B51CA, optionalnumber, player);
  }
}

brleaderdialogteamexcludeplayer(dialog, team, _id_F5720CAC60CA8410, _id_A64CAD1ECC519617, _id_29B55B55D98A28F4, delay) {
  foreach(_id_F0EA4030349A33D5 in level.teamdata[team]["players"]) {
    if(!isDefined(_id_F0EA4030349A33D5)) {
      continue;
    }
    if(_id_F0EA4030349A33D5 != _id_F5720CAC60CA8410)
      brleaderdialogplayer(dialog, _id_F0EA4030349A33D5, _id_A64CAD1ECC519617, _id_29B55B55D98A28F4, delay);
  }
}

brleaderdialogteam(dialog, team, _id_A64CAD1ECC519617, delay, _id_ABB7E1EA2ADCE060, _id_BA850EF48CFDAD1D) {
  brleaderdialog(dialog, _id_A64CAD1ECC519617, level.teamdata[team]["players"], undefined, delay, _id_ABB7E1EA2ADCE060, _id_BA850EF48CFDAD1D);
}

brleaderdialog(dialog, _id_A64CAD1ECC519617, _id_F16321BA668D68F5, _id_29B55B55D98A28F4, delay, _id_ABB7E1EA2ADCE060, _id_BA850EF48CFDAD1D) {
  if(!isDefined(game["dialog"][dialog])) {
    return;
  }
  players = level.players;

  if(isDefined(_id_F16321BA668D68F5))
    players = _id_F16321BA668D68F5;

  for(_id_EF50426720E1DBB8 = 0; _id_EF50426720E1DBB8 < players.size; _id_EF50426720E1DBB8++) {
    player = players[_id_EF50426720E1DBB8];
    thread brleaderdialogplayer(dialog, player, _id_A64CAD1ECC519617, _id_29B55B55D98A28F4, delay, _id_ABB7E1EA2ADCE060, _id_BA850EF48CFDAD1D);
  }
}

_id_6FF291AF572EEFB6(dialog, alias) {
  if(!isDefined(game["dialog"][dialog])) {
    return;
  }
  game["dialog"][dialog] = alias;

  if(!isDefined(game["dialogForAllTeams"]))
    game["dialogForAllTeams"] = [];

  game["dialogForAllTeams"][dialog] = 1;
}

modeplayerskipdialog(dialog, _id_A64CAD1ECC519617) {
  if(!isDefined(_id_A64CAD1ECC519617))
    _id_A64CAD1ECC519617 = 1;

  if(istrue(_id_A64CAD1ECC519617) && isplayeringulag())
    return 1;

  if(_id_5C61825C1DCE3571::_id_94B952789D039ABB() && getDvar("dvar_12E53040D5281856", "") == "scripted")
    return 1;

  if(istrue(self.playinggulagbink))
    return 1;

  if(_id_CC053AECC2C53ECF()) {
    if(istrue(self.playingtutorialdialogue))
      return 1;

    if(dialog == "deploy_squad_leader" || dialog == "prematch_enter")
      return 1;

    if((dialog == "circle_closing" || dialog == "first_circle") && !istrue(level.playerumpedfromplane))
      return 1;
  }

  _id_04AD7C03EC4FA687 = level.maxteamsize == 1;

  if(_id_04AD7C03EC4FA687) {
    switch (dialog) {
      case "deploy_squad_leader":
        return 1;
    }
  }

  return 0;
}

brgetoperatorteam(player) {
  _id_95CE4F91D0F58568 = player.defaultoperatorteam;

  if(isai(player))
    _id_95CE4F91D0F58568 = player.botoperatorteam;

  if(istutorial() || _id_CC053AECC2C53ECF())
    _id_95CE4F91D0F58568 = "allies";

  return _id_95CE4F91D0F58568;
}

brleaderdialogplayer(dialog, player, _id_A64CAD1ECC519617, _id_29B55B55D98A28F4, delay, _id_ABB7E1EA2ADCE060, _id_BA850EF48CFDAD1D) {
  player endon("disconnect");
  level endon("game_ended");

  if(!isDefined(player)) {
    return;
  }
  if(istrue(player.isdisconnecting)) {
    return;
  }
  if(!isDefined(_id_29B55B55D98A28F4))
    _id_29B55B55D98A28F4 = getdvarint("dvar_A6587A24D2081693", 1);

  if(!isalive(player) && !istrue(_id_29B55B55D98A28F4)) {
    return;
  }
  if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
    return;
  }
  if(player modeplayerskipdialog(dialog, _id_A64CAD1ECC519617)) {
    return;
  }
  if(istutorial() || _id_CC053AECC2C53ECF()) {
    if(dialog == "mission_scav_accept" || dialog == "mission_obj_next_nptarget")
      return;
  }

  _id_CB3339ECE72DBDEB = _id_93550B34F0A49DD9(dialog, player, _id_BA850EF48CFDAD1D);

  if(isDefined(_id_CB3339ECE72DBDEB)) {
    _id_CB3339ECE72DBDEB = tolower(_id_CB3339ECE72DBDEB);

    if(soundexists(_id_CB3339ECE72DBDEB)) {
      _id_1499E7C2D69E0074 = lookupsoundlength(_id_CB3339ECE72DBDEB, 1) / 1000.0;

      if(isDefined(delay) && delay >= level.framedurationseconds)
        wait(delay);

      player queuedialogforplayer(_id_CB3339ECE72DBDEB, dialog, _id_1499E7C2D69E0074);
    }
  }
}

_id_93550B34F0A49DD9(dialog, player, _id_BA850EF48CFDAD1D) {
  _id_CB3339ECE72DBDEB = undefined;
  _id_95CE4F91D0F58568 = brgetoperatorteam(player);

  if(!isDefined(_id_95CE4F91D0F58568))
    _id_95CE4F91D0F58568 = "allies";

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    if(isDefined(_id_BA850EF48CFDAD1D))
      _id_CB3339ECE72DBDEB = _id_BA850EF48CFDAD1D + game["dialog"][dialog];
    else
      _id_CB3339ECE72DBDEB = "dx_bra_" + game["voice"][_id_95CE4F91D0F58568] + "_" + game["dialog"][dialog];
  } else {
    _id_DEC9BCCE93873125 = "dx_br_dmzc_";

    if(isDefined(_id_BA850EF48CFDAD1D))
      _id_DEC9BCCE93873125 = _id_BA850EF48CFDAD1D;

    _id_CB3339ECE72DBDEB = "" + _id_DEC9BCCE93873125 + game["dialog"][dialog];
  }

  if(isDefined(_id_CB3339ECE72DBDEB))
    _id_CB3339ECE72DBDEB = tolower(_id_CB3339ECE72DBDEB);

  return _id_CB3339ECE72DBDEB;
}

_id_D6AE35E0CE14BBAF() {
  return isDefined(level.script) && level.script == "mp_bm_tut";
}

_id_55B494A07469298A() {
  return getDvar("dvar_12E53040D5281856", "") == "scripted";
}

istutorial() {
  return _id_55B494A07469298A() || isDefined(level.script) && (level.script == "mp_br_tut" || level.script == "mp_lc_br_tut");
}

_id_CC053AECC2C53ECF() {
  if(!isDefined(level._id_CC053AECC2C53ECF)) {
    if(!isDefined(level.script))
      return 0;

    level._id_CC053AECC2C53ECF = level.script == "mp_br_quarry";
  }

  return level._id_CC053AECC2C53ECF;
}

isdmzbotpracticematch() {
  return isDefined(level.script) && level.script == "mp_br_money";
}

isanytutorialorbotpracticematch() {
  return istutorial() || _id_D6AE35E0CE14BBAF() || _id_CC053AECC2C53ECF() || isdmzbotpracticematch();
}

playergetlaststandpistol() {
  weaponlist = self getweaponslistprimaries();

  foreach(_id_06B62DB6EEC868E2 in weaponlist) {
    weaponname = _id_06B62DB6EEC868E2.basename;

    if(weaponclass(_id_06B62DB6EEC868E2) == "pistol" && weaponname != "iw9_me_fists_mp" && weaponname != "iw8_me_riotshield_mp" && weaponname != "iw9_knifestab_mp" && weaponname != "iw8_throwingknife_fire_melee_mp" && weaponname != "iw8_throwingknife_electric_melee_mp")
      return _id_06B62DB6EEC868E2;
  }
}

playerwaittillstreamhintcomplete() {
  if(istrue(self.prestreaminglocation))
    self waittill("playerPrestreamComplete");
}

playerstreamhintdroptoground(_id_11F3B4465C8B637B, _id_EDED8B6C3565A24C) {
  if(!isDefined(_id_EDED8B6C3565A24C))
    _id_EDED8B6C3565A24C = _id_0930A1E7BD882C1D::getinfilspawnoffset();

  _id_18A32798902944EE = getdvarint("dvar_C103B956E0125687", 4500);

  if(_id_18A32798902944EE >= 0) {
    _id_625180CE8D2F8F77 = _id_EDED8B6C3565A24C - _id_18A32798902944EE;
    contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
    _id_11F3B4465C8B637B = scripts\engine\utility::drop_to_ground(_id_11F3B4465C8B637B, 0, -1 * _id_625180CE8D2F8F77, undefined, contents);
  }

  return _id_11F3B4465C8B637B;
}

playerstreamhintlocation(_id_11F3B4465C8B637B, timeoutms, _id_A3269DB2B15568DA, _id_DE6EF125511E1141, _id_4A1D79951B2BD56C) {
  thread playerstreamhintlocationinternal(_id_11F3B4465C8B637B, timeoutms, _id_A3269DB2B15568DA, _id_DE6EF125511E1141, _id_4A1D79951B2BD56C);
}

playerstreamhintlocationinternal(_id_11F3B4465C8B637B, timeoutms, _id_A3269DB2B15568DA, _id_DE6EF125511E1141, _id_4A1D79951B2BD56C) {
  if(!isDefined(self) || !isDefined(_id_11F3B4465C8B637B)) {
    return;
  }
  self notify("playerPrestreamLocationWait");
  self endon("playerPrestreamLocationWait");
  self endon("disconnect");
  _id_4DE859B9228E5CFD = !self isplayerheadless() && !isbot(self);

  if(!isDefined(timeoutms))
    timeoutms = getdefaultstreamhinttimeoutms();

  timeout = gettime() + timeoutms;
  self.prestreaminglocation = 1;
  self._id_F9BCDD83C6C6899F = undefined;

  if(!self ispredictedstreamposready())
    self clearpredictedstreampos();

  _id_599BE23B9AFB9909 = gettime();

  if(_id_4DE859B9228E5CFD) {
    while(!istrue(self.pers["streamSyncComplete"]) && gettime() < timeout)
      waitframe();
  }

  self _meth_BC667001F9DD3808(_id_11F3B4465C8B637B);

  if(istrue(_id_A3269DB2B15568DA))
    self loadcustomizationplayerview(self);

  if(_id_4DE859B9228E5CFD) {
    waitframe();

    while((!self ispredictedstreamposready() || istrue(_id_A3269DB2B15568DA) && !self hasloadedcustomizationplayerview(self)) && gettime() < timeout)
      waitframe();

    self._id_F9BCDD83C6C6899F = 1;

    if(istrue(_id_DE6EF125511E1141)) {
      _id_6176904164DB6B75 = gettime() + getdvarint("dvar_6F5F8DAEB9F79D47", 5000);

      while(gettime() < _id_6176904164DB6B75)
        waitframe();
    }

    if(isDefined(_id_4A1D79951B2BD56C)) {
      _id_1E41981F0FA40795 = getdvarint("dvar_9D5507C09010BAE5", 2000);
      timeout = gettime() + _id_4A1D79951B2BD56C;
      _id_8CABE71736D798A7 = 0;

      while(_id_4A1D79951B2BD56C == -1 || gettime() < timeout) {
        if(gettime() > _id_8CABE71736D798A7) {
          self _meth_BC667001F9DD3808(_id_11F3B4465C8B637B);
          _id_8CABE71736D798A7 = gettime() + _id_1E41981F0FA40795;
        }

        waitframe();
      }
    }
  }

  self.prestreaminglocation = undefined;
  self notify("playerPrestreamComplete");
}

getdefaultstreamhinttimeoutms() {
  return getdvarint("dvar_AAFFD5B201281AD4", 9000);
}

playerclearstreamhintorigin() {
  self notify("playerPrestreamLocationWait");
  self clearpredictedstreampos();
}

_id_2DCD6A9EB79260A6() {
  self cancelmantle();

  if(self isskydiving())
    self skydive_interrupt();

  if(istrue(self.inlaststand))
    scripts\mp\laststand::finishreviveplayer("self_revive_success", self);

  if(isDefined(self.burninginfo))
    scripts\mp\equipment\molotov::molotov_clear_burning();

  if(istrue(self.usingascender))
    scripts\cp_mp\auto_ascender::ascenderinstantstop();

  if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    data = spawnStruct();
    data.allowairexit = 1;
    data.exittype = "INVOLUNTARY";
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(self.vehicle, undefined, self, data, 1);
  }

  if(isDefined(self.remoteuav))
    self.remoteuav scripts\mp\killstreaks\remoteuav::remoteuav_leave();

  if(isDefined(self.currentturret))
    scripts\cp_mp\killstreaks\manual_turret::manualturret_endplayeruse(self.currentturret);

  if(isDefined(self.usingremote)) {
    vehicles = vehicle_getarray();

    foreach(vehicle in vehicles) {
      if(isDefined(vehicle.owner) && vehicle.owner == self) {
        if(isDefined(vehicle.helperdronetype))
          vehicle scripts\cp_mp\killstreaks\helper_drone::_id_06EDFDA4764129E3(1);
      }
    }
  }

  scripts\mp\javelin::javelin_forceclear();
}

calchelicoptertrailpoint() {
  droppoint = self.origin - anglesToForward(self.angles) * 150;
  return droppoint;
}

prematchmusic(team) {
  if(scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm") {
    return;
  }
  _id_5A9CFC3686B1FD8D = scripts\mp\utility\teams::getteamdata(team, "players");

  if(isarray(_id_5A9CFC3686B1FD8D) && _id_5A9CFC3686B1FD8D.size == 0) {
    return;
  }
  setglobalsoundcontext("lobby_fade", "on", 3);

  if(!isDefined(level._id_9D615A366EC2FB6F) && (scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && getDvar("dvar_7611A2790A0BF7FE", "") != "dmz" && getDvar("dvar_7611A2790A0BF7FE", "") != "exgm"))
    level._id_9D615A366EC2FB6F = 1;

  if(level.matchcountdowntime > 13) {
    waittime = level.matchcountdowntime - 13;
    wait(waittime);
    _id_3C143D48494EBF12 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_lobby_outro");
    _id_7CAC3993CD7DA309 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_lobby_outro_classic");
    _id_7AB5B649FA408138::_id_46979D2FD81A6D4B(team, _id_3C143D48494EBF12, undefined, _id_7CAC3993CD7DA309);
    _id_7AB5B649FA408138::_id_C7F38D0611AA82E7(team, "mp_br_lobby_fade", 8.0);
    wait(level.matchcountdowntime);
  } else {}
}

prematchdialog(team) {
  if(istutorial() || scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm") {
    return;
  }
  if(level.matchcountdowntime > 3) {
    waittime = level.matchcountdowntime - 3;
    wait(waittime);
    brleaderdialogteam("prematch_end", team);
  }
}

_id_D26E2B04E5D064B6(_id_149B29E625082ED4) {
  if(!getdvarint("dvar_65F74244D3C0F108", 1)) {
    return;
  }
  _id_3D9A04704748E997 = getdvarint("dvar_501689ED1F1820D6", 2);
  players = level.players;
  restrictions = ["execution_attack", "execution_victim"];

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    player _id_3B64EB40368C1450::_id_59C053B89257BC95("prematch_plotarmor", restrictions, 0);
  }

  wait(_id_149B29E625082ED4 + _id_3D9A04704748E997);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    player _id_3B64EB40368C1450::_id_59C053B89257BC95("prematch_plotarmor", restrictions, 1);
  }
}

applyprematchplotarmor(_id_6958D396E4AD3B95) {
  if(getdvarint("dvar_FE3AFD6EAD4AA523", 1) == 0) {
    return;
  }
  _id_149B29E625082ED4 = 5;
  waittime = _id_6958D396E4AD3B95 - _id_149B29E625082ED4;

  if(waittime > 0)
    wait(waittime);

  foreach(player in level.players)
  player.plotarmor = 1;

  level thread _id_D26E2B04E5D064B6(_id_149B29E625082ED4);
}

br_onvehicledeath() {
  player = self;
  player _id_07C40FA80892A721::damagearmor(150, 1);
}

br_delaynojip() {
  level endon("game_ended");
  _id_04400D6A8D876BD9 = getdvarint("dvar_C1AF35BDCBB75C06", 30);
  wait(_id_04400D6A8D876BD9);
  setnojipscore(1, 1);
  setnojiptime(1, 1);
  level.nojip = 1;
}

raytraceoffset(origin, xoffset, yoffset, _id_084D0C3E36ADDFA4, _id_191EBD2DD0D5F975, contents, ignoreents) {
  result = scripts\engine\trace::ray_trace(origin + (xoffset, yoffset, _id_084D0C3E36ADDFA4), origin + (xoffset, yoffset, _id_191EBD2DD0D5F975), ignoreents, contents);
  return result;
}

droptogroundmultitrace(origin, _id_084D0C3E36ADDFA4, _id_191EBD2DD0D5F975, _id_C3FBB6661B91750F) {
  _id_1F0F661B1F135896 = -2400;
  _id_3B5AD6F63AF5E57A = 5000;
  _id_E25C6801A01F7FCE = 4000;
  _id_BEFD185E0007A7B8 = -19000 + _id_1F0F661B1F135896;
  _id_E89346B6C5BFD043 = 15;

  if(!isDefined(_id_084D0C3E36ADDFA4))
    _id_084D0C3E36ADDFA4 = _id_E25C6801A01F7FCE;

  if(!isDefined(_id_191EBD2DD0D5F975))
    _id_191EBD2DD0D5F975 = _id_BEFD185E0007A7B8;

  contents = undefined;

  if(isDefined(_id_C3FBB6661B91750F))
    contents = _id_C3FBB6661B91750F;
  else
    contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);

  ignoreents = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("little_bird");
  result = raytraceoffset(origin, 0, 0, _id_084D0C3E36ADDFA4, _id_191EBD2DD0D5F975, contents, ignoreents);

  if(traceresultisValid(result, _id_1F0F661B1F135896))
    return result["position"];

  result = raytraceoffset(origin, _id_E89346B6C5BFD043, 0, _id_084D0C3E36ADDFA4, _id_191EBD2DD0D5F975, contents, ignoreents);

  if(traceresultisValid(result, _id_1F0F661B1F135896))
    return result["position"];

  result = raytraceoffset(origin, 0, _id_E89346B6C5BFD043, _id_084D0C3E36ADDFA4, _id_191EBD2DD0D5F975, contents, ignoreents);

  if(traceresultisValid(result, _id_1F0F661B1F135896))
    return result["position"];

  result = raytraceoffset(origin, -1 * _id_E89346B6C5BFD043, 0, _id_084D0C3E36ADDFA4, _id_191EBD2DD0D5F975, contents, ignoreents);

  if(traceresultisValid(result, _id_1F0F661B1F135896))
    return result["position"];

  result = raytraceoffset(origin, 0, -1 * _id_E89346B6C5BFD043, _id_084D0C3E36ADDFA4, _id_191EBD2DD0D5F975, contents, ignoreents);

  if(traceresultisValid(result, _id_1F0F661B1F135896))
    return result["position"];

  _id_D9A08AE769157CC8 = (origin[0], origin[1], _id_3B5AD6F63AF5E57A);
  return _id_D9A08AE769157CC8;
}

traceresultisValid(result, _id_5484E8AB4179D22F) {
  return result["fraction"] != 1 && result["position"][2] > _id_5484E8AB4179D22F;
}

_id_199ED650E3E5B30C() {
  if(!getdvarint("dvar_74CE45C3EF7D0741", 1)) {
    return;
  }
  if(self.triggertype == "proximity" && !self.usetime) {
    self.touchlist = [];
    self.touchlist["neutral"] = [];
    self.touchlist["none"] = [];
    self.assisttouchlist = undefined;
  }
}

_id_6B531C76815D77F3(scriptablename) {
  if(isammo(scriptablename))
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(scriptablename);
  else
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(scriptablename);

  if(isDefined(lootid))
    return _id_2D9D24F7C63AC143::_id_36B1968BFE78916B(lootid);

  return 0;
}

_id_B7DA95B3958A0EF0(flag, _id_E3108E412AFB3811) {
  currentvalue = self getclientomnvar("br_archived_flags");

  if(istrue(_id_E3108E412AFB3811))
    currentvalue = currentvalue | flag;
  else
    currentvalue = currentvalue &~flag;

  self setclientomnvar("br_archived_flags", currentvalue);
}

_id_179A8D5A185DFB56(_id_E3108E412AFB3811) {
  _id_B7DA95B3958A0EF0(1, _id_E3108E412AFB3811);
}

_id_AC3376FECC550EF0(scriptablename) {
  if(!isDefined(scriptablename))
    return 0;

  return scriptablename == "brloot_offhand_binoculars" || scriptablename == "brloot_offhand_heartbeatsensor" || scriptablename == "brloot_offhand_geigercounter";
}