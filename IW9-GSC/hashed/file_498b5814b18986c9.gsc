/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_498b5814b18986c9.gsc
***********************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("scubaGasMask", "hasScubaGasMask", ::_id_5D9D2C2A5901FEA2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("scubaGasMask", "isScubaGasMaskEquipped", ::_id_924B408D0B51F2DD);
  scripts\cp_mp\utility\script_utility::registersharedfunc("scubaGasMask", "removeScubaGasMaskFromPlayer", ::_id_F7171C4854FC6E65);
  scripts\cp_mp\utility\script_utility::registersharedfunc("scubaGasMask", "updateScubaGasmask", ::_id_DDE366FAB56A1A89);
  scripts\cp_mp\utility\script_utility::registersharedfunc("scubaGasMask", "monitorScubaGasMaskDamage", ::_id_4E41BF5F9D46E115);
}

_id_18D5497F462E3A46(player) {
  return istrue(self._id_5239162658BE30D6);
}

_id_5D9D2C2A5901FEA2(player) {
  return _id_18D5497F462E3A46(player) && scripts\cp_mp\gasmask::hasgasmask(player);
}

_id_924B408D0B51F2DD(player) {
  return _id_5D9D2C2A5901FEA2(player) && scripts\cp_mp\gasmask::_id_260708C89A11F0C3(player);
}

_id_F7171C4854FC6E65(player) {
  if(_id_5D9D2C2A5901FEA2(player))
    player._id_5239162658BE30D6 = undefined;
}

_id_DDE366FAB56A1A89(player, _id_6150B9D03028F80C) {
  if(isDefined(player) && isDefined(player.origin))
    level thread _id_9C13C9F95161D576(player, _id_6150B9D03028F80C);
}

_id_9C13C9F95161D576(player, _id_6150B9D03028F80C) {
  player endon("death_or_disconnect");
  player notify("queue_scuba");
  player endon("queue_scuba");
  level endon("game_ended");

  for(;;) {
    if(!istrue(player.gasmaskswapinprogress)) {
      break;
    }

    waitframe();
  }

  if(_id_6150B9D03028F80C)
    player _id_7E52B56769FA7774::_id_00CDF7F2F6BD3207("underwater");
  else
    player _id_7E52B56769FA7774::_id_8206BC54A1ED73CB("underwater");
}

_id_4E41BF5F9D46E115() {
  self endon("death_or_disconnect");
  self endon("swim_breathing_disabled_end");
  level endon("game_ended");
  _id_9B7983C73DF8B968 = getdvarfloat("dvar_4A852245A5077873", 1.0);
  _id_76E563DB5D11A0EA = getdvarfloat("dvar_8D16D3F760DF5419", 0.857);

  for(;;) {
    if(!_id_4B87F2871B6B025C::_id_1CF18F5E612E68C5()) {
      break;
    }

    if(!_id_5D9D2C2A5901FEA2(self)) {
      break;
    }

    if(isDefined(self.origin) && !istrue(self.plotarmor))
      scripts\cp_mp\gasmask::processdamage(_id_76E563DB5D11A0EA);

    wait(_id_9B7983C73DF8B968);
  }
}