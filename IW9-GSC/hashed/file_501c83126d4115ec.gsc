/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_501c83126d4115ec.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14, ::_id_E3D9D27A30E4D693);
}

_id_E0844A2B7F904B14(bot) {
  if(scripts\mp\gamelogic::_id_1147BBC93EA9B83C())
    return 0;

  _id_A0F36FF3EAE203AE = level.br_circle.circleindex + 1 >= level.br_level.br_circlecenters.size - level.br_level.br_movingcirclecount;

  if(!_id_A0F36FF3EAE203AE) {
    _id_7D9A6D00A336393B = _id_2695A20D4011076D::getmintimetillpointindangercircle(bot.origin);

    if(_id_7D9A6D00A336393B >= 0) {
      _id_72BB89E60D3674DF = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_7D9A6D00A336393B, self._id_E889B543C8E054AE._id_3DD54452AF7D2B91, self._id_E889B543C8E054AE._id_49E2976CA0C853EF);
      _id_72BB89E60D3674DF = _id_72BB89E60D3674DF + _id_0D74AE0B4AA21186::_id_4E58BF49977D1BFD();
      return _id_72BB89E60D3674DF;
    }
  } else if(bot _id_68AA3C169A03E3B9())
    return self._id_E889B543C8E054AE._id_5518DEAF35F7B0CE;

  return 0;
}

_id_E3D9D27A30E4D693(bot) {
  return _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("escape_gas", undefined, "main", "", ::_id_35671B7B1A04BF58, self, ::_id_F4CAAE7E8AF9D32C, self._id_E889B543C8E054AE._id_57228F75B014A7B8, self._id_E889B543C8E054AE._id_DAEC6FD98C7CEE50);
}

_id_35671B7B1A04BF58(bot) {
  bot allowreload(0);
  _id_E24929C0E254D7B4 = bot _id_BF97A7A48FA19ED3();

  for(;;) {
    if(!isDefined(_id_E24929C0E254D7B4))
      return "No destination";

    bot _id_59FF79D681BB860C::_id_9E400058EF021B03(_id_E24929C0E254D7B4, 64);
    bot botpressbutton("sprint", 1);
    result = bot scripts\engine\utility::waittill_any_in_array_or_timeout(["goal", "bad_path"], 1);

    if(result == "bad_path") {
      _id_E24929C0E254D7B4 = bot _id_BF97A7A48FA19ED3(1);
      continue;
    }

    if(result == "goal") {
      break;
    }
  }

  bot notify("dormant_bot_suspending_chance");
}

_id_BF97A7A48FA19ED3(_id_28BFDDF285650387) {
  _id_C4CA8C2703D417D4 = 400;
  _id_7BA79E92EFEEE9CD = 4000;
  destination = _id_2695A20D4011076D::getdangercircleorigin();

  if(istrue(_id_28BFDDF285650387))
    destination = _id_2695A20D4011076D::getrandompointincircle(destination, _id_C4CA8C2703D417D4);

  return _id_59FF79D681BB860C::_id_207BA502560FA1D2(destination, _id_7BA79E92EFEEE9CD);
}

_id_68AA3C169A03E3B9() {
  _id_FBADF88256285B55 = 0.7;
  _id_0DCD37EB0F547595 = 320;

  if(!scripts\mp\flags::gameflag("graceperiod_done"))
    return 0;

  if(!_id_59FF79D681BB860C::isvalidplayer(self))
    return 0;

  circleorigin = _id_2695A20D4011076D::getdangercircleorigin();
  circleradius = _id_2695A20D4011076D::getdangercircleradius();

  if(istrue(level.circleclosing)) {
    circleorigin = _id_2695A20D4011076D::getsafecircleorigin();
    circleradius = _id_2695A20D4011076D::getsafecircleradius();
  }

  _id_6AFF45107E415FE9 = max(circleradius * _id_FBADF88256285B55, circleradius - _id_0DCD37EB0F547595);
  return !scripts\engine\utility::ispointinsidecircle(self.origin, circleorigin, _id_6AFF45107E415FE9);
}

_id_F4CAAE7E8AF9D32C(action) {
  if(_id_0D74AE0B4AA21186::_id_D57DD414963503D1())
    self allowreload(1);
}