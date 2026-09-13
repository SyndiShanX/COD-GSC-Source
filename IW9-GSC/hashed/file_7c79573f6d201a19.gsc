/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7c79573f6d201a19.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  _id_A0185A724941F02F = _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14, undefined, undefined, ::_id_B97E27A7552F6031);
  _id_A0185A724941F02F _id_7FE87B5456BF27B8();
  return _id_A0185A724941F02F;
}

_id_B97E27A7552F6031(_id_9DBFE859B2119409, _id_9DBFE559B2118D70) {
  return _id_9DBFE859B2119409.entity == _id_9DBFE559B2118D70.entity;
}

_id_E0844A2B7F904B14(bot) {
  result = spawnStruct();
  result._id_72BB89E60D3674DF = 0;
  result._id_2828A4FE12D2EB06 = undefined;
  _id_32028DB58AFC5FA9 = bot _id_4F76BEE355450E6D::_id_7E7DDFA33EFF2C11();
  _id_E58460405B36B647 = bot _id_7FC58C95EE47D870::_id_7E7DDFA33EFF2C11();
  _id_EC10C084410E83FC = bot _id_0CA34B05781DBECE::_id_7E7DDFA33EFF2C11();
  _id_0CEC7C34920151FA();
  _id_6A902180EBD8F336(bot, _id_32028DB58AFC5FA9, result);
  _id_6A902180EBD8F336(bot, _id_E58460405B36B647, result);
  _id_6A902180EBD8F336(bot, _id_EC10C084410E83FC, result);

  if(bot scripts\mp\utility\player::_id_9612D351D714EFB1())
    result._id_72BB89E60D3674DF = result._id_72BB89E60D3674DF + self._id_E889B543C8E054AE._id_65789424B6D020CC;

  if(isDefined(self._id_8FF05874BBB1AC7C) && self._id_8FF05874BBB1AC7C.score > result._id_72BB89E60D3674DF) {
    self._id_DF9D35D9B4BEE654 = self._id_8FF05874BBB1AC7C;
    return self._id_8FF05874BBB1AC7C.score;
  }

  if(isDefined(result._id_2828A4FE12D2EB06) && isDefined(result._id_2828A4FE12D2EB06.entity))
    self._id_DF9D35D9B4BEE654 = _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("pickup", result._id_2828A4FE12D2EB06, "main", "id:" + result._id_2828A4FE12D2EB06.entity.index + " location:" + result._id_2828A4FE12D2EB06.entity.origin, ::_id_35671B7B1A04BF58, self, ::_id_F4CAAE7E8AF9D32C, self._id_E889B543C8E054AE._id_57228F75B014A7B8, self._id_E889B543C8E054AE._id_DAEC6FD98C7CEE50);

  return result._id_72BB89E60D3674DF;
}

_id_6A902180EBD8F336(bot, _id_1D2BE7531AAF82AF, result) {
  _id_E09327B44385B3CE = undefined;

  if(getdvarint("dvar_82BDE055B11E6698", 0))
    _id_E09327B44385B3CE = scripts\engine\utility::array_contains(level.questinfo.teamsonquests, bot.team);
  else
    _id_E09327B44385B3CE = _id_64ACB6CE534155B7::_id_7094C7010C5E3827(bot.team);

  _id_A1EB8777F2132A97 = _id_40E63DD222434655::_id_1C51F7C46A848DDD();
  _id_9073E5955EAEBE2C = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_A1EB8777F2132A97, self._id_E889B543C8E054AE._id_E23500DBD314BAE2, self._id_E889B543C8E054AE._id_E58A5E1EFEB78937);

  foreach(ent in _id_1D2BE7531AAF82AF) {
    if(ent.type == "") {
      continue;
    }
    if(_id_D4454868DBB4E0AB(ent)) {
      continue;
    }
    if(ent.type == "tablet") {
      if(_id_E09327B44385B3CE) {
        continue;
      }
      _id_17BEC417681D2AF0 = _id_60067BF70F45D4DD(bot, ent, _id_A1EB8777F2132A97);
    } else if(ent.type == "airdrop_loadout")
      _id_17BEC417681D2AF0 = _id_04D09767D744E71E(bot, ent, _id_9073E5955EAEBE2C);
    else
      _id_17BEC417681D2AF0 = _id_0DC1A77B6A8234CD(bot, ent, _id_9073E5955EAEBE2C);

    if(!isDefined(_id_17BEC417681D2AF0)) {
      continue;
    }
    _id_7D9A6D00A336393B = _id_2695A20D4011076D::getmintimetillpointindangercircle(ent.entity.origin);

    if(_id_7D9A6D00A336393B >= 0) {
      _id_40F4B7920A0CA8A0 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_7D9A6D00A336393B, self._id_E889B543C8E054AE._id_93BCC2B99D24433F, self._id_E889B543C8E054AE._id_05107F0B927DAD2B);
      _id_17BEC417681D2AF0 = _id_17BEC417681D2AF0 + _id_40F4B7920A0CA8A0;
    }

    _id_17BEC417681D2AF0 = _id_17BEC417681D2AF0 + _id_0D74AE0B4AA21186::_id_4E58BF49977D1BFD(ent);

    if(_id_17BEC417681D2AF0 > result._id_72BB89E60D3674DF) {
      result._id_2828A4FE12D2EB06 = ent;
      result._id_72BB89E60D3674DF = _id_17BEC417681D2AF0;
    }
  }
}

