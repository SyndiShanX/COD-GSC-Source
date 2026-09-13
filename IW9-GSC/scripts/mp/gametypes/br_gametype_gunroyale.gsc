/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_gunroyale.gsc
**********************************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "gunroyale") {
    return;
  }
  init();
}

init() {
  thread _id_826F80257FD81210();
}

_id_826F80257FD81210() {
  waittillframeend;
  level.onplayerkilled = ::_id_FE215CD3800C5578;
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerNakedDropLoadout", ::_id_42EBBEF460D526AF);
  _id_B136DB053D1CF4FD();
  _id_CF7B53136C0EDD17();
  _id_62EAA3050AF3A5BB();
  _id_56149302E3B12B05();
}

_id_D023474236519E43() {
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = "none";
  loadout["loadoutPrimaryAttachment"] = "none";
  loadout["loadoutPrimaryAttachment2"] = "none";
  loadout["loadoutPrimaryAttachment3"] = "none";
  loadout["loadoutPrimaryAttachment4"] = "none";
  loadout["loadoutPrimaryAttachment5"] = "none";
  loadout["loadoutPrimaryCamo"] = "none";
  loadout["loadoutPrimaryReticle"] = "none";
  secondaryweapon = _id_5E77C1882298C281();
  loadout["loadoutSecondary"] = secondaryweapon.basename;
  loadout["loadoutSecondaryVariantID"] = scripts\engine\utility::ter_op(isDefined(secondaryweapon.variantid), secondaryweapon.variantid, 0);
  loadout["loadoutSecondaryAttachment"] = "none";
  loadout["loadoutSecondaryAttachment2"] = "none";
  loadout["loadoutSecondaryAttachment3"] = "none";
  loadout["loadoutSecondaryAttachment4"] = "none";
  loadout["loadoutSecondaryAttachment5"] = "none";
  loadout["loadoutSecondaryCamo"] = "none";
  loadout["loadoutSecondaryReticle"] = "none";
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutSwimWeapon"] = "none";
  loadout["loadoutClimbWeapon"] = "none";
  loadout["loadoutEquipmentPrimary"] = "none";
  loadout["loadoutEquipmentSecondary"] = "none";
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutPerks"] = ["specialty_hustle", "specialty_restock", "specialty_warhead"];
  loadout["loadoutSuper"] = "none";
  loadout["loadoutGesture"] = "playerData";
  return loadout;
}

_id_42EBBEF460D526AF() {
  if(!isDefined(level.brgametype.loadout))
    level.brgametype.loadout = _id_D023474236519E43();

  _id_F8BB81C71CF4EBB3(level.brgametype.loadout);
}

_id_F8BB81C71CF4EBB3(loadout) {
  self.pers["gamemodeLoadout"] = loadout;
  self.class = "gamemode";
  struct = scripts\mp\class::loadout_getclassstruct();
  struct = scripts\mp\class::loadout_updateclass(struct, "gamemode");
  scripts\mp\class::preloadandqueueclassstruct(struct, 1, 1);
  scripts\mp\class::giveloadout(self.team, "gamemode", 1, 1);
  _id_EC2B0D7C087A30E5();
}

_id_62EAA3050AF3A5BB() {
  foreach(team in level.teamnamelist) {
    level.teamdata[team]["gunRoyaleScore"] = 0;
    level.teamdata[team]["teamWeaponIndex"] = 0;
  }
}

_id_AEFBA2BE6A3CE533(team) {
  level.teamdata[team]["gunRoyaleScore"] = level.teamdata[team]["gunRoyaleScore"] + 1;
  _id_E3E8165F8F67045F(team);
  _id_9144E11E979551E9();

  if(level.teamdata[team]["gunRoyaleScore"] >= level._id_D414BA671EB56685)
    thread _id_8D7D28401F970F13(team);
}

_id_246366FE20E4DDDE(team) {
  if(level.teamdata[team]["gunRoyaleScore"] > 0) {
    level.teamdata[team]["gunRoyaleScore"] = level.teamdata[team]["gunRoyaleScore"] - 1;
    _id_E3E8165F8F67045F(team);
    _id_9144E11E979551E9();
  }
}

