/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\models\interactive_utility.gsc
**************************************************/

array_sortbyarray(array, _id_5CE60C10972B30A7) {
  _id_BFC65A378A6D8EFE = [];
  _id_BFC65A378A6D8EFE[0] = array[0];
  _id_3EB3EDB0429A0173 = [];
  _id_3EB3EDB0429A0173[0] = _id_5CE60C10972B30A7[0];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
    _id_DFDD438871090D04 = 0;

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_BFC65A378A6D8EFE.size; _id_AC0E5C4AC96AAA41++) {
      if(_id_5CE60C10972B30A7[_id_AC0E594AC96AA3A8] < _id_3EB3EDB0429A0173[_id_AC0E5C4AC96AAA41]) {
        for(_id_AC0E5B4AC96AA80E = _id_BFC65A378A6D8EFE.size - 1; _id_AC0E5B4AC96AA80E >= _id_AC0E5C4AC96AAA41; _id_AC0E5B4AC96AA80E--) {
          _id_BFC65A378A6D8EFE[_id_AC0E5B4AC96AA80E + 1] = _id_BFC65A378A6D8EFE[_id_AC0E5B4AC96AA80E];
          _id_3EB3EDB0429A0173[_id_AC0E5B4AC96AA80E + 1] = _id_3EB3EDB0429A0173[_id_AC0E5B4AC96AA80E];
        }

        _id_BFC65A378A6D8EFE[_id_AC0E5C4AC96AAA41] = array[_id_AC0E594AC96AA3A8];
        _id_3EB3EDB0429A0173[_id_AC0E5C4AC96AAA41] = _id_5CE60C10972B30A7[_id_AC0E594AC96AA3A8];
        _id_DFDD438871090D04 = 1;
        break;
      }
    }

    if(!_id_DFDD438871090D04) {
      _id_BFC65A378A6D8EFE[_id_AC0E594AC96AA3A8] = array[_id_AC0E594AC96AA3A8];
      _id_3EB3EDB0429A0173[_id_AC0E594AC96AA3A8] = _id_5CE60C10972B30A7[_id_AC0E594AC96AA3A8];
    }
  }

  return _id_BFC65A378A6D8EFE;
}

array_sortbysorter(array) {
  _id_BFC65A378A6D8EFE = [];
  _id_BFC65A378A6D8EFE[0] = array[0];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
    _id_DFDD438871090D04 = 0;

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_BFC65A378A6D8EFE.size; _id_AC0E5C4AC96AAA41++) {
      if(array[_id_AC0E594AC96AA3A8].sorter < _id_BFC65A378A6D8EFE[_id_AC0E5C4AC96AAA41].sorter) {
        for(_id_AC0E5B4AC96AA80E = _id_BFC65A378A6D8EFE.size - 1; _id_AC0E5B4AC96AA80E >= _id_AC0E5C4AC96AAA41; _id_AC0E5B4AC96AA80E--)
          _id_BFC65A378A6D8EFE[_id_AC0E5B4AC96AA80E + 1] = _id_BFC65A378A6D8EFE[_id_AC0E5B4AC96AA80E];

        _id_BFC65A378A6D8EFE[_id_AC0E5C4AC96AAA41] = array[_id_AC0E594AC96AA3A8];
        _id_DFDD438871090D04 = 1;
        break;
      }
    }

    if(!_id_DFDD438871090D04)
      _id_BFC65A378A6D8EFE[_id_AC0E594AC96AA3A8] = array[_id_AC0E594AC96AA3A8];
  }

  return _id_BFC65A378A6D8EFE;
}