getlootname(_id_2F44E3B98C77C7CC) {
  _id_A1093166DE09E6B8 = _id_2F44E3B98C77C7CC _meth_15C8C4841BFC1FD5();

  if(isDefined(_id_A1093166DE09E6B8))
    return _id_A1093166DE09E6B8;

  return _id_2F44E3B98C77C7CC.type;
}

_id_0DC1A77B6A8234CD(bot, loot, _id_9073E5955EAEBE2C) {
  _id_17BEC417681D2AF0 = 0;
  _id_5732AE178F7310E6 = distance(loot.entity.origin, bot.origin);

  if(_id_5732AE178F7310E6 > self._id_E889B543C8E054AE._id_65A3F0D7A3F96F0F)
    return _id_17BEC417681D2AF0;

  _id_02F96C6A3FAD9912 = self._id_E889B543C8E054AE._id_02F96C6A3FAD9912;
  _id_A1093166DE09E6B8 = getlootname(loot.entity);
  _id_76DABEE05A567F15 = bot _id_40E63DD222434655::_id_0BBC2D6967287DC7(_id_A1093166DE09E6B8, _id_02F96C6A3FAD9912);
  _id_98AC27FD131B6FAF = 0;

  if(!istrue(_id_76DABEE05A567F15))
    return undefined;

  _id_98AC27FD131B6FAF = scripts\engine\utility::ter_op(isDefined(_id_02F96C6A3FAD9912._id_1987D8B5D11DFD90[_id_A1093166DE09E6B8]), _id_02F96C6A3FAD9912._id_1987D8B5D11DFD90[_id_A1093166DE09E6B8], _id_02F96C6A3FAD9912._id_03A436BD812A2B86[loot.type]);

  if(_id_7E816FA0720D38A1::ispointincurrentcircle(loot.entity.origin) && _id_98AC27FD131B6FAF > 0) {
    if(loot.type == "cache" || loot.type == "ammo_restock") {
      _id_9122F7A6B88609ED = scripts\engine\utility::ter_op(_id_F6BE8129663916FD(loot.entity), 0, _id_5732AE178F7310E6);
      _id_17BEC417681D2AF0 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_9122F7A6B88609ED, self._id_E889B543C8E054AE._id_6C134B04A6E15E0F, self._id_E889B543C8E054AE._id_EEA720F577A76B0B) + _id_9073E5955EAEBE2C;
    } else if(_id_5732AE178F7310E6 < self._id_E889B543C8E054AE._id_5DCBC5CCEC64F7DE)
      _id_17BEC417681D2AF0 = _id_98AC27FD131B6FAF + _id_9073E5955EAEBE2C;
    else if(_id_5732AE178F7310E6 < self._id_E889B543C8E054AE._id_576F233D91CC27FF)
      _id_17BEC417681D2AF0 = scripts\engine\utility::ter_op(bot _id_2F201CA20292AD12(loot.entity.origin), _id_98AC27FD131B6FAF + _id_9073E5955EAEBE2C, 0);
  }

  return _id_17BEC417681D2AF0;
}