_id_4A370134CBC53A9C(team) {
  return int(level.teamdata[team]["gunRoyaleScore"]);
}

_id_FE215CD3800C5578(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  if(isDefined(attacker) && isPlayer(attacker) && attacker != self && isDefined(objweapon)) {
    if(objweapon == _id_5E77C1882298C281())
      _id_246366FE20E4DDDE(self.team);

    if(_id_2A7D520196077BAC(objweapon, attacker.team))
      _id_AEFBA2BE6A3CE533(attacker.team);
  }
}

_id_56149302E3B12B05() {
  _id_6BAF68472BCE8B01 = scripts\engine\utility::ter_op(getdvarint("dvar_3EBF6F8B070BD35F", 1), getdvarint("dvar_4838B7C39021124C", 3), 0);

  switch (_id_6BAF68472BCE8B01) {
    case 2:
    case 1:
      level._id_3B2445010F37CE53 = 1;
      level._id_F1C98C98EE4675DA = 1;
      break;
    case 3:
      level._id_3B2445010F37CE53 = 2;
      level._id_F1C98C98EE4675DA = 1;
      break;
    case 4:
      level._id_3B2445010F37CE53 = 3;
      level._id_F1C98C98EE4675DA = 2;
      break;
    default:
      level._id_3B2445010F37CE53 = getdvarint("dvar_39120CE57308390A", 2);
      level._id_F1C98C98EE4675DA = getdvarint("dvar_B50888757CB7A4F5", 1);
      break;
  }

  level._id_D414BA671EB56685 = (level.brgametype._id_8CAC01EF5BCB1816.size - 1) * level._id_3B2445010F37CE53 + level._id_F1C98C98EE4675DA;
  setomnvar("ui_br_gunroyale_max_score", level._id_D414BA671EB56685);
}

_id_9144E11E979551E9() {
  _id_C78F6A328A060AB7 = _id_C01CF4F08D32654F();
  _id_23D3E6625D3F7FA0 = _id_4A370134CBC53A9C(_id_C78F6A328A060AB7[0]);
  _id_8ACBB0D8AC1FC9FA = scripts\engine\utility::ter_op(_id_C78F6A328A060AB7.size > 1, _id_4A370134CBC53A9C(_id_C78F6A328A060AB7[1]), undefined);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C78F6A328A060AB7.size; _id_AC0E594AC96AA3A8++) {
    team = _id_C78F6A328A060AB7[_id_AC0E594AC96AA3A8];
    teamplacement = _id_AC0E594AC96AA3A8 + 1;
    _id_929A6DF466DC4F22 = _id_4A370134CBC53A9C(team);

    foreach(player in level.teamdata[team]["players"]) {
      if(!isDefined(player)) {
        continue;
      }
      if(isDefined(_id_8ACBB0D8AC1FC9FA)) {
        _id_403184B6415044D2 = scripts\engine\utility::ter_op(_id_929A6DF466DC4F22 >= _id_23D3E6625D3F7FA0, _id_8ACBB0D8AC1FC9FA, _id_23D3E6625D3F7FA0);
        player setclientomnvar("ui_br_gunroyale_opponent_score", _id_403184B6415044D2);
      }

      player setclientomnvar("ui_br_gunroyale_team_score", _id_929A6DF466DC4F22);
      player setclientomnvar("ui_br_team_placement", teamplacement);
    }
  }
}

_id_C01CF4F08D32654F() {
  _id_1944E1199C69339A = [];

  foreach(team in level.teamnamelist) {
    if(_id_40144DDCDE4BCC4C(team)) {
      continue;
    }
    _id_1944E1199C69339A[_id_1944E1199C69339A.size] = team;
  }

  return scripts\mp\utility\script::quicksort(_id_1944E1199C69339A, ::_id_EB9D4561BF7E696E);
}

_id_EB9D4561BF7E696E(_id_BF3A49036DE80FCD, _id_6BF32DB8E4C60B98) {
  _id_6BAC05234E357366 = _id_4A370134CBC53A9C(_id_BF3A49036DE80FCD);
  _id_C28B9980243A5251 = _id_4A370134CBC53A9C(_id_6BF32DB8E4C60B98);
  return _id_6BAC05234E357366 >= _id_C28B9980243A5251;
}

