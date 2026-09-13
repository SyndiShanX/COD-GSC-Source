/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_25a72681f753607e.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14);
}

_id_E0844A2B7F904B14(bot) {
  _id_D9F03CE835EE985B = "toma_strike";

  if(!bot _id_40E63DD222434655::_id_81B00A2BA10C143A(_id_D9F03CE835EE985B)) {
    _id_D9F03CE835EE985B = "precision_airstrike";

    if(!bot _id_40E63DD222434655::_id_81B00A2BA10C143A(_id_D9F03CE835EE985B))
      return 0;
  }

  _id_D414BA671EB56685 = 0;
  target = undefined;
  _id_FDF6F26ABEE82B42 = bot _id_2D121AC0A4E1A5B8::_id_7E7DDFA33EFF2C11();
  _id_FDF6F26ABEE82B42 _id_2D121AC0A4E1A5B8::_id_2F1735D1CB737A0C(bot);
  _id_FDF6F26ABEE82B42 _id_2D121AC0A4E1A5B8::_id_8500E6AE452B1E19(self._id_E889B543C8E054AE._id_6B536E17B179B18C);

  foreach(player in _id_FDF6F26ABEE82B42.result) {
    if(isDefined(self._id_E889B543C8E054AE._id_39E02A8A79B6BA4C)) {
      switch (self._id_E889B543C8E054AE._id_39E02A8A79B6BA4C) {
        case "bot":
          if(!isbot(player)) {
            continue;
          }
          break;
        case "human":
          if(isbot(player)) {
            continue;
          }
          break;
        default:
          break;
      }
    }

    if(player _id_F3B2BB1E37A0ABAE() && bot botcanseeentity(player)) {
      _id_DF8E0358F6E2B842 = distance(bot.origin, player.origin);
      _id_54E0AB2472351543 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_DF8E0358F6E2B842, self._id_E889B543C8E054AE._id_CA44FA65DC21651A, self._id_E889B543C8E054AE._id_E6F117499091FD02);

      if(_id_54E0AB2472351543 > _id_D414BA671EB56685) {
        _id_D414BA671EB56685 = _id_54E0AB2472351543;
        target = player;
      }
    }
  }

  if(isDefined(target)) {
    self._id_DF9D35D9B4BEE654 = _id_E3D9D27A30E4D693(target.origin, _id_D9F03CE835EE985B);
    return self._id_E889B543C8E054AE.basescore + _id_D414BA671EB56685;
  }

  return 0;
}

_id_F3B2BB1E37A0ABAE() {
  _id_C7D42B381BA6869C = 20;

  if(!isDefined(self._id_3C6AE4971DF01A1F) || gettime() >= self._id_3C6AE4971DF01A1F + _id_C7D42B381BA6869C) {
    self._id_3C6AE4971DF01A1F = gettime();
    self._id_5EB7151348570383 = self sightconetrace((self.origin[0], self.origin[1], 6000)) > 0;
  }

  return self._id_5EB7151348570383;
}

_id_E3D9D27A30E4D693(targetpos, _id_EBFC9454321CB5C3) {
  return _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("Killstreak air_strike", targetpos, "upper body", _id_EBFC9454321CB5C3 + ":" + targetpos[0] + "," + targetpos[1] + "," + targetpos[2], ::_id_35671B7B1A04BF58, self);
}

_id_35671B7B1A04BF58(bot) {
  if(bot _id_40E63DD222434655::_id_81B00A2BA10C143A("precision_airstrike")) {
    _id_BA0A9212A8D8504F = randomintrange(200, 420);
    _id_B2C06D4A5F630779 = (_id_BA0A9212A8D8504F * scripts\engine\utility::random([-1, 1]), _id_BA0A9212A8D8504F * scripts\engine\utility::random([-1, 1]), 0);
    bot.kstargetlocation = self._id_EC02147FEE952CE2 + _id_B2C06D4A5F630779;
  } else
    bot.kstargetlocation = self._id_EC02147FEE952CE2;

  bot scripts\mp\killstreaks\killstreaks::dokillstreakaction(undefined, 1);
}