_id_60067BF70F45D4DD(bot, _id_6640C2677653D96F, _id_A1EB8777F2132A97) {
  _id_17BEC417681D2AF0 = 0;

  if(_id_7E816FA0720D38A1::ispointincurrentcircle(_id_6640C2677653D96F.entity.origin)) {
    type = undefined;

    if(getdvarint("dvar_82BDE055B11E6698", 0))
      type = _id_6640C2677653D96F.entity.tablettype;
    else
      type = _id_6640C2677653D96F.entity.tablettype.ref;

    switch (type) {
      case "assassination":
        _id_61EF9EAFD8ABB6BE = self._id_E889B543C8E054AE._id_B516486DE7D13311;
        break;
      case "domination":
        _id_61EF9EAFD8ABB6BE = self._id_E889B543C8E054AE._id_DE1C985391B99A2B;
        break;
      case "scavenger":
        _id_61EF9EAFD8ABB6BE = self._id_E889B543C8E054AE._id_E749E36FEC025A10;
        break;
      case "vip":
        _id_61EF9EAFD8ABB6BE = self._id_E889B543C8E054AE._id_3F74FC9A89BD6F1E;
        break;
      case "timedrun":
        _id_61EF9EAFD8ABB6BE = self._id_E889B543C8E054AE._id_2ECAB98395F8D2F8;
        break;
      default:
        return 0;
    }

    _id_17BEC417681D2AF0 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_A1EB8777F2132A97, self._id_E889B543C8E054AE._id_2E392955E7388247, _id_61EF9EAFD8ABB6BE);

    if(_id_17BEC417681D2AF0 > 0) {
      _id_5732AE178F7310E6 = distance(_id_6640C2677653D96F.entity.origin, bot.origin);
      _id_9122F7A6B88609ED = scripts\engine\utility::ter_op(_id_F6BE8129663916FD(_id_6640C2677653D96F.entity), 0, _id_5732AE178F7310E6);
      _id_17BEC417681D2AF0 = _id_17BEC417681D2AF0 + _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_9122F7A6B88609ED, self._id_E889B543C8E054AE._id_7604B66FC0BF7887, self._id_E889B543C8E054AE._id_9BA7C398DE3AB6B8);
    }
  }

  return _id_17BEC417681D2AF0;
}

_id_04D09767D744E71E(bot, _id_03EF9B41093F5752, _id_9073E5955EAEBE2C) {
  _id_17BEC417681D2AF0 = self._id_E889B543C8E054AE._id_C0C5B5DD018DC8CF;
  _id_5732AE178F7310E6 = distance(_id_03EF9B41093F5752.entity.origin, bot.origin);
  _id_9122F7A6B88609ED = scripts\engine\utility::ter_op(_id_F6BE8129663916FD(_id_03EF9B41093F5752.entity), 0, _id_5732AE178F7310E6);
  _id_17BEC417681D2AF0 = _id_17BEC417681D2AF0 + _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_9122F7A6B88609ED, self._id_E889B543C8E054AE._id_18143B1F14CC381D, self._id_E889B543C8E054AE._id_0C82FA9468A010A2);
  _id_17BEC417681D2AF0 = _id_17BEC417681D2AF0 + _id_9073E5955EAEBE2C;
  return _id_17BEC417681D2AF0;
}

_id_F6BE8129663916FD(entity) {
  if(isDefined(self._id_16BD053D665E8C13))
    return self._id_16BD053D665E8C13.entity == entity;

  return 0;
}

_id_2F201CA20292AD12(point) {
  _id_CCBD7E93D84D42E8 = self botpredictseepoint(point);
  _id_E1B57EC944A64540 = 40;

  if(isvector(_id_CCBD7E93D84D42E8))
    return abs(_id_CCBD7E93D84D42E8[2] - point[2]) < _id_E1B57EC944A64540;

  return 0;
}