_id_8D7D28401F970F13(_id_037E0FE1F4E33613) {
  _id_C78F6A328A060AB7 = _id_C01CF4F08D32654F();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C78F6A328A060AB7.size; _id_AC0E594AC96AA3A8++) {
    team = _id_C78F6A328A060AB7[_id_AC0E594AC96AA3A8];
    teamplacement = _id_AC0E594AC96AA3A8 + 1;
    _id_CD149C72F7A9CC9E(team, teamplacement);
  }

  thread _id_1E4A61DB11011446::brendgame(_id_037E0FE1F4E33613, game["end_reason"]["objective_completed"]);
}

_id_CD149C72F7A9CC9E(team, teamplacement) {
  foreach(player in level.teamdata[team]["players"]) {
    if(!isDefined(player)) {
      continue;
    }
    player freezecontrols(1);
    player setclientomnvar("ui_br_player_position", teamplacement);
    player setclientomnvar("ui_br_squad_eliminated_active", 1);
  }
}

_id_B136DB053D1CF4FD() {
  level.brgametype._id_8CAC01EF5BCB1816 = [];
  _id_CA742875C374502E();
  _id_819C398DC41E2D48 = _id_98EFDA5C0AA6F471();

  foreach(weapontype in _id_819C398DC41E2D48) {
    _id_CA71F4FEF063057C = _id_063E3229314768CF(weapontype);
    level.brgametype._id_8CAC01EF5BCB1816[level.brgametype._id_8CAC01EF5BCB1816.size] = _id_CA71F4FEF063057C;
  }
}

_id_CA742875C374502E() {
  _id_6507022B1007B0E1 = [];
  _id_BAE77D8848F4D84D = getscriptbundle("enum_403F58FA35E67800");

  foreach(_id_BA7D157F3BBF68E9 in _id_BAE77D8848F4D84D._id_7BB993CAF9F54322)
  _id_6507022B1007B0E1[_id_BA7D157F3BBF68E9.type] = scripts\engine\utility::array_randomize(_id_BA7D157F3BBF68E9._id_8CAC01EF5BCB1816);

  level.brgametype._id_6507022B1007B0E1 = _id_6507022B1007B0E1;
}

_id_98EFDA5C0AA6F471() {
  _id_819C398DC41E2D48 = getdvarint("dvar_88AFCD04BC84E6B1", 0);

  switch (_id_819C398DC41E2D48) {
    case 1:
      return ["pistol", "smg_burst", "shotgun", "dmr", "smg_spray", "lmg", "ar_spray", "sniper", "launcher", "meleeFinal"];
    case 2:
      return ["smg_burst", "smg_spray", "ar_burst", "ar_spray", "ar_spray", "lmg", "br", "dmr", "sniper", "meleeFinal"];
    case 3:
      return ["smg_spray", "smg_spray", "ar_spray", "ar_spray", "lmg", "lmg", "dmr", "sniper", "pistol", "meleeFinal"];
    case 4:
      return ["pistol", "shotgun", "smg_burst", "smg_spray", "lmg", "ar_burst", "ar_spray", "br", "dmr", "sniper", "launcher", "meleeFinal"];
    default:
      return ["pistol", "shotgun", "smg_burst", "smg_spray", "lmg", "ar_spray", "br", "sniper", "launcher", "meleeFinal"];
  }
}