wait_then_fn(_id_DEE1E90C5A8243B7, _id_608C7CD243900096, _id_CE2D4778F5804E61, _id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_434849FD34BB4BA0, _id_434850FD34BB5B05) {
  self endon("death");

  if(isDefined(_id_608C7CD243900096)) {
    if(isarray(_id_608C7CD243900096)) {
      foreach(ender in _id_608C7CD243900096)
      self endon(ender);
    } else
      self endon(_id_608C7CD243900096);
  }

  if(isstring(_id_DEE1E90C5A8243B7))
    self waittill(_id_DEE1E90C5A8243B7);
  else
    wait(_id_DEE1E90C5A8243B7);

  if(isDefined(_id_434850FD34BB5B05))
    self[[_id_CE2D4778F5804E61]](_id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_434849FD34BB4BA0, _id_434850FD34BB5B05);
  else if(isDefined(_id_434849FD34BB4BA0))
    self[[_id_CE2D4778F5804E61]](_id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_434849FD34BB4BA0);
  else if(isDefined(_id_43484AFD34BB4DD3))
    self[[_id_CE2D4778F5804E61]](_id_43484BFD34BB5006, _id_43484AFD34BB4DD3);
  else if(isDefined(_id_43484BFD34BB5006))
    self[[_id_CE2D4778F5804E61]](_id_43484BFD34BB5006);
  else
    self[[_id_CE2D4778F5804E61]]();
}

waittill_notify(_id_137628862F7C8CFB, _id_E332C90D19067E4D, _id_DEE1E90C5A8243B7, ender, _id_E2A2D749AE907B0D) {
  if(!isDefined(_id_E2A2D749AE907B0D))
    _id_E2A2D749AE907B0D = 0;

  for(_id_AF4E48DB675A4E67 = 1; _id_AF4E48DB675A4E67; _id_AF4E48DB675A4E67 = _id_E2A2D749AE907B0D) {
    self endon("death");

    if(isDefined(ender))
      self endon(ender);

    self waittill(_id_137628862F7C8CFB);
    _id_E332C90D19067E4D notify(_id_DEE1E90C5A8243B7);
  }
}

loop_anim(animarray, animname, ender, _id_07B60BC0EAB3FD1E) {
  self endon("death");

  if(isDefined(ender))
    self endon(ender);

  for(;;) {
    a = single_anim(animarray, animname, "loop_anim", 0, _id_07B60BC0EAB3FD1E);

    if(scripts\common\utility::issp()) {
      self waittillmatch("loop_anim", "end");
      continue;
    }

    wait(getanimlength(a));
  }
}

single_anim(animarray, animname, _id_DEE1E90C5A8243B7, _id_D07A6CD6FACA576D, _id_07B60BC0EAB3FD1E) {
  if(!isDefined(_id_DEE1E90C5A8243B7))
    _id_DEE1E90C5A8243B7 = "single_anim";

  if(!isDefined(_id_07B60BC0EAB3FD1E))
    _id_07B60BC0EAB3FD1E = 1;

  if(isarray(animarray[animname])) {
    if(!isDefined(animarray[animname + "weight"])) {
      animarray[animname + "weight"] = [];
      keys = getarraykeys(animarray[animname]);

      foreach(key in keys)
      animarray[animname + "weight"][key] = 1;
    }

    _id_AB337A614AC67FEF = animarray[animname].size;
    _id_D4B9E030F49735D5 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_AB337A614AC67FEF; _id_AC0E594AC96AA3A8++)
      _id_D4B9E030F49735D5 = _id_D4B9E030F49735D5 + animarray[animname + "weight"][_id_AC0E594AC96AA3A8];

    _id_00AE14C5A8B1B582 = randomfloat(_id_D4B9E030F49735D5);
    _id_DB9267D0D9167FD8 = 0;

    for(_id_BE1FFF030AD6D6AF = -1; _id_DB9267D0D9167FD8 <= _id_00AE14C5A8B1B582; _id_DB9267D0D9167FD8 = _id_DB9267D0D9167FD8 + animarray[animname + "weight"][_id_BE1FFF030AD6D6AF])
      _id_BE1FFF030AD6D6AF++;

    animation = animarray[animname][_id_BE1FFF030AD6D6AF];

    if(isDefined(animarray[animname + "mp"]))
      _id_CFBEE1A154F9F667 = animarray[animname + "mp"][_id_BE1FFF030AD6D6AF];
    else
      _id_CFBEE1A154F9F667 = undefined;
  } else {
    animation = animarray[animname];
    _id_CFBEE1A154F9F667 = animarray[animname + "mp"];
  }

  if(scripts\common\utility::issp()) {
    if(isDefined(_id_D07A6CD6FACA576D) && _id_D07A6CD6FACA576D)
      self call[[level.func["setflaggedanimknobrestart"]]](_id_DEE1E90C5A8243B7, animation, 1, 0.1, _id_07B60BC0EAB3FD1E);
    else
      self call[[level.func["setflaggedanimknob"]]](_id_DEE1E90C5A8243B7, animation, 1, 0.1, _id_07B60BC0EAB3FD1E);
  } else
    self call[[level.func["scriptModelPlayAnim"]]](_id_CFBEE1A154F9F667);

  return animation;
}