_id_35671B7B1A04BF58(bot) {
  target = self._id_EC02147FEE952CE2;
  self._id_A0185A724941F02F._id_16BD053D665E8C13 = target;
  _id_EE2EEA100343D059 = target.type == "cache";
  _id_60DF4D40BBA49D3C = target.type == "ammo_restock";
  _id_54ADDD2A9A7CCDF2 = target.type == "airdrop_loadout";
  _id_FE2E596FD1C7FA49 = !_id_EE2EEA100343D059 && !_id_60DF4D40BBA49D3C && !_id_54ADDD2A9A7CCDF2;
  _id_E6A27152696418BD = 0;
  _id_0A02B95B69B3E316 = 0;
  _id_883446D683094420 = 56;
  targetpos = undefined;
  lookatpos = target.entity.origin;

  if(_id_60DF4D40BBA49D3C || _id_54ADDD2A9A7CCDF2)
    targetpos = getclosestpointonnavmesh(target.entity.origin);
  else if(_id_EE2EEA100343D059) {
    _id_883446D683094420 = 24;
    _id_90A93951E4C15E03 = 45;
    pos = target.entity.origin + anglestoleft(target.entity.angles) * _id_90A93951E4C15E03;
    targetpos = getclosestpointonnavmesh(pos);
  } else
    targetpos = target.entity.origin;

  bot _id_59FF79D681BB860C::_id_9E400058EF021B03(targetpos, _id_883446D683094420);

  for(;;) {
    result = bot scripts\engine\utility::waittill_any_in_array_or_timeout(["goal", "bad_path"], 1);

    if(result == "goal") {
      bot _id_40E63DD222434655::_id_8B201BCCC0AA3695(lookatpos);

      if(_id_EE2EEA100343D059) {
        if(!bot _id_D75CF6C7882B3BC4(target.entity))
          bot botpressbutton("use", 0.25);

        _id_F519820317D400EA();
        _id_BE48ED4E05EFE5CF = 45;
        _id_60C1A9BC1584EF28 = 1.5;
        bot _id_40E63DD222434655::_id_D1ACAD1EE42B2B2F(target.entity, _id_60C1A9BC1584EF28, _id_BE48ED4E05EFE5CF);
      } else if(_id_60DF4D40BBA49D3C) {
        bot botpressbutton("use", 0.25);
        self._id_A0185A724941F02F _id_02D9FCD6970321BA(target);
      } else if(_id_54ADDD2A9A7CCDF2) {
        if(!isDefined(target.entity))
          return "airdrop has been consumed";
        else if(target.entity.inuse)
          return "airdrop is in use";

        wait 1.5;
        target.entity _id_1E4A61DB11011446::br_givedropbagloadout(bot);
        self._id_A0185A724941F02F _id_02D9FCD6970321BA(target);
      } else {
        if(_id_0A02B95B69B3E316 || _id_A8B0C59FB4582264(target.entity))
          return "Target missed";

        _id_12E7D95B6CC9CC78 = _id_7E52B56769FA7774::lootused(target.entity, undefined, "visible", bot, 0);

        if(!isDefined(_id_12E7D95B6CC9CC78))
          return "Target missed";
        else if(!_id_12E7D95B6CC9CC78) {
          if(isDefined(target.entity)) {
            self._id_A0185A724941F02F _id_02D9FCD6970321BA(target);
            return "Can't pick up " + target.entity.type;
          } else
            return "Can't pick up missed " + target.type;
        }

        if(isDefined(target.entity.lootsource) && target.entity.lootsource == "cache")
          _id_F519820317D400EA();
      }

      break;
    } else if(result == "bad_path") {
      self._id_A0185A724941F02F _id_02D9FCD6970321BA(target);
      return result;
    } else if(result == "timeout") {
      if(_id_EE2EEA100343D059) {
        if(!_id_E6A27152696418BD)
          _id_E6A27152696418BD = _id_A12EE73ED183CB4F(target.entity);

        if(_id_E6A27152696418BD && bot _id_0106ADF4429E0902(targetpos, self._id_A0185A724941F02F._id_E889B543C8E054AE._id_576F233D91CC27FF))
          return "Cache is open";
      } else if(_id_FE2E596FD1C7FA49) {
        if(!_id_0A02B95B69B3E316)
          _id_0A02B95B69B3E316 = _id_A8B0C59FB4582264(target.entity);

        if(_id_0A02B95B69B3E316 && bot _id_0106ADF4429E0902(targetpos, self._id_A0185A724941F02F._id_E889B543C8E054AE._id_576F233D91CC27FF))
          return "Can't see target";
      }
    }
  }
}

