/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2012.gsc
*************************************************/

init() {
  level.leanthread = getdvarint("#x3e3ebdc1d60efb8da", 0) == 1;
  level.script = tolower(getDvar("#x376847958d67972ef"));
  level.gametype = tolower(getDvar("#x315af23e89f368200"));
  level.codcasterenabled = getdvarint("#x32570320b7015b225", 0) == 1;
  level.systemlink = getdvarint("#x3297ffeae3a9e9231", 0) == 1;
  level.useperbullethitmarkers = getdvarint("#x33adeebe7fcfc9b08", 0) == 1;
  level.splitscreen = _func_011F();
  var_0 = getdvarint("#x3580980004274b38b", 0) == 1 || !isgamebattlematch();
  level.onlinegame = getdvarint("#x34e9ab8c76756925d");
  level.rankedmatch = level.onlinegame && !getdvarint("#x310c28bb5d64c8c6d") && var_0 || getdvarint("#x378c3667dfc793afa");
  level.matchmakingmatch = level.onlinegame && !getdvarint("#x310c28bb5d64c8c6d");
  level.playerxpenabled = level.matchmakingmatch && var_0 || getdvarint("#x378c3667dfc793afa");
  level.weaponxpenabled = level.playerxpenabled;
  level.challengesallowed = level.playerxpenabled || getdvarint("#x39da705b2efed14b2");
  level.enforceantiboosting = level.playerxpenabled || level.weaponxpenabled || level.challengesallowed;
  level.onlinestatsenabled = level.rankedmatch;
  level.leagueplaymatch = getdvarint("#x3aaa68a87d79fa0b6");
  level._id_E730 = _func_00D7();
  scripts\mp\utility\stats::setplayerdatagroups();
  level._id_5F3A = level._id_01E2 / 1000;
  level.teambased = 0;
  level._id_A8D4 = 0;
  level._id_5303 = 1;
  level._id_DCBA = 0;
  level._id_F295 = getdvarint("#x38548afe115b9d808");
  level._id_73BD = "halftime";
  level._id_903C = 0;
  level._id_10A24 = "none";
  level._id_9047 = 0;
  level._id_BA5A = 4.5;
  level._id_10DC8 = [];
  _id_C251();
  setthrowingweaponcallbacks();

  if(scripts\mp\utility\game::matchmakinggame()) {
    var_1 = " LB_MAP_" + getDvar("#x36d16f02578d0ee10");
    var_2 = "";
    var_3 = "";
    var_3 = "LB_GB_TOTALXP_AT LB_GB_TOTALXP_LT LB_GB_WINS_AT LB_GB_WINS_LT LB_GB_KILLS_AT LB_GB_KILLS_LT LB_GB_ACCURACY_AT LB_ACCOLADES";
    var_2 = " LB_GM_" + level.gametype;

    if(getdvarint("#x3af383f37c3a10748")) {
      var_2 = var_2 + "_HC";
    }

    _func_01AA(var_3 + var_2 + var_1);
  }

  level thread _id_084D::_id_DEFA();

  switch (scripts\mp\utility\game::getexperimentaldvarsetnumber()) {
    case 1:
      setDvar("#x34348a48effaf53db", "stcf2_DT");
      setDvar("#x3786b1d0072bbf7c0", 1);
      break;
    case 2:
      setDvar("#x34348a48effaf53db", "stcf2_R");
      setDvar("#x3347c3720ea131ae6", 22500);
      break;
    case 3:
      setDvar("#x34348a48effaf53db", "stcf2_DT-R");
      setDvar("#x3786b1d0072bbf7c0", 1);
      setDvar("#x3347c3720ea131ae6", 22500);
      break;
    case 4:
      setDvar("#x34348a48effaf53db", "stcf2_HL-DT-R");
      setDvar("#x37c1378efcb07a186", 5000);
      setDvar("#x3786b1d0072bbf7c0", 1);
      setDvar("#x3347c3720ea131ae6", 22500);
      break;
    case 5:
      setDvar("#x34348a48effaf53db", "stcf2_LL-DT-R");
      setDvar("#x31164269ea9b26376", 3000);
      setDvar("#x37c1378efcb07a186", 5000);
      setDvar("#x3786b1d0072bbf7c0", 1);
      setDvar("#x3347c3720ea131ae6", 22500);
      break;
    default:
      var_4 = 0;
      var_4 = var_4 + getdvarint("#x362075248d18c02ef", 0);
      var_4 = var_4 + getdvarint("#x363b7fbc5cf89e049", 0);
      var_4 = var_4 + getdvarint("#x37e2e19b84ebaa633", 0);
      var_4 = var_4 + getdvarint("#x3668bc5183d388cb5", 0);
      var_4 = var_4 + getdvarint("#x373cae31acde46c45", 0);

      if(var_4 > 0) {
        setDvar("#x34348a48effaf53db", "stcf2_control");
        return;
      }
  }
}