blendanimsbyspeed(speed, anims, _id_B26B58D3CC398CFC, _id_9EDE37C35118ABA9, _id_D180B535A33B044D) {
  if(!isDefined(_id_D180B535A33B044D))
    _id_D180B535A33B044D = 0.1;

  speed = clamp(speed, _id_B26B58D3CC398CFC[0], _id_B26B58D3CC398CFC[_id_B26B58D3CC398CFC.size - 1]);

  for(_id_AC0E594AC96AA3A8 = 0; speed > _id_B26B58D3CC398CFC[_id_AC0E594AC96AA3A8 + 1]; _id_AC0E594AC96AA3A8++) {}

  _id_5F3C0FE015B324A7 = speed - _id_B26B58D3CC398CFC[_id_AC0E594AC96AA3A8];
  _id_5F3C0FE015B324A7 = _id_5F3C0FE015B324A7 / (_id_B26B58D3CC398CFC[_id_AC0E594AC96AA3A8 + 1] - _id_B26B58D3CC398CFC[_id_AC0E594AC96AA3A8]);

  if(scripts\common\utility::issp()) {
    _id_5F3C0FE015B324A7 = clamp(_id_5F3C0FE015B324A7, 0.01, 0.99);
    _id_49CA266187246AA7 = _id_9EDE37C35118ABA9[_id_AC0E594AC96AA3A8 + 1] / _id_9EDE37C35118ABA9[_id_AC0E594AC96AA3A8];
    _id_2D082CFBC3507491 = _id_5F3C0FE015B324A7 + (1 - _id_5F3C0FE015B324A7) * _id_49CA266187246AA7;
    self call[[level.func["setanimlimited"]]](anims[_id_AC0E594AC96AA3A8], 1 - _id_5F3C0FE015B324A7, _id_D180B535A33B044D, _id_2D082CFBC3507491 / _id_49CA266187246AA7);
    self call[[level.func["setanimlimited"]]](anims[_id_AC0E594AC96AA3A8 + 1], _id_5F3C0FE015B324A7, _id_D180B535A33B044D, _id_2D082CFBC3507491);

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_AC0E594AC96AA3A8; _id_AC0E5C4AC96AAA41++) {
      _id_49CA266187246AA7 = _id_9EDE37C35118ABA9[_id_AC0E594AC96AA3A8 + 1] / _id_9EDE37C35118ABA9[_id_AC0E5C4AC96AAA41];
      self call[[level.func["setanimlimited"]]](anims[_id_AC0E5C4AC96AAA41], 0.01, _id_D180B535A33B044D, _id_2D082CFBC3507491 / _id_49CA266187246AA7);
    }

    for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 + 2; _id_AC0E5C4AC96AAA41 < _id_B26B58D3CC398CFC.size; _id_AC0E5C4AC96AAA41++) {
      _id_49CA266187246AA7 = _id_9EDE37C35118ABA9[_id_AC0E594AC96AA3A8 + 1] / _id_9EDE37C35118ABA9[_id_AC0E5C4AC96AAA41];
      self call[[level.func["setanimlimited"]]](anims[_id_AC0E5C4AC96AAA41], 0.01, _id_D180B535A33B044D, _id_2D082CFBC3507491 / _id_49CA266187246AA7);
    }
  } else if(_id_5F3C0FE015B324A7 > 0.5)
    self call[[level.func["scriptModelPlayAnim"]]](anims[_id_AC0E594AC96AA3A8 + 1]);
  else
    self call[[level.func["scriptModelPlayAnim"]]](anims[_id_AC0E594AC96AA3A8]);
}

