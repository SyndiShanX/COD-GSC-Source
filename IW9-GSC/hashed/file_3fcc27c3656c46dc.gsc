/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3fcc27c3656c46dc.gsc
***********************************************/

_id_E3D9D27A30E4D693(target) {
  return _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("Buy", target, "main", target._id_7148C1A6F25491F8 + "/" + target.itemname, ::_id_35671B7B1A04BF58, self, ::_id_F4CAAE7E8AF9D32C);
}

_id_35671B7B1A04BF58(bot) {
  target = self._id_EC02147FEE952CE2;

  if(!isDefined(target))
    return "Target is undefined";

  targetpos = _id_B454FB48A26AA2C7(target._id_2FA65F34EB9042F5);
  bot _id_59FF79D681BB860C::_id_9E400058EF021B03(targetpos, 32);

  for(;;) {
    result = bot scripts\engine\utility::waittill_any_in_array_or_timeout(["goal", "bad_path"], 15);

    if(result == "goal") {
      bot setvelocity((0, 0, 0));
      waitframe();
      bot _id_40E63DD222434655::_id_8B201BCCC0AA3695(target._id_2FA65F34EB9042F5.origin);
      wait 0.5;
      bot botpressbutton("use", 0.25);
      wait 1.5;
      _id_4F98C366C1BA6F75 = bot.plundercount;
      bot.armorykioskpurchaseallowed = 1;
      bot _id_4384ABBF498DF6A7::onarmorykioskpurchase(target._id_7148C1A6F25491F8, target._id_1657E74C9190D2A2);

      if(bot.plundercount >= _id_4F98C366C1BA6F75)
        _id_6789BD08CBABDB47(target._id_2FA65F34EB9042F5, bot);

      _id_BE48ED4E05EFE5CF = 45;
      _id_60C1A9BC1584EF28 = 1.5;
      bot _id_40E63DD222434655::_id_D1ACAD1EE42B2B2F(target._id_2FA65F34EB9042F5, _id_60C1A9BC1584EF28, _id_BE48ED4E05EFE5CF);
      break;
    } else if(result == "bad_path")
      return result;
  }
}

_id_B454FB48A26AA2C7(_id_2FA65F34EB9042F5) {
  _id_90A93951E4C15E03 = 48;
  pos = _id_2FA65F34EB9042F5.origin + anglesToForward(_id_2FA65F34EB9042F5.angles) * _id_90A93951E4C15E03;
  return getclosestpointonnavmesh(pos);
}

_id_6789BD08CBABDB47(_id_2FA65F34EB9042F5, bot) {
  if(!isDefined(_id_2FA65F34EB9042F5._id_19C6F51451310013))
    _id_2FA65F34EB9042F5._id_19C6F51451310013 = [];

  _id_2FA65F34EB9042F5._id_19C6F51451310013[bot.entity_number] = gettime();
}

_id_F4CAAE7E8AF9D32C(action) {
  if(_id_0D74AE0B4AA21186::_id_D57DD414963503D1())
    self.armorykioskpurchaseallowed = undefined;
}