/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_27fdece778e999d8.gsc
***********************************************/

initialize(_id_F9320D3953360CA2) {
  _id_0D74AE0B4AA21186::_id_0232B4A5109DF340(_id_F9320D3953360CA2);
  level.bot_funcs["player_spawned_gamemode"] = ::_id_B1F5606E58998B8D;
  level.bot_funcs["gametype_think"] = ::_id_A3B11047212A9BBD;
  level.modifyplayerdamage = ::modifyplayerdamage;
  level.bot_funcs["revive_think"] = scripts\engine\utility::void;
}

_id_B1F5606E58998B8D() {
  _id_59FF79D681BB860C::_id_21B2D65575E9C0CC("Combat");
  self botsetflag("ignore_nodes", 1);
  _id_5F51C5C13FD2911B();
}

_id_5F51C5C13FD2911B() {
  if(!isDefined(self._id_D298338A64096D6D)) {
    difficulty = _id_59FF79D681BB860C::_id_D55289CEEC7CF934();
    scripts\mp\bots\bots_util::bot_set_difficulty(difficulty);
    self.difficulty = difficulty;
    self._id_D298338A64096D6D = difficulty;
  }
}

_id_A3B11047212A9BBD() {
  self._id_0DEB55E4A0429EF1 = 1;
  self notify("bot_br_super_think");
  self endon("bot_br_super_think");
  self endon("bot_suspended");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isnavmeshloaded())
    wait 0.05;

  _id_3B64EB40368C1450::set(scripts\mp\utility\game::getgametype(), "vehicle_use", 0);
  _id_59FF79D681BB860C::_id_142B713A2846F9AC("Mind");
  _id_0D74AE0B4AA21186::_id_555C24CBDE8F72C6();

  for(;;) {
    if(scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
      wait 0.05;
      continue;
    }

    _id_0D74AE0B4AA21186::update();
  }
}

modifyplayerdamage(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, _id_BE4285B26ED99AB1) {
  _id_702BFC08FABD86CB = _id_59FF79D681BB860C::_id_0D111733407F6518(smeansofdeath, victim, eattacker, idamage, 0);
  return _id_702BFC08FABD86CB;
}

_id_C38398385AFC10FC() {
  level waittill("player_spawned", player);

  if(!scripts\mp\utility\game::matchmakinggame()) {
    _id_F4343E072926C2F9 = getdvarint("dvar_409BDB274DE67D6E", 0);

    if(_id_F4343E072926C2F9 > 0) {
      _id_ACCE55F72D869802 = int(_id_F4343E072926C2F9 / 2);
      _id_7D07BCC667393CDF = _id_F4343E072926C2F9 - _id_ACCE55F72D869802;
    } else {
      _id_ACCE55F72D869802 = 0;
      _id_7D07BCC667393CDF = 0;
    }

    level thread _id_F166B9F78BECA5E6(_id_ACCE55F72D869802, "allies");
    level thread _id_F166B9F78BECA5E6(_id_7D07BCC667393CDF, "axis");
  }
}

_id_F166B9F78BECA5E6(count, team) {
  _id_50ADE409B1E5EFCB = [];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= count; _id_AC0E594AC96AA3A8++) {
    _id_DD4614803231D30A = spawnStruct();
    _id_DD4614803231D30A.name = "";
    _id_50ADE409B1E5EFCB[_id_50ADE409B1E5EFCB.size] = _id_DD4614803231D30A;
  }

  level _id_59FF79D681BB860C::_id_7D92B857142DBDC6(_id_50ADE409B1E5EFCB, team, undefined, undefined, "spawned_bots");
}

_id_36E75380D944A65D(player) {
  return _id_59FF79D681BB860C::_id_DED80385EA7471DB(player);
}