detect_events(notifystring) {
  if(scripts\common\utility::issp()) {
    self endon("death");
    self endon("damage");
    self call[[level.func["makeEntitySentient"]]]("neutral");
    self call[[level.addaieventlistener_func]]("projectile_impact");
    self call[[level.addaieventlistener_func]]("bulletwhizby");
    self call[[level.addaieventlistener_func]]("gunshot");
    self call[[level.addaieventlistener_func]]("explosion");

    for(;;) {
      self waittill("ai_events");
      self notify(notifystring);
      self.interrupted = 1;
      waittillframeend;
      self.interrupted = 0;
    }
  }
}

detect_people(radius, _id_DEE1E90C5A8243B7, _id_A86AC46EF036B2B6) {
  if(!isarray(_id_A86AC46EF036B2B6)) {
    _id_24B6BA9D89A11752 = _id_A86AC46EF036B2B6;
    _id_A86AC46EF036B2B6 = [];
    _id_A86AC46EF036B2B6[0] = _id_24B6BA9D89A11752;
  }

  foreach(str in _id_A86AC46EF036B2B6)
  self endon(str);

  self.detect_people_trigger[_id_DEE1E90C5A8243B7] = spawn("trigger_radius", self.origin, 23, radius, radius);

  for(_id_AC0E594AC96AA3A8 = _id_A86AC46EF036B2B6.size; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++)
    _id_A86AC46EF036B2B6[_id_AC0E594AC96AA3A8] = undefined;

  thread scripts\engine\utility::delete_on_notify(self.detect_people_trigger[_id_DEE1E90C5A8243B7], _id_A86AC46EF036B2B6[0], _id_A86AC46EF036B2B6[1], _id_A86AC46EF036B2B6[2]);

  for(;;) {
    self.detect_people_trigger[_id_DEE1E90C5A8243B7] waittill("trigger", interruptedent);
    self.interruptedent = interruptedent;
    self notify(_id_DEE1E90C5A8243B7);
    self.interrupted = 1;
    waittillframeend;
    self.interrupted = 0;
  }
}

detect_player_event(radius, _id_DEE1E90C5A8243B7, _id_A86AC46EF036B2B6, _id_0BB0A0A84C7691F2) {
  if(!isarray(_id_A86AC46EF036B2B6)) {
    _id_24B6BA9D89A11752 = _id_A86AC46EF036B2B6;
    _id_A86AC46EF036B2B6 = [];
    _id_A86AC46EF036B2B6[0] = _id_24B6BA9D89A11752;
  }

  foreach(str in _id_A86AC46EF036B2B6)
  self endon(str);

  for(;;) {
    level.player waittill(_id_0BB0A0A84C7691F2);

    if(distancesquared(level.player.origin, self.origin) < radius * radius) {
      self notify(_id_DEE1E90C5A8243B7);
      self.interruptedent = level.player;
      self notify(_id_DEE1E90C5A8243B7);
      self.interrupted = 1;
      waittillframeend;
      self.interrupted = 0;
    }
  }
}

wrap(number, range) {
  _id_8C0862800F4FE0AC = int(number / range);
  _id_02C0DC6323DDFA44 = number - range * _id_8C0862800F4FE0AC;

  if(number < 0)
    _id_02C0DC6323DDFA44 = _id_02C0DC6323DDFA44 + range;

  if(_id_02C0DC6323DDFA44 == range)
    _id_02C0DC6323DDFA44 = 0;

  return _id_02C0DC6323DDFA44;
}

interactives_drawdebuglinefortime(_id_6C12713F33727294, org2, r, g, b, timer) {}

drawcross(origin, _id_A61C75B156FC1EE0, color, _id_735A70BE53A0E4B5) {
  thread scripts\engine\utility::draw_line_for_time(origin - (_id_A61C75B156FC1EE0, 0, 0), origin + (_id_A61C75B156FC1EE0, 0, 0), color[0], color[1], color[2], _id_735A70BE53A0E4B5);
  thread scripts\engine\utility::draw_line_for_time(origin - (0, _id_A61C75B156FC1EE0, 0), origin + (0, _id_A61C75B156FC1EE0, 0), color[0], color[1], color[2], _id_735A70BE53A0E4B5);
  thread scripts\engine\utility::draw_line_for_time(origin - (0, 0, _id_A61C75B156FC1EE0), origin + (0, 0, _id_A61C75B156FC1EE0), color[0], color[1], color[2], _id_735A70BE53A0E4B5);
}

