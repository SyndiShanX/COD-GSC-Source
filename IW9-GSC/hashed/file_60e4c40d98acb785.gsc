/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_60e4c40d98acb785.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14, undefined, 2000);
}

_id_E0844A2B7F904B14(bot) {
  activequests = _id_3ACF1C0EBAF602F2::getallactivequestsforteam(bot.team);
  _id_1F94C0CCA708DE02 = undefined;

  if(isDefined(activequests) && activequests.size > 0) {
    foreach(_id_12461E617D024EF9 in activequests) {
      if(_id_12461E617D024EF9.instance.questcategory == "domination") {
        _id_1F94C0CCA708DE02 = _id_12461E617D024EF9;
        break;
      }
    }
  }

  if(!isDefined(_id_1F94C0CCA708DE02))
    return 0;

  _id_2828A4FE12D2EB06 = spawnStruct();
  _id_2828A4FE12D2EB06._id_DDF4DD8AD690D592 = _id_1F94C0CCA708DE02.origin;
  _id_2828A4FE12D2EB06.radius = _id_1F94C0CCA708DE02.instance.subscribedlocale.radius;
  self._id_DF9D35D9B4BEE654 = _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("Perform Recon Contract", _id_2828A4FE12D2EB06, "main", _id_1F94C0CCA708DE02.instance.id, ::_id_35671B7B1A04BF58, self, ::_id_F4CAAE7E8AF9D32C);
  _id_46227231153BDF50 = istrue(self._id_B32868A9471D2CAA) || distance(bot.origin, _id_1F94C0CCA708DE02.origin) <= _id_2828A4FE12D2EB06.radius;
  return scripts\engine\utility::ter_op(_id_46227231153BDF50, self._id_E889B543C8E054AE._id_CF22D0ED88800557, self._id_E889B543C8E054AE.basescore);
}

_id_35671B7B1A04BF58(bot) {
  target = self._id_EC02147FEE952CE2;
  self._id_A0185A724941F02F._id_B32868A9471D2CAA = 1;
  _id_C9E915E56C1B6170 = _id_2695A20D4011076D::getrandompointincircle(target._id_DDF4DD8AD690D592, target.radius);

  if(_id_C9E915E56C1B6170[2] - target._id_DDF4DD8AD690D592[2] > 70)
    _id_C9E915E56C1B6170 = _id_2695A20D4011076D::getrandompointincircle(target._id_DDF4DD8AD690D592, target.radius, undefined, undefined, 0, 1);

  for(;;) {
    bot _id_59FF79D681BB860C::_id_9E400058EF021B03(_id_C9E915E56C1B6170, 32);
    result = bot scripts\engine\utility::waittill_any_in_array_or_timeout(["goal", "bad_path"], 15);

    if(result == "goal") {
      break;
    } else if(result != "timeout")
      return result;
  }
}

_id_F4CAAE7E8AF9D32C(action) {
  action._id_A0185A724941F02F._id_B32868A9471D2CAA = undefined;
}