_id_D75CF6C7882B3BC4(_id_36B81911E31BB387) {
  currentstate = _id_36B81911E31BB387 getscriptablepartstate("body", 1);

  if(!isDefined(currentstate))
    return 0;

  switch (currentstate) {
    case "closed_usable_no_collision":
    case "partially_open_usable":
    case "closed_usable":
      _id_552B8E4EA5FF7DF1::lootcacheused(_id_36B81911E31BB387, "body", currentstate, self);
      return 1;
    case "fully_open_unusable":
    case "closed_to_fully_open_unusable":
    case "partially_reopen_in_use_unusable":
    case "partially_open_in_use_unusable":
    case "fully_opening_unusable":
    case "partially_opening_unusable":
      return 1;
    default:
      return 0;
  }
}

_id_F519820317D400EA() {
  if(randomfloat(1.0) < 0.5) {
    _id_9B9FFCD51FCA002A = randomfloatrange(2.5, 5);
    wait(_id_9B9FFCD51FCA002A);
  }
}

_id_A12EE73ED183CB4F(_id_36B81911E31BB387) {
  currentstate = _id_36B81911E31BB387 getscriptablepartstate("body", 1);
  return isDefined(currentstate) && (currentstate == "fully_opening_unusable" || currentstate == "fully_open_unusable" || currentstate == "closed_to_fully_open_unusable");
}

_id_A8B0C59FB4582264(entity) {
  if(!isDefined(entity))
    return 1;

  _id_CF94F6893F81B1AF = "hidden";
  currentstate = entity getscriptablepartstate(entity.type, 1);
  return isDefined(currentstate) && currentstate == _id_CF94F6893F81B1AF;
}

_id_0106ADF4429E0902(targetpos, _id_576F233D91CC27FF) {
  _id_CC838CBB6F1A700B = distancesquared(targetpos, self.origin) < squared(_id_576F233D91CC27FF);
  return _id_CC838CBB6F1A700B && _id_2F201CA20292AD12(targetpos);
}

_id_F4CAAE7E8AF9D32C(action) {
  action._id_A0185A724941F02F._id_16BD053D665E8C13 = undefined;
}

_id_7FE87B5456BF27B8() {
  self._id_CEB0AAF169DDC698 = [];
}

_id_02D9FCD6970321BA(loot) {
  if(isDefined(loot.entity) && _id_D4454868DBB4E0AB(loot)) {
    return;
  }
  self._id_CEB0AAF169DDC698[self._id_CEB0AAF169DDC698.size] = loot;
}

_id_D4454868DBB4E0AB(loot) {
  foreach(item in self._id_CEB0AAF169DDC698) {
    if(loot.entity.index == item.entity.index)
      return 1;
  }

  return 0;
}

_id_0CEC7C34920151FA() {
  if(self._id_CEB0AAF169DDC698.size == 0) {
    return;
  }
  _id_E5DAB4F107F3A279 = [];

  foreach(item in self._id_CEB0AAF169DDC698) {
    if(isDefined(item.entity))
      _id_E5DAB4F107F3A279[_id_E5DAB4F107F3A279.size] = item;
  }

  self._id_CEB0AAF169DDC698 = _id_E5DAB4F107F3A279;
}

_id_54F633F649764EA9(bot, _id_40182794C7966D47) {
  _id_0CEC7C34920151FA();
  _id_B039FB43C7E9FD4A = undefined;

  if(isDefined(_id_40182794C7966D47) && isDefined(_id_40182794C7966D47.entity))
    _id_B039FB43C7E9FD4A = _id_40182794C7966D47.entity;

  _id_A8D1793197306629 = bot _id_4F76BEE355450E6D::_id_7E7DDFA33EFF2C11();
  _id_A8D1793197306629 = scripts\engine\utility::array_randomize(_id_A8D1793197306629);

  foreach(loot in _id_A8D1793197306629) {
    _id_5CB43410B9CD63EF = _id_7E816FA0720D38A1::ispointincurrentcircle(loot.entity.origin) && (!isDefined(_id_B039FB43C7E9FD4A) || _id_B039FB43C7E9FD4A != loot.entity) && !_id_D4454868DBB4E0AB(loot);

    if(_id_5CB43410B9CD63EF)
      return loot;
  }

  return undefined;
}