drawcircle(origin, radius, color, _id_735A70BE53A0E4B5) {
  _id_5C9CB2FBE8943109 = 16;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 360; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 360 / _id_5C9CB2FBE8943109) {
    _id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 + 360 / _id_5C9CB2FBE8943109;
    thread scripts\engine\utility::draw_line_for_time(origin + (radius * cos(_id_AC0E594AC96AA3A8), radius * sin(_id_AC0E594AC96AA3A8), 0), origin + (radius * cos(_id_AC0E5C4AC96AAA41), radius * sin(_id_AC0E5C4AC96AAA41), 0), color[0], color[1], color[2], _id_735A70BE53A0E4B5);
  }
}

drawcirculararrow(origin, radius, color, _id_735A70BE53A0E4B5, _id_D90439D9C610BE2A) {
  if(_id_D90439D9C610BE2A == 0) {
    return;
  }
  _id_B5D101D69B7C6B94 = 16;
  _id_5C9CB2FBE8943109 = int(1 + _id_B5D101D69B7C6B94 * abs(_id_D90439D9C610BE2A) / 360);

  for(_id_BE2008030AD6EA7A = 0; _id_BE2008030AD6EA7A < _id_5C9CB2FBE8943109; _id_BE2008030AD6EA7A++) {
    _id_AC0E594AC96AA3A8 = _id_BE2008030AD6EA7A * _id_D90439D9C610BE2A / _id_5C9CB2FBE8943109;
    _id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 + _id_D90439D9C610BE2A / _id_5C9CB2FBE8943109;
    thread scripts\engine\utility::draw_line_for_time(origin + (radius * cos(_id_AC0E594AC96AA3A8), radius * sin(_id_AC0E594AC96AA3A8), 0), origin + (radius * cos(_id_AC0E5C4AC96AAA41), radius * sin(_id_AC0E5C4AC96AAA41), 0), color[0], color[1], color[2], _id_735A70BE53A0E4B5);
  }

  _id_AC0E594AC96AA3A8 = _id_D90439D9C610BE2A;
  _id_AC0E5C4AC96AAA41 = _id_D90439D9C610BE2A - scripts\engine\utility::sign(_id_D90439D9C610BE2A) * 20;
  thread scripts\engine\utility::draw_line_for_time(origin + (radius * cos(_id_AC0E594AC96AA3A8), radius * sin(_id_AC0E594AC96AA3A8), 0), origin + (radius * 0.8 * cos(_id_AC0E5C4AC96AAA41), radius * 0.8 * sin(_id_AC0E5C4AC96AAA41), 0), color[0], color[1], color[2], _id_735A70BE53A0E4B5);
  thread scripts\engine\utility::draw_line_for_time(origin + (radius * cos(_id_AC0E594AC96AA3A8), radius * sin(_id_AC0E594AC96AA3A8), 0), origin + (radius * 1.2 * cos(_id_AC0E5C4AC96AAA41), radius * 1.2 * sin(_id_AC0E5C4AC96AAA41), 0), color[0], color[1], color[2], _id_735A70BE53A0E4B5);
}

isinarray(e, array) {
  foreach(a in array) {
    if(e == a)
      return 1;
  }

  return 0;
}

newtonsmethod(_id_CDEFFD78F53D3AE1, _id_CDEFFC78F53D38AE, p3, p2, p1, _id_CDCCED78F516CFF9, tolerance) {
  _id_5D511DFB0DA42511 = 5;
  x = (_id_CDEFFD78F53D3AE1 + _id_CDEFFC78F53D38AE) / 2;

  for(offset = tolerance + 1; abs(offset) > tolerance && _id_5D511DFB0DA42511 > 0; _id_5D511DFB0DA42511--) {
    value = p3 * x * x * x + p2 * x * x + p1 * x + _id_CDCCED78F516CFF9;
    _id_13F52C8DB665C5A4 = 3 * p3 * x * x + 2 * p2 * x + p1;
    offset = -1 * value / _id_13F52C8DB665C5A4;
    _id_3841E23FC9842B9E = x;
    x = x + offset;

    if(x > _id_CDEFFC78F53D38AE) {
      x = (_id_3841E23FC9842B9E + 3 * _id_CDEFFC78F53D38AE) / 4;
      continue;
    }

    if(x < _id_CDEFFD78F53D3AE1)
      x = (_id_3841E23FC9842B9E + 3 * _id_CDEFFD78F53D3AE1) / 4;
  }

  return x;
}