_id_063E3229314768CF(weapontype) {
  _id_8D28E9CDD8829565 = undefined;

  if(isDefined(level.brgametype._id_6507022B1007B0E1[weapontype]) && level.brgametype._id_6507022B1007B0E1[weapontype].size > 0) {
    _id_2F253F748439AEF9 = 1;

    foreach(_id_558774275543A708 in level.brgametype._id_6507022B1007B0E1[weapontype]) {
      if(istrue(_id_558774275543A708._id_FC4EA3D56E6C1110)) {
        continue;
      }
      _id_8D28E9CDD8829565 = _id_558774275543A708;
      _id_558774275543A708._id_FC4EA3D56E6C1110 = 1;
      _id_2F253F748439AEF9 = 0;
      break;
    }

    if(istrue(_id_2F253F748439AEF9)) {
      _id_610520BE555433B2 = randomint(level.brgametype._id_6507022B1007B0E1[weapontype].size);
      _id_8D28E9CDD8829565 = level.brgametype._id_6507022B1007B0E1[weapontype][_id_610520BE555433B2];
    }
  }

  if(!isDefined(_id_8D28E9CDD8829565)) {
    _id_8D28E9CDD8829565 = spawnStruct();
    _id_8D28E9CDD8829565.weapontype = "ar_spray";
    _id_8D28E9CDD8829565._id_BAE77D8848F4D84D = "iw9_ar_mike4_mp";
    _id_8D28E9CDD8829565._id_6794F7417ED0B5A2 = 0;
  }

  _id_CA71F4FEF063057C = _id_2669878CF5A1B6BC::buildweapon(_id_8D28E9CDD8829565._id_BAE77D8848F4D84D, [], "none", "none", _id_8D28E9CDD8829565._id_6794F7417ED0B5A2);
  return _id_CA71F4FEF063057C;
}

_id_E3E8165F8F67045F(team) {
  _id_929A6DF466DC4F22 = _id_4A370134CBC53A9C(team);
  _id_1B9206F5B4AD02E0 = _id_FA4EA86F32505B15(team);

  if(_id_929A6DF466DC4F22 <= level._id_D414BA671EB56685 - level._id_F1C98C98EE4675DA)
    level.teamdata[team]["teamWeaponIndex"] = floor(_id_929A6DF466DC4F22 / level._id_3B2445010F37CE53);

  _id_F9D99F28A65562CD = _id_1B9206F5B4AD02E0 < level.teamdata[team]["teamWeaponIndex"];
  _id_FFF1B7FA4F6E4701 = _id_1B9206F5B4AD02E0 > level.teamdata[team]["teamWeaponIndex"];
  _id_6B080C717E855E13 = istrue(_id_F9D99F28A65562CD) || istrue(_id_FFF1B7FA4F6E4701);

  if(istrue(_id_6B080C717E855E13)) {
    foreach(player in level.teamdata[team]["alivePlayers"])
    player _id_EC2B0D7C087A30E5();
  }

  if(istrue(_id_F9D99F28A65562CD)) {
    foreach(player in level.teamdata[team]["players"])
    player _id_1E8A61CBBA599C09();
  }
}

_id_B48CA644B01FD975(team) {
  _id_1B9206F5B4AD02E0 = _id_FA4EA86F32505B15(team);
  objweapon = level.brgametype._id_8CAC01EF5BCB1816[_id_1B9206F5B4AD02E0];
  return objweapon;
}

_id_2A7D520196077BAC(objweapon, team) {
  return objweapon == _id_B48CA644B01FD975(team);
}

_id_F6A2E55BE0AF3A3C(team) {
  return _id_B48CA644B01FD975(team) == _id_5E77C1882298C281();
}

_id_5E77C1882298C281() {
  return level.brgametype._id_8CAC01EF5BCB1816[level.brgametype._id_8CAC01EF5BCB1816.size - 1];
}

_id_FA4EA86F32505B15(team) {
  return int(level.teamdata[team]["teamWeaponIndex"]);
}

_id_EC2B0D7C087A30E5() {
  if(_id_F6A2E55BE0AF3A3C(self.team))
    scripts\cp_mp\utility\inventory_utility::_takeweapon(self.secondaryweapon);

  if(isDefined(self.primaryweapon))
    scripts\cp_mp\utility\inventory_utility::_takeweapon(self.primaryweapon);

  _id_72672CD81EC1093D = _id_B48CA644B01FD975(self.team);
  self.primaryweapon = _id_72672CD81EC1093D;
  self.primaryweaponobj = _id_72672CD81EC1093D;
  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_72672CD81EC1093D);
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(_id_72672CD81EC1093D);
  _id_903461B2C1A68908(_id_72672CD81EC1093D);
}