setthrowingweaponcallbacks() {
  level._id_7168 = scripts\mp\weapons::_id_7168;
  level._id_8774 = scripts\mp\utility\weapon::_id_8774;
  level.displayhudmessage = _id_07C4::_id_7B6B;
  level._id_5BFC = scripts\mp\weapons::_id_5BFC;
  level._id_10C2F = scripts\mp\weapons::_id_10BCF;
  level._id_7AB1 = scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause;
  level.outlineaxe = scripts\mp\utility\outline::outlineenableforplayer;
  level.ricochetaxe = scripts\mp\weapons::_id_C2F0;
}

_id_5327() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);

    if(var_0 ishost()) {
      var_1 = var_0;
      break;
    }
  }

  var_1 waittill("disconnect");
  thread scripts\mp\gamelogic::_id_52F7("draw", game["end_reason"]["host_ended_game"]);
}

_id_C251() {
  if(getDvar("#x3a8fb0620196c6263") != "1") {
    setomnvar("ui_nuke_end_milliseconds", 0);
  }

  setDvar("#x38e356d04714e7f2c", "");
  setDvar("#x31ce9c5116005b62a", 0);
  setDvar("#x35fabbf5308a8b0cc", 0);
  setDvar("#x36c8f5946a1247e70", getdvarint("#x3a0b18441977f013b"));
  setDvar("#x3eda3e1dbaa77e557", 1750);
  setDvar("#x3c80aa624ac7318ab", 275);
  setDvar("#x366d61d90ed3d6119", 375);
  setDvar("#x35c1ba2123ed16e6a", 275);
  setDvar("#x346347e6aa0d17b2c", 375);
  setDvar("#x3406ec6dcd8b93898", 0);
}

_id_D854() {
  _id_D501();
  _id_0011::_id_D85E();
  scripts\mp\gametypes\common::_id_D85A();
  level._id_6D4A = ::_id_253B;
  level._id_ABA4 = scripts\mp\gametypes\common::_id_ABA5;
  level._id_AB71 = scripts\mp\gametypes\common::_id_AB71;
  level._id_AB8C = ::_id_253B;
  level._id_ABC0 = scripts\mp\gamelogic::_id_4580;
  level._id_AAFC = scripts\mp\gamelogic::_id_457E;
  level._id_AAA3 = scripts\mp\gamelogic::_id_457D;
  level._id_AB47 = scripts\mp\gamelogic::_id_457F;
  level._id_AB7F = ::_id_253B;
  level._id_ABAD = ::_id_253B;
  level._id_AB70 = ::_id_253B;

  if(!scripts\mp\utility\game::_id_98D3()) {
    level._id_9BD7 = _id_07F0::init;
  }

  level._id_10DB1 = scripts\mp\utility\weapon::_id_9ACB;
  level._id_812C = _id_09EF::_id_812C;
  level._id_D468 = _id_09EF::_id_D136;
  level._id_121E = _id_0A8B::_id_0DB6;
  level._id_1215 = _id_09EF::_id_1215;
  level._id_6A56 = _id_09EF::_id_6A56;
  level._id_115A = _id_0817::_id_115A;
  level._id_BB9F = scripts\mp\playerlogic::_id_B75B;
  level._id_FC75 = scripts\mp\gamelogic::_id_FC75;
}

_id_D501() {
  level._id_2F59 = scripts\mp\gamelogic::_id_2F3F;
  level._id_2F4A = scripts\mp\playerlogic::_id_2F36;
  level._id_2F4B = scripts\mp\playerlogic::_id_2F37;
  level._id_2F4D = scripts\mp\playerlogic::_id_2F3A;
  level._id_2F4C = _id_07C3::_id_2F38;
  level._id_2F4E = _id_07C3::_id_2F3B;
  level._id_2F4F = _id_07C3::_id_2F3C;
  level._id_2F50 = _id_07C3::_id_2F3D;
  level._id_2F51 = scripts\mp\playerlogic::_id_2F3E;
  level._id_2F48 = scripts\mp\hostmigration::_id_2F32;
  level._id_2F46 = scripts\mp\weapons::_id_2F26;
  level._id_2F57 = _id_0817::_id_3A22;
  level._id_2F58 = _id_0817::_id_3A23;
  level._id_2F56 = _id_0817::_id_3A21;
}

_id_253B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

_id_44DC(var_0, var_1) {
  for(var_2 = 0; var_2 < 50; var_2++) {
    wait 0.05;
  }
}