rootsofcubic(a, b, c, _id_AC0E564AC96A9D0F) {
  if(a == 0)
    return rootsofquadratic(b, c, _id_AC0E564AC96A9D0F);

  _id_AC0E414AC96A6EE0 = 2 * b * b * b - 9 * a * b * c + 27 * a * a * _id_AC0E564AC96A9D0F;
  _id_1FB77E21069563E7 = b * b - 3 * a * c;

  if(_id_1FB77E21069563E7 == 0) {}

  if(_id_AC0E414AC96A6EE0 == 0 && _id_1FB77E21069563E7 == 0)
    x[0] = -1 * b / (3 * a);
  else if(_id_AC0E414AC96A6EE0 == 0 && _id_1FB77E21069563E7 != 0)
    x[0] = (9 * a * a * _id_AC0E564AC96A9D0F - 4 * a * b * c + b * b * b) / (a * (3 * a * c - b * b));
  else {}
}

rootsofquadratic(a, b, c) {
  while(abs(a) > 65536 || abs(b) > 65536 || abs(c) > 65536) {
    a = a / 10;
    b = b / 10;
    c = c / 10;
  }

  x = [];

  if(a == 0) {
    if(b != 0)
      x[0] = -1 * c / b;
  } else {
    _id_684C33213BCCE7F6 = b * b - 4 * a * c;

    if(_id_684C33213BCCE7F6 > 0) {
      x[0] = (-1 * b - sqrt(_id_684C33213BCCE7F6)) / (2 * a);
      x[1] = (-1 * b + sqrt(_id_684C33213BCCE7F6)) / (2 * a);
    } else if(_id_684C33213BCCE7F6 == 0)
      x[0] = -1 * b / (2 * a);
  }

  return x;
}

nonvectorlength(array, _id_4F6FF04F222AFBD8) {
  _id_BE66DE030B25508C = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
    value = array[_id_AC0E594AC96AA3A8];

    if(isDefined(_id_4F6FF04F222AFBD8))
      value = value - _id_4F6FF04F222AFBD8[_id_AC0E594AC96AA3A8];

    _id_BE66DE030B25508C = _id_BE66DE030B25508C + value * value;
  }

  return sqrt(_id_BE66DE030B25508C);
}

clampandnormalize(x, min, max) {
  if(min < max)
    x = clamp(x, min, max);
  else
    x = clamp(x, max, min);

  return (x - min) / (max - min);
}

pointoncircle(center, radius, _id_D3FA1303D7529A1B) {
  x = cos(_id_D3FA1303D7529A1B);
  x = x * radius;
  x = x + center[0];
  y = sin(_id_D3FA1303D7529A1B);
  y = y * radius;
  y = y + center[1];
  z = center[2];
  return (x, y, z);
}

zerocomponent(_id_16290C9DDA466BCE, _id_6CAAB024B490A416) {
  return (_id_16290C9DDA466BCE[0] * (_id_6CAAB024B490A416 != 0), _id_16290C9DDA466BCE[1] * (_id_6CAAB024B490A416 != 1), _id_16290C9DDA466BCE[2] * (_id_6CAAB024B490A416 != 2));
}

rotate90aroundaxis(_id_16290C9DDA466BCE, _id_6CAAB024B490A416) {
  if(_id_6CAAB024B490A416 == 0)
    return (_id_16290C9DDA466BCE[0], _id_16290C9DDA466BCE[2], -1 * _id_16290C9DDA466BCE[1]);
  else if(_id_6CAAB024B490A416 == 1)
    return (-1 * _id_16290C9DDA466BCE[2], _id_16290C9DDA466BCE[1], _id_16290C9DDA466BCE[0]);
  else
    return (_id_16290C9DDA466BCE[1], -1 * _id_16290C9DDA466BCE[0], _id_16290C9DDA466BCE[2]);
}