_id_903461B2C1A68908(weapon) {}

_id_CF7B53136C0EDD17() {
  level.respawnheightoverride = getdvarint("dvar_AE35E4BB8A3AA9E7", 19000);
  level.brgametype._id_F50EBEFCC7D069A2 = getdvarint("dvar_C37516BB0903A37C", 1);
  level.brgametype._id_65F8FA4978A64FF2 = getdvarint("dvar_559F1E8919659440", 2);
  level.brgametype.respawndelay = getdvarint("dvar_2A410697B1CFE7F5", 10);
  level.brgametype._id_A916B204F027AF6B = getdvarint("dvar_A91B489383D89274", 0);
  level.brgametype._id_6F3C4D74A8C614AB = getdvarint("dvar_38AFF65BDA44B82A", 1);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("mayConsiderPlayerDead", ::_id_989C7D7F381856CA);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("triggerRespawnOverlay", ::_id_717F2775548D5FD7);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("kioskRevivePlayer", ::_id_611CE3EB3081CF2C);
  level.ondeadevent = ::_id_DC858233A1872732;
  thread _id_1852B91CA4326856();
  thread _id_BC585657F20CA114();
}

_id_BC585657F20CA114() {
  level endon("game_ended");
  level waittill("prematch_fade_done");
  level.brgametype._id_C42E40EC22A1F0D4 = 1;

  foreach(player in level.players)
  player._id_E2A28BB5B9800948 = level.brgametype._id_F50EBEFCC7D069A2;
}

_id_1852B91CA4326856() {
  foreach(name, team in level.teamdata)
  level.teamdata[name]["deadPlayers"] = [];
}

_id_989C7D7F381856CA(player) {
  if(scripts\mp\flags::gameflag("prematch_done") && scripts\mp\flags::gameflag("prematch_fade_done")) {
    player thread _id_E180AD77AB9F911C();
    _id_0A34750D17473C49::markplayeraseliminated(player);
  }

  return 1;
}

_id_E180AD77AB9F911C() {
  if(!istrue(level.brgametype._id_C42E40EC22A1F0D4)) {
    return;
  }
  player = self;
  level endon("game_ended");
  player endon("squad_wiped");
  player endon("disconnect");
  player thread _id_5ED9302B97C19047();
  player.respawndelay = level.brgametype.respawndelay;
  _id_DE1E71241AAE57ED = 0;

  if(isDefined(player._id_E2A28BB5B9800948)) {
    while(player.respawndelay > 0 || _id_DE1E71241AAE57ED == 0) {
      if(isalive(player)) {
        player.respawndelay = 0;
        _id_DE1E71241AAE57ED = 1;
      }

      wait 1;
      player.respawndelay--;

      if(player._id_E2A28BB5B9800948 > 0 && player.respawndelay <= 0 && !isalive(player)) {
        player thread _id_B97A89DB030E6FE0(level.teamdata[player.team]["alivePlayers"]);
        player _id_33939AE89E367152();
        _id_DE1E71241AAE57ED = 1;
      }

      if(_id_40144DDCDE4BCC4C(player.team)) {
        break;
      }
    }
  }
}

