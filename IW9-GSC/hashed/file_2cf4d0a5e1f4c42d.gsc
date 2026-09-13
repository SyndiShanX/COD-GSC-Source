/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2cf4d0a5e1f4c42d.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14, ::_id_E3D9D27A30E4D693);
}

_id_E0844A2B7F904B14(bot) {
  if(istrue(bot.inlaststand))
    return 999;

  return 0;
}

_id_E3D9D27A30E4D693(_id_0DE5AD618378DCA3) {
  return _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("laststand", undefined, "main", "", ::_id_35671B7B1A04BF58, self);
}

_id_35671B7B1A04BF58(bot) {
  for(;;) {
    _id_F0EA4030349A33D5 = undefined;

    if(bot _id_7E816FA0720D38A1::bot_is_in_gas()) {
      circleorigin = _id_2695A20D4011076D::getsafecircleorigin();
      nextpoint = bot _id_59FF79D681BB860C::_id_207BA502560FA1D2(circleorigin);
      _id_E5DC471579D90471 = 0;
    } else {
      _id_F0EA4030349A33D5 = _id_4F3EA8C58542178A(bot);
      nextpoint = _id_A0BB005EC23FA9AF(bot, _id_F0EA4030349A33D5);
      _id_E5DC471579D90471 = isDefined(_id_F0EA4030349A33D5) && nextpoint == _id_F0EA4030349A33D5.origin;
    }

    if(!isDefined(nextpoint)) {
      point = _id_2695A20D4011076D::getrandompointincircle(bot.origin, 200, 0.5, 1, 1, 1);
      nextpoint = bot getclosestreachablepointonnavmesh(point);
    }

    bot _id_59FF79D681BB860C::_id_9E400058EF021B03(nextpoint, 32);
    msg = bot scripts\engine\utility::waittill_any_in_array_or_timeout(["goal", "bad_path"], 1.0);

    if(msg == "bad_path") {
      continue;
    }
    if(msg == "goal" && _id_E5DC471579D90471) {
      _id_556AB897CC3C3788 = 4096;

      while(_id_59FF79D681BB860C::isvalidplayer(_id_F0EA4030349A33D5)) {
        _id_BE8BB7E6270B5A4A = distancesquared(_id_F0EA4030349A33D5.origin, bot.origin);

        if(_id_BE8BB7E6270B5A4A > _id_556AB897CC3C3788) {
          break;
        }

        _id_CBA40E031462D0A0 = bot scripts\engine\utility::waittill_any_in_array_or_timeout(["last_stand_revived"], 1.0);

        if(_id_CBA40E031462D0A0 == "last_stand_revived")
          return;
      }
    }
  }
}

_id_A0BB005EC23FA9AF(bot, _id_F0EA4030349A33D5) {
  attacker = undefined;

  if(isDefined(bot.laststandattacker) && _id_59FF79D681BB860C::isvalidplayer(bot.laststandattacker))
    attacker = bot.laststandattacker;

  nextpoint = undefined;

  if(isDefined(_id_F0EA4030349A33D5) && isDefined(attacker) && _id_CF7B2C0ABEAFBA37(bot, _id_F0EA4030349A33D5, attacker))
    nextpoint = _id_F0EA4030349A33D5.origin;
  else if(isDefined(attacker)) {
    _id_D043251C1C5FF583 = 200;
    point = bot.origin + vectorNormalize(bot.origin - attacker.origin) * _id_D043251C1C5FF583;
    nextpoint = bot getclosestreachablepointonnavmesh(point);
  } else if(isDefined(_id_F0EA4030349A33D5))
    nextpoint = _id_F0EA4030349A33D5.origin;

  return nextpoint;
}

_id_4F3EA8C58542178A(bot) {
  _id_365493582892E9A2 = 2214144;
  _id_2DA15EEE6B62525C = 0;
  _id_52321A255B786E1C = undefined;
  players = scripts\mp\utility\teams::getteamdata(bot.team, "alivePlayers");

  foreach(_id_F0EA4030349A33D5 in players) {
    if(_id_F0EA4030349A33D5 == bot) {
      continue;
    }
    if(!_id_59FF79D681BB860C::isvalidplayer(_id_F0EA4030349A33D5)) {
      continue;
    }
    dist = distancesquared(_id_F0EA4030349A33D5.origin, bot.origin);

    if(dist > _id_365493582892E9A2) {
      continue;
    }
    if(!isDefined(_id_52321A255B786E1C) || dist < _id_2DA15EEE6B62525C) {
      _id_52321A255B786E1C = _id_F0EA4030349A33D5;
      _id_2DA15EEE6B62525C = dist;
    }
  }

  return _id_52321A255B786E1C;
}

_id_CF7B2C0ABEAFBA37(bot, _id_66E6D55B52A17D34, attacker) {
  _id_77FBCA5CB965B16A = vectorNormalize(attacker.origin - bot.origin);
  _id_16CBDE366E22C3AD = vectorNormalize(_id_66E6D55B52A17D34.origin - bot.origin);
  return vectordot(_id_77FBCA5CB965B16A, _id_16CBDE366E22C3AD) < 0;
}