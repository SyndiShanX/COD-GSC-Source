/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_54a9e44119886147.gsc
***********************************************/

_id_E3D9D27A30E4D693(target) {
  targetname = _id_59FF79D681BB860C::_id_EE72E3F03E5196B7(target);
  return _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("combat", target, "main", targetname + "/" + target getentitynumber(), ::_id_35671B7B1A04BF58, self, ::_id_F4CAAE7E8AF9D32C);
}

_id_35671B7B1A04BF58(bot) {
  target = self._id_EC02147FEE952CE2;
  target endon("death_or_disconnect");
  meleechargedist = bot botgetdifficultysetting("meleeChargeDist");
  _id_7E28DD052F7B8A2C = meleechargedist * meleechargedist;
  _id_A8340BAE5A5E4FFC = 0;
  _id_BDF249B5A9979371(bot);

  for(;;) {
    if(!bot _id_59FF79D681BB860C::_id_42266A7FD7932C50(target))
      return "Invalid target";

    bot _id_59FF79D681BB860C::_id_2C2B5B435027F895(target);
    bot botclearscriptgoal();
    _id_33C1B9EB98AF9E77 = distancesquared(bot.origin, target.origin) <= _id_7E28DD052F7B8A2C;

    if(_id_A8340BAE5A5E4FFC != _id_33C1B9EB98AF9E77) {
      _id_A8340BAE5A5E4FFC = _id_33C1B9EB98AF9E77;
      _id_20158EB686F4B21B = _id_33C1B9EB98AF9E77 && randomfloat(1) < 0.5 && bot botcanseeentity(target);
      bot botsetflag("prefer_melee", _id_20158EB686F4B21B);
    }

    msg = bot scripts\engine\utility::waittill_any_in_array_or_timeout(["bad_path", "long_path"], 0.1);

    if(!bot _id_59FF79D681BB860C::_id_42266A7FD7932C50(target))
      return "Invalid target";

    if(!bot botcanseeentity(target)) {
      if(msg == "bad_path") {
        bot _id_59FF79D681BB860C::_id_2C2B5B435027F895(undefined);
        point = _id_2695A20D4011076D::getrandompointincircle(bot.origin, 200, 0.5, 1, 1, 1);
        _id_03863887FED6F155 = bot getclosestreachablepointonnavmesh(point);
        bot _id_59FF79D681BB860C::_id_9E400058EF021B03(_id_03863887FED6F155, 32);
        bot scripts\engine\utility::waittill_any_in_array_or_timeout(["goal", "bad_path"], 2.0);

        if(!bot _id_59FF79D681BB860C::_id_42266A7FD7932C50(target))
          return "Invalid target";
      } else if(msg == "long_path")
        return msg;
    }

    if(istrue(self._id_A0185A724941F02F._id_E889B543C8E054AE._id_C1F6D75F14545B1F))
      bot _id_59FF79D681BB860C::_id_CF1A9E98122E3931(target);
  }
}

_id_BDF249B5A9979371(bot) {
  _id_3B00F93932AA61C4 = self._id_A0185A724941F02F._id_E889B543C8E054AE._id_386520F2D17685D5;

  if(isDefined(_id_3B00F93932AA61C4) && _id_3B00F93932AA61C4 != 0 && !isbot(self._id_EC02147FEE952CE2)) {
    self._id_98A8D73FF5329A01 = bot botgetdifficultysetting("hitInaccuracyScale");
    _id_5FC09D1BC4492FC6 = self._id_98A8D73FF5329A01 * _id_3B00F93932AA61C4;
    bot botsetdifficultysetting("hitInaccuracyScale", _id_5FC09D1BC4492FC6);
  }
}

_id_F4CAAE7E8AF9D32C(action) {
  if(_id_0D74AE0B4AA21186::_id_D57DD414963503D1())
    self botsetflag("prefer_melee", 0);

  if(isDefined(action._id_98A8D73FF5329A01)) {
    self botsetdifficultysetting("hitInaccuracyScale", action._id_98A8D73FF5329A01);
    action._id_98A8D73FF5329A01 = undefined;
  }
}