_id_B97A89DB030E6FE0(_id_54EBFC906D9A55E7) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player notify("doingRespawn");

  if(istrue(level.brgametype._id_6F3C4D74A8C614AB))
    player notify("started_spawnPlayer");

  _id_3A2841CB1A537313();
  _id_0A34750D17473C49::unmarkplayeraseliminated(player);
  player scripts\mp\playerlogic::addtoalivecount("gunroyale");
  player _id_7E52B56769FA7774::addrespawntoken(1);
  player.respawningfromtoken = 1;
  _id_1476E0F78320A501 = 0;

  if(istrue(level.brgametype._id_A916B204F027AF6B))
    _id_1476E0F78320A501 = player _id_5BAB271917698DC4::playerwaitforprestreaming();

  streamtimeout = _id_2CEDCC356F1B9FC8::getdefaultstreamhinttimeoutms() / 1000;
  spawnpoint = player _id_5BAB271917698DC4::_id_952548D8AED47102(0, streamtimeout, level.respawnheightoverride);
  _id_11F3B4465C8B637B = player _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
  self.forcespawnorigin = _id_11F3B4465C8B637B;

  if(_id_1476E0F78320A501)
    player scripts\mp\utility\lower_message::setlowermessageomnvar(0);

  _id_B59F471C2C064E56 = 1.0;
  player _id_5BAB271917698DC4::_id_334A8FE67E88BBE7();
  wait(_id_B59F471C2C064E56);
  player scripts\mp\hud_message::clearsplashqueue();
  player scripts\mp\playerlogic::spawnplayer(undefined, 0);
  player scripts\cp_mp\execution::_clearexecution();
  player _id_7E52B56769FA7774::initplayer();
  player.respawningfromtoken = undefined;
  player _id_6489FCDFE6FA2E36::playerclearspectatekillchainsystem();
  player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 0);
  player thread _id_5BAB271917698DC4::triggerrespawnoverlay(4);
  player _id_FE0F59869B5ADF07(spawnpoint, _id_11F3B4465C8B637B);
}

_id_FE0F59869B5ADF07(spawnpoint, _id_11F3B4465C8B637B) {
  level notify("update_circle_hide");

  if(isDefined(self.oobimmunity))
    scripts\mp\outofbounds::disableoobimmunity(self);

  _id_1E4A61DB11011446::givelaststandifneeded(self);

  if(istrue(self.squadwiped))
    self.squadwiped = 0;

  if(!isDefined(spawnpoint))
    spawnpoint = _id_5BAB271917698DC4::_id_952548D8AED47102(undefined, undefined, level.respawnheightoverride);

  spawnorigin = spawnpoint.origin;
  spawnangles = spawnpoint.angles;
  startorigin = spawnorigin;

  if(isDefined(_id_11F3B4465C8B637B))
    startorigin = _id_11F3B4465C8B637B;

  _id_5BAB271917698DC4::_id_961B4AFC4C695B94();
  self setOrigin(startorigin, 1);
  self setplayerangles(spawnangles);
  linker = spawn("script_model", startorigin);
  linker setModel("tag_origin");
  linker.angles = spawnangles;
  linker hide();
  linker showtoplayer(self);
  self playerlinktoabsolute(linker, "tag_origin");
  scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_gametype_gunroyale::brGR_respawn()");
  thread _id_5BAB271917698DC4::playercleanupentondisconnect(linker);
  waitframe();
  _id_8A9081C470563AC0();

  if(getdvarint("dvar_DF02345C60008647", 1) == 0)
    _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();

  _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin();

  if(isDefined(_id_11F3B4465C8B637B))
    linker.origin = spawnorigin;

  linker playsoundtoplayer("br_ac130_flyby", self);
  wait 1.5;
  self unlink();
  self clearsoundsubmix("deaths_door_mp");
  self clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
  self clearclienttriggeraudiozone(1);
  scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
  scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("br_gametype_gunroyale::brGR_respawn()");
  _id_67E06A8DA315AC6A(1);
  _id_6489FCDFE6FA2E36::playerclearspectatekillchainsystem();
  scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 0);
  _id_BDA1DE83E1856735 = 0;

  if(isDefined(level.parachutedeploydelay))
    _id_BDA1DE83E1856735 = level.parachutedeploydelay;

  thread scripts\cp_mp\parachute::startfreefall(_id_BDA1DE83E1856735, 0, undefined, undefined, 1);
  self setclientomnvar("ui_show_spectateHud", -1);
  _id_5BAB271917698DC4::resetplayermovespeedscale();
  _id_64E4C3AB6B01B316::givestartingarmor();
  _id_3ACF1C0EBAF602F2::onplayerrespawn();
  _id_4D5A55FCA0ED1835::onplayerrespawn();
  _id_7E52B56769FA7774::removerespawntoken();
  wait 0.5;
  thread _id_5BAB271917698DC4::playercinematicfadeout();
  waitframe();
  linker delete();
  self notify("can_show_splashes");
}

