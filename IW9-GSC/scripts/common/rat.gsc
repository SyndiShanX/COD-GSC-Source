/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\rat.gsc
***********************************************/

init() {
  if(isDefined(level._id_6392BEFA93AE3CC6)) {
    return;
  }
  level._id_6392BEFA93AE3CC6 = [];
  level._id_91CA776F27D516C0 = [];
  _id_7A2DF9055CB22721("RatGetPlayerPosition", ::_id_1D8337A738D7532A, "vector3");
  _id_7A2DF9055CB22721("RatGetPlayerAngles", ::_id_C83951D46586F551, "vector3");
  _id_7A2DF9055CB22721("RatGetPlayerIsSwitchingWeapon", ::_id_14EBD6FA4B64977F, "bool");
  _id_7A2DF9055CB22721("RatGetPlayerIsReloading", ::_id_1FC9F18B0501F2DC, "bool");
  _id_7A2DF9055CB22721("RatGetPlayerIsMeleeing", ::_id_8E824BBE5A079B4D, "bool");
  _id_7A2DF9055CB22721("RatGetPlayerADS", ::_id_B194576E9BBE94D1, "float");
  _id_7A2DF9055CB22721("RatGetPlayerStance", ::_id_19E0BD157C921345, "string");
  _id_7A2DF9055CB22721("RatGetPlayerHealth", ::_id_A54F0792C1F1DEAF, "int64_t");
  _id_7A2DF9055CB22721("RatSetPlayerHealth", ::_id_C1FD9671BFC996C3);
  _id_7A2DF9055CB22721("RatDoDamage", ::_id_38FD7126D56ED438, "bool");
  _id_7A2DF9055CB22721("RatGetClipAmmoCount", ::_id_1EC2630BF175E33F, "int64_t");
  _id_7A2DF9055CB22721("RatGetTotalAmmoCount", ::_id_7929431D2F06C183, "int64_t");
  _id_7A2DF9055CB22721("RatGetCompleteWeaponName", ::_id_47B08883815FF704, "string");
  _id_7A2DF9055CB22721("RatGetPlayerKills", ::_id_ECC6D80FAA7B3EFE, "int64_t");
  _id_7A2DF9055CB22721("RatGetPlayerDeaths", ::_id_7344CE0E91F9715A, "int64_t");
}

_id_7A2DF9055CB22721(_id_9BC7C47CBF86E43D, _id_66130EF1F7F7270F, _id_E249B3B7EC719CB4) {
  key = tolower(_id_9BC7C47CBF86E43D);
  level._id_6392BEFA93AE3CC6[key] = _id_66130EF1F7F7270F;
  level._id_91CA776F27D516C0[key] = _id_E249B3B7EC719CB4;
}

_id_070CF605D288EBAE(_id_9BC7C47CBF86E43D) {
  init();
  key = tolower(_id_9BC7C47CBF86E43D);

  if(isDefined(level._id_91CA776F27D516C0[key]))
    return level._id_91CA776F27D516C0[key];

  return "";
}

_id_B596C6FF2E019C61(params) {
  key = tolower(params._id_279A44DD155A1BE2);
  func = level._id_6392BEFA93AE3CC6[key];
  return [[func]](params);
}

_id_C98BC8F1BC6DECB2(params) {
  if(isDefined(params.xuid)) {
    xuid = int(params.xuid);
    players = getEntArray("player", "classname");

    for(index = 0; index < players.size; index++) {
      player = players[index];

      if(!isDefined(player.bot)) {
        params.xuid = int(player getxuid());

        if(xuid == params.xuid)
          return player;
      }
    }
  }

  if(!isDefined(level.players) || !isDefined(level.players[0]))
    return level.player;

  return level.players[0];
}

_id_1D8337A738D7532A(params) {
  player = _id_C98BC8F1BC6DECB2(params);
  return player.origin + (0, 0, 60);
}

_id_C83951D46586F551(params) {
  player = _id_C98BC8F1BC6DECB2(params);
  _id_3C70A7175FBFA3FC = player getplayerangles();
  return ((_id_3C70A7175FBFA3FC[0] + 360) % 360, (_id_3C70A7175FBFA3FC[1] + 360) % 360, _id_3C70A7175FBFA3FC[2]);
}

_id_14EBD6FA4B64977F(params) {
  player = _id_C98BC8F1BC6DECB2(params);
  return player isswitchingweapon();
}

_id_1FC9F18B0501F2DC(params) {
  player = _id_C98BC8F1BC6DECB2(params);
  return player isreloading();
}

_id_8E824BBE5A079B4D(params) {
  player = _id_C98BC8F1BC6DECB2(params);
  return player ismeleeing();
}

_id_B194576E9BBE94D1(params) {
  player = _id_C98BC8F1BC6DECB2(params);
  return player playerads();
}

_id_19E0BD157C921345(params) {
  player = _id_C98BC8F1BC6DECB2(params);
  return player getstance();
}

_id_A54F0792C1F1DEAF(params) {
  player = _id_C98BC8F1BC6DECB2(params);
  return player.health;
}

_id_C1FD9671BFC996C3(params) {
  amount = _id_DF18326E92ABC83B(params.amount, 1.0);
  player = _id_C98BC8F1BC6DECB2(params);
  player.health = amount;
}

_id_38FD7126D56ED438(params) {
  amount = _id_B4A0DB97EE6D9256(params.amount, 1.0);
  _id_26FE25F7F39DE3A8 = _id_237B5B4DD63C605E(params._id_26FE25F7F39DE3A8, 0);
  player = _id_C98BC8F1BC6DECB2(params);

  if(_id_26FE25F7F39DE3A8) {
    _id_8E3F23290B67F726 = getdvarint("dvar_45DD70C0AC1AFDA2");
    setDvar("dvar_45DD70C0AC1AFDA2", 1);
    success = player dodamage(amount, player.origin);
    setDvar("dvar_45DD70C0AC1AFDA2", _id_8E3F23290B67F726);
  } else
    success = player dodamage(amount, player.origin, player);

  return success;
}

_id_1EC2630BF175E33F(params) {
  player = _id_C98BC8F1BC6DECB2(params);
  return player getcurrentweaponclipammo();
}

_id_7929431D2F06C183(params) {
  player = _id_C98BC8F1BC6DECB2(params);
  currentweapon = player getcurrentweapon();
  return player getammocount(currentweapon);
}

_id_47B08883815FF704(params) {
  player = _id_C98BC8F1BC6DECB2(params);
  currentweapon = player getcurrentweapon();
  weaponname = getcompleteweaponname(currentweapon);
  return weaponname;
}

_id_ECC6D80FAA7B3EFE(params) {
  player = _id_C98BC8F1BC6DECB2(params);
  return player.kills;
}

_id_7344CE0E91F9715A(params) {
  player = _id_C98BC8F1BC6DECB2(params);
  return player.deaths;
}

_id_DF18326E92ABC83B(param, _id_540D580F7A9505DE) {
  if(!isDefined(param))
    return _id_540D580F7A9505DE;

  return int(param);
}

_id_B4A0DB97EE6D9256(param, _id_540D580F7A9505DE) {
  if(!isDefined(param))
    return _id_540D580F7A9505DE;

  return float(param);
}

_id_237B5B4DD63C605E(param, _id_540D580F7A9505DE) {
  if(!isDefined(param))
    return _id_540D580F7A9505DE;

  _id_11CA4146797DA8F0 = tolower(param);

  if(_id_11CA4146797DA8F0 == "false" || _id_11CA4146797DA8F0 == "0")
    return 0;

  return 1;
}