_id_67E06A8DA315AC6A(enable) {
  if(enable) {
    self enableoffhandweapons();
    self enableusability();
  } else {
    self disableoffhandweapons();
    self disableusability();
  }
}

_id_8A9081C470563AC0() {
  self.health = self.maxhealth;
  _id_6A5D3BF7A5B7064A::onexitdeathsdoor(1);
  _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("isRespawning", 0);
}

_id_717F2775548D5FD7() {
  wait 0.5;
  return 1;
}

_id_611CE3EB3081CF2C(_id_84E2123AACA9A965, _id_57D71760971F748F) {
  _id_C7869D69DBCF7FD3 = self;
  _id_C7869D69DBCF7FD3 thread _id_67708F418B1FAC79::playergulagautowin("grKioskRevive", _id_84E2123AACA9A965, _id_57D71760971F748F);
  _id_C7869D69DBCF7FD3.squadwiped = 0;
  _id_C7869D69DBCF7FD3 _id_3A2841CB1A537313();
  return;
}

_id_5ED9302B97C19047() {
  level endon("game_ended");
  self endon("disconnect");
  waitframe();
  waittillframeend;
  _id_CF05FD4CAE69F883();
}

_id_CF05FD4CAE69F883() {
  _id_92884735D8E33FBB = spawnStruct();
  _id_92884735D8E33FBB.player = self;
  _id_7193E062042F638D = [];
  _id_77AE8A032E59320B = level.teamdata[self.team]["deadPlayers"];

  foreach(dead in _id_77AE8A032E59320B) {
    if(isDefined(dead))
      _id_7193E062042F638D[_id_7193E062042F638D.size] = dead.player.name;
  }

  level.teamdata[self.team]["deadPlayers"] = scripts\engine\utility::array_add(level.teamdata[self.team]["deadPlayers"], _id_92884735D8E33FBB);
}

_id_3A2841CB1A537313() {
  _id_77AE8A032E59320B = level.teamdata[self.team]["deadPlayers"];
  _id_D674D7970EEF9653 = [];

  foreach(item in _id_77AE8A032E59320B) {
    if(isDefined(item) && item.player != self)
      _id_D674D7970EEF9653[_id_D674D7970EEF9653.size] = item;
  }

  _id_77AE8A032E59320B = _id_D674D7970EEF9653;
  level.teamdata[self.team]["deadPlayers"] = _id_77AE8A032E59320B;
}

_id_1E8A61CBBA599C09() {
  if(self._id_E2A28BB5B9800948 < level.brgametype._id_65F8FA4978A64FF2)
    self._id_E2A28BB5B9800948++;
}

_id_33939AE89E367152() {
  if(self._id_E2A28BB5B9800948 > 0)
    self._id_E2A28BB5B9800948--;
}

_id_DC858233A1872732(team) {
  if(isDefined(team) && team != "all") {
    players = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(_id_736D8D9188CCBD45 in players) {
      if(isDefined(_id_736D8D9188CCBD45))
        _id_736D8D9188CCBD45.squadwiped = 1;
    }

    if(_id_40144DDCDE4BCC4C(team)) {
      thread _id_1E4A61DB11011446::onsquadeliminated(team);
      scripts\mp\gamelogic::default_ondeadevent(team);
    }
  }
}

_id_40144DDCDE4BCC4C(team) {
  _id_99625D3DA64B1246 = undefined;
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(_id_736D8D9188CCBD45 in players) {
    if(isDefined(_id_736D8D9188CCBD45) && istrue(_id_736D8D9188CCBD45.squadwiped))
      _id_99625D3DA64B1246 = 1;
  }

  if(istrue(_id_99625D3DA64B1246) && _id_323BEA616F0EF5EA(team) <= 0)
    return 1;

  return 0;
}

_id_323BEA616F0EF5EA(team) {
  _id_79EDB9CFE7E95925 = 0;
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in _id_A6AB8D0FDA441DC2)
  _id_79EDB9CFE7E95925 = _id_79EDB9CFE7E95925 + player._id_E2A28BB5B9800948;

  return _id_79EDB9CFE7E95925;
}