/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\battlechatter_events.gsc
*************************************************/

_id_F5154A3D477820D9() {
  if(_id_35DE402EFC5ACFB3::_id_8F59CAA9212FCC56()) {
    return;
  }
  if(scripts\common\utility::issp() && !isalive(level.player)) {
    return;
  }
  if(_id_35DE402EFC5ACFB3::_id_9F810AAE92AC7BF1(3) && !isDefined(self.battlechatter._id_02AA26FB8B4BF8A1) || isDefined(self.battlechatter._id_020E68057B05A543)) {
    if(!isDefined(self.battlechatter._id_02AA26FB8B4BF8A1))
      _id_971153A5E8911FEF = 999;
    else
      _id_971153A5E8911FEF = (gettime() - self.battlechatter._id_020E68057B05A543) / 1000;

    self.battlechatter._id_02AA26FB8B4BF8A1 = gettime();
    self.battlechatter._id_020E68057B05A543 = undefined;

    if(_id_971153A5E8911FEF > 30)
      return _id_5634AD9C7902C703();
  }

  self.battlechatter._id_02AA26FB8B4BF8A1 = gettime();

  if(isstruct(_id_16C83724C6B1446D())) {
    return;
  }
  if(isstruct(_id_6C86247E5B5EB26D())) {
    return;
  }
  if(isstruct(_id_C5ECE4FA44D2894E())) {
    return;
  }
  if(isstruct(_id_25BC4D68CC6D7A4A())) {
    return;
  }
  if(isstruct(_id_9B24C93B2BC885CF())) {
    return;
  }
  if(isstruct(_id_6DE481EBC9A12469()))
    return;
}

_id_5634AD9C7902C703() {
  other = _id_35DE402EFC5ACFB3::getclosestfriendlyspeaker();

  if(!isDefined(other)) {
    return;
  }
  if(scripts\common\utility::issp() && (!isDefined(self.enemy) || !isDefined(self.enemy.origin) || istrue(!self canshoot(self.enemy.origin + (0, 0, 40))))) {
    return;
  }
  if(scripts\engine\utility::_id_51D76700600CEBE3(40))
    _id_BE1FF2030AD6BA18 = [0.3, "enemy_soldier", _id_35DE402EFC5ACFB3::_id_D4148681450730E1, other, ::_id_D2B3539E8CDD93E7];
  else
    _id_BE1FF2030AD6BA18 = [0.3, "enemy_soldier", _id_35DE402EFC5ACFB3::_id_D4148681450730E1];

  if(scripts\engine\utility::_id_51D76700600CEBE3(65))
    _id_BE1FF2030AD6BA18 = scripts\engine\utility::array_combine(_id_BE1FF2030AD6BA18, [other, 0.1, "aquired_target"]);

  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("aquired_target", _id_BE1FF2030AD6BA18, 0, 2, 50);
}

_id_D2B3539E8CDD93E7() {
  if(!isDefined(self._id_7D2852D02216C876) || !isDefined(self._id_6727329A89208345) || !isDefined(self._id_7D2852D02216C876.enemy)) {
    return;
  }
  direction = self._id_6727329A89208345 _id_3893E3DB7E7694D5(self._id_6727329A89208345.enemy);

  if(!isDefined(direction)) {
    return;
  }
  if(!self._id_7D2852D02216C876 seerecently(self._id_7D2852D02216C876.enemy, 3))
    return [0.4, "neg_target", self._id_6727329A89208345, 0.2, direction];
}

_id_6DE481EBC9A12469() {
  _id_BE1FF2030AD6BA18 = _id_F06047156C190734();

  if(!isDefined(_id_BE1FF2030AD6BA18)) {
    return;
  }
  return _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("order_attack", _id_BE1FF2030AD6BA18, 0, 2, 15);
}

_id_F06047156C190734() {
  other = _id_35DE402EFC5ACFB3::getclosestfriendlyspeaker();

  if(!isDefined(other)) {
    return;
  }
  _id_185936C4E070C511 = other _id_2008B43ADF7E18EF();

  if(scripts\engine\utility::_id_51D76700600CEBE3(30))
    _id_185936C4E070C511 = 0;

  if(scripts\engine\utility::_id_51D76700600CEBE3(40))
    _id_BE1FF2030AD6BA18 = [_id_185936C4E070C511, "order_attack", other, 0.3, "copy", 0.1, "attacking"];
  else
    _id_BE1FF2030AD6BA18 = [_id_185936C4E070C511, "order_attack", other, 0.2, ::_id_E5312C6DFA471FDB];

  return _id_BE1FF2030AD6BA18;
}

_id_E5312C6DFA471FDB() {
  return scripts\engine\utility::ter_op(self._id_7D2852D02216C876 _id_2B79931B08683E0A::recentlysawenemy(), "aquired_target", "target_covered");
}

_id_A06C6F8B2F6D82D0(direction) {
  if(self.enemy _id_35DE402EFC5ACFB3::_id_A9328A64687886FB(self, level._id_FB605061A3778884)) {
    return;
  }
  if(!_id_35DE402EFC5ACFB3::_id_45F570789FF9A0FD(5, 1)) {
    return;
  }
  if(!isDefined(direction))
    direction = _id_3893E3DB7E7694D5(self.enemy);

  if(!isDefined(direction) || direction == "ahead") {
    return;
  }
  _id_BE1FF2030AD6BA18 = [direction, _id_35DE402EFC5ACFB3::_id_D4148681450730E1];
  other = _id_35DE402EFC5ACFB3::getclosestfriendlyspeaker();

  if(isDefined(other))
    return 0;

  _id_BE1FF2030AD6BA18 = scripts\engine\utility::array_combine(_id_BE1FF2030AD6BA18, [other, 0.1, ::_id_E5312C6DFA471FDB]);
  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("enemy_direction", _id_BE1FF2030AD6BA18, 0, 2, 20);
}

_id_3893E3DB7E7694D5(target) {
  if(!isDefined(target) || !isDefined(target.origin) || !isDefined(target.team)) {
    return;
  }
  if(target.origin[2] > self.origin[2] + 100)
    return "high";

  allies = _id_35DE402EFC5ACFB3::_id_FD9E4CB348A5F283(self.origin, level._id_63A73645A8E030AD, self.team);

  if(self.team == "allies")
    allies = scripts\engine\utility::array_combine(allies, _id_35DE402EFC5ACFB3::_id_2AA175082BDB56F5(self.origin, level._id_798AA343368F724E));

  if(allies.size == 0) {
    return;
  }
  _id_8005708C7112C01D = get_average_origin(allies);
  _id_D5F00D2293024573 = vectorNormalize(_id_7969D683DFC4FB9E(allies));
  _id_53B34AADF7B8E731 = vectorNormalize(target.origin - _id_8005708C7112C01D);
  _id_9913FD1FFEA99C33 = vectordot(_id_53B34AADF7B8E731, _id_D5F00D2293024573);

  if(_id_9913FD1FFEA99C33 > 0.95)
    return "ahead";

  if(_id_9913FD1FFEA99C33 < -0.1)
    return "behind";

  right = vectorcross((0, 0, 1), _id_D5F00D2293024573);
  _id_9913FD1FFEA99C33 = vectordot(_id_53B34AADF7B8E731, right);
  return scripts\engine\utility::ter_op(_id_9913FD1FFEA99C33 < 0, "right", "left");
}

_id_A1B5CCD038B58C59(start, end, color, _id_CDC08C2C59A55365, _id_B7973E4DBA31564C, _id_3F809D1940BBAE5C, _id_FFB74DFE2FDAD3BE, duration) {
  angle = vectortoangles(end - start);
  _id_46F432042B3473D8 = length(end - start);

  if(isDefined(_id_3F809D1940BBAE5C) && _id_3F809D1940BBAE5C <= 1)
    _id_3F809D1940BBAE5C = _id_46F432042B3473D8 * _id_3F809D1940BBAE5C;

  right = anglestoright(angle);
  forward = anglesToForward(angle);
  _id_CDC08C2C59A55365 = scripts\engine\utility::_id_53C4C53197386572(_id_CDC08C2C59A55365, 2);
  _id_B7973E4DBA31564C = scripts\engine\utility::_id_53C4C53197386572(_id_B7973E4DBA31564C, _id_CDC08C2C59A55365 * 4);
  _id_3F809D1940BBAE5C = scripts\engine\utility::_id_53C4C53197386572(_id_3F809D1940BBAE5C, _id_B7973E4DBA31564C * 3);
  _id_FFB74DFE2FDAD3BE = scripts\engine\utility::_id_53C4C53197386572(_id_FFB74DFE2FDAD3BE, 1);
  duration = scripts\engine\utility::_id_53C4C53197386572(duration, 1);
  _id_3A7377042D23723C = start + forward * (_id_46F432042B3473D8 - _id_3F809D1940BBAE5C);
  _id_C83AA9DBC3654AFA = [end];
  _id_C83AA9DBC3654AFA[_id_C83AA9DBC3654AFA.size] = _id_3A7377042D23723C + right * _id_B7973E4DBA31564C / 2;
  _id_C83AA9DBC3654AFA[_id_C83AA9DBC3654AFA.size] = _id_3A7377042D23723C + right * _id_CDC08C2C59A55365 / 2;
  _id_C83AA9DBC3654AFA[_id_C83AA9DBC3654AFA.size] = start + right * _id_CDC08C2C59A55365 / 2;
  _id_C83AA9DBC3654AFA[_id_C83AA9DBC3654AFA.size] = start - right * _id_CDC08C2C59A55365 / 2;
  _id_C83AA9DBC3654AFA[_id_C83AA9DBC3654AFA.size] = _id_3A7377042D23723C - right * _id_CDC08C2C59A55365 / 2;
  _id_C83AA9DBC3654AFA[_id_C83AA9DBC3654AFA.size] = _id_3A7377042D23723C - right * _id_B7973E4DBA31564C / 2;

  for(_id_AC0E424AC96A7113 = 0; _id_AC0E424AC96A7113 < _id_C83AA9DBC3654AFA.size; _id_AC0E424AC96A7113++) {}
}

get_average_origin(guys, max_count) {
  max_count = scripts\engine\utility::_id_53C4C53197386572(max_count, guys.size);
  origins = [];

  foreach(guy in guys) {
    if(origins.size >= max_count) {
      break;
    }

    origins[origins.size] = guy.origin;
  }

  return averagepoint(origins);
}

_id_7969D683DFC4FB9E(guys, max_count) {
  max_count = scripts\engine\utility::_id_53C4C53197386572(max_count, guys.size);
  _id_4F8BF27D0FADF637 = [];

  foreach(guy in guys) {
    if(_id_4F8BF27D0FADF637.size >= max_count) {
      break;
    }

    if(isDefined(guy.node))
      guy = guy.node;

    _id_4F8BF27D0FADF637[_id_4F8BF27D0FADF637.size] = anglesToForward(guy.angles);
  }

  return averagenormal(_id_4F8BF27D0FADF637);
}

_id_25BC4D68CC6D7A4A() {
  enemy = self.enemy;

  if(!isDefined(enemy) || !isDefined(enemy.origin) || !isDefined(enemy.team)) {
    return;
  }
  if(!_id_35DE402EFC5ACFB3::_id_45F570789FF9A0FD(5, 1)) {
    return;
  }
  if(isPlayer(enemy))
    _id_89CCB978EE789750 = !self seerecently(self.enemy, 0.5);
  else {
    _id_FD38FDC63572E2FD = isDefined(enemy.node) && isDefined(enemy.node.type) && enemy.node.type != "Exposed 3D" && enemy.node.type != "Path 3D";
    _id_89CCB978EE789750 = _id_FD38FDC63572E2FD && distance2dsquared(enemy.origin, enemy.node.origin) <= enemy.goalradius * enemy.goalradius;
  }

  if(_id_89CCB978EE789750)
    _id_BE2008030AD6EA7A = _id_35DE402EFC5ACFB3::_id_1609EF297B7A32CF(enemy, "target_covered", "enemy_getting_cover");
  else
    _id_BE2008030AD6EA7A = _id_35DE402EFC5ACFB3::_id_1609EF297B7A32CF(enemy, "target_exposed", "enemy_exposed");

  return _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("enemy_exposure", [0.3, _id_BE2008030AD6EA7A, _id_35DE402EFC5ACFB3::_id_D4148681450730E1], 0, 2, 15);
}

_id_C5ECE4FA44D2894E() {
  allies = _id_35DE402EFC5ACFB3::_id_FD9E4CB348A5F283(self.origin, level._id_798AA343368F724E, self.team);

  foreach(ally in allies) {
    if(ally == self) {
      continue;
    }
    if(!isDefined(ally.node) || !isDefined(ally.node.type) || ally.node.type == "Exposed 3D" || ally.node.type == "Path 3D") {
      _id_782921312B88FD8F = ally _id_2008B43ADF7E18EF();
      return _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("ally_exposure", [_id_782921312B88FD8F, 0.1, "youre_exposed"], 0, 1, 15);
    }
  }
}

_id_6C86247E5B5EB26D() {
  other = _id_35DE402EFC5ACFB3::getclosestfriendlyspeaker();

  if(isDefined(other))
    _id_BE1FF2030AD6BA18 = _id_E9B99C2D42EA8B56(other);
  else
    _id_BE1FF2030AD6BA18 = scripts\engine\utility::ter_op(_id_859D741DC99BF1A4(), "wounded", "low_ammo");

  return _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("combat_status", _id_BE1FF2030AD6BA18, 0, 1, 20);
}

_id_E9B99C2D42EA8B56(other) {
  _id_185936C4E070C511 = other _id_2008B43ADF7E18EF();

  switch (randomint(3)) {
    case 0:
      return [_id_185936C4E070C511, "ask_wounded", 0.1, other, ::_id_9485CA5CF96BD699];
    case 1:
      return [_id_185936C4E070C511, "ask_low_ammo", 0.1, other, ::_id_4FDBCAA7C15F5B11];
    default:
      if(scripts\engine\utility::cointoss()) {
        return ["ask_status", 0.1, other, ::_id_9485CA5CF96BD699];
        return;
      }
  }
}

_id_4FDBCAA7C15F5B11() {
  return scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "reply_low_ammo", "reply_okay");
}

_id_9485CA5CF96BD699() {
  return scripts\engine\utility::ter_op(self._id_7D2852D02216C876 _id_859D741DC99BF1A4(), "reply_wounded", "reply_okay");
}

_id_859D741DC99BF1A4() {
  maxhealth = scripts\engine\utility::_id_53C4C53197386572(self.maxhealth, 100);
  return self.health < maxhealth;
}

_id_16C83724C6B1446D(enemy) {
  enemy = scripts\engine\utility::_id_53C4C53197386572(enemy, self.enemy);

  if(!_id_35DE402EFC5ACFB3::_id_45F570789FF9A0FD(5, 1)) {
    return;
  }
  _id_AFAD886D032C5E04 = enemy _id_003CC20D595E70F8();

  if(!isDefined(_id_AFAD886D032C5E04)) {
    return;
  }
  _id_BE2008030AD6EA7A = _id_35DE402EFC5ACFB3::_id_1609EF297B7A32CF(enemy, "target_" + _id_AFAD886D032C5E04, "enemy_" + _id_AFAD886D032C5E04);
  return _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("enemy_weapon", [0.3, _id_BE2008030AD6EA7A, _id_35DE402EFC5ACFB3::_id_D4148681450730E1], 0, 1, 20);
}

_id_003CC20D595E70F8() {
  weapon = scripts\engine\utility::ter_op(isDefined(self.weapon), self.weapon, self.currentweapon);

  if(!isDefined(weapon)) {
    return;
  }
  if(isarray(weapon))
    weapon = weapon[0];

  class = weaponclass(weapon);

  if(!isDefined(class)) {
    return;
  }
  switch (class) {
    case "mg":
      return "lmg";
    case "spread":
      return "shotgun";
    case "sniper":
      return "sniper";
    case "rocketlauncher":
    case "grenade":
    case "rifle":
    case "pistol":
    case "smg":
    default:
      return undefined;
  }
}

_id_9B24C93B2BC885CF() {
  if(!isDefined(self.team) || self.team == "dead") {
    return;
  }
  if(!isDefined(self.battlechatter) || !isDefined(self.battlechatter.countryid) || self.battlechatter.countryid == "PMC") {
    return;
  }
  if(!isDefined(self.voice) || self.voice == "mexicanarmy") {
    return;
  }
  other = _id_35DE402EFC5ACFB3::getclosestfriendlyspeaker(self.team, "combat");
  return _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("hostile_burst", "hostile_burst", 0, 1, 15);
}

_id_656C8BA582163660(type) {
  if(type == "frag" || type == "semtex")
    type = "grenade";

  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("use_" + type, "using_" + type, 0, 1, 10);
}

_id_A7A911968F655267(type) {
  if(type == "frag" || type == "semtex")
    type = "grenade";

  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("incoming_" + type, "enemy_using_" + type, 0, 1, 10);
}

_id_A3B5180187A17623() {
  if(scripts\common\utility::issp() && !isalive(level.player)) {
    return;
  }
  wait 0.3;
  lastshoottime = self.battlechatter.lastshoottime;

  if(isDefined(self.battlechatter._id_3C94D4874D436201) && self.battlechatter._id_3C94D4874D436201 > gettime()) {
    return;
  }
  self.battlechatter.lastshoottime = gettime();

  if(!scripts\engine\utility::time_has_passed(lastshoottime, 20)) {
    return;
  }
  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("attacking", "attacking", 0, 1, 40);
}

_id_8BDFF60054CE5866() {}

_id_C4E2E61A7CE330C0() {
  if(scripts\common\utility::issp() && !isalive(level.player)) {
    return;
  }
  if(!scripts\common\utility::issp() && isPlayer(self)) {
    return;
  }
  if(!isPlayer(self) && _id_35DE402EFC5ACFB3::_id_8F59CAA9212FCC56()) {
    return;
  }
  enemies = [];

  if(_id_35DE402EFC5ACFB3::_id_EAD4BED232D015ED("enemy_reloading")) {
    if(isPlayer(self))
      enemies = _id_35DE402EFC5ACFB3::_id_FD9E4CB348A5F283(self.origin, level._id_587DE0E7B537210A, "axis");
    else
      enemies = _id_35DE402EFC5ACFB3::_id_E457176B043F3F8B();
  }

  foreach(enemy in enemies) {
    if(scripts\common\utility::issp() && isPlayer(self) && !enemy canshoot(self.origin + (0, 0, 40))) {
      continue;
    }
    if(scripts\engine\utility::is_equal(enemy.enemy, self) && enemy seerecently(self, 5)) {
      _id_BE1FF2030AD6BA18 = [0.3, _id_35DE402EFC5ACFB3::_id_1609EF297B7A32CF(enemy, "target_reloading", "enemy_reloading")];

      if(scripts\engine\utility::_id_51D76700600CEBE3(60)) {
        _id_F06047156C190734 = enemy _id_F06047156C190734();

        if(isDefined(_id_F06047156C190734))
          _id_BE1FF2030AD6BA18 = scripts\engine\utility::array_combine(_id_BE1FF2030AD6BA18, _id_F06047156C190734);
      }

      enemy _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("enemy_reloading", _id_BE1FF2030AD6BA18, 0, 1, 20);
      return;
    }
  }

  other = _id_35DE402EFC5ACFB3::getclosestfriendlyspeaker();

  if(isDefined(other) && scripts\engine\utility::_id_51D76700600CEBE3(65)) {
    _id_185936C4E070C511 = other _id_2008B43ADF7E18EF();

    if(scripts\engine\utility::_id_51D76700600CEBE3(30))
      _id_185936C4E070C511 = 0;

    if(other _id_35DE402EFC5ACFB3::_id_9F810AAE92AC7BF1(3))
      _id_BE1FF2030AD6BA18 = ["reloading", 0.2, _id_185936C4E070C511, "coverme", other, 0.3, "suppressing"];
    else
      _id_BE1FF2030AD6BA18 = ["reloading", 0.2, _id_185936C4E070C511, "coverme"];
  } else if(scripts\engine\utility::_id_51D76700600CEBE3(30))
    _id_BE1FF2030AD6BA18 = ["reloading", other, 0.1, "copy"];
  else
    _id_BE1FF2030AD6BA18 = "reloading";

  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("reloading", _id_BE1FF2030AD6BA18, 0, 1, 15);
}

_id_42C77C7F13A1BEB8(_id_12853466CE806612) {
  if(scripts\common\utility::issp() && !isalive(level.player)) {
    return;
  }
  if(_id_35DE402EFC5ACFB3::_id_8F59CAA9212FCC56()) {
    return;
  }
  if(!_id_35DE402EFC5ACFB3::_id_EAD4BED232D015ED("enemy_movement"))
    _id_12853466CE806612 = 0;

  enemies = _id_35DE402EFC5ACFB3::_id_E457176B043F3F8B();

  if(enemies.size == 0) {
    return;
  }
  _id_D40324EDC38301C9 = get_average_origin(enemies);
  _id_A2BDE827FD591515 = _id_D40324EDC38301C9 - self.origin;
  _id_AEB1CF2A75782056 = self.goalpos - self.origin;
  _id_9913FD1FFEA99C33 = vectordot(_id_A2BDE827FD591515, _id_AEB1CF2A75782056);

  if(scripts\engine\utility::_id_53C4C53197386572(_id_12853466CE806612, 1)) {
    foreach(enemy in enemies) {
      if(isPlayer(enemy) || scripts\engine\utility::is_equal(enemy.enemy, self) && enemy seerecently(self, 5)) {
        if(_id_9913FD1FFEA99C33 > 0.65)
          _id_BE1FF2030AD6BA18 = _id_35DE402EFC5ACFB3::_id_1609EF297B7A32CF(enemy, "target_moving_up", "enemy_moving_up");
        else
          _id_BE1FF2030AD6BA18 = _id_35DE402EFC5ACFB3::_id_1609EF297B7A32CF(enemy, "target_moving", "enemy_moving");

        if(scripts\engine\utility::_id_51D76700600CEBE3(60)) {
          _id_F06047156C190734 = enemy _id_F06047156C190734();

          if(isDefined(_id_F06047156C190734))
            _id_BE1FF2030AD6BA18 = scripts\engine\utility::array_insert(_id_F06047156C190734, _id_BE1FF2030AD6BA18, 0);
        }

        enemy _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("enemy_movement", _id_BE1FF2030AD6BA18, 0, 1, 20);
        return;
      }
    }
  }

  other = _id_35DE402EFC5ACFB3::getclosestfriendlyspeaker();
  _id_BE1FF2030AD6BA18 = scripts\engine\utility::ter_op(_id_9913FD1FFEA99C33 > 0.65, "movingup", "moving");

  if(isDefined(other) && scripts\engine\utility::_id_51D76700600CEBE3(65)) {
    _id_185936C4E070C511 = other _id_2008B43ADF7E18EF();

    if(scripts\engine\utility::_id_51D76700600CEBE3(30))
      _id_185936C4E070C511 = 0;

    if(other _id_35DE402EFC5ACFB3::_id_9F810AAE92AC7BF1(3))
      _id_BE1FF2030AD6BA18 = [_id_BE1FF2030AD6BA18, 0.2, _id_185936C4E070C511, "coverme", other, 0.3, "suppressing"];
    else
      _id_BE1FF2030AD6BA18 = [_id_BE1FF2030AD6BA18, 0.2, _id_185936C4E070C511, "coverme", other];
  } else if(scripts\engine\utility::_id_51D76700600CEBE3(30))
    _id_BE1FF2030AD6BA18 = [_id_BE1FF2030AD6BA18, other, 0.1, "copy"];
  else
    _id_BE1FF2030AD6BA18 = _id_BE1FF2030AD6BA18;

  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("movement", _id_BE1FF2030AD6BA18, 0, 1, 15);
}

_id_453B3867C6EC0CEB(enemy, team, type) {
  wait 0.6;

  if(!isDefined(self) || !isDefined(team) || !isDefined(enemy) || team == "dead") {
    return;
  }
  if(isDefined(type)) {
    _id_927B3199642B75FC = "killfirm_" + type;
    name = "killfirm_" + type;
  } else {
    _id_927B3199642B75FC = _id_35DE402EFC5ACFB3::_id_1609EF297B7A32CF(enemy, "killfirm_target", "killfirm_enemy");
    name = "killfirm";
  }

  cooldown = 15;
  _id_7D2852D02216C876 = self;
  other = _id_35DE402EFC5ACFB3::getclosestfriendlyspeaker(team, undefined, 1);

  if(isPlayer(self) && isalive(self) || isDefined(self.vehicletype)) {
    _id_7D2852D02216C876 = other;
    _id_927B3199642B75FC = [0.4, "praise"];
    name = "player_killfirm";
    cooldown = 30;
  } else if(scripts\engine\utility::_id_51D76700600CEBE3(30))
    _id_927B3199642B75FC = [0.4, _id_927B3199642B75FC, 0.25, other, "praise"];
  else
    _id_927B3199642B75FC = [0.4, _id_927B3199642B75FC];

  if(!isalive(_id_7D2852D02216C876)) {
    return;
  }
  _id_7D2852D02216C876 _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45(name, _id_927B3199642B75FC, 0, 2, cooldown);
}

_id_F649C4EF3ACDEC1D(team) {
  wait 0.7;

  if(!isDefined(self) || !isDefined(team) || team == "dead") {
    return;
  }
  if(scripts\common\utility::issp())
    _id_7D2852D02216C876 = _id_35DE402EFC5ACFB3::getclosestfriendlyspeaker(team, "combat", 1);
  else
    _id_7D2852D02216C876 = _id_35DE402EFC5ACFB3::getclosestfriendlyspeaker(team, "combat", 0);

  _id_B6606917990CD887 = _id_8271E180C87B8970();

  if(!isDefined(_id_7D2852D02216C876)) {
    return;
  }
  if(!_id_7D2852D02216C876 _id_35DE402EFC5ACFB3::_id_EAD4BED232D015ED("casualty")) {
    _id_7D2852D02216C876 _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("casualties", "casualties", 0.6, 3, 30);
    return;
  }

  if(isDefined(_id_B6606917990CD887) && scripts\engine\utility::_id_51D76700600CEBE3(35))
    _id_927B3199642B75FC = [0.4, _id_B6606917990CD887];
  else if(isDefined(_id_B6606917990CD887) && scripts\engine\utility::_id_51D76700600CEBE3(40))
    _id_927B3199642B75FC = [0.4, _id_B6606917990CD887, 0.5, "casualty"];
  else if(scripts\engine\utility::_id_51D76700600CEBE3(90))
    _id_927B3199642B75FC = [0.4, "casualty"];
  else
    return;

  _id_7D2852D02216C876 _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("casualty", _id_927B3199642B75FC, 0, 2, 15);
}

_id_D8ED6827953BCAC2() {
  self endon("death");
  wait 0.15;

  if(isDefined(self._id_261AAF24A09D231D)) {
    foreach(_id_5564A66C3EC1C07B in self._id_261AAF24A09D231D) {
      if(!istrue(_id_5564A66C3EC1C07B._id_79498ADF23C51E6A))
        return;
    }
  }

  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("friendlyfire", "checkfire", 1, 0, 3);
}

_id_45B841E13DD6CF9C(root, _id_0E4731409BD255E0) {
  _id_B6606917990CD887 = _id_35DE402EFC5ACFB3::getname();

  if(!isDefined(_id_B6606917990CD887)) {
    return;
  }
  return root + _id_B6606917990CD887;
}

_id_8271E180C87B8970() {
  return _id_45B841E13DD6CF9C("c_canm_");
}

_id_2008B43ADF7E18EF() {
  return _id_45B841E13DD6CF9C("c_ator_");
}

_id_7E6D670C76D60628() {
  return _id_45B841E13DD6CF9C("s_idnm_");
}

_id_472B1D721B3B7618() {
  return _id_45B841E13DD6CF9C("s_idcn_");
}

_id_03E144FDA9848FD5() {
  return _id_45B841E13DD6CF9C("s_hnnm_");
}

_id_479FA1BCEACAC04B() {
  return _id_45B841E13DD6CF9C("s_alcn_its");
}

_id_F06007E1F432CE27() {
  if(!isDefined(self.team) || self.team == "dead") {
    return;
  }
  if(_id_35DE402EFC5ACFB3::_id_EAD4BED232D015ED("status_report"))
    return _id_01E4F162BF544387();

  if(!isDefined(self.battlechatter) || !isDefined(self.battlechatter.npcid)) {
    return;
  }
  if(isDefined(self.battlechatter.countryid) && self.battlechatter.countryid == "AQ" && self.battlechatter.npcid == "5") {
    return;
  }
  guys = [];
  guys[0] = self;
  guys[1] = _id_35DE402EFC5ACFB3::_id_D8C3C539BC71C7AF(self.team, undefined, 0, 400);

  if(isDefined(guys[1]) && !isDefined(guys[1].battlechatter))
    guys[1] = undefined;

  if(isDefined(guys[1]) && isDefined(guys[1].battlechatter.countryid) && guys[1].battlechatter.countryid == "AQ") {
    if(!isDefined(guys[1].battlechatter.npcid) || guys[1].battlechatter.npcid == "5")
      guys[1] = undefined;
  }

  if(guys.size == 2 && scripts\engine\utility::_id_51D76700600CEBE3(70)) {
    aliases = _id_AC566E2D34BCCAA2("idle_conv");

    if(!isDefined(aliases)) {
      return;
    }
    _id_7F9BB0B911C426BC = [];
    _id_7F0F9E1B37721777 = 1;

    foreach(alias in aliases) {
      _id_7F9BB0B911C426BC[_id_7F9BB0B911C426BC.size] = randomfloatrange(1.0, 2.0);
      _id_7F9BB0B911C426BC[_id_7F9BB0B911C426BC.size] = alias;
      _id_7F9BB0B911C426BC[_id_7F9BB0B911C426BC.size] = guys[_id_7F0F9E1B37721777];
      _id_7F0F9E1B37721777 = !_id_7F0F9E1B37721777;
    }

    _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("idle_convo", _id_7F9BB0B911C426BC, 0, 1, 10, ["stealth_investigate", "stealth_combat"]);
  } else {
    aliases = _id_AC566E2D34BCCAA2("idle_solo");

    if(!isDefined(aliases)) {
      return;
    }
    _id_927B3199642B75FC = [];

    foreach(alias in aliases) {
      _id_927B3199642B75FC[_id_927B3199642B75FC.size] = randomfloatrange(1.0, 2.0);
      _id_927B3199642B75FC[_id_927B3199642B75FC.size] = alias;
    }

    _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("idle", aliases, 0, 1, 10, ["stealth_investigate", "stealth_combat"]);
  }
}

_id_1D268B003B51A5B3() {
  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("patrol_curious", "react_first", 0.05, 0, 2);
}

_id_01E4F162BF544387() {
  if(!isDefined(level.stealth) || istrue(level._id_B8B68F147D0EEB36)) {
    return;
  }
  _id_927B3199642B75FC = [];
  agent = self;
  leader = _id_35DE402EFC5ACFB3::_id_592F13F1A0E078FF(agent);
  _id_B6606917990CD887 = agent _id_7E6D670C76D60628();

  if(isDefined(_id_B6606917990CD887) && scripts\engine\utility::_id_51D76700600CEBE3(60))
    _id_927B3199642B75FC = scripts\engine\utility::array_combine(_id_927B3199642B75FC, [leader, 0.1, _id_B6606917990CD887]);

  if(scripts\engine\utility::_id_51D76700600CEBE3(60))
    _id_927B3199642B75FC = scripts\engine\utility::array_combine(_id_927B3199642B75FC, [leader, 0.15, "ask_how_copy", agent, 0.15, "reply_hear_you"]);

  _id_A4A81419D5DC1A07 = scripts\engine\utility::random(["report_idle", "ask_found_anything"]);
  _id_927B3199642B75FC = scripts\engine\utility::array_combine(_id_927B3199642B75FC, [leader, 0.2, _id_A4A81419D5DC1A07, agent, 0.3, "report_reply_idle", leader, 0.1, "confirming"]);

  if(scripts\engine\utility::_id_51D76700600CEBE3(40)) {
    _id_E58FA9C1FFFEEE86 = undefined;

    if(_id_35DE402EFC5ACFB3::_id_16DCE705F14F4B84() == "hunt")
      _id_E58FA9C1FFFEEE86 = scripts\engine\utility::random(["order_continue_search", "order_find_target", "order_find_perimeter"]);
    else
      _id_E58FA9C1FFFEEE86 = scripts\engine\utility::random(["order_stay_alert", "good_hunting", "signoff"]);

    if(isDefined(_id_E58FA9C1FFFEEE86))
      _id_927B3199642B75FC = scripts\engine\utility::array_combine(_id_927B3199642B75FC, [leader, 0.2, _id_E58FA9C1FFFEEE86]);
  }

  _id_3A7AEA3989AE851A = agent _id_35DE402EFC5ACFB3::_id_6345913274A2CA6A("status_report", _id_927B3199642B75FC, 0.1, 1, 35, ["stealth_investigate", "stealth_combat"]);
  agent _id_35DE402EFC5ACFB3::_id_55BF3F231C0283CC(_id_3A7AEA3989AE851A);
}

_id_E196D9B15E858B0F(players) {
  if(!isDefined(level.stealth) || istrue(level._id_B8B68F147D0EEB36)) {
    return;
  }
  allies = _id_35DE402EFC5ACFB3::_id_FD9E4CB348A5F283(self.origin, level._id_587DE0E7B537210A, self.team);

  if(_id_E3A09AC9C428DBEA(allies)) {
    return;
  }
  radio = _id_35DE402EFC5ACFB3::_id_592F13F1A0E078FF(self);

  if(!isDefined(radio)) {
    return;
  }
  _id_B6606917990CD887 = _id_7E6D670C76D60628();
  _id_535435846552E6E0 = _id_472B1D721B3B7618();
  _id_927B3199642B75FC = [_id_B6606917990CD887, 0.5, "ask_how_copy", 1.5, "report_search"];
  _id_927B3199642B75FC = scripts\engine\utility::array_combine(_id_927B3199642B75FC, _id_842319303719440C());
  _id_3A7AEA3989AE851A = radio _id_35DE402EFC5ACFB3::_id_6345913274A2CA6A("corpse_status_report", _id_927B3199642B75FC, 0.1, 1, 120, ["stealth_combat"]);
  radio _id_35DE402EFC5ACFB3::_id_55BF3F231C0283CC(_id_3A7AEA3989AE851A);
  return 1;
}

_id_E3A09AC9C428DBEA(array) {
  foreach(guy in array) {
    if(guy == self) {
      continue;
    }
    if(guy _id_35DE402EFC5ACFB3::_id_16DCE705F14F4B84() == "combat")
      return 1;
  }

  return 0;
}

_id_842319303719440C() {
  allies = _id_35DE402EFC5ACFB3::_id_FD9E4CB348A5F283(self.origin, level._id_587DE0E7B537210A, self.team);
  allies = scripts\engine\utility::array_remove(allies, self);
  _id_2AB32AC347DC0A8F = sortbydistance(allies, self.origin)[0];

  if(isDefined(_id_2AB32AC347DC0A8F))
    _id_782921312B88FD8F = _id_2AB32AC347DC0A8F _id_7E6D670C76D60628();
  else
    _id_782921312B88FD8F = 0;

  _id_927B3199642B75FC = 0;

  if(scripts\common\utility::issp()) {
    _id_0328A443CDFE40D7 = _id_479FA1BCEACAC04B();
    _id_927B3199642B75FC = [1.5, ::_id_607FD7B62A18E9DC, "react_noreply", ::_id_C315A1B81D2E3288, 0.7, ::_id_607FD7B62A18E9DC, _id_782921312B88FD8F, 0.3, ::_id_607FD7B62A18E9DC, _id_0328A443CDFE40D7, 0.1, ::_id_607FD7B62A18E9DC, "inv_no_response", 0.3, ::_id_607FD7B62A18E9DC];

    if(!scripts\engine\utility::is_dead_or_dying(_id_2AB32AC347DC0A8F) && isDefined(_id_2AB32AC347DC0A8F.fnsetstealthstate)) {
      if(!istrue(level._id_2B9D0F1E2BEB4DE2) || !_id_2AB32AC347DC0A8F _id_ABC132C5C51197C9(self.origin))
        _id_5063E2574B94140A = ["order_stay_alert", _id_2AB32AC347DC0A8F, 0.2, ::_id_1E0FD010AA69762D, "confirming"];
      else
        _id_5063E2574B94140A = ["order_get_visual", 0.2, ::_id_C7DA930CD7BA754F, _id_2AB32AC347DC0A8F, ::_id_64D791A1D9D155B1, 0.1, ::_id_1E0FD010AA69762D, "moving_there"];

      _id_927B3199642B75FC = scripts\engine\utility::array_combine(_id_927B3199642B75FC, _id_5063E2574B94140A);
    }
  } else {
    _id_F55E72FE06DDFE83 = scripts\engine\utility::ter_op(_id_35DE402EFC5ACFB3::_id_16DCE705F14F4B84() == "combat", "order_stay_alert", "order_stay_aware");
    _id_927B3199642B75FC = [1.5, ::_id_607FD7B62A18E9DC, "react_noreply", ::_id_C315A1B81D2E3288, 0.7, ::_id_607FD7B62A18E9DC, _id_782921312B88FD8F, 0.3, ::_id_607FD7B62A18E9DC, "report_alert", 0.2, _id_F55E72FE06DDFE83];
  }

  return _id_927B3199642B75FC;
}

_id_607FD7B62A18E9DC() {
  if(scripts\engine\utility::is_dead_or_dying(level.player)) {
    return;
  }
  enemies = _id_35DE402EFC5ACFB3::_id_FD9E4CB348A5F283(level.player.origin, level._id_798AA343368F724E, self._id_7D2852D02216C876.team);

  if(enemies.size == 0) {
    return;
  }
  guy = sortbydistance(enemies, level.player.origin)[0];
  return _id_35DE402EFC5ACFB3::_id_592F13F1A0E078FF(guy);
}

_id_1E0FD010AA69762D() {
  if(scripts\engine\utility::is_dead_or_dying(level.player)) {
    return;
  }
  enemies = _id_35DE402EFC5ACFB3::_id_FD9E4CB348A5F283(level.player.origin, level._id_63A73645A8E030AD, self._id_7D2852D02216C876.team);
  corpses = [[level._id_621AF16EF0684A11]](level._id_63A73645A8E030AD);
  enemies = scripts\engine\utility::array_combine(enemies, corpses);
  enemies = scripts\engine\utility::array_remove(enemies, self._id_7D2852D02216C876);

  if(enemies.size == 0) {
    return;
  }
  guy = sortbydistance(enemies, level.player.origin)[0];
  self._id_5C1322185369EFCD = guy;
}

_id_C7DA930CD7BA754F() {
  if(scripts\engine\utility::is_dead_or_dying(self._id_927B3199642B75FC[self.index]))
    return [1.5, "ally_missing_multi", undefined];
}

_id_C315A1B81D2E3288() {
  parent = self._id_7D2852D02216C876._id_868E98CF48B92CFB;

  if(isDefined(parent))
    parent._id_6EF5F7AC4D441CBB = 1;
}

_id_64D791A1D9D155B1() {
  thread _id_4DC52E4105914357();
  self.owner.battlechatter.npcid = self._id_7D2852D02216C876.battlechatter.npcid;
  self.owner.battlechatter._id_37962CA7989C729A = undefined;
}

_id_4DC52E4105914357() {
  self._id_7D2852D02216C876 endon("stealth_combat");
  self._id_7D2852D02216C876 endon("stealth_update_investigate");
  corpse = self.owner._id_868E98CF48B92CFB;
  event = spawnStruct();
  event.type = "investigate";
  event.typeorig = "unresponsive_teammate";
  event.origin = corpse.origin;
  event.investigate_pos = corpse.origin;

  if(!isDefined(self._id_7D2852D02216C876.fnsetstealthstate)) {
    return;
  }
  self._id_7D2852D02216C876 thread[[self._id_7D2852D02216C876.fnsetstealthstate]]("investigate", event);
}

_id_ABC132C5C51197C9(_id_4351410D12107DF3, _id_574307D4CDBDAC4C) {
  _id_ABD9EE4725B96FC2 = squared(scripts\engine\utility::_id_53C4C53197386572(_id_574307D4CDBDAC4C, 100));
  path = self findpath(self.origin, _id_4351410D12107DF3);
  return distancesquared(path[path.size - 1], _id_4351410D12107DF3) < _id_ABD9EE4725B96FC2;
}

_id_BFFB62C0764278A7() {
  self._id_6727329A89208345 scripts\engine\utility::delaycall(0.5, ::kill);
}

_id_64E63285A83E3EFE() {
  self endon("death");

  if(scripts\engine\utility::is_dead_or_dying(self) || istrue(self.battlechatter._id_D611E2F69FA1CAC4)) {
    return;
  }
  _id_35DE402EFC5ACFB3::_id_B145367392D5843D(2, 1);
  result = _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("initial_combat", [0.2, "surprise", 0.7, "react_first_combat"], 1, 0.5, 15);

  if(!isDefined(result) || !isint(result) || result)
    _id_35DE402EFC5ACFB3::_id_E23B0906B02CD179("enter_combat", 15);
}

_id_23A29830A84AF4CF() {
  self endon("death");
  self endon("stealth_combat");
  _id_927B3199642B75FC = [self, 0.5, "disguise_enter_investigate"];
  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("disguise_enter_investigate", _id_927B3199642B75FC, 1, 2, 10);
}

_id_BBB539FD7C238608() {
  self endon("death");
  self endon("stealth_combat");
  wait(randomfloatrange(2, 2.5));
  _id_927B3199642B75FC = undefined;
  leader = _id_35DE402EFC5ACFB3::_id_592F13F1A0E078FF(self);
  other = _id_35DE402EFC5ACFB3::getclosestfriendlyspeaker();
  _id_B70B49DC45959168 = isalive(other) && other _id_35DE402EFC5ACFB3::_id_A9328A64687886FB(self, level._id_798AA343368F724E);

  if(_id_B70B49DC45959168 && isDefined(other.stealth) && other._id_FE5EBEFA740C7106 == 1)
    _id_927B3199642B75FC = [self, 2, "report_investigating", leader, 1.5, "order_check_together", self, 1, "confirming", other, 1, "covering_investigate"];
  else if(scripts\engine\utility::_id_51D76700600CEBE3(33)) {
    if(scripts\engine\utility::_id_51D76700600CEBE3(50))
      _id_927B3199642B75FC = [self, 2, "report_investigating", leader, 1.5, "order_investigate", self, 1, "confirming"];
    else
      _id_927B3199642B75FC = [self, 2, "have_something", leader, 1.5, "order_investigate", self, 1, "confirming"];
  } else if(_id_B70B49DC45959168 && scripts\engine\utility::_id_51D76700600CEBE3(33))
    _id_927B3199642B75FC = [self, 2, "investigating", other, 1.5, "confirming"];
  else
    _id_927B3199642B75FC = "investigating";

  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("investigate_start", _id_927B3199642B75FC, 0, 2, 5);
}

_id_E46D9FD4C3250863() {
  _id_927B3199642B75FC = undefined;

  if(scripts\engine\utility::_id_51D76700600CEBE3(50)) {
    _id_927B3199642B75FC = [];
    leader = _id_35DE402EFC5ACFB3::_id_592F13F1A0E078FF(self);

    if(scripts\engine\utility::_id_51D76700600CEBE3(50))
      _id_927B3199642B75FC = [leader, 0, "ask_found_anything", self, 1.5, "reply_found_nothing"];
    else
      _id_927B3199642B75FC = [self, 0, "reply_found_nothing", leader, 1.5, "confirming"];
  } else
    _id_927B3199642B75FC = "inv_arrive";

  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("investigate_pos_reached", _id_927B3199642B75FC, 0, 2, 5);
}

_id_E906749F6343F822() {
  _id_BE1FF2030AD6BA18 = ["muttered_confusion", 0.5, "surprise"];
  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("saw_corpse", _id_BE1FF2030AD6BA18, 0.9, 0, 10, "stealth_combat");
}

_id_4DFFA550C687B071() {
  leader = _id_35DE402EFC5ACFB3::_id_592F13F1A0E078FF(self);
  _id_AB7DF55129FD6369 = undefined;

  if(scripts\common\utility::issp()) {
    corpses = [[level._id_621AF16EF0684A11]](level._id_798AA343368F724E);

    if(corpses.size > 0) {
      corpse = sortbydistance(corpses, self.origin)[0];
      _id_AB7DF55129FD6369 = corpse _id_479FA1BCEACAC04B();
      corpse._id_6EF5F7AC4D441CBB = 1;
    }
  }

  if(!isDefined(_id_AB7DF55129FD6369))
    _id_AB7DF55129FD6369 = 0;

  _id_BE1FF2030AD6BA18 = [1, "react_found_corpse", 0.2, _id_AB7DF55129FD6369, leader, 0.4, "order_search_start", 0.3, "order_report_back", 0.5, "report_alert"];
  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("found_corpse", _id_BE1FF2030AD6BA18, 1, 1, 10, "stealth_combat");
}

_id_91AE298FCC3884C2(type, event) {
  if(type == "cover_blown") {
    return;
  }
  if(!isDefined(self.team) || self.team == "dead") {
    return;
  }
  if(_id_35DE402EFC5ACFB3::_id_16DCE705F14F4B84() == "combat") {
    return;
  }
  if(_id_E3A09AC9C428DBEA(_id_35DE402EFC5ACFB3::_id_FD9E4CB348A5F283(self.origin, 4000, self.team))) {
    return;
  }
  if(type == "found_corpse" || type == "saw_corpse") {
    return;
  }
  if(isstartstr(type, "gunshot") || type == "bulletwhizby" || type == "ally_damaged")
    _id_785E3B8EA1895C6B = "surprise";
  else
    _id_785E3B8EA1895C6B = "muttered_confusion";

  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("announce_" + type, _id_785E3B8EA1895C6B, 1, 1, 5, "stealth_combat");
}

_id_22D252D6CFA50EDD() {}

_id_E64DBAAAE396FBB8(previousstate) {
  self endon("death");
  self endon("stealth_combat");

  if(previousstate == 1) {
    other = _id_35DE402EFC5ACFB3::getclosestfriendlyspeaker();
    _id_B70B49DC45959168 = isalive(other) && other _id_35DE402EFC5ACFB3::_id_A9328A64687886FB(self, level._id_798AA343368F724E);

    if(_id_B70B49DC45959168 && isDefined(other.stealth) && other._id_FE5EBEFA740C7106 == 1)
      _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("return_to_idle", "team_return_idle", 0, 2, 5);
    else
      _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("return_to_idle", "report_reply_idle", 0, 2, 5);

    self waittill("goal");
    _id_B70B49DC45959168 = isalive(other) && other _id_35DE402EFC5ACFB3::_id_A9328A64687886FB(self, level._id_798AA343368F724E);

    if(_id_B70B49DC45959168) {
      if(istrue(self._id_FEB4F7B19477FE9D))
        _id_927B3199642B75FC = [other, 1, "inv_ask_second", self, 1.5, "resp_sound_first"];
      else {
        self._id_FEB4F7B19477FE9D = 1;
        _id_927B3199642B75FC = [other, 1, "inv_ask_first", self, 1.5, "resp_sound_first"];
      }

      _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("returned_to_idle_pos", _id_927B3199642B75FC, 0, 2, 5);
    }
  }
}

_id_F6C7D545B09F9F0A() {}

_id_7CE36B78C85185C2() {
  if(_id_35DE402EFC5ACFB3::_id_EAD4BED232D015ED("status_report"))
    return _id_01E4F162BF544387();

  other = _id_35DE402EFC5ACFB3::getclosestfriendlyspeaker();
  _id_B70B49DC45959168 = isalive(other) && other _id_35DE402EFC5ACFB3::_id_A9328A64687886FB(self, level._id_798AA343368F724E);

  if(isalive(other) && _id_35DE402EFC5ACFB3::_id_EAD4BED232D015ED("hunt_ask_found")) {
    _id_F6FB64B0D63B65F8 = [];
    _id_F6FB66B0D63B6A5E = [];
    _id_38F8EACFA4E06005 = other _id_7E6D670C76D60628();

    if(!_id_B70B49DC45959168) {
      other = _id_35DE402EFC5ACFB3::_id_573B9FF9ED152518(self);
      _id_F6FB64B0D63B65F8 = [_id_38F8EACFA4E06005, 0.3];
      _id_F6FB66B0D63B6A5E = [self, 0.6, "order_dir", other, 0.4, "hunt_copy"];
    }

    _id_F6FB65B0D63B682B = ["ask_found_anything", other, 0.4, "reply_found_nothing"];

    if(_id_B70B49DC45959168 && scripts\engine\utility::_id_51D76700600CEBE3(60))
      _id_F6FB66B0D63B6A5E = [self, 0.6, "order_dir", other, 0.4, "hunt_copy"];

    _id_BE1FF2030AD6BA18 = scripts\engine\utility::array_combine(_id_F6FB64B0D63B65F8, _id_F6FB65B0D63B682B, _id_F6FB66B0D63B6A5E);
    _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("hunt_ask_found", _id_BE1FF2030AD6BA18, 0, 1, 30);
    return;
  }

  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("hunt_solo", "hunt", 0, 1, 8);
}

_id_F4671F61A3031990() {
  self endon("death");

  if(!_id_35DE402EFC5ACFB3::_id_D8462B621401984A("hunt") || !_id_35DE402EFC5ACFB3::_id_EAD4BED232D015ED("enter_hunt")) {
    return;
  }
  players = [];

  foreach(player in _id_35DE402EFC5ACFB3::_id_2AA175082BDB56F5(self.origin, level._id_587DE0E7B537210A)) {
    if(!isalive(player) || istrue(player.inlaststand)) {
      continue;
    }
    _id_35DE402EFC5ACFB3::_id_B9CC4FF760926456("enter_hunt", ["ask_target_location", 0.7, "lost_target"], 1, 3, 10);
    wait 0.5;
    other = _id_35DE402EFC5ACFB3::getclosestfriendlyspeaker(self.team, "hunt");

    if(!isDefined(other)) {
      return;
    }
    _id_185936C4E070C511 = other _id_03E144FDA9848FD5();
    _id_BE1FF2030AD6BA18 = ["target_still_close", 0.3, "hunt_report_alert", 1.5, _id_185936C4E070C511, 0.4, "alert_search_orders", 0.6, "order_dir_resp", other, 0.2, "hunt_copy"];
    _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("enter_hunt_followup", _id_BE1FF2030AD6BA18, 0.3, 5, 10);
  }
}

_id_07CC890E658E3F93() {
  if(!isalive(self._id_7D2852D02216C876)) {
    return;
  }
  _id_41C0982BEF2FE12B = scripts\engine\utility::array_remove(level.stealth.groupdata.groups[self._id_7D2852D02216C876.script_stealthgroup].members, self._id_7D2852D02216C876);

  if(_id_41C0982BEF2FE12B.size > 0)
    return _id_35DE402EFC5ACFB3::_id_248A7374A1A0605A(self._id_7D2852D02216C876.origin, _id_41C0982BEF2FE12B, self._id_7D2852D02216C876.battlechatter.npcid);
}

_id_1AE088B4C06D0525() {
  self endon("death");

  if(scripts\engine\utility::is_dead_or_dying(self) || istrue(self.battlechatter._id_D611E2F69FA1CAC4)) {
    return;
  }
  if(scripts\common\utility::issp())
    _id_35DE402EFC5ACFB3::_id_AF3A6677D4327AAE(2, 1);
  else
    _id_35DE402EFC5ACFB3::_id_B145367392D5843D(2, 1);

  result = _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("initial_combat", [0.2, "surprise", 0.7, "react_first_combat"], 1, 0.5, 15);

  if(!isDefined(result) || !isint(result) || result)
    _id_35DE402EFC5ACFB3::_id_E23B0906B02CD179("enter_combat", 15);
}

_id_8FA36B2CE712A5BB() {
  self endon("death");

  if(scripts\engine\utility::is_dead_or_dying(self) || istrue(self.battlechatter._id_D611E2F69FA1CAC4)) {
    return;
  }
  if(scripts\common\utility::issp())
    _id_35DE402EFC5ACFB3::_id_AF3A6677D4327AAE(2, 1);
  else
    _id_35DE402EFC5ACFB3::_id_B145367392D5843D(2, 1);

  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("enter_combat", "react_first_combat", 1, 0.5, 15);
}

_id_BAA35784BE25B993(target) {
  target = scripts\engine\utility::_id_53C4C53197386572(target, self.enemy);
  groupdata = level.stealth.groupdata.groups[self.script_stealthgroup];

  foreach(_id_5B7B66F613115D5A in groupdata.members) {
    if(self == _id_5B7B66F613115D5A) {
      continue;
    }
    if(isDefined(target) && isDefined(target.origin)) {
      _id_5B7B66F613115D5A aieventlistenerevent("combat", target, target.origin);
      continue;
    }

    _id_5B7B66F613115D5A aieventlistenerevent("combat", self, self.origin);
  }
}

_id_881AB22021BE3C6B(_id_56D4E883D1ED4129) {
  self endon("death");
  wait 2;

  if(scripts\engine\utility::is_dead_or_dying(self) || !isDefined(self.team) || self.team == "dead") {
    return;
  }
  if(scripts\common\utility::issp() && _id_35DE402EFC5ACFB3::_id_FD9E4CB348A5F283(self.origin, level._id_798AA343368F724E, self.team).size == 1) {
    return;
  }
  _id_BE1FF2030AD6BA18 = scripts\engine\utility::random(["order_attack", "attacking", "suppressing"]);
  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("join_combat", _id_BE1FF2030AD6BA18, 0, 3, 15);
}

_id_6237814879B07FBF() {
  self endon("death");

  if(scripts\engine\utility::is_dead_or_dying(self) || istrue(self.battlechatter._id_D611E2F69FA1CAC4)) {
    return;
  }
  if(_id_E3A09AC9C428DBEA(_id_35DE402EFC5ACFB3::_id_FD9E4CB348A5F283(self.origin, level._id_798AA343368F724E, self.team)))
    return _id_881AB22021BE3C6B();

  if(scripts\common\utility::issp())
    _id_35DE402EFC5ACFB3::_id_AF3A6677D4327AAE(2, 1);
  else
    _id_35DE402EFC5ACFB3::_id_B145367392D5843D(2, 1);

  if(!_id_35DE402EFC5ACFB3::_id_EAD4BED232D015ED("enter_combat")) {
    return;
  }
  _id_785E3B8EA1895C6B = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "found_target", "found_you");
  _id_13EAEF47AA5BA1BD = "at_my_location";

  if(scripts\common\utility::issp()) {
    _id_7A3107322BC6AB13 = 0;
    other = level.player;

    if(isDefined(other) && (isagent(other) || isPlayer(other)))
      _id_7A3107322BC6AB13 = other _meth_E40102956C887F7C() || other _meth_6F55D55CCFF20D14();

    if(_id_7A3107322BC6AB13)
      _id_13EAEF47AA5BA1BD = "report_target_water";
    else if(distancesquared(other.origin, self.origin) > level._id_C1ED820E79E07B7C)
      _id_13EAEF47AA5BA1BD = "over_there";
  }

  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("enter_combat", [_id_785E3B8EA1895C6B, 0.5, _id_13EAEF47AA5BA1BD], 1, 0.5, 5);
}

_id_E2D4E5C64D62278E(other) {
  _id_7A3107322BC6AB13 = 0;

  if(isDefined(other) && (isagent(other) || isPlayer(other)))
    _id_7A3107322BC6AB13 = other _meth_E40102956C887F7C() || other _meth_6F55D55CCFF20D14();

  if(_id_7A3107322BC6AB13)
    _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("losing_target_water", "lost_target_water", 0, 2, 5);
  else
    _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("losing_target", "lost_target", 0, 2, 5);
}

_id_79B973BC437563DB(_id_3DA06140A804E127) {}

_id_51AC5B1DF7F85112(region, _id_168C108518D4BAC9) {}

_id_4531D54403FE6D07(_id_3DA06140A804E127, _id_168C108518D4BAC9) {}

_id_AC566E2D34BCCAA2(_id_9144967162969CD7, data) {
  countryid = scripts\engine\utility::_id_53C4C53197386572(self.battlechatter._id_96A045A4858E3F20, self.battlechatter.countryid);
  faction = scripts\engine\utility::_id_53C4C53197386572(self.battlechatter._id_37962CA7989C729A, countryid);

  if(!isDefined(faction) || !isDefined(level.battlechatter._id_ED774F98C3EFAE87) || !isDefined(level.battlechatter._id_ED774F98C3EFAE87[faction])) {
    return;
  }
  event = level.battlechatter._id_ED774F98C3EFAE87[faction][_id_9144967162969CD7];

  if(isarray(event)) {
    if(event.size == 0) {
      return;
    }
    if(_id_9144967162969CD7 == "casualty" && isDefined(self.voice) && self.voice == "mexicanarmy")
      event[event.size - 1] = undefined;

    event = _id_C1C2326DB1C9B81D(event, _id_9144967162969CD7, faction);
  }

  if(isfunction(event))
    event = [[event]](data);

  if(isstring(event) || isarray(event))
    return event;
}

_id_C1C2326DB1C9B81D(event, _id_9144967162969CD7, faction) {
  if(scripts\common\utility::ismp())
    return event[randomint(event.size)];

  index = undefined;

  if(isDefined(self._id_868E98CF48B92CFB))
    origin = self._id_868E98CF48B92CFB.origin;
  else
    origin = self.origin;

  if(!isDefined(origin))
    return undefined;

  if(scripts\common\utility::issp())
    nearby_players = [level.player];
  else
    nearby_players = _id_35DE402EFC5ACFB3::_id_2AA175082BDB56F5(origin, level._id_587DE0E7B537210A);

  foreach(player in nearby_players) {
    if(isDefined(player._id_2036DDD05C3FFDC9) && isDefined(player._id_2036DDD05C3FFDC9[faction]) && isDefined(player._id_2036DDD05C3FFDC9[faction][_id_9144967162969CD7])) {
      index = player._id_2036DDD05C3FFDC9[faction][_id_9144967162969CD7];
      break;
    }
  }

  index = scripts\engine\utility::_id_53C4C53197386572(index, randomint(event.size));

  foreach(player in nearby_players) {
    if(!isDefined(player._id_2036DDD05C3FFDC9))
      player._id_2036DDD05C3FFDC9 = [];

    if(!isDefined(player._id_2036DDD05C3FFDC9[faction]))
      player._id_2036DDD05C3FFDC9[faction] = [];

    player._id_2036DDD05C3FFDC9[faction][_id_9144967162969CD7] = (index + 1) % event.size;
  }

  return event[index];
}

_id_21333116B170A5BB(faction, key, values) {
  level.battlechatter._id_ED774F98C3EFAE87[faction][key] = values;
}

_id_BD1704B44A1A730E() {
  level.battlechatter._id_ED774F98C3EFAE87["DGG"]["warn_getBack"] = ["s_wrnf_heygetthefuckback"];
  level.battlechatter._id_ED774F98C3EFAE87["DGG"]["warn_getBackNow"] = ["s_wrnf_getbackgetbackrightn"];
  level.battlechatter._id_ED774F98C3EFAE87["DGG"]["warn_getOut"] = ["s_wrnf_heyyougetthefuckouto"];
  level.battlechatter._id_ED774F98C3EFAE87["DGG"]["warn_curse"] = ["s_wrnk_motherfucker"];
  level.battlechatter._id_ED774F98C3EFAE87["DGG"]["warn_attack"] = ["s_wrnk_heyiwarnedyou", "s_wrnk_youwerewarned", "s_wrnk_heyyoujustfuckedup"];
  level.battlechatter._id_ED774F98C3EFAE87["DGG"]["react_aware"] = ["s_rcaw_surprisedeffort", "s_rcaw_surprisedeffort_01", "s_rcaw_surprisedeffort_02", "s_rcaw_ohfuck", "s_rcaw_ohshit"];
  level.battlechatter._id_ED774F98C3EFAE87["DGG"]["react_multi"] = ["s_rcml_takingcontact", "s_rcml_contactcontact"];
  level.battlechatter._id_ED774F98C3EFAE87["DGG"]["react_unaware"] = ["s_rcun_whothefuckthrewthat", "s_rcun_whothrewthat", "s_rcun_wheredthatcomefrom", "s_rcun_whereditcomefrom"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["right"] = ["c_posn_toourright", "c_posn_ontheright", "c_posn_rightsdie", "c_posn_rightright"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["ahead"] = ["c_posn_aheadahead", "c_posn_rightinfrontofus", "c_posn_aheadofus", "c_posn_lookforward", "c_posn_thatwayaheadofyou"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["behind"] = ["c_posn_watchbehindus", "c_posn_lookbehindus", "c_posn_watchourbacksbrother", "c_posn_checkbehindus", "c_posn_turnaround", "c_posn_behindusbrother"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["high"] = ["c_posn_upup", "c_posn_upthere", "c_posn_aboveus"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["left"] = ["c_posn_ontheleft", "c_posn_leftside", "c_posn_left", "c_posn_toourleft"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["use_flash"] = ["c_ator_useaflashgrenade", "c_ator_throwaflashgrenade", "c_ator_blindthemwithaflashg"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["use_grenade"] = ["c_ator_useagrenade", "c_ator_throwagrenade", "c_ator_attackthemwithagrena"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["use_molotov"] = ["c_ator_throwamolotov", "c_ator_useamolotov", "c_ator_burnthemwithamolotov"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["use_rpg"] = ["c_ator_firearocketatthem", "c_ator_useyourrockets", "c_ator_therocketusetherocke"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["order_attack"] = ["c_ator_shootthem", "c_ator_startshooting", "c_ator_shootshoot", "c_ator_fireonthem", "c_ator_attackthem", "c_ator_shootyourweapon", "c_ator_shootthemthisisanord"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["move"] = ["c_tcor_getmoving", "c_tcor_move", "c_tcor_movenow", "c_tcor_getupmove", "c_tcor_startmoving", "c_tcor_gobrothermove", "c_tcor_moveoverthere", "c_tcor_gonowgo"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["moveup"] = ["c_tcor_moveup", "c_tcor_movetowardsthem", "c_tcor_goup", "c_tcor_getupthere", "c_tcor_goforwardmove"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["coverme"] = ["c_tcor_coverme", "c_tcor_covermebrother", "c_tcor_ineedcover"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["using_flash"] = ["c_atac_usingflashgrenade", "c_atac_tossingaflashgrenade"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["using_grenade"] = ["c_atac_usinggrenade", "c_atac_tossingagrenade"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["using_molotov"] = ["c_atac_usingamolotov", "c_atac_tossingamolotov"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["using_rpg"] = ["c_atac_usingarocket", "c_atac_launchingarocket"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["using_smoke"] = ["c_atac_throwingsmoke", "c_atac_smokegrenadeout"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["attacking"] = ["c_atac_openingfire", "c_atac_imshooting", "c_atac_firing"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["movingup"] = ["c_tcac_immovingup", "c_tcac_followme", "c_tcac_thiswaybrothers", "c_tcac_movingforward"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["reloading"] = ["c_tcac_changingmagazine", "c_tcac_imreloading"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["moving"] = ["c_tcac_moving", "c_tcac_immoving", "c_tcac_heyimmoving"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["getting_cover"] = ["c_tcac_takingcover", "c_tcac_movingtocover", "c_tcac_gettingcover"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["enemy_using_flash"] = ["c_eata_reactionimblind", "c_eata_reactionicantsee", "c_eata_flashgrenade"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["enemy_using_grenade"] = ["c_eata_grenade", "c_eata_ohshit", "c_eata_grenadewatchout"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["enemy_using_molotov"] = ["c_eata_molotov", "c_eata_watchthefire", "c_eata_molotovmove"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["enemy_using_rpg"] = ["c_eata_rpg", "c_eata_rpg_01", "c_eata_rocketrocket"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["enemy_attacking"] = ["c_eata_imtakingfire", "c_eata_imgettingshotat", "c_eata_theyreshootingatus"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["enemy_flanking_left"] = ["c_etca_guardtheleftflank", "c_etca_theenemyisflankingle", "c_etca_theyreflankingleft"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["enemy_flanking_right"] = ["c_etca_guardtherightflank", "c_etca_theenemyisflankingri", "c_etca_theyreflankingright"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["enemy_moving"] = ["c_etca_onesmoving", "c_etca_iseeonemoving", "c_etca_theresonemoving"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["enemy_moving_up"] = ["c_etca_onesmovingtowardsus", "c_etca_onesmovingup", "c_etca_onesmovingthisway"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["enemy_getting_cover"] = ["c_etca_theenemyistakingcove", "c_etca_enemytakingcover", "c_etca_onestakingcover"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["enemy_reloading"] = ["c_etca_onesreloading", "c_etca_iseeonereloading", "c_etca_heyonesreloading"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["target_getting_cover"] = ["c_ttca_theyretakingcover", "c_ttca_theyreincover", "c_ttca_theyrebehindcover"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["target_reloading"] = ["c_ttca_theyrereloading", "c_ttca_iseethemreloading", "c_ttca_thatonesreloading"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["target_moving"] = ["c_ttca_theyremoving", "c_ttca_heytheyremoving", "c_ttca_theyremovingrightnow"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["target_moving_up"] = ["c_ttca_theyremovingup", "c_ttca_theyremovingforward", "c_ttca_theyremovingtowardsu"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["target_near_patrol"] = ["c_ttca_theyreswimmingnearth", "c_ttca_theyreswimmingyourwa", "c_ttca_interceptthem"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["enemy_soldier"] = ["c_enmy_iseeanenemy", "c_enmy_iseeone", "c_enmy_enemy"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["enemy_soldiers"] = ["c_enmy_enemiesenemies", "c_enmy_iseeenemies", "c_enmy_enemies"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["aquired_target"] = ["c_aqen_hesrightthere", "c_aqen_icanseehim", "c_aqen_ifoundhim", "c_aqen_thereheis"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["neg_target"] = ["c_aqen_where", "c_aqen_idontseeanyone", "c_aqen_whereishe", "c_aqen_icantseehim", "c_aqen_idontseehimbrother", "c_aqen_whatshislocation"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["enemy_exposed"] = ["c_exco_onesoutofcover", "c_exco_anenemyisintheopen", "c_exco_onesintheopen"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["target_exposed"] = ["c_exco_theyreoutofcover", "c_exco_theyreintheopen", "c_exco_theyrenotincover"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["youre_exposed"] = ["c_exco_tothecovertothecover", "c_exco_gettocover", "c_exco_getbehindthecover"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["target_covered"] = ["c_exco_theyrebehindthecover", "c_exco_theyretakingcover", "c_exco_theyreincover"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["killfirm_enemy"] = ["c_firm_gotone", "c_firm_ikilledone", "c_firm_ishotone"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["killfirm_target"] = ["c_firm_theyredead", "c_firm_ikilledthemthatpig", "c_firm_ishotthatone"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["killfirm_truck"] = ["c_firm_theirtruckisdestroye", "c_firm_theirtruckisdown", "c_firm_idestroyedtheirtruck"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["killfirm_bigrig"] = ["c_firm_itookouttheirbigrig", "c_firm_wedestroyedtheirbigr", "c_firm_theirbigrigisdestroy"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["killfirm_helo"] = ["c_firm_ishotdowntheirhelico", "c_firm_idestroyedtheirhelic", "c_firm_theirhelicopterisdow"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["casualties"] = ["c_casu_werelosingtoomany", "c_casu_theyrekillingus"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["copy"] = ["c_conf_igotit", "c_conf_yesbrother", "c_conf_understood", "c_conf_iknow", "c_conf_iam", "c_aqcp_copy", "c_aqcp_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["praise"] = ["c_pras_goodgood", "c_pras_goodworknowkillanoth", "c_pras_forsulamanmayhissoul", "c_pras_goodihopetheysuffere", "c_pras_yesbrotherkillthemal"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["low_ammo"] = ["c_stat_ineedammunition", "c_stat_ineedmoreammunition", "c_stat_whohasanothermagazin", "c_stat_ineedamagazine", "c_stat_ineedanothermagazine"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["wounded"] = ["c_stat_imhit", "c_stat_imhurtbrother", "c_stat_imwounded"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["ask_wounded"] = ["c_stat_areyouwounded", "c_stat_areyouhurtbrother", "c_stat_areyouhit"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["ask_low_ammo"] = ["c_stat_howsyourammunition", "c_stat_doyouneedammunition", "c_stat_areyougoodonammuniti"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["ask_status"] = ["c_stat_areyouokay", "c_stat_areyougoodbrother", "c_stat_iseverythinggood"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["reply_wounded"] = ["c_stat_theyshotme", "c_stat_thosepigsshotme", "c_stat_igothit"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["reply_low_ammo"] = ["c_stat_runninglow", "c_stat_imlow", "c_stat_imalmostout"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["reply_okay"] = ["c_stat_imokay", "c_stat_imgoodbrother", "c_stat_imgood"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["wounded_enemy"] = ["c_aens_iwoundedthatone", "c_aens_gotoneheswounded", "c_aens_ihitoneofthem"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["ask_target_loc"] = ["c_tast_whatstheirlocation", "c_tast_doyouseethem", "c_tast_wherearethey"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["ask_target_wounded"] = ["c_tast_aretheydead", "c_tast_didyoushootthem", "c_tast_aretheyhitbrother"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["target_wounded"] = ["c_tast_theyrewounded", "c_tast_theyrehurtkillthem", "c_tast_theyrebleeding"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["target_unhurt"] = ["c_tast_theygotaway", "c_tast_ididntgetthem", "c_tast_imissedthembrother"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["wounded_target"] = ["c_atas_heshurt", "c_atas_heswounded", "c_atas_iinjuredhim"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["enemy_lmg"] = ["c_enws_machinegunner", "c_enws_theyhaveamachinegunn", "c_enws_onehasamachinegun"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["enemy_shotgun"] = ["c_enws_shotgun", "c_enws_shotgun_01", "c_enws_oneofthemhasashotgun"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["enemy_sniper"] = ["c_enws_theyhaveasniper", "c_enws_snipergetdown", "c_enws_carefulonessniping"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["target_lmg"] = ["c_taws_machinegunmachinegun", "c_taws_thatonehasamachinegu", "c_taws_carefulbrothertheyha"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["target_shotgun"] = ["c_taws_thatonehasashotgun", "c_taws_shotgun"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["target_sniper"] = ["c_taws_sniper", "c_taws_hessnipingatus"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["casualty"] = ["c_canm_mybrother", "c_canm_theykilledoneofours", "c_canm_theykilledhim", "c_canm_theykilledourbrother", "c_canm_abrotherhasfallen"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["hostile_burst"] = ["c_hsbr_yournationswillburn", "c_hsbr_wearethekillers", "c_hsbr_weareyourexecutioner", "c_hsbr_wearethewolvesofsula"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["suppressing"] = ["c_aqsp_gotyoucovered", "c_aqsp_coveringyou", "c_aqsp_imcoveringyougo", "c_aqsp_getbackgo"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["reply_hear_you"] = ["s_idrp_yesbrother", "s_idrp_goahead", "s_idrp_yesihearyou", "s_idrp_ihearyougoahead"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["resp_patrol"] = ["s_idrp_thisispatrol", "s_ahrp_thisispatrol"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["muttered_confusion"] = ["s_idin_whatthefuck", "s_idin_whatthehell", "s_idin_whatthefuckisthat", "s_idin_whatthehellisthat"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["investigating"] = ["s_idin_imgoingtocheckitout", "s_idin_illcheckitout", "s_idin_illgocheck"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["inv_arrive"] = ["s_idin_hmm", "s_idin_hmphokay", "s_idin_huhwhatwasthat", "s_idin_hrm", "s_idin_huhthehell"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["react_found_corpse"] = ["s_alrc_welostaman", "s_alrc_ifoundabodyitsoneofo", "s_alrc_oneofourpatrolsgothi", "s_alrc_welostabrother"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["ask_corpse_name"] = ["s_alrc_whoisit", "s_alrc_who", "s_alrc_whodidwelose"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["need_backup"] = ["s_alrc_sendbackup", "s_alrc_illneedbackup", "s_albc_getmesomebackup"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["hunt_affirm"] = ["s_hnrs_yesbrother"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["hunt_copy"] = ["s_hnrs_okay", "s_hnrs_gotit", "s_hnrs_copy"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["hunt_neg"] = ["s_hnrs_nobrother"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["react_whizby"] = ["s_unrc_someoneshotatme", "s_unrc_ijustgotshotat", "s_unrc_imgettingshotat", "s_unrc_someonetriedtoshootm", "s_unrc_itookfire"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["react_loc"] = ["s_unrc_itcamefromoverthere", "s_unrc_itcamefromthatdirect", "s_unrc_itwasfromthatway", "s_unrc_itcamefromthatway", "s_unrc_itwasfromthatdirecti"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["react_unaware"] = ["s_unrc_imtakingfire", "s_unrc_contact", "s_unrc_imunderattack"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["over_there"] = ["s_hnfn_overthere", "s_hnfn_theyreoverthere", "s_hnfn_theyreoverthatway"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["surprise"] = ["s_hurc_ohgod", "s_hurc_ohfuck", "s_hurc_ohshit"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["report_reply_idle"] = ["s_idrr_nothinghere", "s_idrr_secure", "s_idrr_weregoodbrother", "s_idrr_allclear", "s_idrr_goodhere", "s_idrr_nothingtoreport", "s_idrr_quietherebrother"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["react_first"] = ["s_idrc_huh", "s_idrc_wha", "s_idrc_hm", "s_idrc_eh", "s_idrc_hrm", "s_idrc_hmph"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["react_second"] = ["s_idrc_whatthefuckwasthat", "s_idrc_whatthehellwasthat", "s_idrc_whosthere"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["react_multi"] = ["s_idrm_whatthefuckisgoingon", "s_idrm_okaywhatthefuck", "s_idrm_issomeonefuckingwith"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["react_interrupt"] = ["s_idli_whatswrong", "s_idli_whatwasthat", "s_idli_areyouokaybrother"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["react_noreply"] = ["s_idli_areyouthere", "s_idli_wheredyougo", "s_idli_canyouhearme"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["order_investigate"] = ["s_idio_gocheckitout", "s_idio_goseewhatitwas", "s_idio_gocheckjusttobesure"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["confirming"] = ["s_idlc_roger", "s_idlc_copy", "s_idlc_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_good_hunting"] = ["s_idls_besafebrother", "s_idls_staysharpbrother", "s_idls_keepyoureyesopenbrot"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["inv_ask_first"] = ["s_idia_whatwasit", "s_idia_whatdidyousee", "s_idia_yougotanything", "s_idia_didyouseeanything", "s_idia_findanything"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["inv_ask_second"] = ["s_idia_whatwasitthistime", "s_idia_seeanythingthistime", "s_idia_stillnothing", "s_idia_stilldidntfindanythi", "s_idia_findanythingthistime"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["resp_water_first"] = ["s_idir_soundedlikesomething", "s_idir_iheardsplashingbutit", "s_idir_thewaterwasmovingbut", "s_idir_thoughtiheardsomethi"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["resp_sound_first"] = ["s_idir_nothingididntseeanyo", "s_idir_ididntseeanyonewereg", "s_idir_thoughtiheardsomeone", "s_idir_soundedlikesomeoneru"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["order_check_together"] = ["s_idit_letsgocheckitout", "s_idit_thiswayfollowme", "s_idit_overherecoverme"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["covering_investigate"] = ["s_idit_rightbehindyou", "s_idit_imwithyou", "s_idit_ivegotyourback"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["team_return_idle"] = ["s_idid_letsheadback", "s_idid_fuckitletsgetback", "s_idid_alrightweshouldgetba"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["ask_heard_that"] = ["s_alre_didyouhearthat", "s_alre_youheardthatright", "s_alre_youheardthattoo"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["ask_saw_that"] = ["s_alre_didyouseethat", "s_alre_tellmeyousawthat", "s_alre_yousawthatright"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["have_something"] = ["s_alre_imighthavesomething", "s_alre_ithinkihavesomething", "s_alre_ithinksomethingsover"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["heard_something"] = ["s_alre_iheardsomething", "s_alre_iheardanoise", "s_alre_iheardanoisebyme"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["saw_something"] = ["s_alre_isawsomething", "s_alre_ithinkisawsomething", "s_alre_ithinksomeonesnearme"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["see_something"] = ["s_alre_iseesomething", "s_alre_ithinkiseesomething", "s_alre_iseesomethingnearme"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["team_have_something"] = ["s_alre_wemighthavesomething", "s_alre_ithinkwegotsomething", "s_alre_wemayhavesomethinghe"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["team_heard_something"] = ["s_alre_weheardsomething", "s_alre_weheardsomethingnear", "s_alre_weheardanoise"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["team_saw_something"] = ["s_alre_wesawsomething", "s_alre_wesawsomethingnearus", "s_alre_wesawsomethingnearou"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["team_see_something"] = ["s_alre_weseesomething"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["object_whizby"] = ["s_alre_whothefuckthrewthat", "s_alre_whothrewthat", "s_alre_youmissed"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["jailer_body_react"] = ["s_idrm_okaywhatthefuck", "s_idrm_whatthefuckisgoingon", "s_idrm_issomeonefuckingwith"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["jailer_head_react"] = ["s_unrc_imtakingfire", "s_unrc_contact", "s_unrc_imunderattack", "s_unrc_itookfire"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["react_resp"] = ["s_alrr_yeah", "s_alrr_yesbrother", "s_alrr_yeahidid"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["alert_investigating"] = ["s_alin_imgoingtocheckitout", "s_alin_imcheckingitout", "s_alin_imgoingtochecktheare"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["team_alert_investigating"] = ["s_alin_weregoingtocheckitou", "s_alin_werecheckingitout", "s_alin_weregoingtoseewhatit"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["alert_confirming"] = ["s_alcf_roger", "s_alcf_copy", "s_alcf_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["inv_ask"] = ["s_alia_youseeanything", "s_alia_yougotsomething", "s_alia_whatvewegot", "s_alia_youseesomething"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["inv_patrol"] = ["s_alip_illsecurethisareayou", "s_alip_illsearcharoundgetba", "s_alip_headbacktoyourpatrol", "s_alip_keeppatrollingillsec"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["report_reply_search"] = ["s_alir_nothingyet", "s_alir_nothingsofar", "s_alir_itsbeenquietsofar", "s_alir_weregoodfornow", "s_alir_allclearrightnow", "s_alir_sofarsogood", "s_alir_notseeinganythingyet", "s_alir_haventseenanything", "s_alir_nothingfornow", "s_alir_itsclearfornow", "s_alir_weregoodsofar"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["ask_enemy_loc"] = ["s_unwl_wheredthatcomefrom", "s_unwl_whereditcomefrom", "s_unwl_wherethefuckarethey"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["enemy_loc_resp"] = ["s_unrs_idontknow", "s_unrs_ididntseethem", "s_unrs_idontfuckingknow", "s_unrs_ididntsee"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["ask_enemy_count"] = ["s_unwc_howmanyarethere", "s_unwc_howmanyofem", "s_unwc_howmany"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["unaware_backup"] = ["s_unwb_ineedbackupnow", "s_unwb_getbackupoverhere", "s_unwb_sendbackupnow"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["react_first_combat"] = ["s_awrr_enemy", "s_awrr_theenemyishere", "s_awrr_enemyrighthere", "s_awrr_theresanenemy", "s_awrr_enemyenemy", "s_awrr_someoneshere", "s_awrr_enemyhere"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["at_my_location"] = ["s_awrr_hererighthere", "s_awrr_rightherebrothers", "s_awrr_heyoverhere", "s_awrr_righthererighthere", "s_awrr_heytheyrerighthere", "s_awrr_theyrehereiseethem", "s_awrr_heytheyreoverhere", "s_awrr_heytheyrehere"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["found_you"] = ["s_awrr_motherfucker", "s_awrr_pieceofshit", "s_awrr_youbitch", "s_awrr_fuckyou", "s_awrr_gotyou"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["report_target_water"] = ["s_awrr_theyreinthewaterover", "s_awrr_theyreswimmingoverth", "s_awrr_heytheyreswimmingove", "s_awrr_theyreswimmingthiswa", "s_awrr_icanhearthemtheyrein", "s_awrr_theyreswimmingoverhe", "s_awrr_heytheyreswimmingtha"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["found_target"] = ["s_awrr_heytheyrerightthere", "s_awrr_heyiseethem", "s_awrr_ifoundthem", "s_awrr_igotthem", "s_awrr_theretheyare", "s_awrr_theyrerightoverthere"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["order_check_last"] = ["s_advo_moveontheirlocationg", "s_advo_checkiftheyrethere", "s_advo_moveonthem"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["lost_target"] = ["s_lkpl_frustratedgrunttheyr", "s_lkpl_frustratedgrunttheyr_01", "s_lkpl_frustratedgruntwelos_01", "s_lkpl_frustratedgruntfuckt"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["lost_target_water"] = ["s_lkpw_theywentunderwater", "s_lkpw_theyreinthewater", "s_lkpw_theyjumpedinthewater", "s_lkpw_theywentinthewater"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["ask_target_location"] = ["s_lklr_wherearethey", "s_lklr_doyouseethem", "s_lklr_youseewheretheywent", "s_lklr_wheredtheygo", "s_lklr_wherethefuckarethey", "s_lklr_whereisthisperson"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["wait_target_surface"] = ["s_lkwr_whentheycomesupforai", "s_lkwr_theypoptheirheadouty", "s_lkwr_whentheycomeupyoukil", "s_lkwr_theygoforairyoutaket", "s_lkwr_whentheypopuptheyred", "s_lkwr_theyllcomeupforairwh"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["water_use_grenade"] = ["s_lkwf_dontusebulletsusegre", "s_lkwf_throwagrenadeinthere", "s_lkwf_useyourgrenadesthrow"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["target_still_close"] = ["s_lkpc_theywerehere", "s_lkpc_theywererighthere", "s_lkpc_theycantbefar", "s_lkpc_theyreclose", "s_lkpc_theyrehiding", "s_lkpc_theyvegottabehere", "s_lkpc_theydidntjustdisappe", "s_lkpc_theyreheresomewhere"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["order_clear_building"] = ["s_cmho_clearthebuilding", "s_cmho_securethebuilding", "s_cmho_getthisbuildingclear"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["order_search_water"] = ["s_cmho_searchthewater", "s_cmho_checkthewater", "s_cmho_keepyoureyesonthewat", "s_cmho_watchthewater", "s_cmho_theywereinthewater"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["clearing_east"] = ["s_cmhs_checkingeast", "s_cmhs_movingeast", "s_cmhs_searchingeast"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["clearing_north"] = ["s_cmhs_scoutingnorth", "s_cmhs_checkingnorth", "s_cmhs_movingnorth"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["clearing_south"] = ["s_cmhs_movingsouth", "s_cmhs_checkingsouth", "s_cmhs_scanningsouth"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["clearing_west"] = ["s_cmhs_movingwest", "s_cmhs_scoutingwest", "s_cmhs_checkingwest"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["searching_here"] = ["s_cmhc_thisareasgood", "s_cmhc_thisareasclear", "s_cmhc_myareaisclear"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["cmb_hunt_confirmation"] = ["s_cmhr_yesbrother", "s_cmhr_copythat", "s_cmhr_okay", "s_cmhr_gotit", "s_cmhr_nobrother"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["good_hunting"] = ["s_hnts_besafebrother", "s_hnts_stayalertbrother", "s_hnts_onyourtoesbrother"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["moving_there"] = ["s_hntm_movingnow", "s_hntm_movingtherenow", "s_hntm_moving"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["moving_alone"] = ["s_hntm_onmywaybrother", "s_hntm_immoving", "s_hntm_imheadingtherenow"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["moving_following"] = ["s_hntm_imwithyoubrother", "s_hntm_ihaveyourback", "s_hntm_illguardyourback"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["moving_together"] = ["s_hntm_weremoving", "s_hntm_weremovingtherenow", "s_hntm_onourwaybrother"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["order_follow_me"] = ["s_hntm_letsmovestaytogether", "s_hntm_followmeletsgo", "s_hntm_yourewithmeletsmove"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["order_take_point"] = ["s_hntm_taketheleadbrotherle", "s_hntm_letskeepmovingyoulea", "s_hntm_letsgetovertherelead", "s_aqhr_letsgoillcoveryou", "s_aqhr_letsgetovertherelead", "s_aqhr_letsmoveyoulead"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["ask_found_anything"] = ["s_aqhr_gotanything", "s_aqhr_yougotsomething", "s_aqhr_findanything", "s_aqhr_youseethem", "s_aqhr_didyoufindsomething", "s_aqhr_whatdoyougot"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["reply_found_nothing"] = ["s_aqhr_nothingyet", "s_aqhr_nothingsofar", "s_aqhr_nothingherebrother"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["report_searching"] = ["s_aqhr_stillsweepingthisare", "s_aqhr_stillsearching", "s_aqhr_stilllookingforthem"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["report_nothing"] = ["s_aqhr_theresnothinghere", "s_aqhr_nosignofthemyet", "s_aqhr_noonesherebrother"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["report_investigating"] = ["s_aqhr_checkingthisarea", "s_aqhr_securingthisarea", "s_aqhr_searchingthisarea"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["area_clear"] = ["s_aqhr_thisareaisclear", "s_aqhr_clearhere", "s_aqhr_areaclear"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["order_dir"] = ["s_aqhs_checkthatway", "s_aqhs_heysearchoverthere", "s_aqhs_checkoverthere", "s_aqhs_searchthatway"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["order_dir_resp"] = ["s_aqhs_illsearchoverhere", "s_aqhs_illtakethisway", "s_aqhs_illtakeoverhere", "s_aqhs_illsearchthisway"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["hunt_search_object"] = ["s_aqhs_itsclear", "s_aqhs_clear", "s_aqhs_nothinghere", "s_aqhs_goodhere"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["hunt"] = ["s_aqhb_wherethefuckareyou", "s_aqhb_wherethefuckishe", "s_aqhb_whereisthispieceofsh", "s_aqhb_comeonwhereareyouhid", "s_aqhb_wherethefuckdidyougo", "s_aqhb_pieceofshitshowyours", "s_aqhb_motherfuckerwhereare"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["hunt_inv_order"] = ["s_ahii_checkit", "s_ahii_checkitout", "s_ahii_gocheckit", "s_ahii_searchit"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["hunt_inv_event"] = ["s_ahir_ithinktheyrenearme", "s_ahir_imighthavethem", "s_ahir_ijustheardthem", "s_ahir_imighthavefoundthem"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["hunt_reactions"] = ["s_ahnr_surprisedinttenserea", "s_ahnr_surprisedinttenserea_01", "s_ahnr_surprisedinttenserea_02"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["cmb_reactions"] = ["s_aqcr_surprisedinttenserea", "s_aqcr_surprisedinttenserea_01", "s_aqcr_surprisedinttenserea_02"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["whizby_resp"] = ["s_aqal_itcamefromoverthere", "s_aqal_itcamefromthatway", "s_aqal_itwasfromoverthere"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["hunt_cornercheck"] = ["s_aqho_checkyourcorners", "s_aqho_checkthecorners", "s_aqho_searcheverycornerfin"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["hunt_order_hold"] = ["s_aqho_holdup", "s_aqho_wait", "s_aqho_hold"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["alert_cornercheck"] = ["s_aqao_besuretocheckthecorn", "s_aqao_checkthecornersjustt", "s_aqao_remembertochecktheco"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["alert_order_hold"] = ["s_aqao_holdup", "s_aqao_wait", "s_aqao_hold"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["alert_search_orders"] = ["s_aqao_checkthatway", "s_aqao_gothatway", "s_aqao_checkoverthere", "s_aqao_searchoverthere", "s_aqao_searchthatway", "s_aqao_lookoverthere"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["attack_orders"] = ["s_aato_patrol"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["lkp_patrol_search"] = ["s_alwp_justwatchthewater", "s_alwp_keepwatchingthatside", "s_alwp_justkeepyoureyesonth"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["hunt_report_alert"] = ["s_aqlo_spreadoutfindthem", "s_aqlo_searchtheareafindthe", "s_aqlo_spreadoutsearchthear"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["disguise_enter_investigate"] = ["s_idrc_whosthere", "s_idli_areyouokaybrother", "s_alrc_whoisit", "s_idin_huhwhatwasthat", "s_idin_hmphokay", "s_idin_hmm"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_solo"] = [];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_solo"][0] = ["s_idsl_wewillkillalltheysen", "s_idsl_likegrandfatherdid", "s_idsl_theydontcareaboutthi", "s_idsl_itmeansnothingtothem", "s_idsl_notheywantsomething", "s_idsl_theyalwayswantsometh", "s_idsl_neverheretohelptofix", "s_idsl_justtakeandtake", "s_idsl_untileverythingisdea", "s_idsl_thesemercenaries", "s_idsl_youwanttostealfromus", "s_idsl_illsendallyoudemonsb"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_solo"][1] = ["s_idsl_ourwarisnotforourfai", "s_idsl_wefighttoremoveallfo", "s_idsl_wearealqatalaweareth", "s_idsl_wefightwithoutsorrow", "s_idsl_wewagewarwithoutsymp", "s_idsl_thisistheonlywaytoli", "s_idsl_atruesoldier"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_solo"][2] = ["s_idsl_ourwarisnotforourfai_01", "s_idsl_wefighttoremovetorem", "s_idsl_startoverokayourwari", "s_idsl_wefighttoremoveuhall", "s_idsl_wewagewarswithnosymp", "s_idsl_itistheonlywaytolive", "s_idsl_atruesoldieratruesol", "s_idsl_okayonemoretime"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_solo"][3] = ["s_idsl_goahead", "s_idsl_anysecondnow", "s_idsl_askmetoreportin", "s_idsl_everyfewminutesthisf", "s_idsl_illreportinwhenthere"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_solo"][4] = ["s_idsl_mastaphakazithekingo", "s_idsl_wetookyourcrownandsl", "s_idsl_nowalmasrareturnstoh", "s_idsl_whowillalwaysfightto"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_solo"][5] = ["s_idsl_goingtobealongday", "s_idsl_cantsleep", "s_idsl_themercenairesrisewi", "s_idsl_juststayfocused", "s_idsl_rememberwhyyoufighth", "s_idsl_dontgetlazy", "s_idsl_ifyourelazyyoudie"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_solo"][6] = ["s_idsl_thisfuckingheat", "s_idsl_whycantwefightduring", "s_idsl_atleasticoulddiecomf"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_solo"][7] = ["s_idsl_irangivesusarmorandw", "s_idsl_couldatleastgiveusso", "s_idsl_weneedtocontrolthesk", "s_idsl_thennoonewillfuckwit"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_solo"][8] = ["s_idsl_ishouldbeonthefrontl", "s_idsl_notdefendinggarbage", "s_idsl_ihopeanenemyshowsuph", "s_idsl_thenitwontbesofuckin", "s_idsl_icouldseesomecombat", "s_idsl_getmyfirstkill"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_conv"] = [];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_conv"][0] = ["s_idcv_haveyoutrainedforthe", "s_idcv_yeahlastmonth", "s_idcv_whatplacedoyouwantto", "s_idcv_spainiwanttoworkwith", "s_idcv_thatismyfirstchoices", "s_idcv_notamsterdamthatshit", "s_idcv_idontcareatleastitsc"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_conv"][1] = ["s_idcv_haveyoufoughtthembef", "s_idcv_themercenaries", "s_idcv_yesthelegionorthaton", "s_idcv_nonotthemifoughtones", "s_idcv_youwereinverdansk", "s_idcv_yesbrotheriwastherew", "s_idcv_whatwasitlike", "s_idcv_hehitwashellbutfunto", "s_idcv_iwantedtogotheykeptm", "s_idcv_russiansiranianswhen", "s_idcv_wehavenewweaponsbett", "s_idcv_yeahwealsohaveabigge", "s_idcv_sobeitillfightanyone", "s_idcv_yeahsurejustkeepaloo"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_conv"][2] = ["s_idcv_howmuchlonger", "s_idcv_untilwhat", "s_idcv_untilthiswarisover", "s_idcv_hehwhenthebastardsfi", "s_idcv_thatwillneverhappenw", "s_idcv_liketherussians", "s_idcv_themandtheamericans", "s_idcv_anddictatorskazithat", "s_idcv_dontforgettheirarmie", "s_idcv_andnowtheirmercenari", "s_idcv_yeahwellkillthemtoo", "s_idcv_thatsrightbrother"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_conv"][3] = ["s_idcv_whatwasyourfirstbigb", "s_idcv_theattackonthecoast", "s_idcv_youwereontheship", "s_idcv_yeahiwaswiththesnipe", "s_idcv_iheardyouguyskilleds", "s_idcv_eitherthebulletsorfl", "s_idcv_thatsbadassthatshipw"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_conv"][4] = ["s_idcv_heyiseeone", "s_idcv_noyoudontstopdoingth", "s_idcv_imboredmanineedenter", "s_idcv_yeahwelldontgetuskil", "s_idcv_itwasajoke", "s_idcv_doesntmatterwhenyoua", "s_idcv_okayokayfairenough"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_conv"][5] = ["s_idcv_heyyoudead", "s_idcv_stillalive", "s_idcv_sometimesithinkicoul", "s_idcv_sometimes", "s_idcv_youthinkthatcouldhap", "s_idcv_no", "s_idcv_ithoughtmyfrienddied", "s_idcv_aoneleggedamericando", "s_idcv_imsayingtheamericani", "s_idcv_howdyouknowhehadonel", "s_idcv_nobutothersdidtheyto", "s_idcv_tohellwiththattraito", "s_idcv_youknowherownbrother", "s_idcv_andhewasrighttodoitn", "s_idcv_okaywellletmethinkof"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_conv"][6] = ["s_idcv_iheardthemercenaries", "s_idcv_didourbrothersstopth", "s_idcv_easilytheykilledallo", "s_idcv_goodforthem"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_conv"][7] = ["s_idcv_ithinkiknowawaytoend", "s_idcv_yeahwhatsthat", "s_idcv_justdoitliketheoldda", "s_idcv_andwhosourbestyou", "s_idcv_nobutevenicouldslaug", "s_idcv_sowewoulddefinitelyw", "s_idcv_itellyoutakeawaythei", "s_idcv_ohsoyouthinkthiswoul", "s_idcv_managainstmanwewould", "s_idcv_yourefullofshitjustp"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_conv"][8] = ["s_idcv_whatdoyouthinkofthel", "s_idcv_idontknowalotabouthi", "s_idcv_thewolftrustedhim", "s_idcv_andhowdidthatturnout", "s_idcv_ibelieveinhimheisbol", "s_idcv_thosearemiraclesinth", "s_idcv_youresayinghesatyran", "s_idcv_imsayinghemustprovew"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS"]["idle_conv"][9] = ["s_idcv_youknowwhywereguardi", "s_idcv_thisisourhome", "s_idcv_nobrotheritstostopth", "s_idcv_becausetheywanttotak", "s_idcv_theydontgiveashitabo", "s_idcv_nowhat", "s_idcv_abrokenwatchandsomec", "s_idcv_theyrejustthieves", "s_idcv_simplesmallbrainedth", "s_idcv_pathetic"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["reply_hear_you"] = ["s_idrp_yesbrother", "s_idrp_goahead", "s_idrp_thisiscommand", "s_idrp_whatisitbrother", "s_idrp_yesihearyou", "s_idrp_ihearyougoahead"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["react_interrupt"] = ["s_idli_whatswrong", "s_idli_whatwasthat", "s_idli_whathappened", "s_idli_ididnthearyoubrother", "s_idli_issomethingwrong", "s_idli_areyouokaybrother"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["react_noreply"] = ["s_idli_areyouthere", "s_idli_didiloseyou", "s_idli_canyouhearmebrother"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["confirming"] = ["s_idlc_roger", "s_idlc_copy", "s_idlc_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["signoff"] = ["s_idls_outhere", "s_idls_commandout", "s_idls_staysafebrotherout", "s_idls_out"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["inv_patrol"] = ["s_alip_resumeyourpatrolkeep", "s_alip_getbacktoyourpatrolb", "s_alip_returntoyourpatrolbu"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["report_search"] = ["s_alip_whatsyourstatus", "s_aias_reportin", "s_aias_haveyoufoundanything", "s_aias_givemeanupdate", "s_aias_whathaveyougot"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["wait_target_surface"] = ["s_lkwr_whentheycomesupforai", "s_lkwr_theypoptheirheadouty", "s_lkwr_whentheycomeupyoukil", "s_lkwr_theygoforairyoutaket", "s_lkwr_whentheypopuptheyred", "s_lkwr_theyllcomeupforairwh"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["order_find_target"] = ["s_cmho_findthem", "s_cmho_searcheverywherefind", "s_cmho_huntthemdown"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["order_find_perimeter"] = ["s_cmho_cleartheperimeter", "s_cmho_securetheperimeter", "s_cmho_gettheperimeterclear"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["order_search_water"] = ["s_cmho_searchthewater", "s_cmho_checkthewater", "s_cmho_theywereinthewater", "s_cmho_keepyoureyesonthewat", "s_cmho_watchthewater"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["good_hunting"] = ["s_hnts_besafebrother", "s_hnts_stayvigilantbrother", "s_hnts_becarefuloutthere", "s_aisg_copybesafebrother"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["ask_found_anything"] = ["s_aqhr_haveyoufoundanything", "s_aqhr_whathaveyoufound", "s_aqhr_whathaveyougot"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["order_take_point"] = ["s_aqhr_reportin", "s_aqhr_givemesomething", "s_aqhr_tellmeyouhavesomethi"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["hunt_report_alert"] = ["s_aqhr_anenemyisintheareahu", "s_aqhr_wehaveanenemyinsidet", "s_aqhr_brotherstheresanenem", "s_aqlo_spreadoutfindthem", "s_aqlo_searchtheareafindthe", "s_aqlo_spreadoutsearchthear"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["order_continue_search"] = ["s_aqho_continuesweeping", "s_aqho_keepsearchingthearea", "s_aqho_searchtheareauntilyo"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["order_stay_alert"] = ["s_aqho_stayalert", "s_aqho_keepyoureyesopen", "s_aqho_stayfocusedbrother"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["order_stay_aware"] = ["s_aqho_guardyourselfbrother", "s_aqho_donotunderestimateth", "s_aqho_keepyourguardup"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["ask_how_copy"] = ["s_idcm_doyouhearmebrother", "s_idcm_comein", "s_idcm_thisiscommand"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["inv_no_response"] = ["s_iinr_hesnotrespondingonra", "s_iinr_icantreachhim", "s_iinr_hesnotansweringhisra", "s_iinr_hesnotresponding"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["order_get_visual"] = ["s_iinr_canyougocheckitout", "s_iinr_checkitoutmakesureno", "s_iinr_seeifyoucanfindhimok", "s_iinr_ineedyoucheckitout"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["inv_patrol_noresp"] = ["s_iinr_patrolisntresponding", "s_iinr_patroldidntcheckin", "s_iinr_patrolisntansweringo", "s_iinr_icantreachpatrol"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["hunt_patrol_noresp"] = ["s_iinr_patrolisntresponding_01", "s_iinr_patroldidntcheckin_01", "s_iinr_patrolisntansweringo_01", "s_iinr_icantreachpatrol_01", "s_hpnr_patrolisntresponding", "s_hpnr_patroldidntcheckin", "s_hpnr_patrolisntansweringo", "s_hpnr_icantreachpatrol"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["report_alert"] = ["s_airp_brotherswemayhavecom", "s_airp_allteamswemayhaveasi", "s_airp_everyonetightenupwem", "s_airp_brotherskeepyoureyes"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["report_reply_search"] = ["s_wrpl_iftheyshowupagainyou", "s_wrpl_ifyouseethemagainope", "s_wrpl_iftheyshowbackupyour"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["warn_reply"] = ["s_wrpl_iftheyshowupagainsho", "s_wrpl_ifyouseethemagainope_01", "s_wrpl_iftheyreturnjustkill"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["report_target_location"] = ["s_chrp_givemeanupdatedoesan", "s_chrp_talktomeguyswhatsthe", "s_chrp_starttalkingguysiwan", "s_chrp_reportinguyswhereare"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["report_idle"] = ["s_irpr_status", "s_irpr_report", "s_irpr_anythingtoreport", "s_irpr_gotanything", "s_irpr_checkin"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["ally_missing_multi"] = ["s_alms_multipleteamsarentre", "s_alms_anothergroupisntresp", "s_alms_wevelostcontactwitha", "s_alms_anotherteamfailedtor"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["order_search_start"] = ["s_aior_searchthearea", "s_aior_searcharound", "s_aior_sweeptheperimeter"];
  level.battlechatter._id_ED774F98C3EFAE87["AQS_L"]["order_report_back"] = ["s_aior_reportwhatyoufind", "s_aior_radioifyoufindanythi", "s_aior_reportbackifyoufinds"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["left"] = ["c_posn_leftside", "c_posn_left", "c_posn_checkleft", "c_posn_theyreflankingleft"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["right"] = ["c_posn_rightside", "c_posn_theyreflankingright", "c_posn_right", "c_posn_checkright"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["ahead"] = ["c_posn_straightahead", "c_posn_rightinfrontofus", "c_posn_aheadofus", "c_posn_front", "c_posn_deadahead"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["behind"] = ["c_posn_behindus", "c_posn_onoursix", "c_posn_checkrear", "c_posn_rear"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["high"] = ["c_posn_uptop", "c_posn_checkhigh"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["use_flash"] = ["c_ator_useaflashbang", "c_ator_throwaflashbang", "c_ator_tossaflashbang"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["use_grenade"] = ["c_ator_useagrenade", "c_ator_throwafrag", "c_ator_tossafrag"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["use_molotov"] = ["c_ator_throwamolotov", "c_ator_useamolotov", "c_ator_tossamolotov"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["use_rpg"] = ["c_ator_hitemwitharocket", "c_ator_usearocket", "c_ator_rocket"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["order_attack"] = ["c_ator_engage", "c_ator_giveemsome", "c_ator_dumpem", "c_ator_gohot", "c_ator_fuckinshootem", "c_ator_startsmokinem"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["attacking"] = ["c_atac_goinghot", "c_atac_engaging", "c_atac_openinup"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["using_rpg"] = ["c_atac_rocket", "c_atac_rocket_01"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["using_smoke"] = ["c_atac_throwingsmoke", "c_atac_smokeout"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["using_flash"] = ["c_atac_flashbangout", "c_atac_throwingflashbang"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["using_grenade"] = ["c_atac_fragout", "c_atac_throwingafrag"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["using_molotov"] = ["c_atac_throwingmolotov", "c_atac_molotovout"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["movingup"] = ["c_tcac_impushingup", "c_tcac_pushingforward", "c_tcac_movingup", "c_tcac_pushinup"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["getting_cover"] = ["c_tcac_covercover", "c_tcac_takingcover", "c_tcac_movingtocover"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["reloading"] = ["c_tcac_reloading", "c_tcac_changingmags"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["moving"] = ["c_tcac_moving", "c_tcac_immoving", "c_tcac_heyimmoving"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["enemy_using_flash"] = ["c_eata_flashincoming", "c_eata_flashgrenade", "c_eata_flash", "c_eata_flashgrenade_01"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["enemy_using_grenade"] = ["c_eata_grenade", "c_eata_grenadewatchout", "c_eata_grenadeincoming"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["enemy_using_molotov"] = ["c_eata_molotov", "c_eata_molotovincoming", "c_eata_molotov_01"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["enemy_using_rpg"] = ["c_eata_rpg", "c_eata_rpgincoming", "c_eata_rpggetdown"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["enemy_attacking"] = ["c_eata_takingfire", "c_eata_contact", "c_eata_shadowsincontact"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["enemy_moving_up"] = ["c_etca_onespushing", "c_etca_gotonemovingup", "c_etca_onesmovingup"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["enemy_getting_cover"] = ["c_etca_novisualontarget", "c_etca_gotonetakingcover", "c_etca_onesmovingtocover", "c_etca_novisualontarget_01"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["enemy_reloading"] = ["c_etca_onesreloading", "c_etca_onesreloading_01", "c_etca_oneschangingmags"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["enemy_flanking_left"] = ["c_etca_onesmovingleft", "c_etca_leftflank", "c_etca_guardleft"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["enemy_flanking_right"] = ["c_etca_guardright", "c_etca_rightflank", "c_etca_onesmovingright"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["enemy_moving"] = ["c_etca_onesmovin", "c_etca_thatonesmoving", "c_etca_gotonemoving"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["target_getting_cover"] = ["c_ttca_theyremovingtocover", "c_ttca_hesgoingforcover", "c_ttca_hestakingcover"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["target_reloading"] = ["c_ttca_theyrereloading", "c_ttca_hesout", "c_ttca_hesreloading"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["target_moving"] = ["c_ttca_theyremoving", "c_ttca_hesmoving", "c_ttca_hesrunning"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["target_moving_up"] = ["c_ttca_theyremovingup", "c_ttca_hescominguponyou", "c_ttca_hesmovingup"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["target_near_patrol"] = ["c_ttca_theyreswimmingnearth", "c_ttca_theyreswimmingyourwa", "c_ttca_interceptthem"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["enemy_soldier"] = ["c_enmy_visualonatarget", "c_enmy_targetspotted", "c_enmy_gotatarget"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["enemy_soldiers"] = ["c_enmy_targets", "c_enmy_targets_01", "c_enmy_wegotbadguys"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["neg_target"] = ["c_aqen_idontseeem", "c_aqen_novisual", "c_aqen_cantseehim", "c_aqen_wherethefuckishe"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["aquired_target"] = ["c_aqen_gotavisual", "c_aqen_targetacquired", "c_aqen_iseehim", "c_aqen_thereheis"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["enemy_exposed"] = ["c_exco_onesintheopen", "c_exco_onesintheopen_01", "c_exco_gotoneintheopen"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["target_exposed"] = ["c_exco_theyreintheopen", "c_exco_hesintheopen", "c_exco_theyreintheopen_01"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["youre_exposed"] = ["c_exco_findcover"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["target_covered"] = ["c_exco_hesbehindcover", "c_exco_hesgotcover", "c_exco_hestakingcover"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["killfirm_bigrig"] = ["c_firm_theyresemitrucksdown", "c_firm_destroyedtheirsemitr", "c_firm_enemysemitrucksdown"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["killfirm_enemy"] = ["c_firm_gotone", "c_firm_ekia", "c_firm_targetdown"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["killfirm_target"] = ["c_firm_hesdone", "c_firm_hesdown", "c_firm_dumpedhim"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["killfirm_truck"] = ["c_firm_truckdestroyed", "c_firm_theirtrucksdown", "c_firm_enemytrucksdown"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["killfirm_helo"] = ["c_firm_helodown", "c_firm_helodestroyed", "c_firm_theirhelosdown"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["casualties"] = ["c_casu_weretakingheavies", "c_casu_weregettingourassesk", "c_casu_werelosingshooters", "c_casu_weretakingcasualties"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["copy"] = ["c_conf_copy", "c_conf_check", "c_conf_copythat", "c_conf_goodcopy", "c_conf_solidcopy", "c_aqcp_copy", "c_aqcp_solidcopy"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["praise"] = ["c_pras_hellyeah", "c_pras_niceone", "c_pras_fuckina", "c_pras_yeah", "c_pras_getyousome"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["low_ammo"] = ["c_stat_ineedamag", "c_stat_lowonammo", "c_stat_lastmag", "c_stat_needammo", "c_stat_imwinchester"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["wounded"] = ["c_stat_imhit", "c_stat_imshot", "c_stat_medic"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["ask_wounded"] = ["c_stat_yougood", "c_stat_youwounded", "c_stat_youhit"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["ask_low_ammo"] = ["c_stat_howsyourammo", "c_stat_checkyourammo", "c_stat_whatsyourroundcount"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["ask_status"] = ["c_stat_youokay", "c_stat_whatsyourstatus", "c_stat_status"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["reply_wounded"] = ["c_stat_itookaround", "c_stat_imgood", "c_stat_yeahroundhittheplate"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["reply_low_ammo"] = ["c_stat_runninglow", "c_stat_imlow", "c_stat_almostout"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["reply_okay"] = ["c_stat_imsolid", "c_stat_goodtogo", "c_stat_goodhere"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["wounded_enemy"] = ["c_aens_igothim", "c_aens_clippedhim", "c_aens_hitone"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["ask_target_loc"] = ["c_tast_wheresheat", "c_tast_doesanyonehaveavisua", "c_tast_wherethefuckretheyat"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["ask_target_wounded"] = ["c_tast_yougethim", "c_tast_youhithim", "c_tast_youdrophim"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["target_wounded"] = ["c_tast_heshit", "c_tast_heswounded", "c_tast_hesbleeding"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["target_unhurt"] = ["c_tast_hegotaway", "c_tast_heranoff", "c_tast_hesfallingback"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["wounded_target"] = ["c_atas_woundedhim", "c_atas_ihithim", "c_atas_itaggedem"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["enemy_shotgun"] = ["c_enws_shotgunwatchout", "c_enws_onesgotashotgun", "c_enws_shotgun"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["enemy_sniper"] = ["c_enws_thatsasniper", "c_enws_sniper", "c_enws_enemysniper"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["enemy_lmg"] = ["c_enws_enemymachinegunner", "c_enws_lmg", "c_enws_machinegun"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["target_lmg"] = ["c_taws_theyreusingamachineg", "c_taws_hesgotamachinegun", "c_taws_machinegunner"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["target_shotgun"] = ["c_taws_theyvegotashotgun", "c_taws_hesgotashotgun"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["target_sniper"] = ["c_taws_hessnipingus", "c_taws_hesasniper"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["checkfire"] = ["c_chck_checkyourfire", "c_chck_watchyourfire", "c_chck_blueblue", "c_chck_checkfirecheckfire"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["move"] = ["c_tcor_move", "c_tcor_igotyoumove", "c_tcor_startmoving", "c_tcor_go"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["moveup"] = ["c_tcor_moveup", "c_tcor_moveupgo", "c_tcor_pushup", "c_tcor_getupthere", "c_tcor_pushforward"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["coverme"] = ["c_tcor_coverme", "c_tcor_ineedcoverfire", "c_tcor_coverme_01"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["casualty"] = ["c_canm_wegotacasualty", "c_canm_shadowdown", "c_canm_wehaveashadowdown", "c_canm_wevegotwounded", "c_canm_mandown"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["suppressing"] = ["c_aqsp_suppressingfire", "c_aqsp_imcoveringyou", "c_aqsp_coveringfire"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["disguise_enter_combat"] = ["s_awrr_motherfucker", "s_awrr_foundyou", "s_awrr_igotyou", "s_awrr_troopsincontact", "s_awrr_gotyou", "s_awrr_ifoundyou"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["reply_hear_you"] = ["s_idrp_go", "s_idrp_goahead", "s_idrp_imhere", "s_idrp_rogergoahead"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["resp_patrol"] = ["s_idrp_thisisthresher", "s_ahrp_thisisthresher"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["muttered_confusion"] = ["s_idin_whatthefuck", "s_idin_whatthehell", "s_idin_whatthefuckwasthat", "s_idin_whatthehellwasthat"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["investigating"] = ["s_idin_illseewhatsup", "s_idin_illcheckitout", "s_idin_illgocheck"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["inv_arrive"] = ["s_idin_hmm", "s_idin_hmphokay", "s_idin_huhwhatwasthat", "s_idin_hrm", "s_idin_huhthehell"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["react_found_corpse"] = ["s_alrc_wegotamandown", "s_alrc_wegotacasualty", "s_alrc_gotashadowdown", "s_alrc_wegotakia"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["ask_corpse_name"] = ["s_alrc_whoisit", "s_alrc_who", "s_alrc_whodidwelose"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["need_backup"] = ["s_alrc_sendshadows", "s_alrc_sendreinforcements", "s_albc_sendreinforcements"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["hunt_affirm"] = ["s_hnrs_rog"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["hunt_copy"] = ["s_hnrs_copy", "s_hnrs_rogerthat", "s_hnrs_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["hunt_neg"] = ["s_hnrs_negative"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["react_whizby"] = ["s_unrc_imtakingfire", "s_unrc_thatsclose", "s_unrc_someonesshootinatme", "s_unrc_takineffectivefire", "s_unrc_imgettingshotat"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["react_loc"] = ["s_unrc_itcamefromoverthere", "s_unrc_camefromthatway", "s_unrc_thatwaythatway", "s_unrc_itwasoverthatway", "s_unrc_itcamefromthatdirect"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["react_unaware"] = ["s_unrc_takingcontact", "s_unrc_contactcontact", "s_unrc_takingindirectfire"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["over_there"] = ["s_hnfn_overthere", "s_hnfn_theyreoverthere", "s_hnfn_rightthere"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["surprise"] = ["s_hurc_surprisedeffort", "s_hurc_surprisedeffort_01", "s_hurc_surprisedeffort_02", "s_hurc_ohfuck", "s_hurc_ohshit"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["report_reply_idle"] = ["s_idrr_gotnothing", "s_idrr_secure", "s_idrr_clearhere", "s_idrr_allclear", "s_idrr_goodhere", "s_idrr_allquiet", "s_idrr_areassecure"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["react_first"] = ["s_idrc_huh", "s_idrc_wha", "s_idrc_hm", "s_idrc_eh", "s_idrc_hrm", "s_idrc_hmph"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["react_second"] = ["s_idrc_whatthefuckisthat", "s_idrc_whatthehellisthat", "s_idrc_thefuckisgoingon"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["react_multi"] = ["s_idrm_whosoutthere", "s_idrm_okaywhatthefuck", "s_idrm_whatisthisshit"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["react_interrupt"] = ["s_idli_missedyourlastover", "s_idli_sayagainover", "s_idli_yougood"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["react_noreply"] = ["s_idli_youreceivingme", "s_idli_youcopy", "s_idli_doyoureadme"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["order_investigate"] = ["s_idio_gocheckit", "s_idio_checkitout", "s_idio_gocheckthatout"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["confirming"] = ["s_idlc_roger", "s_idlc_copy", "s_idlc_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["idle_good_hunting"] = ["s_idls_stayfrosty", "s_idls_keepittight", "s_idls_staysharp"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["inv_ask_first"] = ["s_idia_whatwasit", "s_idia_whatdyoufind", "s_idia_yougotanything", "s_idia_seeanything", "s_idia_findanything"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["inv_ask_second"] = ["s_idia_whatwasitthistime", "s_idia_anythingthistime", "s_idia_stillnothing", "s_idia_stilldidntfindanythi", "s_idia_findanythingthistime"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["resp_window_first"] = ["s_idir_awindowwasleftopenwe", "s_idir_foundanopenwindowche", "s_idir_someoneleftawindowop"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["resp_water_first"] = ["s_idir_checkedthewaterthere", "s_idir_sweptthewaterdidntfi", "s_idir_checkednearthewaterw", "s_idir_nothinginthewaterwer"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["resp_sound_first"] = ["s_idir_nothingnobody", "s_idir_negativewereclear", "s_idir_nahweresecure", "s_idir_nothingnovisual"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["resp_window_multi"] = ["s_idir_sawanotheropenwindow", "s_idir_anotheropenwindowwer", "s_idir_therewasanotheropenw"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["order_check_together"] = ["s_idit_letsgocheckitout", "s_idit_letscheckitwatchmyba", "s_idit_letsgocheckcoverme"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["covering_investigate"] = ["s_idit_covering", "s_idit_imwithyou", "s_idit_gotyoucovered"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["team_return_idle"] = ["s_idid_okayletsheadback", "s_idid_weregoodhereletsgetb", "s_idid_backtoourpostsletsgo"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["ask_heard_that"] = ["s_alre_youhearthat", "s_alre_youheardthatright", "s_alre_youheardthattoo"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["ask_saw_that"] = ["s_alre_didyouseethat", "s_alre_yougeteyesonthat", "s_alre_youcatchthat"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["have_something"] = ["s_alre_imighthavesomething", "s_alre_ithinkihavesomething", "s_alre_igotapossiblethreat"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["heard_something"] = ["s_alre_iheardsomething", "s_alre_heardsomethingnearme", "s_alre_iheardanoise"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["saw_something"] = ["s_alre_isawsomething", "s_alre_thoughtisawsomething", "s_alre_ithinksomeonesnearme"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["see_something"] = ["s_alre_iseesomething", "s_alre_ithinkiseesomething", "s_alre_iseesomethingnearme"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["team_have_something"] = ["s_alre_wemighthavesomething", "s_alre_ithinkwegotsomething", "s_alre_wegotapossiblethreat"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["team_heard_something"] = ["s_alre_weheardsomething", "s_alre_weheardsomethingclos", "s_alre_weheardanoise"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["team_saw_something"] = ["s_alre_wesawsomething", "s_alre_wesawsomethingnearus", "s_alre_wesawsomethingnearou"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["team_see_something"] = ["s_alre_weseesomething"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["object_whizby"] = ["s_alre_whothefuckthrewthat", "s_alre_whothrewthat", "s_alre_youmissed"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["jailer_body_react"] = ["s_idrm_okaywhatthefuck", "s_idrm_whatthefuckisgoingon", "s_idrm_issomeonefuckingwith"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["jailer_head_react"] = ["s_unrc_contact", "s_unrc_imunderattack", "s_unrc_itookfire"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["react_resp"] = ["s_alrr_yeah", "s_alrr_afirm", "s_alrr_yeahrogerthat"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["alert_investigating"] = ["s_alin_imgonnareccethearea", "s_alin_imcheckingitout", "s_alin_imgonnacheckitout"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["team_alert_investigating"] = ["s_alin_wellcheckthearea", "s_alin_werecheckingitout", "s_alin_weregonnacheckitout"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["alert_confirming"] = ["s_alcf_roger", "s_alcf_copy", "s_alcf_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["alert_ask"] = ["s_alia_seeanything", "s_alia_yougotsomething", "s_alia_anything", "s_alia_gotanything"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["alert_patrol"] = ["s_alip_illpullsecurityherea", "s_alip_illsecuretheareakeep", "s_alip_headbackillpullsecur", "s_alip_ivegotthisareagetbac"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["report_reply_search"] = ["s_alir_negativenothingyet", "s_alir_nothingsofar", "s_alir_nothing", "s_alir_goodsofar", "s_alir_igotnothingyet", "s_alir_sofarsogood", "s_alir_notseeinganything", "s_alir_negativegotnothing", "s_alir_nothingfornow", "s_alir_itsclearsofar", "s_alir_weregoodfornow"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["warn_report"] = ["s_wrnr_hadanunknowninsideth", "s_wrnr_hadanunknowninsideth_01", "s_wrnr_anunknownwasintheare"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["warn_spotted"] = ["s_wrnf_heygetthefuckback", "s_wrnf_heyyougetthefuckoutt", "s_wrnf_getbackgetbackrightn"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["warn_conv"] = ["s_wrni_scaredthehelloutofem", "s_wrni_probablyshittingthem", "s_wrni_whatthehellweretheyd", "s_wrni_whatthefuckweretheyt"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["warn_conv_reply"] = ["s_wrir_almostgotthemselvesk", "s_wrir_iwasreadytodumpthatm", "s_wrir_luckytheydidntcatcha"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["warn_attack"] = ["s_wrnk_heyiwarnedyou", "s_wrnk_youwerewarned", "s_wrnk_heyyoujustfuckedup"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["ask_enemy_loc"] = ["s_unwl_wheredthatcomefrom", "s_unwl_whereditcomefrom", "s_unwl_wherethefuckarethey"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["enemy_loc_resp"] = ["s_unrs_idontknowbutthatwasa", "s_unrs_ididntseeem", "s_unrs_idontfuckingknow", "s_unrs_novisualdidntseeem"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["ask_enemy_count"] = ["s_unwc_howmanyarethere", "s_unwc_howmanyofem", "s_unwc_howmany"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["unaware_backup"] = ["s_unwb_ineedreinforcements", "s_unwb_getmoreshadowshereno", "s_unwb_sendreinforcementsmy"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["react_first_combat"] = ["s_awrr_contact", "s_awrr_troopsincontact", "s_awrr_enemymyposition", "s_awrr_enemy", "s_awrr_enemyshere", "s_awrr_gotenemyhere", "s_awrr_enemysclose"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["report_target_water"] = ["s_awrr_targetsinthewater", "s_awrr_gotavisualtheyreinth", "s_awrr_iseeeminthewater", "s_awrr_inthewaterinthewater", "s_awrr_enemyinthewater", "s_awrr_theyremovinginthewat", "s_awrr_heytheyreinthewater"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["at_my_location"] = ["s_awrr_righthere", "s_awrr_onmeonme", "s_awrr_myposition", "s_awrr_righthererighthere", "s_awrr_onme", "s_awrr_theyrerighthere", "s_awrr_overhere", "s_awrr_theyreoverhere"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["found_target"] = ["s_awrr_gotem", "s_awrr_iseeem", "s_awrr_foundem", "s_awrr_hey", "s_awrr_visual", "s_awrr_targetspotted"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["found_you"] = ["s_awrr_motherfucker", "s_awrr_foundyou", "s_awrr_igotyou", "s_awrr_ifoundyou", "s_awrr_gotyou"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["order_check_last"] = ["s_advo_moveonemgo", "s_advo_forceuponemgo", "s_advo_pushtheirpositiongo"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["lost_target"] = ["s_lkpl_frustratedgrunttheyr", "s_lkpl_frustratedgrunttheyr_01", "s_lkpl_frustratedgruntnovis", "s_lkpl_frustratedgrunttheyg"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["lost_target_water"] = ["s_lkpw_theywentunderwater", "s_lkpw_theyreinthewater", "s_lkpw_theyjumpedinthewater", "s_lkpw_targetsinthewater"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["ask_target_location"] = ["s_lklr_gotavisual", "s_lklr_youseeem", "s_lklr_whatstheirlocation", "s_lklr_wherearethey", "s_lklr_wherethefuckarethey", "s_lklr_getmealocation"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["wait_target_surface"] = ["s_lkwr_whentheycomeupsmokee", "s_lkwr_theypopupyoushootem", "s_lkwr_whentheysurfaceopenu", "s_lkwr_theygoforairyoudrope", "s_lkwr_waittiltheysurfaceth", "s_lkwr_theysurfaceyoulighte"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["water_use_grenade"] = ["s_lkwf_dontwasteammousegren", "s_lkwf_throwagrenadeinthere", "s_lkwf_getagrenadeinthewate"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["target_still_close"] = ["s_lkpc_theywerehere", "s_lkpc_theywererighthere", "s_lkpc_theycantbefar", "s_lkpc_theyreclose", "s_lkpc_theyrehiding", "s_lkpc_theygottabeclose", "s_lkpc_theydidntmakeitfar", "s_lkpc_theyrestillheresomew"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["order_clear_building"] = ["s_cmho_clearthebuilding", "s_cmho_securethebuilding", "s_cmho_getthisbuildingsecur"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["order_search_water"] = ["s_cmho_searchthewater", "s_cmho_checkthewater", "s_cmho_targetwasinthewater", "s_cmho_geteyesonthewater", "s_cmho_watchthewater"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["clearing_east"] = ["s_cmhs_checkingeast", "s_cmhs_movingeast", "s_cmhs_securingeast"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["clearing_north"] = ["s_cmhs_checkingnorth", "s_cmhs_movingnorth", "s_cmhs_securingnorth"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["clearing_south"] = ["s_cmhs_checkingsouth", "s_cmhs_movingsouth", "s_cmhs_securingsouth"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["clearing_west"] = ["s_cmhs_checkingwest", "s_cmhs_movingwest", "s_cmhs_securingwest"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["searching_here"] = ["s_cmhc_checkingthisarea", "s_cmhc_securingthisarea", "s_cmhc_searchingthisarea"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["cmb_hunt_confirmation"] = ["s_cmhr_rog", "s_cmhr_rogerthat", "s_cmhr_copy", "s_cmhr_copythat", "s_cmhr_negative"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["good_hunting"] = ["s_hnts_staysharp", "s_hnts_stayfrosty", "s_hnts_keepittight"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["moving_there"] = ["s_hntm_movingnow", "s_hntm_movingtherenow", "s_hntm_moving"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["moving_alone"] = ["s_hntm_iminbound", "s_hntm_immoving", "s_hntm_immovingnow"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["moving_following"] = ["s_hntm_gotyoursix", "s_hntm_imwithyou", "s_hntm_gotyourback"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["moving_together"] = ["s_hntm_weremoving", "s_hntm_weremovingtherenow", "s_hntm_wereinboundnow"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["order_follow_me"] = ["s_hntm_illleadletsgo", "s_hntm_onme", "s_hntm_illtakepointletsmove"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["order_take_point"] = ["s_hntm_takepointmoveout", "s_hntm_youtakepointletsgo", "s_hntm_onyouletsmove", "s_aqhr_takeitoutigotyourbac", "s_aqhr_takepointillcover", "s_aqhr_takepointletsroll"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["ask_found_anything"] = ["s_aqhr_gotanything", "s_aqhr_yougotsomething", "s_aqhr_findanything", "s_aqhr_gotavisual", "s_aqhr_anyvisual", "s_aqhr_whatdoyougot"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["reply_found_nothing"] = ["s_aqhr_novisualonthetarget", "s_aqhr_nosignofem", "s_aqhr_novisual"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["report_searching"] = ["s_aqhr_stillsweeping", "s_aqhr_stillsearching", "s_aqhr_stilllookingforem"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["report_nothing"] = ["s_aqhr_nothingyet", "s_aqhr_nothingsofar", "s_aqhr_nothinghere"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["report_investigating"] = ["s_aqhr_immovingin", "s_aqhr_imcheckingitout", "s_aqhr_movingtosecure"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["area_clear"] = ["s_aqhr_thisareassecure", "s_aqhr_securehere", "s_aqhr_areasecure"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["order_dir"] = ["s_aqhs_securethatarea", "s_aqhs_clearthatarea", "s_aqhs_cordonthatarea", "s_aqhs_checkthatway"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["order_dir_resp"] = ["s_aqhs_illsecurethisarea", "s_aqhs_illtakethisway", "s_aqhs_illcheckoverhere", "s_aqhs_illsearchthisway"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["hunt_search_object"] = ["s_aqhs_itsclear", "s_aqhs_clear", "s_aqhs_secure", "s_aqhs_weresecure"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["hunt"] = ["s_aqhb_wherethefuckareyou", "s_aqhb_motherfuckers", "s_aqhb_yourehidingiknowyour", "s_aqhb_youreheresomewherear", "s_aqhb_comeonout", "s_aqhb_gonnafindyou", "s_aqhb_wheredyoufuckinggo"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["hunt_inv_order"] = ["s_ahii_checkit", "s_ahii_gocheckitout", "s_ahii_checkthatout", "s_ahii_gocheckthat"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["hunt_inv_event"] = ["s_ahir_ithinktheyrenearme", "s_ahir_imighthaveem", "s_ahir_ithinkigotem", "s_ahir_thinkifoundem"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["hunt_reactions"] = ["s_ahnr_surprisedinttenserea", "s_ahnr_surprisedinttenserea_01", "s_ahnr_surprisedinttenserea_02"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["cmb_reactions"] = ["s_aqcr_surprisedinttenserea", "s_aqcr_surprisedinttenserea_01", "s_aqcr_surprisedinttenserea_02"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["whizby_resp"] = ["s_aqal_itcamefromoverthere", "s_aqal_itcamefromthatway", "s_aqal_itwasfromoverthere"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["hunt_cornercheck"] = ["s_aqho_checkyourcorners", "s_aqho_checkcornersfindem", "s_aqho_checkthosecorners"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["hunt_order_hold"] = ["s_aqho_holdup", "s_aqho_standfast", "s_aqho_hold"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["alert_cornercheck"] = ["s_aqao_checkthecorners", "s_aqao_watchyourcorners", "s_aqao_checkthosecorners"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["alert_order_hold"] = ["s_aqao_holdup", "s_aqao_standfast", "s_aqao_hold"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["alert_search_orders"] = ["s_aqao_checkthatway", "s_aqao_gothatway", "s_aqao_checkoverthere", "s_aqao_searchoverthere", "s_aqao_searchthatway", "s_aqao_securethatarea"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["attack_orders"] = ["s_aato_thresher"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["lkp_patrol_search"] = ["s_alwp_justwatchthewater", "s_alwp_keepwatchingthatside", "s_alwp_justkeepyoureyesonth"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["hunt_report_alert"] = ["s_aqlo_cordonandsearchthear", "s_aqlo_fanoutsearchthearea", "s_aqlo_cordonofftheareafind"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["resp_glass_first"] = ["s_airs_brokenglasshere", "s_airs_itsbrokenglass", "s_airs_gotsomebrokenglass"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["resp_glass_multi"] = ["s_airs_moreglass", "s_airs_gotsomemoreglass", "s_airs_theresmorebrokenglas"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC"]["disguise_enter_investigate"] = ["s_alrc_whoisit", "s_alrc_who", "s_idrc_hmph", "s_idrc_hrm", "s_idrc_eh", "s_idrc_hm", "s_idrc_wha"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["reply_hear_you"] = ["s_idrp_rogergoahead", "s_idrp_go", "s_idrp_goahead", "s_idrp_thisisactualgoahead", "s_idrp_thisisactual", "s_idrp_goforactual"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["react_interrupt"] = ["s_idli_missedyourlastover", "s_idli_sayagainover", "s_idli_yougood", "s_idli_sayagainyourlastover", "s_idli_commscheck", "s_idli_missedyourlastsayaga"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["react_noreply"] = ["s_idli_youreceivingme", "s_idli_youcopy", "s_idli_doyoureadme"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["confirming"] = ["s_idlc_roger", "s_idlc_copy", "s_idlc_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["signoff"] = ["s_idls_out", "s_idls_actualout", "s_idls_stayfrosty", "s_idls_out_01"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["inv_patrol"] = ["s_alip_continueyourpatrolst", "s_alip_getbacktoyourrouteke", "s_alip_returntoyourpatrolst"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["wait_target_surface"] = ["s_lkwr_waitforemtocomeupthe", "s_lkwr_whentheycomeupforair", "s_lkwr_whentheycomeupyourec", "s_lkwr_whentheygoforairyout", "s_lkwr_lightemupwhentheygof", "s_lkwr_waitforemtosurfaceth"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["order_find_target"] = ["s_cmho_weneedalocationonthe", "s_cmho_locatethetargetnow", "s_cmho_huntemdown"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["order_find_perimeter"] = ["s_cmho_getthisarealockeddow", "s_cmho_securetheperimeter", "s_cmho_iwantthisarealockedd"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["order_search_water"] = ["s_cmho_searchthewater", "s_cmho_checkthewater", "s_cmho_theywereinthewater", "s_cmho_keepyoureyesonthewat", "s_cmho_watchthewater"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["good_hunting"] = ["s_hnts_goodhunting", "s_hnts_staysharpoutthere", "s_hnts_out", "s_aisg_copystaysharp"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["ask_found_anything"] = ["s_aqhr_whatsyourstatus", "s_aqhr_whatveyougot", "s_aqhr_givemeasitrep", "s_aqhr_sitrep", "s_aqhr_youfindanything", "s_aqhr_tellmeyougotsomethin"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["hunt_report_alert"] = ["s_aqhr_allshadowswehaveenem", "s_aqhr_allshadowsenemyisins", "s_aqhr_allshadowsperimeteri", "s_aqlo_fanoutsecuretheperim", "s_aqlo_setcontainmentfindem", "s_aqlo_spreadoutsearchthear"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["order_continue_search"] = ["s_aqho_keeplookingforem", "s_aqho_keepsweeping", "s_aqho_keepsearchingthearea"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["order_stay_alert"] = ["s_aqho_staysharp", "s_aqho_keepittight", "s_aqho_eyesopen"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["order_stay_aware"] = ["s_aqho_dontlettheseguysgett", "s_aqho_theseguysaretf141don", "s_aqho_keepyourguardupwitht"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["ask_how_copy"] = ["s_idcm_howcopy", "s_idcm_doyoucopy", "s_idcm_commscheck"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["inv_no_response"] = ["s_iinr_hesradiosilent", "s_iinr_icantreachhim", "s_iinr_hesnotoncomms", "s_iinr_hesnotresponding"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["order_get_visual"] = ["s_iinr_seeifyoucanfindoutwh", "s_iinr_checkitoutmakesureno", "s_iinr_canyougetavisualonem", "s_iinr_ineedyoutocheckitout"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["inv_patrol_noresp"] = ["s_iinr_thresherisntrespondi", "s_iinr_thresherdidntcheckin", "s_iinr_thresherisntoncomms", "s_iinr_icantreachthresher"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["report_search"] = ["s_aias_sitrep", "s_aias_whatsyourstatus", "s_aias_findanything", "s_aias_gotanything", "s_aias_status"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["report_alert"] = ["s_airp_allshadowsgetswitche", "s_airp_allshadowsperimeterm", "s_airp_allshadowspossibleen", "s_airp_allshadowssetsecurit"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["warn_reply"] = ["s_wrpl_youreclearedhotifthe", "s_wrpl_youseeemagainputemin", "s_wrpl_theycomebackyourecle"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["report_target_location"] = ["s_chrp_doesanyonehaveavisua", "s_chrp_talktomeguyswhatsthe", "s_chrp_cmonshadowsineedaloc", "s_chrp_allshadowsdoyouhavea"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["report_idle"] = ["s_irpr_status", "s_irpr_sitrep", "s_irpr_yougood", "s_irpr_gotanything", "s_irpr_report"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["ally_missing_multi"] = ["s_alms_multipleshadowsarent", "s_alms_moreshadowsarentresp", "s_alms_wevelostcontactwithm", "s_alms_anotherteamlostcomms"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["order_search_start"] = ["s_aior_searchthearea", "s_aior_pullsecuritysweepthe", "s_aior_securetheperimeter"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["order_report_back"] = ["s_aior_soundoffifyoufindsom", "s_aior_imstandingbyifyoufin", "s_aior_usecommsifyoufindsom"];
  level.battlechatter._id_ED774F98C3EFAE87["PMC_L"]["hunt_patrol_noresp"] = ["s_hpnr_thresherisntrespondi", "s_hpnr_thresherdidntcheckin", "s_hpnr_thresherisntanswerin", "s_hpnr_icantreachthresher"];

  if(!scripts\common\utility::ismp()) {
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["left"] = ["m_posn_ontheleft", "m_posn_leftside"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["right"] = ["m_posn_watchright", "m_posn_rightside"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["order_attack"] = ["m_ator_shootthem", "m_ator_attack", "m_ator_fireyourweapon"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["using_grenade"] = ["m_atac_fragout", "m_atac_grenadeout"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["attacking"] = ["m_atac_attacking", "m_atac_engaging", "m_atac_firing"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["movingup"] = ["m_tcac_immovingup", "m_tcac_movingforward", "m_tcac_movingup"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["reloading"] = ["m_tcac_changingmags", "m_tcac_imreloading"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["moving"] = ["m_tcac_moving", "m_tcac_immoving", "m_tcac_movingnow"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["getting_cover"] = ["m_tcac_takingcover", "m_tcac_movingtocover"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["enemy_using_flash"] = ["m_eata_flashbang", "m_eata_flashbangwatchout"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["enemy_using_grenade"] = ["m_eata_grenade", "m_eata_grenade_01", "m_eata_grenadegetback"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["enemy_using_rpg"] = ["m_eata_rpg", "m_eata_rocket"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["enemy_attacking"] = ["m_eata_imtakingfire", "m_eata_contact", "m_eata_takingeffectivefire"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["enemy_moving"] = ["m_etca_onesmoving", "m_etca_iseeonemoving"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["enemy_moving_up"] = ["m_etca_onesgettingclose", "m_etca_onesmovingup"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["enemy_getting_cover"] = ["m_etca_theyretakingcover", "m_etca_enemytakingcover"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["enemy_reloading"] = ["m_etca_onesreloading", "m_etca_iseeonereloading"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["target_getting_cover"] = ["m_ttca_hesgoingforcover", "m_ttca_hestryingtohide"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["target_reloading"] = ["m_ttca_hesreloading", "m_ttca_hestryingtoreload"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["target_moving"] = ["m_ttca_hesmoving", "m_ttca_heyhesmoving"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["target_moving_up"] = ["m_ttca_hesmovingup", "m_ttca_hesmovingourway"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["enemy_soldiers"] = ["m_enmy_iseethem", "m_enmy_iseeenemies", "m_enmy_enemies"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["aquired_target"] = ["m_aqen_hesrightthere", "m_aqen_icanseehim", "m_aqen_ifoundhim"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["neg_target"] = ["m_aqen_where", "m_aqen_idontseeanyone", "m_aqen_whereishe"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["enemy_exposed"] = ["m_exco_onesoutofcover", "m_exco_gotoneintheopen", "m_exco_onesintheopenyouseeh"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["target_exposed"] = ["m_exco_hesoutofcover", "m_exco_hesmovingfromcover"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["youre_exposed"] = ["m_exco_takecover", "m_exco_gettocover", "m_exco_getbehindsomething"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["target_covered"] = ["m_exco_hesincover", "m_exco_hestakingcover"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["killfirm_enemy"] = ["m_firm_gotone", "m_firm_enemydown", "m_firm_downedone"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["killfirm_target"] = ["m_firm_ishothim", "m_firm_igothim"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["casualties"] = ["m_casu_werelosingmen", "m_casu_weretakingheavies"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["copy"] = ["m_conf_copy", "m_conf_copythat", "m_conf_roger"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["low_ammo"] = ["m_stat_ineedammunition", "m_stat_ineedammo", "m_stat_whohasammo"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["wounded"] = ["m_stat_imhit", "m_stat_medic"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["wounded_enemy"] = ["m_aens_iwoundedone", "m_aens_ihitone"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["wounded_target"] = ["m_atas_heshurt", "m_atas_ihithim"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["coverme"] = ["m_tcor_coverme", "m_tcor_ineedcover"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["casualty"] = ["m_canm_dude", "m_canm_theykilledoneofours", "m_canm_theykilledhim"];
    level.battlechatter._id_ED774F98C3EFAE87["USS"]["suppressing"] = ["m_aqsp_gotyoucovered", "m_aqsp_imcoveringyou"];
  }

  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["ahead"] = ["c_posn_upahead", "c_posn_infrontofus", "c_posn_aheadofus"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["behind"] = ["c_posn_behindus", "c_posn_onoursix", "c_posn_checkrear"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["high"] = ["c_posn_lookupup", "c_posn_upthere", "c_posn_aboveus"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["left"] = ["c_posn_ontheleft", "c_posn_leftside", "c_posn_lookleft", "c_posn_watchtheleft"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["right"] = ["c_posn_lookontheright", "c_posn_rightside", "c_posn_rightright", "c_posn_watchtheright"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["use_flash"] = ["c_ator_useaflashgrenade", "c_ator_throwaflashgrenade", "c_ator_tossaflashgrenadebli"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["use_grenade"] = ["c_ator_useagrenade", "c_ator_throwagrenade", "c_ator_getagrenadeonthem"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["use_molotov"] = ["c_ator_throwamolotov", "c_ator_useamolotov", "c_ator_yougotamolotovburnem"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["use_rpg"] = ["c_ator_firearocket", "c_ator_hitthemwitharocket", "c_ator_usearocket"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["order_attack"] = ["c_ator_shootthem", "c_ator_attack", "c_ator_fireyourweapon", "c_ator_fire", "c_ator_fuckthemupshoot", "c_ator_killthem", "c_ator_shootthosefuckers"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["attack_orders"] = ["c_ator_chepe", "c_ator_rodrigo", "c_ator_alonso", "c_ator_carlos", "c_ator_paco", "c_ator_chava", "c_ator_juan", "c_ator_rami", "c_ator_miguel", "c_ator_mincho", "c_ator_oscar", "c_ator_hector", "c_ator_too", "c_ator_andrs", "c_ator_arturo", "c_ator_raul", "c_ator_ramon", "c_ator_chente", "c_ator_manny", "c_ator_temo", "c_ator_nando", "c_ator_central"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["using_flash"] = ["c_atac_usingflashgrenade", "c_atac_throwingflashgrenade"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["using_grenade"] = ["c_atac_throwinggrenade", "c_atac_grenadeout"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["using_molotov"] = ["c_atac_usingamolotov", "c_atac_throwingmolotov"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["using_rpg"] = ["c_atac_imusingarocket", "c_atac_firingarocket"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["attacking"] = ["c_atac_attacking", "c_atac_engaging", "c_atac_firing"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["using_smoke"] = ["c_atac_throwingsmoke", "c_atac_smokegrenadeout"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["movingup"] = ["c_tcac_immovingup", "c_tcac_movingforward", "c_tcac_movingup", "c_tcac_advancing"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["reloading"] = ["c_tcac_changingmagazine", "c_tcac_imreloading"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["moving"] = ["c_tcac_moving", "c_tcac_immoving", "c_tcac_movingnow"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["getting_cover"] = ["c_tcac_takingcover", "c_tcac_movingtocover", "c_tcac_gettingcover"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["enemy_using_flash"] = ["c_eata_reactionfuckmyeyes", "c_eata_reactionicantsee", "c_eata_flashgrenade"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["enemy_using_grenade"] = ["c_eata_grenade", "c_eata_ohhhshit", "c_eata_grenadegetback"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["enemy_using_molotov"] = ["c_eata_molotov", "c_eata_molotovgetback", "c_eata_molotovwatchout"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["enemy_using_rpg"] = ["c_eata_rpg", "c_eata_rocket", "c_eata_rocketmove"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["enemy_attacking"] = ["c_eata_imtakingfire", "c_eata_contact", "c_eata_thosebitchesareshoot"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["enemy_flanking_left"] = ["c_etca_watchlefttheyreflank", "c_etca_leftwatchleft", "c_etca_theyreflankingleft"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["enemy_flanking_right"] = ["c_etca_heywatchright", "c_etca_theenemyisflankingri", "c_etca_theyreflankingright"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["enemy_moving"] = ["c_etca_onesmoving", "c_etca_iseeonemoving", "c_etca_theresonemoving"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["enemy_moving_up"] = ["c_etca_onesgettingclose", "c_etca_onesmovingup", "c_etca_onesmovingthisway"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["enemy_getting_cover"] = ["c_etca_theyretakingcover", "c_etca_enemytakingcover", "c_etca_onestakingcover"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["enemy_reloading"] = ["c_etca_onesreloading", "c_etca_iseeonereloading", "c_etca_heyonesreloading"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["target_getting_cover"] = ["c_ttca_hesgoingforcover", "c_ttca_hestryingtohide", "c_ttca_hesrunningforcover"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["target_reloading"] = ["c_ttca_hesreloading", "c_ttca_hestryingtoreload", "c_ttca_thatonesreloading"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["target_moving"] = ["c_ttca_hesmoving", "c_ttca_heyhesmoving", "c_ttca_hesmovingrightnow"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["target_moving_up"] = ["c_ttca_hesmovingup", "c_ttca_hesmovingourway", "c_ttca_hesgettingclose"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["target_near_patrol"] = ["c_ttca_hesinthewaternearyou", "c_ttca_hesswimmingtowardsyo", "c_ttca_intercepthim"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["enemy_soldier"] = ["c_enmy_theresone", "c_enmy_iseeone", "c_enmy_enemy"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["enemy_soldiers"] = ["c_enmy_iseethem", "c_enmy_iseeenemies", "c_enmy_enemies"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["aquired_target"] = ["c_aqen_hesrightthere", "c_aqen_icanseehim", "c_aqen_ifoundhim", "c_aqen_herestherat"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["neg_target"] = ["c_aqen_where", "c_aqen_idontseeanyone", "c_aqen_whereishe", "c_aqen_icantseehim", "c_aqen_whereisthisbitch", "c_aqen_whatshislocation"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["enemy_exposed"] = ["c_exco_onesoutofcover", "c_exco_gotoneintheopen", "c_exco_onesintheopenyouseeh"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["target_exposed"] = ["c_exco_hesoutofcover", "c_exco_hesmovingfromcover", "c_exco_hesnotincover"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["youre_exposed"] = ["c_exco_takecover", "c_exco_gettocover", "c_exco_getbehindsomething"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["target_covered"] = ["c_exco_hesincover", "c_exco_hestakingcover", "c_exco_heshidinglikeabitch"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["killfirm_enemy"] = ["c_firm_gotone", "c_firm_ishotoneofthosefucke", "c_firm_killedoneofthem"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["killfirm_target"] = ["c_firm_ishothim", "c_firm_gotthatfucker", "c_firm_killedthatlittlebitc"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["killfirm_truck"] = ["c_firm_wedestroyedtheirtruc", "c_firm_theirtruckisdown", "c_firm_wekilledtheirtruck"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["killfirm_bigrig"] = ["c_firm_itookouttheirbigrig", "c_firm_wedestroyedtheirbigr", "c_firm_theirbigriggotfucked"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["killfirm_helo"] = ["c_firm_shottheirhelicoptero", "c_firm_wetookouttheirhelico", "c_firm_theirhelicopterisdow"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["casualties"] = ["c_casu_werelosingmen", "c_casu_weregettingkilledout"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["copy"] = ["c_conf_igotit", "c_conf_yesyes", "c_conf_understood", "c_conf_iknow", "c_conf_copythat", "c_aqcp_copy", "c_aqcp_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["praise"] = ["c_pras_yeahmakethemeatshit", "c_pras_yeahkillallthesefuck", "c_pras_thatsitfuckthemup", "c_pras_thatwasagoodshot", "c_pras_yougotthemdude"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["low_ammo"] = ["c_stat_ineedammunition", "c_stat_wherestheammo", "c_stat_whohasammo", "c_stat_ineedamagazine", "c_stat_ineedanothermagazine"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["wounded"] = ["c_stat_imhit", "c_stat_painimhurtbaddude", "c_stat_painimhit"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["ask_wounded"] = ["c_stat_youstillwithus", "c_stat_didyougethit", "c_stat_areyouhit"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["ask_low_ammo"] = ["c_stat_howsyourammunition", "c_stat_doyouneedammunition", "c_stat_areyougoodonammuniti"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["ask_status"] = ["c_stat_areyouokay", "c_stat_reportwhatsyourstatu", "c_stat_heydudeyougood"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["reply_wounded"] = ["c_stat_painthatfuckinbitchs", "c_stat_painimshot", "c_stat_fuckigothit"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["reply_low_ammo"] = ["c_stat_imlowonammo", "c_stat_ineedammo", "c_stat_heygivemesomeammo"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["reply_okay"] = ["c_stat_imfuckininvincibledu", "c_stat_imokay", "c_stat_imgoodimgood"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["wounded_enemy"] = ["c_aens_oneshurtbad", "c_aens_fuckeduponeofthem", "c_aens_ihitoneofthem"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["ask_target_loc"] = ["c_tast_whatstheirlocation", "c_tast_doyouseethem", "c_tast_wherearethey"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["ask_target_wounded"] = ["c_tast_tellmeyoukilledthatb", "c_tast_didyoukillthatpieceo", "c_tast_didyougethim"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["target_wounded"] = ["c_tast_hesbleeding", "c_tast_hesfuckedupdude", "c_tast_hesmissingapiece"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["target_unhurt"] = ["c_tast_hegotawaytherat", "c_tast_fuckididntgethim", "c_tast_arhhimissedhim"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["wounded_target"] = ["c_atas_heshurt", "c_atas_ihithim", "c_atas_ifuckedhimup"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["enemy_lmg"] = ["c_enws_machinegunner", "c_enws_theyhaveamachinegunn", "c_enws_onehasamachinegun"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["enemy_shotgun"] = ["c_enws_isawonewithashotgun", "c_enws_onesgotashotgun", "c_enws_carefulonesusingasho"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["enemy_sniper"] = ["c_enws_theyhaveasniper", "c_enws_snipergetdown", "c_enws_theresasniperonus"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["target_lmg"] = ["c_taws_thatfuckersusingamac", "c_taws_hesgotamachinegun", "c_taws_watchithesusingamach"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["target_shotgun"] = ["c_taws_thatrathasashotgun", "c_taws_shotgun"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["target_sniper"] = ["c_taws_sniper", "c_taws_hessnipingatus"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["move"] = ["c_tcor_gogo", "c_tcor_move", "c_tcor_getmoving", "c_tcor_moveyourass", "c_tcor_movefast", "c_tcor_gonow", "c_tcor_moveasshole", "c_tcor_getgoing"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["moveup"] = ["c_tcor_moveup", "c_tcor_movein", "c_tcor_goup", "c_tcor_getupthere", "c_tcor_goforwardmove"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["coverme"] = ["c_tcor_coverme", "c_tcor_givemecoverfire", "c_tcor_ineedcover"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["hostile_burst"] = ["c_hsbr_gofuckyourmothers", "c_hsbr_werewiththenamelessy", "c_hsbr_thisisthesoulscartel", "c_hsbr_longlivethesoulscart"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["casualty"] = ["m_canm_theykilledhim", "m_canm_dude", "m_canm_theykilledoneofours", "m_canm_fuckwelostaman", "m_canm_welostasoul"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["suppressing"] = ["c_aqsp_gotyoucovered", "c_aqsp_imcoveringyou", "c_aqsp_igotyougo", "c_aqsp_fallbackillcoveryou"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["reply_hear_you"] = ["s_idrp_yes", "s_idrp_goahead", "s_idrp_copyihearyou", "s_idrp_ihearyougoahead"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["muttered_confusion"] = ["s_idin_whatthefuck", "s_idin_whatthehell", "s_idin_whatthefuckisthat", "s_idin_whatthehellisthat"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["investigating"] = ["s_idin_goingtocheckitout", "s_idin_checkingitout", "s_idin_gonnagocheckit"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["inv_arrive"] = ["s_idin_hmm", "s_idin_hmphokay", "s_idin_huhwhatwasthat", "s_idin_hrm", "s_idin_huhthehell"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["react_found_corpse"] = ["s_alrc_welostaman", "s_alrc_foundabodyoneofours", "s_alrc_oneofourpatrolsgothi", "s_alrc_welostaman_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["hunt_affirm"] = ["s_hnrs_yeahyeah"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["hunt_copy"] = ["s_hnrs_copiedman", "s_hnrs_gotit", "s_hnrs_copy"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["hunt_neg"] = ["s_hnrs_negative"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["react_whizby"] = ["s_unrc_someoneshotatme", "s_unrc_ijustgotshotat", "s_unrc_imgettingfuckinshota", "s_unrc_someonetriedtoshootm", "s_unrc_itookfire"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["react_loc"] = ["s_unrc_itcamefromoverthere", "s_unrc_itcamefromthatdirect", "s_unrc_itwasfromthatway", "s_unrc_itcamefromthatway", "s_unrc_itwasfromthatdirecti"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["react_unaware"] = ["s_unrc_imtakingfire", "s_unrc_contact", "s_unrc_theressomeonehere"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["over_there"] = ["s_hnfn_overthere", "s_hnfn_theyreoverthere", "s_hnfn_theyreoverthatway"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["surprise"] = ["s_hurc_ohgod", "s_hurc_ohfuck", "s_hurc_ohshit"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["report_reply_idle"] = ["s_idrr_nothinghere", "s_idrr_secure", "s_idrr_weregoodman", "s_idrr_allclear", "s_idrr_goodhere", "s_idrr_nothingtoreport", "s_idrr_allquietoverhere"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["react_first"] = ["s_idrc_huh", "s_idrc_wha", "s_idrc_hm", "s_idrc_eh", "s_idrc_hrm", "s_idrc_hmph"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["react_second"] = ["s_idrc_whatthefuckwasthat", "s_idrc_whatthehellwasthat", "s_idrc_whosthere"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["react_multi"] = ["s_idrm_whatthefuckisgoingon", "s_idrm_okaywhatthefuck", "s_idrm_someonesfuckinwithme"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["react_interrupt"] = ["s_idli_heywhatswrong", "s_idli_whatwasthat", "s_idli_areyouokayman"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["react_noreply"] = ["s_idli_areyouthere", "s_idli_wheredyougo", "s_idli_canyouhearme"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["confirming"] = ["s_idlc_roger", "s_idlc_copy", "s_idlc_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["idle_good_hunting"] = ["s_idls_stayfocusedoverthere", "s_idls_staysharpman", "s_idls_keepyoureyesopenman"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["resp_sound_first"] = ["s_idir_nothingdidntseeanyon", "s_idir_didntseeanyonewerego", "s_idir_thoughtiheardsomeone", "s_idir_soundedlikesomeonewa"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["order_check_together"] = ["s_idit_letsgocheckitout", "s_idit_thiswayfollowme", "s_idit_overherecoverme"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["covering_investigate"] = ["s_idit_rightbehindyou", "s_idit_imwithyou", "s_idit_ivegotyourback"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["team_return_idle"] = ["s_idid_letsheadback", "s_idid_fuckitletsgetback", "s_idid_alrightweshouldgetba"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["have_something"] = ["s_alre_mighthavesomething_01", "s_alre_couldhavesomethinghe_01", "s_alre_somethingsoverhere_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["heard_something"] = ["s_alre_heardsomething_01", "s_alre_heardanoise_01", "s_alre_heardanoiseoverhere_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["saw_something"] = ["s_alre_sawsomethingoverhere_01", "s_alre_mighthaveeyesonsomeo_01", "s_alre_thinksomeonescloseby_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["see_something"] = ["s_alre_seeingsomethingoverh_01", "s_alre_gotavisualonsomethin_01", "s_alre_goteyesonsomething_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["object_whizby"] = ["s_alre_whothefuckthrewthat", "s_alre_whothrewthat", "s_alre_youmissed"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["jailer_body_react"] = ["s_idrm_okaywhatthefuck", "s_idrm_whatthefuckisgoingon", "s_idrm_issomeonefuckingwith"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["jailer_head_react"] = ["s_unrc_contact", "s_unrc_imunderattack", "s_unrc_itookfire"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["alert_investigating"] = ["s_alin_goingtocheckitout", "s_alin_checkingitout", "s_alin_goingtocheckthearea"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["alert_confirming"] = ["s_alcf_roger", "s_alcf_copy", "s_alcf_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["inv_ask"] = ["s_alia_youseeanything", "s_alia_yougotsomething", "s_alia_whatvewegot", "s_alia_youseesomething"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["report_reply_search"] = ["s_alir_nothingyet", "s_alir_nothingsofar", "s_alir_itsbeenquietsofar", "s_alir_weregoodfornow", "s_alir_allclearrightnow", "s_alir_sofarsogood", "s_alir_notseeinganythingyet", "s_alir_haventseenanything", "s_alir_nothingfornow", "s_alir_itsclearfornow", "s_alir_weregoodsofar"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["ask_enemy_loc"] = ["s_unwl_wheredthatcomefrom", "s_unwl_whereditcomefrom", "s_unwl_wherethefuckarethey"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["enemy_loc_resp"] = ["s_unrs_idontknow", "s_unrs_ididntseethem", "s_unrs_idontfuckingknow", "s_unrs_ididntsee"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["ask_enemy_count"] = ["s_unwc_howmanyarethere", "s_unwc_howmanyofem", "s_unwc_howmany"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["react_first_combat"] = ["s_awrr_enemy_01", "s_awrr_theenemyishere_01", "s_awrr_enemyrighthere_01", "s_awrr_theresanenemy_01", "s_awrr_enemyenemy_01", "s_awrr_someoneshere_01", "s_awrr_enemyhere_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["at_my_location"] = ["s_awrr_hererighthere_01", "s_awrr_righthereguys", "s_awrr_heyoverhere_01", "s_awrr_righthererighthere_01", "s_awrr_heytheyrerighthere_01", "s_awrr_theyrehereiseethem_01", "s_awrr_heytheyreoverhere_01", "s_awrr_heytheyrehere_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["found_you"] = ["s_awrr_motherfucker", "s_awrr_pieceofshit", "s_awrr_youbitch", "s_awrr_fuckyou", "s_awrr_gotyou"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["found_target"] = ["s_awrr_heytheyrerightthere_01", "s_awrr_heyiseethem_01", "s_awrr_ifoundthem_01", "s_awrr_igotthem_01", "s_awrr_theretheyare_01", "s_awrr_theyrerightoverthere_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["found_target_loc"] = ["s_awrr_attheoffrenda", "s_awrr_theoffrenda", "s_awrr_offrenda", "s_awrr_firstfloor", "s_awrr_onthefirstfloor", "s_awrr_thefirstfloor", "s_awrr_secondfloor", "s_awrr_onthesecondfloor", "s_awrr_thesecondfloor", "s_awrr_ontheroof", "s_awrr_theroof", "s_awrr_upontheroof", "s_awrr_thegarage", "s_awrr_atthegarage", "s_awrr_inthegarage", "s_awrr_theelevator", "s_awrr_attheelevator", "s_awrr_neartheelevator"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["order_check_last"] = ["s_advo_moveonemgo", "s_advo_theyrerighttherepush", "s_advo_moveuponemnownow"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["lost_target"] = ["s_lkpl_frustratedgrunttheyr", "s_lkpl_frustratedgrunttheyr_01", "s_lkpl_frustratedgruntwelos", "s_lkpl_frustratedgruntfuckt"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["ask_target_location"] = ["s_lklr_wherearethey", "s_lklr_doyouseethem", "s_lklr_youseewheretheywent", "s_lklr_wheredtheygo", "s_lklr_wherethefuckarethey", "s_lklr_whereisthislittlebit"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["target_still_close"] = ["s_lkpc_theywerehere", "s_lkpc_theywererighthere", "s_lkpc_theycantbefar", "s_lkpc_theyreclose", "s_lkpc_theyrehiding", "s_lkpc_theyvegottabehere", "s_lkpc_theydidntjustdisappe", "s_lkpc_theyreheresomewhere"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["order_clear_offrenda"] = ["s_cmho_clearthealtarroom", "s_cmho_securethealtarroom", "s_cmho_sweepthealtarroom"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["order_clear_1stfloor"] = ["s_cmho_clearthefirstfloor", "s_cmho_securethefirstfloor", "s_cmho_sweepthefirstfloor"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["order_clear_2ndfloor"] = ["s_cmho_clearthesecondfloor", "s_cmho_securethesecondfloor", "s_cmho_sweepthesecondfloor"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["order_clear_roof"] = ["s_cmho_cleartheroof", "s_cmho_securetheroof", "s_cmho_sweeptheroof"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["order_clear_garage"] = ["s_cmho_clearthegarage", "s_cmho_securethegarage", "s_cmho_sweepthegarage"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["order_clear_elevator"] = ["s_cmho_cleartheelevator", "s_cmho_securetheelevator", "s_cmho_sweeptheelevator"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["searching_here"] = ["s_cmhc_thisareasgood", "s_cmhc_thisareasclear", "s_cmhc_myareaisclear"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["cmb_hunt_confirmation"] = ["s_cmhr_yesgotit", "s_cmhr_copythat", "s_cmhr_okay", "s_cmhr_gotit", "s_cmhr_no"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["good_hunting"] = ["s_hnts_watchyourbackman", "s_hnts_stayalertman", "s_hnts_onyourtoesman"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["moving_there"] = ["s_hntm_movingnow", "s_hntm_movingtherenow", "s_hntm_moving", "s_hntm_ontheway", "s_hntm_movingthatway"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["moving_following"] = ["s_hntm_imwithyouman", "s_hntm_ihaveyourback", "s_hntm_illguardyourback"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["order_follow_me"] = ["s_hntm_letsmovestaytogether", "s_hntm_followmeletsgo", "s_hntm_yourewithmeletsmove"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["ask_found_anything"] = ["s_aqhr_gotanything", "s_aqhr_yougotsomething", "s_aqhr_findanything", "s_aqhr_youseethem", "s_aqhr_didyoufindsomething", "s_aqhr_whatdoyougot"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["reply_found_nothing"] = ["s_aqhr_nothingyet", "s_aqhr_nothingsofar", "s_aqhr_nothinghereman"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["report_searching"] = ["s_aqhr_stillsweepingthisare", "s_aqhr_stillsearching", "s_aqhr_stilllookingforthem"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["report_nothing"] = ["s_aqhr_theresnothinghere", "s_aqhr_nosignofthemyet", "s_aqhr_nooneshereman"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["report_investigating"] = ["s_aqhr_mighthavesomethingch", "s_aqhr_heardsomethingsweepi", "s_aqhr_theycouldbeclosesear"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["area_clear"] = ["s_aqhr_thisareaisclear", "s_aqhr_clearhere", "s_aqhr_areaclear"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["area_clear_loc"] = ["s_aqhr_altarroomisclear", "s_aqhr_firstfloorsecure", "s_aqhr_weresecureonthesecon", "s_aqhr_roofisclear", "s_aqhr_garageissecure", "s_aqhr_elevatorssecure"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["order_dir"] = ["s_aqhs_checkthatway", "s_aqhs_heysearchoverthere", "s_aqhs_checkoverthere", "s_aqhs_searchthatway"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["order_dir_resp"] = ["s_aqhs_illsearchoverhere", "s_aqhs_illtakethisway", "s_aqhs_illtakeoverhere", "s_aqhs_illsearchthisway"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["hunt_search_object"] = ["s_aqhs_itsclear", "s_aqhs_clear", "s_aqhs_nothinghere", "s_aqhs_goodhere"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["hunt"] = ["s_aqhb_wherethefuckareyou", "s_aqhb_wherethefuckishe", "s_aqhb_whereisthispieceofsh", "s_aqhb_comeonwhereareyouhid", "s_aqhb_wherethefuckdidyougo", "s_aqhb_pieceofshitshowyours", "s_aqhb_motherfuckerwhereare"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["hunt_inv_order"] = ["s_ahii_checkit", "s_ahii_checkitout", "s_ahii_gocheckit", "s_ahii_searchit"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["hunt_inv_event"] = ["s_ahir_ithinktheyreclose", "s_ahir_imighthavethem", "s_ahir_ijustheardthem", "s_ahir_imighthavefoundthem"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["hunt_inv_loc"] = ["s_ahir_atthealtarroom", "s_ahir_nearthealtarroom", "s_ahir_bythealtarroom", "s_ahir_firstfloor", "s_ahir_onthefirstfloor", "s_ahir_thefirstfloor", "s_ahir_secondfloor", "s_ahir_onthesecondfloor", "s_ahir_thesecondfloor", "s_ahir_ontheroof", "s_ahir_theroof", "s_ahir_upontheroof", "s_ahir_thegarage", "s_ahir_atthegarage", "s_ahir_inthegarage", "s_ahir_theelevator", "s_ahir_attheelevator", "s_ahir_neartheelevator"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["hunt_reactions"] = ["s_ahnr_surprisedintensereac", "s_ahnr_surprisedintensereac_01", "s_ahnr_surprisedintensereac_02"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["cmb_reactions"] = ["s_aqcr_surprisedintensereac", "s_aqcr_surprisedintensereac_01", "s_aqcr_surprisedintensereac_02"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["whizby_resp"] = ["s_aqal_itcamefromoverthere", "s_aqal_itcamefromthatway", "s_aqal_itwasfromoverthere"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["hunt_cornercheck"] = ["s_aqho_checkyourcorners", "s_aqho_checkthecorners", "s_aqho_searcheverycornerfin"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["hunt_order_hold"] = ["s_aqho_holdup", "s_aqho_wait", "s_aqho_hold"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["alert_cornercheck"] = ["s_aqao_besuretocheckthecorn", "s_aqao_checkthecornersjustt", "s_aqao_remembertochecktheco"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["alert_search_orders"] = ["s_aqao_checkthatway", "s_aqao_gothatway", "s_aqao_checkoverthere", "s_aqao_searchoverthere", "s_aqao_searchthatway", "s_aqao_lookoverthere"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM"]["hunt_report_alert"] = ["s_aqlo_spreadoutfindthem_01", "s_aqlo_searchtheareafindthe_01", "s_aqlo_spreadoutsearchthear_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["reply_hear_you"] = ["s_idrp_copymanstarttalking", "s_idrp_goahead", "s_idrp_thisiscentral", "s_idrp_whatisit", "s_idrp_yesihearyou", "s_idrp_ihearyougoahead"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["react_interrupt"] = ["s_idli_whatswrong", "s_idli_whatwasthat", "s_idli_whathappened", "s_idli_ididnthearyoumansaya", "s_idli_issomethingwrong", "s_idli_areyouokayman"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["react_noreply"] = ["s_idli_areyouthere", "s_idli_didiloseyou", "s_idli_canyouhearmedude"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["confirming"] = ["s_idlc_roger", "s_idlc_copy", "s_idlc_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["signoff"] = ["s_idls_outhere", "s_idls_centralout", "s_idls_staysafemanout", "s_idls_out"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["inv_patrol"] = ["s_alip_resumeyourpatrolkeep", "s_alip_getbacktoyourpatrolb", "s_alip_returntoyourpatrolbu"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["report_search"] = ["s_alip_whatsyourstatus", "s_aias_reportin", "s_aias_haveyoufoundanything", "s_aias_givemeanupdate", "s_aias_whathaveyougot"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["wait_target_surface"] = ["s_lkwr_whentheycomesupforai", "s_lkwr_theypoptheirheadouty", "s_lkwr_whentheycomeupyoukil", "s_lkwr_theygoforairyoutaket", "s_lkwr_whentheypopuptheyred", "s_lkwr_theyllcomeupforairwh"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["order_find_target"] = ["s_cmho_findthem", "s_cmho_searcheverywherefind", "s_cmho_huntthemdown"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["order_find_perimeter"] = ["s_cmho_cleartheperimeter", "s_cmho_securetheperimeter", "s_cmho_gettheperimeterclear"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["order_search_water"] = ["s_cmho_searchthewater", "s_cmho_checkthewater", "s_cmho_theywereinthewater", "s_cmho_keepyoureyesonthewat", "s_cmho_watchthewater"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["good_hunting"] = ["s_hnts_watchyourbackoutther", "s_hnts_findthismotherfucker", "s_hnts_becarefuloutthere", "s_aisg_copyonyourtoesbro"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["ask_found_anything"] = ["s_aqhr_haveyoufoundanything", "s_aqhr_whathaveyoufound", "s_aqhr_whathaveyougot", "s_aqhr_reportin", "s_aqhr_givemesomething", "s_aqhr_tellmeyouhavesomethi"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["hunt_report_alert"] = ["s_aqhr_anenemyisintheareahu", "s_aqhr_wehaveanenemyinsidet", "s_aqhr_guystheresanenemyint", "s_aqlo_spreadoutfindthem_01", "s_aqlo_searchtheareafindthe_01", "s_aqlo_spreadoutsearchthear_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["order_continue_search"] = ["s_aqho_continuesweeping", "s_aqho_keepsearchingthearea", "s_aqho_searchtheareauntilyo"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["order_stay_alert"] = ["s_aqho_stayalert", "s_aqho_keepyoureyesopen", "s_aqho_stayfocused"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["order_stay_aware"] = ["s_aqho_guardyourselfman", "s_aqho_donotunderestimateth", "s_aqho_keepyourguardup"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["ask_how_copy"] = ["s_idcm_doyouhearmedude", "s_idcm_comein", "s_idcm_thisiscentral"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["inv_no_response"] = ["s_iinr_hesnotrespondingonra", "s_iinr_icantreachhim", "s_iinr_hesnotansweringhisra", "s_iinr_hesnotresponding"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["order_get_visual"] = ["s_iinr_canyougocheckitout", "s_iinr_checkitoutmakesureno", "s_iinr_seeifyoucanfindhimok", "s_iinr_ineedyoucheckitout"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["inv_patrol_noresp"] = ["s_iinr_patrolisntresponding", "s_iinr_patroldidntcheckin", "s_iinr_patrolisntansweringo", "s_iinr_icantreachpatrol"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["report_alert"] = ["s_airp_guyswemayhavecompany", "s_airp_allteamswemayhaveasi", "s_airp_everyonetightenupwem", "s_airp_guyskeepyoureyesopen"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["warn_reply"] = ["s_wrpl_iftheyshowupagainsho", "s_wrpl_ifyouseethemagainope", "s_wrpl_iftheyreturnjustkill"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["report_target_location"] = ["s_chrp_givemeanupdatedoesan", "s_chrp_talktomeguyswhatsthe", "s_chrp_starttalkingguysiwan", "s_chrp_reportinguyswhereare"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["report_idle"] = ["s_irpr_status", "s_irpr_report", "s_irpr_anythingtoreport", "s_irpr_gotanything", "s_irpr_checkin"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["ally_missing_multi"] = ["s_alms_multipleteamsarentre", "s_alms_anothergroupisntresp", "s_alms_wevelostcontactwitha", "s_alms_anotherteamfailedtor"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["order_search_start"] = ["s_aior_searchthearea_01", "s_aior_searcharound_01", "s_aior_sweeptheperimeter_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["order_report_back"] = ["s_aior_reportwhatyoufind", "s_aior_radioifyoufindanythi", "s_aior_reportbackifyoufinds"];
  level.battlechatter._id_ED774F98C3EFAE87["CTM_L"]["hunt_patrol_noresp"] = ["s_hpnr_patrolisntresponding", "s_hpnr_patroldidntcheckin", "s_hpnr_patrolisntansweringo", "s_hpnr_icantreachpatrol"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["left"] = ["c_posn_leftside", "c_posn_left", "c_posn_checkleft", "c_posn_theyreflankingleft"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["right"] = ["c_posn_rightside", "c_posn_theyreflankingright", "c_posn_right", "c_posn_checkright"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["ahead"] = ["c_posn_straightahead", "c_posn_rightinfrontofus", "c_posn_aheadofus", "c_posn_front", "c_posn_deadahead"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["behind"] = ["c_posn_behindus", "c_posn_onoursix", "c_posn_checkrear", "c_posn_rear"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["high"] = ["c_posn_uptop", "c_posn_checkhigh", "c_posn_coverup"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["using_rpg"] = ["c_atac_rocket", "c_atac_rocket_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["attacking"] = ["c_atac_goinghot", "c_atac_engaging", "c_atac_openinup"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["using_smoke"] = ["c_atac_throwingsmoke", "c_atac_smokeout"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["using_flash"] = ["c_atac_flashbangout", "c_atac_throwingflashbang"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["using_grenade"] = ["c_atac_fragout", "c_atac_throwingafrag"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["using_molotov"] = ["c_atac_throwingmolotov", "c_atac_molotovout"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["use_flash"] = ["c_ator_useaflashbang", "c_ator_throwaflashbang", "c_ator_tossaflashbang"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["use_grenade"] = ["c_ator_useagrenade", "c_ator_throwafrag", "c_ator_tossafrag"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["use_molotov"] = ["c_ator_throwamolotov", "c_ator_useamolotov", "c_ator_tossamolotov"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["use_rpg"] = ["c_ator_hitemwitharocket", "c_ator_usearocket", "c_ator_rocket"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["order_attack"] = ["c_ator_engage", "c_ator_giveemsome", "c_ator_dumpem", "c_ator_gohot", "c_ator_youreclearedhot", "c_ator_fuckinshootem", "c_ator_startsmokinem"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["movingup"] = ["c_tcac_impushingup", "c_tcac_pushingforward", "c_tcac_movingup", "c_tcac_pushinup"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["getting_cover"] = ["c_tcac_covercover", "c_tcac_takingcover", "c_tcac_movingtocover"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["reloading"] = ["c_tcac_reloading", "c_tcac_changingmags"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["enemy_using_flash"] = ["c_eata_flashincoming", "c_eata_flashgrenade", "c_eata_flash", "c_eata_flashgrenade_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["enemy_using_grenade"] = ["c_eata_grenade", "c_eata_grenadewatchout", "c_eata_grenadeincoming"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["enemy_using_molotov"] = ["c_eata_molotov", "c_eata_molotovincoming", "c_eata_molotov_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["enemy_using_rpg"] = ["c_eata_rpg", "c_eata_rpgincoming", "c_eata_rpggetdown"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["enemy_attacking"] = ["c_eata_takingfire", "c_eata_contact", "c_eata_shadowsincontact"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["enemy_moving_up"] = ["c_etca_onespushing", "c_etca_gotonemovingup", "c_etca_onesmovingup"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["enemy_getting_cover"] = ["c_etca_novisualontarget", "c_etca_gotonetakingcover", "c_etca_onesmovingtocover", "c_etca_novisualontarget_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["enemy_reloading"] = ["c_etca_onesreloading", "c_etca_onesreloading_01", "c_etca_oneschangingmags"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["enemy_flanking_left"] = ["c_etca_onesmovingleft", "c_etca_leftflank", "c_etca_guardleft"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["enemy_flanking_right"] = ["c_etca_guardright", "c_etca_rightflank", "c_etca_onesmovingright"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["enemy_moving"] = ["c_etca_onesmovin", "c_etca_thatonesmoving", "c_etca_gotonemoving"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["target_getting_cover"] = ["c_ttca_theyremovingtocover", "c_ttca_theyregoingforcover", "c_ttca_theyretakingcover"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["target_reloading"] = ["c_ttca_theyrereloading", "c_ttca_theyrereloading_01", "c_ttca_thebastardsreloading"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["target_moving"] = ["c_ttca_theyremoving", "c_ttca_hesmoving", "c_ttca_hesrunning"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["target_moving_up"] = ["c_ttca_theyremovingup", "c_ttca_hescominguponyou", "c_ttca_hesmovingup"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["target_near_patrol"] = ["c_ttca_theyreswimmingnearth", "c_ttca_theyreswimmingyourwa", "c_ttca_interceptthem"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["enemy_soldier"] = ["c_enmy_visualonatarget", "c_enmy_targetspotted", "c_enmy_gotatarget"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["enemy_soldiers"] = ["c_enmy_targets", "c_enmy_xrays", "c_enmy_hostiles"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["neg_target"] = ["c_aqen_idontseeem", "c_aqen_novisual", "c_aqen_cantseehim", "c_aqen_wherethefuckishe"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["aquired_target"] = ["c_aqen_gotavisual", "c_aqen_targetacquired", "c_aqen_iseeem", "c_aqen_theyrerightthere"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["enemy_exposed"] = ["c_exco_onesintheopen", "c_exco_onesintheopen_01", "c_exco_gotoneintheopen"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["target_exposed"] = ["c_exco_theyreintheopen", "c_exco_thatonesintheopen", "c_exco_theyreintheopen_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["youre_exposed"] = ["c_exco_findcover"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["target_covered"] = ["c_exco_theyrebehindcover", "c_exco_theyvegotcover", "c_exco_theyretakingcover"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["killfirm_enemy"] = ["c_firm_gotone", "c_firm_hostiledown", "c_firm_xraydown"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["killfirm_target"] = ["c_firm_theyredone", "c_firm_theyredown", "c_firm_sortedem"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["casualties"] = ["c_casu_weretakingheavies", "c_casu_weregettingourassesk", "c_casu_werelosingshooters", "c_casu_weretakingcasualties"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["copy"] = ["c_conf_copy", "c_conf_check", "c_conf_copythat", "c_conf_goodcopy", "c_conf_solidcopy", "c_aqcp_copy", "c_aqcp_solidcopy"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["praise"] = ["c_pras_hellyeah", "c_pras_niceonemate", "c_pras_fuckina", "c_pras_yeah", "c_pras_thatlldo"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["low_ammo"] = ["c_stat_ineedamag", "c_stat_lowonammo", "c_stat_lastmag", "c_stat_needammo", "c_stat_imwinchester"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["wounded"] = ["c_stat_imhit", "c_stat_imshot", "c_stat_medic"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["ask_wounded"] = ["c_stat_yougood", "c_stat_youwounded", "c_stat_youhit"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["ask_low_ammo"] = ["c_stat_howsyourammo", "c_stat_checkyourammo", "c_stat_whatsyourroundcount"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["ask_status"] = ["c_stat_youokay", "c_stat_whatsyourstatus", "c_stat_status"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["reply_wounded"] = ["c_stat_itookaround", "c_stat_imgood", "c_stat_yeahroundhittheplate"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["reply_low_ammo"] = ["c_stat_runninglow", "c_stat_imlow", "c_stat_almostout"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["reply_okay"] = ["c_stat_imsolid", "c_stat_goodtogo", "c_stat_goodhere"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["wounded_enemy"] = ["c_aens_igothim", "c_aens_clippedhim", "c_aens_hitone"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["ask_target_loc"] = ["c_tast_wheresheat", "c_tast_doesanyonehaveavisua", "c_tast_wherethefuckretheyat"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["ask_target_wounded"] = ["c_tast_yougethim", "c_tast_youhithim", "c_tast_youdrophim"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["target_wounded"] = ["c_tast_heshit", "c_tast_heswounded", "c_tast_hesbleeding"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["target_unhurt"] = ["c_tast_hegotaway", "c_tast_heranoff", "c_tast_hesfallingback"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["wounded_target"] = ["c_atas_woundedhim", "c_atas_ihithim", "c_atas_itaggedem"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["enemy_shotgun"] = ["c_enws_shotgunwatchout", "c_enws_onesgotashotgun", "c_enws_shotgun"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["enemy_sniper"] = ["c_enws_thatsasniper", "c_enws_sniper", "c_enws_enemysniper"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["enemy_lmg"] = ["c_enws_enemymachinegunner", "c_enws_lmg", "c_enws_machinegun"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["target_lmg"] = ["c_taws_theyreusingamachineg", "c_taws_hesgotamachinegun", "c_taws_machinegunner"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["target_shotgun"] = ["c_taws_theyvegotashotgun", "c_taws_hesgotashotgun"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["target_sniper"] = ["c_taws_hessnipingus", "c_taws_hesasniper"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["checkfire"] = ["c_chck_checkyourfire", "c_chck_watchyourfire", "c_chck_blueblue", "c_chck_checkfirecheckfire"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["move"] = ["c_tcor_move", "c_tcor_igotyoumove", "c_tcor_startmoving", "c_tcor_go"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["moveup"] = ["c_tcor_moveup", "c_tcor_moveupgo", "c_tcor_pushup", "c_tcor_getupthere", "c_tcor_pushforward"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["coverme"] = ["c_tcor_coverme", "c_tcor_ineedcoverfire", "c_tcor_coverme_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["casualty"] = ["c_canm_wegotacasualty", "c_canm_mandown", "c_canm_wehaveamandown", "c_canm_wevegotwounded", "c_canm_wevegotasoldierdown"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["suppressing"] = ["c_aqsp_suppressingfirefallb", "c_aqsp_suppressingfire", "c_aqsp_imcoveringyou", "c_aqsp_coveringfire"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["reply_hear_you"] = ["s_idrp_sendtraffic", "s_idrp_copygoahead", "s_idrp_imhere", "s_idrp_goahead"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["resp_patrol"] = ["s_idrp_thisisthresher", "s_ahrp_thisisthresher"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["muttered_confusion"] = ["s_idin_whatsthat", "s_idin_whatthehellwasthat", "s_idin_thebleedinhellwastha", "s_idin_whatthehell"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["inv_arrive"] = ["s_idin_huhwhatwasthat", "s_idin_hmphokay", "s_idin_hmm", "s_idin_huhthehell", "s_idin_hrm"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["investigating"] = ["s_idin_illgocheck", "s_idin_illcheckitout", "s_idin_illseewhatsup"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["react_found_corpse"] = ["s_alrc_wehaveasoldierdown", "s_alrc_oneofoursiskia", "s_alrc_gotamandown", "s_alrc_wevegotacasualty"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["ask_corpse_name"] = ["s_alrc_whodidwelose", "s_alrc_who", "s_alrc_whoisit"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["need_backup"] = ["s_alrc_sendreinforcements", "s_alrc_ineedreinforcements", "s_albc_sendreinforcements"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["hunt_copy"] = ["s_hnrs_copy", "s_hnrs_rogerthat", "s_hnrs_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["react_whizby"] = ["s_unrc_imtakingfire", "s_unrc_imgettingshotat", "s_unrc_takineffectivefire", "s_unrc_someonesshootinatme", "s_unrc_thatsclose"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["react_unaware"] = ["s_unrc_takingcontact", "s_unrc_takingindirectfire", "s_unrc_contactcontact"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["over_there"] = ["s_hnfn_overthere", "s_hnfn_theyreoverthere", "s_hnfn_rightthere"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["surprise"] = ["s_hurc_surprisedeffort", "s_hurc_surprisedeffort_01", "s_hurc_surprisedeffort_02", "s_hurc_bollocks", "s_hurc_ohshit"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["report_reply_idle"] = ["s_idrr_gotnothing", "s_idrr_secure", "s_idrr_clearhere", "s_idrr_allclear", "s_idrr_goodhere", "s_idrr_allquiet", "s_idrr_areassecure"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["react_first"] = ["s_idrc_huh", "s_idrc_hmph", "s_idrc_hrm", "s_idrc_eh", "s_idrc_hm", "s_idrc_wha"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["react_second"] = ["s_idrc_yourebloodyjokingwha", "s_idrc_thebloodyhellisgoing", "s_idrc_whatthehellisthat"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["react_multi"] = ["s_idrm_whosoutthere", "s_idrm_okaywhatthefuck", "s_idrm_whatisthisshit"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["react_interrupt"] = ["s_idli_missedyourlastover", "s_idli_yougood", "s_idli_sayagainover"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["react_noreply"] = ["s_idli_doyoureadme", "s_idli_youcopy", "s_idli_youreceivingme"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["order_investigate"] = ["s_idio_gocheckit", "s_idio_checkitout", "s_idio_gocheckthatout"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["confirming"] = ["s_idlc_roger", "s_idlc_copy", "s_idlc_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["inv_ask_first"] = ["s_idia_whatwasit", "s_idia_findanything", "s_idia_seeanything", "s_idia_yougotanything", "s_idia_whatdyoufind"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["inv_ask_second"] = ["s_idia_stillnothing", "s_idia_anythingthistime", "s_idia_whatwasitthistime", "s_idia_findanythingthistime", "s_idia_stilldidntfindanythi"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["resp_sound_first"] = ["s_idir_nothingnovisual", "s_idir_nahweresecure", "s_idir_negativewereclear", "s_idir_nothingnobody"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["order_check_together"] = ["s_idit_letsgocheckitout", "s_idit_letscheckitwatchmyba", "s_idit_letsgocheckcoverme"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["covering_investigate"] = ["s_idit_covering", "s_idit_imwithyou", "s_idit_gotyoucovered"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["team_return_idle"] = ["s_idid_okayletsheadback", "s_idid_weregoodhereletsgetb", "s_idid_backtoourpostsletsgo"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["ask_heard_that"] = ["s_alre_youhearthat", "s_alre_youheardthattoo", "s_alre_youheardthatright"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["ask_saw_that"] = ["s_alre_didyouseethat", "s_alre_yougeteyesonthat", "s_alre_youcatchthat"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["have_something"] = ["s_alre_imighthavesomething", "s_alre_ithinkihavesomething", "s_alre_igotapossiblethreat"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["heard_something"] = ["s_alre_iheardsomething", "s_alre_heardsomethingnearme", "s_alre_iheardanoise"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["saw_something"] = ["s_alre_isawsomething", "s_alre_thoughtisawsomething", "s_alre_ithinksomeonesnearme"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["react_resp"] = ["s_alrr_yeah", "s_alrr_afirm", "s_alrr_yeahrogerthat"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["alert_ask"] = ["s_alia_seeanything", "s_alia_yougotsomething", "s_alia_anything", "s_alia_gotanything"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["alert_patrol"] = ["s_alip_illpullsecurityheret", "s_alip_illsecuretheareakeep", "s_alip_headbackillpullsecur", "s_alip_ivegotthisareagetbac"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["report_reply_search"] = ["s_alir_negativenothingyet", "s_alir_nothingfornow", "s_alir_negativegotnothing", "s_alir_notseeinganything", "s_alir_sofarsogood", "s_alir_igotnothingyet", "s_alir_goodsofar", "s_alir_nothing", "s_alir_nothingsofar", "s_alir_weregoodfornow", "s_alir_itsclearsofar"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["warn_report"] = ["s_wrnr_hadanunknowninsideth", "s_wrnr_hadanunknowninsideth_01", "s_wrnr_anunknownwasintheare"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["warn_spotted"] = ["s_wrnf_heygetthefuckback", "s_wrnf_heyyougetthefuckoutt", "s_wrnf_getbackgetbackrightn"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["warn_conv"] = ["s_wrni_scaredthehelloutofem", "s_wrni_probablyshittingthem", "s_wrni_whatthehellweretheyd", "s_wrni_whatthefuckweretheyt"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["warn_conv_reply"] = ["s_wrir_almostgotthemselvesk", "s_wrir_iwasreadytodumpthatm", "s_wrir_luckytheydidntcatcha"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["warn_attack"] = ["s_wrnk_heyiwarnedyou", "s_wrnk_youwerewarned", "s_wrnk_heyyoujustfuckedup"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["ask_enemy_loc"] = ["s_unwl_wheredthatcomefrom", "s_unwl_whereditcomefrom", "s_unwl_wherethehellarethey"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["enemy_loc_resp"] = ["s_unrs_idontknowbutthatwasa", "s_unrs_ididntseeem", "s_unrs_idontbloodyknow", "s_unrs_novisualdidntseeem"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["react_first_combat"] = ["s_awrr_contact", "s_awrr_enemymyposition", "s_awrr_enemy", "s_awrr_enemyshere", "s_awrr_gotenemyhere", "s_awrr_enemysclose", "s_awrr_troopsincontact"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["report_target_water"] = ["s_awrr_targetsinthewater", "s_awrr_gotavisualtheyreinth", "s_awrr_iseeeminthewater", "s_awrr_inthewaterinthewater", "s_awrr_enemyinthewater", "s_awrr_theyremovinginthewat", "s_awrr_heytheyreinthewater"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["at_my_location"] = ["s_awrr_righthere", "s_awrr_onmeonme", "s_awrr_myposition", "s_awrr_righthererighthere", "s_awrr_onme", "s_awrr_theyrerighthere", "s_awrr_overhere", "s_awrr_theyreoverhere"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["found_target"] = ["s_awrr_gotem", "s_awrr_iseeem", "s_awrr_foundem", "s_awrr_hey", "s_awrr_visual", "s_awrr_targetspotted"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["found_you"] = ["s_awrr_iseeyoubastard", "s_awrr_foundyou", "s_awrr_igotyou", "s_awrr_gotyou", "s_awrr_ifoundyou"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["order_check_last"] = ["s_advo_moveonemgo", "s_advo_forceuponemgo", "s_advo_pushtheirpositiongo"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["lost_target"] = ["s_lkpl_frustratedgrunttheyr", "s_lkpl_frustratedgrunttheyr_01", "s_lkpl_frustratedgruntnovis", "s_lkpl_frustratedgrunttheyg"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["lost_target_water"] = ["s_lkpw_theywentunderwater", "s_lkpw_theyreinthewater", "s_lkpw_theyjumpedinthewater", "s_lkpw_targetsinthewater"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["ask_target_location"] = ["s_lklr_gotavisual", "s_lklr_youseeem", "s_lklr_whatstheirlocation", "s_lklr_wherearethey", "s_lklr_wherethefuckarethey", "s_lklr_getmealocation"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["target_still_close"] = ["s_lkpc_theywerehere", "s_lkpc_theywererighthere", "s_lkpc_theycantbefar", "s_lkpc_theyreclose", "s_lkpc_theyrehiding", "s_lkpc_theygottabeclose", "s_lkpc_theydidntmakeitfar", "s_lkpc_theyrestillheresomew"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["clearing_east"] = ["s_cmhs_checkingeast", "s_cmhs_securingeast", "s_cmhs_movingeast"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["clearing_west"] = ["s_cmhs_checkingwest", "s_cmhs_securingwest", "s_cmhs_movingwest"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["clearing_south"] = ["s_cmhs_securingsouth", "s_cmhs_movingsouth", "s_cmhs_checkingsouth"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["clearing_north"] = ["s_cmhs_securingnorth", "s_cmhs_movingnorth", "s_cmhs_checkingnorth"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["good_hunting"] = ["s_hnts_staysharp", "s_hnts_stayfrosty", "s_hnts_keepittight"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["moving_there"] = ["s_hntm_movingnow", "s_hntm_moving", "s_hntm_movingtherenow", "c_tcac_moving", "c_tcac_immoving", "c_tcac_heyimmoving"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["moving_alone"] = ["s_hntm_iminbound", "s_hntm_immoving", "s_hntm_immovingnow"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["ask_found_anything"] = ["s_aqhr_gotanything", "s_aqhr_findanything", "s_aqhr_gotavisual", "s_aqhr_anyvisual", "s_aqhr_whatdoyougot", "s_aqhr_yougotsomething"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["reply_found_nothing"] = ["s_aqhr_novisualonthetarget", "s_aqhr_nosignofem", "s_aqhr_novisual"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["report_investigating"] = ["s_aqhr_immovingin", "s_aqhr_imcheckingitout", "s_aqhr_movingtosecure"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["area_clear"] = ["s_aqhr_thisareassecure", "s_aqhr_securehere", "s_aqhr_areasecure"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["order_dir"] = ["s_aqhs_securethatarea", "s_aqhs_checkthatway", "s_aqhs_cordonthatarea", "s_aqhs_clearthatarea"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["order_dir_resp"] = ["s_aqhs_illsearchthisway", "s_aqhs_illcheckoverhere", "s_aqhs_illtakethisway", "s_aqhs_illsecurethisarea"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["hunt"] = ["s_aqhb_wherethefuckareyou", "s_aqhb_motherfuckers", "s_aqhb_yourehidingiknowyour", "s_aqhb_youreheresomewherear", "s_aqhb_comeonout", "s_aqhb_gonnafindyou", "s_aqhb_wheredyoufuckinggo"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["hunt_reactions"] = ["s_ahnr_surprisedinttenserea", "s_ahnr_surprisedinttenserea_01", "s_ahnr_surprisedinttenserea_02"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["cmb_reactions"] = ["s_aqcr_surprisedinttenserea", "s_aqcr_surprisedinttenserea_01", "s_aqcr_surprisedinttenserea_02"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["whizby_resp"] = ["s_aqal_itcamefromoverthere", "s_aqal_itcamefromthatway", "s_aqal_itwasfromoverthere"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["hunt_cornercheck"] = ["s_aqho_checkyourcorners", "s_aqho_checkthosecorners", "s_aqho_checkcornersfindem"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["hunt_order_hold"] = ["s_aqho_hold", "s_aqho_standfast", "s_aqho_holdup"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["alert_search_orders"] = ["s_aqao_searchoverthere", "s_aqao_checkoverthere", "s_aqao_gothatway", "s_aqao_checkthatway", "s_aqao_securethatarea", "s_aqao_searchthatway"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["hunt_report_alert"] = ["s_aqlo_cordonandsearchthear", "s_aqlo_fanoutsearchthearea", "s_aqlo_cordonofftheareafind"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_solo"] = [];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_solo"][0] = ["s_idsl_alqatalatakesoveralm", "s_idsl_devgruandkortacmovei", "s_idsl_alongcomeswhitelotus", "s_idsl_blackmous", "s_idsl_legionwellweknowwhat", "s_idsl_thencrowngetsinvolve", "s_idsl_soaqbringinthecartel", "s_idsl_cartelsetsupshop", "s_idsl_thosecowboysfollowem", "s_idsl_andnowyouhavethispha", "s_idsl_somewouldcallthatapr", "s_idsl_icallitatargetrichen"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_solo"][1] = ["s_idsl_sharpenup", "s_idsl_complacencykills", "s_idsl_youknowthemomentyoug", "s_idsl_somelittlefuckerisgo", "s_idsl_sostaysharp", "s_idsl_dontletemgetthedropo", "s_idsl_wellbedoneherebefore"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_solo"][2] = ["s_idsl_cartelandaq", "s_idsl_neverthoughtidliketo", "s_idsl_shouldhavejuststayed", "s_idsl_orchosenothergroupst", "s_idsl_morecapablegroups", "s_idsl_bestsmugglersinthewo", "s_idsl_iftheyweresmarttheyd", "s_idsl_anyonewhoworkswithaq"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_solo"][3] = ["s_idsl_shouldnthavecomehere", "s_idsl_theterrorists", "s_idsl_thecartel", "s_idsl_andalltherestofem", "s_idsl_gonnaridthisplaceofy"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_solo"][4] = ["s_idsl_imapeacekeepingsoldi", "s_idsl_imapeacekeepingsoldi_01", "s_idsl_imapeacekeepingsoldi_02", "s_idsl_imaviolentbastardand"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_solo"][5] = ["s_idsl_shouldntbemuchlonger", "s_idsl_anotherhour", "s_idsl_maybetwo", "s_idsl_thenyoucangetsomeshu", "s_idsl_orasmoke", "s_idsl_justwatchyourcorners", "s_idsl_dontgetsloppy"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_solo"][6] = ["s_idsl_hummingasong", "s_idsl_hummingasong_01", "s_idsl_hummingasong_02"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_solo"][7] = ["s_idsl_clear", "s_idsl_justlikethelasttime", "s_idsl_fiftypoundssaysitscl", "s_idsl_gonnabearichmanbythe"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_solo"][8] = ["s_idsl_touchpointpull", "s_idsl_drivetoeyeline", "s_idsl_lockin", "s_idsl_squeezetrigger", "s_idsl_recoiltargetsdown", "s_idsl_bobsyouruncle"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_conv"] = [];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_conv"][0] = ["s_idcv_wherewereyoubeforeth", "s_idcv_allover", "s_idcv_everbeentourzikstan", "s_idcv_yeahgotfamilythere", "s_idcv_wellthatmakestwoofus", "s_idcv_smallworldeh", "s_idcv_toorightmate"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_conv"][1] = ["s_idcv_youseenanycartelarou", "s_idcv_negative", "s_idcv_youknowthebosselsinn", "s_idcv_whataboutem", "s_idcv_ihearitsawoman", "s_idcv_okay", "s_idcv_imjustsaying", "s_idcv_yeahiknowwhatyouresa", "s_idcv_dontreadintoitmateju", "s_idcv_okaywithwhat", "s_idcv_yknowengaging", "s_idcv_youhavinalaugh", "s_idcv_whenthetimecomesyouc", "s_idcv_ifthetimecomesshellb"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_conv"][2] = ["s_idcv_queencapturesrookh8", "s_idcv_rooktod3", "s_idcv_queentoa8", "s_idcv_pawnc3", "s_idcv_queentoa4check", "s_idcv_kingtoe1", "s_idcv_pawntof4", "s_idcv_sneakybastardpawntof", "s_idcv_kingc1", "s_idcv_rooktod2", "s_idcv_queentoa7resign", "s_idcv_pissoff"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_conv"][3] = ["s_idcv_interrogative", "s_idcv_goahead", "s_idcv_whydidthechickencros", "s_idcv_fuckinhellwhy", "s_idcv_togettotheidiotshous", "s_idcv_whosthere", "s_idcv_thechicken"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_conv"][4] = ["s_idcv_gotanything", "s_idcv_negativeyou", "s_idcv_nothing", "s_idcv_letsgiveittenthenswe", "s_idcv_wegotreconup", "s_idcv_airassetshavebeentas", "s_idcv_sowereourownrecongot"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_conv"][5] = ["s_idcv_latestintelshowsaqan", "s_idcv_howmanyfighters", "s_idcv_adozenmaybemore", "s_idcv_wecanhandlethat", "s_idcv_itsnotthemimconcerne", "s_idcv_whothen", "s_idcv_everyoneelse", "s_idcv_yourenotgettingsofto", "s_idcv_theresadifferencebet", "s_idcv_justkeepyourweaponre", "s_idcv_wecouldusereinforcem", "s_idcv_mostofourassetsareti", "s_idcv_yougoodonweaponsanda", "s_idcv_toppedoffandrightasr", "s_idcv_okayletsstaysharp"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_conv"][6] = ["s_idcv_clear", "s_idcv_allclear", "s_idcv_watchforgreensmoketh", "s_idcv_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_conv"][7] = ["s_idcv_impullingrecceyester", "s_idcv_aqorcartel", "s_idcv_neithersotheyresetti", "s_idcv_howfar", "s_idcv_around800meterssothe", "s_idcv_areconteam", "s_idcv_negativeitwascivilia", "s_idcv_noshitwhatdyoudo", "s_idcv_whatihadtoiwatchedit", "s_idcv_welldonttellmewhowon"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_conv"][8] = ["s_idcv_anysignofaqorcartel", "s_idcv_heardsomethinggoingd", "s_idcv_rogerthatmakesureyou", "s_idcv_wayaheadofyou", "s_idcv_letskeepaneyeonthata", "s_idcv_copymaybewellseesome", "s_idcv_anymovementandyoucal", "s_idcv_solidcopy"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS"]["idle_conv"][9] = ["s_idcv_wehitanaqstrongholdl", "s_idcv_anycasualties", "s_idcv_noneitwasmint", "s_idcv_actionableintel", "s_idcv_unknownatthistime", "s_idcv_maybeitcanleadustoth", "s_idcv_lookedliketheyhadint", "s_idcv_evenus", "s_idcv_wellsee", "s_idcv_soundslikeweneedtohi"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["wait_target_surface"] = ["s_lkwr_whentheygoforairtake", "s_lkwr_whentheycomeupyourec", "s_lkwr_whentheycomeupforair", "s_lkwr_waitforthemtocomeupt", "s_lkwr_waitforthemtosurface", "s_lkwr_theyllhavetosurfacew"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["idle_name"] = ["s_idnm_king", "s_idnm_adams", "s_idnm_baker", "s_idnm_barry", "s_idnm_billy", "s_idnm_chapman", "s_idnm_colin", "s_idnm_edwards", "s_idnm_fisher", "s_idnm_george", "s_idnm_grant", "s_idnm_hall", "s_idnm_james", "s_idnm_matthews", "s_idnm_morgan", "s_idnm_parker", "s_idnm_richards", "s_idnm_roberts", "s_idnm_shaw", "s_idnm_stevens", "s_idnm_thomas", "s_idnm_turner", "s_idnm_williams"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["reply_hear_you"] = ["s_idrp_rogergoahead", "s_idrp_thisisactualgoahead", "s_idrp_goahead", "s_idrp_go", "s_idrp_goforactual", "s_idrp_thisisactual"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["idle_conf_name"] = ["s_idcn_doyoucopy", "s_idcn_king", "s_idcn_adams", "s_idcn_baker", "s_idcn_barry", "s_idcn_billy", "s_idcn_chapman", "s_idcn_colin", "s_idcn_edwards", "s_idcn_fisher", "s_idcn_george", "s_idcn_grant", "s_idcn_hall", "s_idcn_james", "s_idcn_matthews", "s_idcn_morgan", "s_idcn_parker", "s_idcn_richards", "s_idcn_roberts", "s_idcn_shaw", "s_idcn_stevens", "s_idcn_thomas", "s_idcn_turner", "s_idcn_williams"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["hunt_name"] = ["s_hnnm_king", "s_hnnm_adams", "s_hnnm_baker", "s_hnnm_barry", "s_hnnm_billy", "s_hnnm_chapman", "s_hnnm_colin", "s_hnnm_edwards", "s_hnnm_fisher", "s_hnnm_george", "s_hnnm_grant", "s_hnnm_hall", "s_hnnm_james", "s_hnnm_matthews", "s_hnnm_morgan", "s_hnnm_parker", "s_hnnm_richards", "s_hnnm_roberts", "s_hnnm_shaw", "s_hnnm_stevens", "s_hnnm_thomas", "s_hnnm_turner", "s_hnnm_williams"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["react_noreply"] = ["s_idli_areyoureceivingme", "s_idli_doyoureadme", "s_idli_doyoucopy"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["react_interrupt"] = ["s_idli_missedyourlastsayaga", "s_idli_commscheck", "s_idli_sayagainyourlastover", "s_idli_areyougood", "s_idli_sayagainover", "s_idli_missedyourlastover"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["confirming"] = ["s_idlc_roger", "s_idlc_copy", "s_idlc_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["alert_corpse_name"] = ["s_alcn_itsking", "s_alcn_itsadams", "s_alcn_itsbaker", "s_alcn_itsbarry", "s_alcn_itsbilly", "s_alcn_itschapman", "s_alcn_itscolin", "s_alcn_itsedwards", "s_alcn_itsfisher", "s_alcn_itsgeorge", "s_alcn_itsgrant", "s_alcn_itshall", "s_alcn_itsjames", "s_alcn_itsmatthews", "s_alcn_itsmorgan", "s_alcn_itsparker", "s_alcn_itsrichards", "s_alcn_itsroberts", "s_alcn_itsshaw", "s_alcn_itsstevens", "s_alcn_itsthomas", "s_alcn_itsturner", "s_alcn_itswilliams"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["inv_patrol"] = ["s_alip_continueyourpatrolst", "s_alip_getbacktoyourrouteke", "s_alip_returntoyourpatrolke"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["good_hunting"] = ["s_hnts_goodhunting", "s_hnts_staysharpoutthere", "s_hnts_out", "s_aisg_copystaysharp"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["ask_found_anything"] = ["s_aqhr_whatsyourstatus", "s_aqhr_whatveyougot", "s_aqhr_givemeasitrep", "s_aqhr_sitrep", "s_aqhr_didyoufindanything", "s_aqhr_tellmeyouhavesomethi"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["hunt_report_alert"] = ["s_aqhr_allteamswehaveenemyi", "s_aqhr_allteamsperimeterisb", "s_aqhr_allteamsenemyisinsid", "s_aqlo_fanoutsecuretheperim", "s_aqlo_setcontainmentfindth", "s_aqlo_spreadoutsearchthear"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["order_stay_aware"] = ["s_aqho_dontletthesebastards", "s_aqho_keepyourguardup", "s_aqho_dontletyourguarddown"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["order_stay_alert"] = ["s_aqho_eyesopen", "s_aqho_keepittight", "s_aqho_staysharp"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["order_continue_search"] = ["s_aqho_keepsearchingthearea", "s_aqho_keepsweeping", "s_aqho_keeplookingforem"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["signoff"] = ["s_idls_out", "s_idls_actualout", "s_idls_staysharp", "s_idls_out_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["order_find_target"] = ["s_cmho_weneedalocationonthe", "s_cmho_locatethetargetnow", "s_cmho_huntthemdown"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["order_find_perimeter"] = ["s_cmho_getthisarealockeddow", "s_cmho_securetheperimeter", "s_cmho_iwantthisarealockedd"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["order_search_water"] = ["s_cmho_searchthewater", "s_cmho_checkthewater", "s_cmho_theywereinthewater", "s_cmho_watchthewater", "s_cmho_keepyoureyesonthewat"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["ask_how_copy"] = ["s_idcm_howcopy", "s_idcm_doyoucopy", "s_idcm_commscheck"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["inv_no_response"] = ["s_iinr_hesradiosilent", "s_iinr_hesnotresponding", "s_iinr_hesnotoncomms", "s_iinr_icantreachhim"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["inv_patrol_noresp"] = ["s_iinr_stingraydidntcheckin", "s_iinr_stingrayisntrespondi", "s_iinr_icantreachstingray", "s_iinr_stingrayisntoncomms"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["order_get_visual"] = ["s_iinr_ineedyoutocheckitout", "s_iinr_doyouhaveavisualonth", "s_iinr_checkitoutmakesureno", "s_iinr_seeifyoucanfindoutwh"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["report_search"] = ["s_aias_sitrep", "s_aias_whatsyourstatus", "s_aias_findanything", "s_aias_gotanything", "s_aias_status"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["report_alert"] = ["s_airp_allteamssharpenupwem", "s_airp_allteamstheperimeter", "s_airp_allteamspossibleenem", "s_airp_allteamssetsecurityw"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["warn_reply"] = ["s_wrpl_iftheyreturnyourecle", "s_wrpl_youseethemagainsortt", "s_wrpl_iftheyreturnyourecle_01"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["report_target_location"] = ["s_chrp_doesanyonehaveavisua", "s_chrp_talktomegentswhatsth", "s_chrp_cmonladsineedalocati", "s_chrp_allteamsdoyouhaveavi"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["report_idle"] = ["s_irpr_status", "s_irpr_sitrep", "s_irpr_yougood", "s_irpr_gotanything", "s_irpr_report"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["ally_missing_multi"] = ["s_alms_multipleteamsarentre", "s_alms_anotherteamfailedtor", "s_alms_wevelostcontactwitha", "s_alms_anotherteamlostcomms"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["order_search_start"] = ["s_aior_searchthearea", "s_aior_pullsecuritysweepthe", "s_aior_securetheperimeter"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["order_report_back"] = ["s_aior_soundoffifyoufindsom", "s_aior_reportbackifyoufinda", "s_aior_usecommsifyoufindsom"];
  level.battlechatter._id_ED774F98C3EFAE87["CFS_L"]["hunt_patrol_noresp"] = ["s_hpnr_stingrayisntrespondi", "s_hpnr_stingraydidntcheckin", "s_hpnr_stingrayisntanswerin", "s_hpnr_icantreachstingray"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["left"] = ["c_posn_leftside", "c_posn_left", "c_posn_checkleft", "c_posn_theyreflankingleft"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["right"] = ["c_posn_rightside", "c_posn_theyreflankingright", "c_posn_right", "c_posn_checkright"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["ahead"] = ["c_posn_straightahead", "c_posn_rightinfrontofus", "c_posn_aheadofus", "c_posn_front", "c_posn_deadahead"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["behind"] = ["c_posn_behindus", "c_posn_onoursix", "c_posn_checkrear", "c_posn_rear"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["high"] = ["c_posn_uptop", "c_posn_checkhigh", "c_posn_coverup"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["using_rpg"] = ["c_atac_rocket", "c_atac_rocket_01"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["attacking"] = ["c_atac_goinghot", "c_atac_engaging", "c_atac_openinup"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["using_smoke"] = ["c_atac_throwingsmoke", "c_atac_smokeout"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["using_flash"] = ["c_atac_flashbangout", "c_atac_throwingflashbang"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["using_grenade"] = ["c_atac_fragout", "c_atac_throwingafrag"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["using_molotov"] = ["c_atac_throwingmolotov", "c_atac_molotovout"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["use_flash"] = ["c_ator_useaflashbang", "c_ator_throwaflashbang", "c_ator_tossaflashbang"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["use_grenade"] = ["c_ator_useagrenade", "c_ator_throwafrag", "c_ator_tossafrag"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["use_molotov"] = ["c_ator_throwamolotov", "c_ator_useamolotov", "c_ator_tossamolotov"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["use_rpg"] = ["c_ator_hitemwitharocket", "c_ator_usearocket", "c_ator_rocket"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["order_attack"] = ["c_ator_engage", "c_ator_giveemsome", "c_ator_dumpem", "c_ator_gohot", "c_ator_youreclearedhot", "c_ator_fuckinshootem", "c_ator_startsmokinem"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["attack_orders"] = ["c_ator_king", "c_ator_adams", "c_ator_baker", "c_ator_barry", "c_ator_billy", "c_ator_chapman", "c_ator_colin", "c_ator_edwards", "c_ator_fisher", "c_ator_george", "c_ator_grant", "c_ator_hall", "c_ator_james", "c_ator_matthews", "c_ator_morgan", "c_ator_parker", "c_ator_richards", "c_ator_roberts", "c_ator_shaw", "c_ator_stevens", "c_ator_thomas", "c_ator_turner", "c_ator_williams", "c_ator_actual"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["movingup"] = ["c_tcac_impushingup", "c_tcac_pushingforward", "c_tcac_movingup", "c_tcac_pushinup"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["getting_cover"] = ["c_tcac_covercover", "c_tcac_takingcover", "c_tcac_movingtocover"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["reloading"] = ["c_tcac_reloading", "c_tcac_changingmags"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["moving"] = ["c_tcac_moving", "c_tcac_immoving", "c_tcac_heyimmoving"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["enemy_using_flash"] = ["c_eata_flashincoming", "c_eata_flashgrenade", "c_eata_flash", "c_eata_flashgrenade_01"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["enemy_using_grenade"] = ["c_eata_grenade", "c_eata_grenadewatchout", "c_eata_grenadeincoming"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["enemy_using_molotov"] = ["c_eata_molotov", "c_eata_molotovincoming", "c_eata_molotov_01"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["enemy_using_rpg"] = ["c_eata_rpg", "c_eata_rpgincoming", "c_eata_rpggetdown"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["enemy_attacking"] = ["c_eata_takingfire", "c_eata_contact", "c_eata_troopsincontact"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["enemy_moving_up"] = ["c_etca_onespushing", "c_etca_gotonemovingup", "c_etca_onesmovingup"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["enemy_getting_cover"] = ["c_etca_novisualontarget", "c_etca_gotonetakingcover", "c_etca_onesmovingtocover", "c_etca_novisualontarget_01"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["enemy_reloading"] = ["c_etca_onesreloading", "c_etca_onesreloading_01", "c_etca_oneschangingmags"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["enemy_flanking_left"] = ["c_etca_onesmovingleft", "c_etca_leftflank", "c_etca_guardleft"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["enemy_flanking_right"] = ["c_etca_guardright", "c_etca_rightflank", "c_etca_onesmovingright"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["enemy_moving"] = ["c_etca_onesmovin", "c_etca_thatonesmoving", "c_etca_gotonemoving"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["target_getting_cover"] = ["c_ttca_theyremovingtocover", "c_ttca_theyregoingforcover", "c_ttca_theyretakingcover"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["target_reloading"] = ["c_ttca_theyrereloading", "c_ttca_theyrereloading_01", "c_ttca_thebastardsreloading"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["target_moving"] = ["c_ttca_theyremoving", "c_ttca_hesmoving", "c_ttca_hesrunning"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["target_moving_up"] = ["c_ttca_theyremovingup", "c_ttca_hescominguponyou", "c_ttca_hesmovingup"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["target_near_patrol"] = ["c_ttca_theyreswimmingnearth", "c_ttca_theyreswimmingyourwa", "c_ttca_interceptthem"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["enemy_soldier"] = ["c_enmy_visualonatarget", "c_enmy_targetspotted", "c_enmy_gotatarget"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["enemy_soldiers"] = ["c_enmy_targets", "c_enmy_xrays", "c_enmy_hostiles"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["neg_target"] = ["c_aqen_idontseeem", "c_aqen_novisual", "c_aqen_cantseehim", "c_aqen_wherethefuckishe"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["aquired_target"] = ["c_aqen_gotavisual", "c_aqen_targetacquired", "c_aqen_iseeem", "c_aqen_theyrerightthere"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["enemy_exposed"] = ["c_exco_onesintheopen", "c_exco_onesintheopen_01", "c_exco_gotoneintheopen"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["target_exposed"] = ["c_exco_theyreintheopen", "c_exco_thatonesintheopen", "c_exco_theyreintheopen_01"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["youre_exposed"] = ["c_exco_findcover"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["target_covered"] = ["c_exco_theyrebehindcover", "c_exco_theyvegotcover", "c_exco_theyretakingcover"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["killfirm_enemy"] = ["c_firm_gotone", "c_firm_hostiledown", "c_firm_xraydown"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["killfirm_target"] = ["c_firm_theyredone", "c_firm_theyredown", "c_firm_sortedem"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["casualties"] = ["c_casu_weretakingheavies", "c_casu_weregettingourassesk", "c_casu_werelosingshooters", "c_casu_weretakingcasualties"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["copy"] = ["c_conf_copy", "c_conf_check", "c_conf_copythat", "c_conf_goodcopy", "c_conf_solidcopy", "c_aqcp_copy", "c_aqcp_solidcopy"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["praise"] = ["c_pras_hellyeah", "c_pras_niceonemate", "c_pras_fuckina", "c_pras_yeah", "c_pras_thatlldo"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["low_ammo"] = ["c_stat_ineedamag", "c_stat_lowonammo", "c_stat_lastmag", "c_stat_needammo", "c_stat_imwinchester"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["wounded"] = ["c_stat_imhit", "c_stat_imshot", "c_stat_medic"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["ask_wounded"] = ["c_stat_yougood", "c_stat_youwounded", "c_stat_youhit"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["ask_low_ammo"] = ["c_stat_howsyourammo", "c_stat_checkyourammo", "c_stat_whatsyourroundcount"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["ask_status"] = ["c_stat_youokay", "c_stat_whatsyourstatus", "c_stat_status"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["reply_wounded"] = ["c_stat_itookaround", "c_stat_imgood", "c_stat_yeahroundhittheplate"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["reply_low_ammo"] = ["c_stat_runninglow", "c_stat_imlow", "c_stat_almostout"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["reply_okay"] = ["c_stat_imsolid", "c_stat_goodtogo", "c_stat_goodhere"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["wounded_enemy"] = ["c_aens_igothim", "c_aens_clippedhim", "c_aens_hitone"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["ask_target_loc"] = ["c_tast_wheresheat", "c_tast_doesanyonehaveavisua", "c_tast_wherethefuckretheyat"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["ask_target_wounded"] = ["c_tast_yougethim", "c_tast_youhithim", "c_tast_youdrophim"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["target_wounded"] = ["c_tast_heshit", "c_tast_heswounded", "c_tast_hesbleeding"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["target_unhurt"] = ["c_tast_hegotaway", "c_tast_heranoff", "c_tast_hesfallingback"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["wounded_target"] = ["c_atas_woundedhim", "c_atas_ihithim", "c_atas_itaggedem"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["enemy_shotgun"] = ["c_enws_shotgunwatchout", "c_enws_onesgotashotgun", "c_enws_shotgun"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["enemy_sniper"] = ["c_enws_thatsasniper", "c_enws_sniper", "c_enws_enemysniper"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["enemy_lmg"] = ["c_enws_enemymachinegunner", "c_enws_lmg", "c_enws_machinegun"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["target_lmg"] = ["c_taws_theyreusingamachineg", "c_taws_hesgotamachinegun", "c_taws_machinegunner"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["target_shotgun"] = ["c_taws_theyvegotashotgun", "c_taws_hesgotashotgun"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["target_sniper"] = ["c_taws_hessnipingus", "c_taws_hesasniper"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["checkfire"] = ["c_chck_checkyourfire", "c_chck_watchyourfire", "c_chck_blueblue", "c_chck_checkfirecheckfire"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["move"] = ["c_tcor_move", "c_tcor_igotyoumove", "c_tcor_startmoving", "c_tcor_go"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["moveup"] = ["c_tcor_moveup", "c_tcor_moveupgo", "c_tcor_pushup", "c_tcor_getupthere", "c_tcor_pushforward"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["coverme"] = ["c_tcor_coverme", "c_tcor_ineedcoverfire", "c_tcor_coverme_01"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["casualty_name_generic"] = ["c_canm_wegotacasualty", "c_canm_mandown", "c_canm_wehaveamandown", "c_canm_wevegotwounded", "c_canm_wevegotasoldierdown"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["hostile_burst"] = ["c_hsbr_yeahnoshit", "c_hsbr_captainfuckinobvious", "c_hsbr_shutthefuckup", "c_hsbr_youthink"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["suppressing"] = ["c_aqsp_suppressingfirefallb", "c_aqsp_suppressingfire", "c_aqsp_imcoveringyou", "c_aqsp_coveringfire"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["react_first_combat"] = ["s_awrr_troopsincontact", "s_awrr_contact", "s_awrr_enemymyposition", "s_awrr_enemy", "s_awrr_enemyshere", "s_awrr_gotenemyhere", "s_awrr_enemysclose"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_name"] = ["s_idnm_king", "s_idnm_adams", "s_idnm_baker", "s_idnm_barry", "s_idnm_billy", "s_idnm_chapman", "s_idnm_colin", "s_idnm_edwards", "s_idnm_fisher", "s_idnm_george", "s_idnm_grant", "s_idnm_hall", "s_idnm_james", "s_idnm_matthews", "s_idnm_morgan", "s_idnm_parker", "s_idnm_richards", "s_idnm_roberts", "s_idnm_shaw", "s_idnm_stevens", "s_idnm_thomas", "s_idnm_turner", "s_idnm_williams", "s_idnm_actual"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["reply_hear_you"] = ["s_idrp_sendtraffic", "s_idrp_copygoahead", "s_idrp_imhere", "s_idrp_goahead"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["resp_patrol"] = ["s_idrp_thisisthresher", "s_ahrp_thisisthresher"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["muttered_confusion"] = ["s_idin_whatsthat", "s_idin_whatthehellwasthat", "s_idin_thebleedinhellwastha", "s_idin_whatthehell"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["inv_arrive"] = ["s_idin_huhwhatwasthat", "s_idin_hmphokay", "s_idin_hmm", "s_idin_huhthehell", "s_idin_hrm"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["investigating"] = ["s_idin_illgocheck", "s_idin_illcheckitout", "s_idin_illseewhatsup"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_conf_name"] = ["s_idcn_king", "s_idcn_adams", "s_idcn_baker", "s_idcn_barry", "s_idcn_billy", "s_idcn_chapman", "s_idcn_colin", "s_idcn_edwards", "s_idcn_fisher", "s_idcn_george", "s_idcn_grant", "s_idcn_hall", "s_idcn_james", "s_idcn_matthews", "s_idcn_morgan", "s_idcn_parker", "s_idcn_richards", "s_idcn_roberts", "s_idcn_shaw", "s_idcn_stevens", "s_idcn_thomas", "s_idcn_turner", "s_idcn_williams", "s_idcn_actual"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["react_found_corpse"] = ["s_alrc_wehaveasoldierdown", "s_alrc_oneofoursiskia", "s_alrc_gotamandown", "s_alrc_wevegotacasualty"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["ask_corpse_name"] = ["s_alrc_whodidwelose", "s_alrc_who", "s_alrc_whoisit"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["need_backup"] = ["s_alrc_sendreinforcements", "s_alrc_ineedreinforcements", "s_albc_sendreinforcements"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["hunt_name"] = ["s_hnnm_king", "s_hnnm_adams", "s_hnnm_baker", "s_hnnm_barry", "s_hnnm_billy", "s_hnnm_chapman", "s_hnnm_colin", "s_hnnm_edwards", "s_hnnm_fisher", "s_hnnm_george", "s_hnnm_grant", "s_hnnm_hall", "s_hnnm_james", "s_hnnm_matthews", "s_hnnm_morgan", "s_hnnm_parker", "s_hnnm_richards", "s_hnnm_roberts", "s_hnnm_shaw", "s_hnnm_stevens", "s_hnnm_thomas", "s_hnnm_turner", "s_hnnm_williams", "s_hnnm_actual"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["hunt_copy"] = ["s_hnrs_copy", "s_hnrs_rogerthat", "s_hnrs_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["react_whizby"] = ["s_unrc_imtakingfire", "s_unrc_imgettingshotat", "s_unrc_takineffectivefire", "s_unrc_someonesshootinatme", "s_unrc_thatsclose"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["react_unaware"] = ["s_unrc_takingcontact", "s_unrc_takingindirectfire", "s_unrc_contactcontact"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["over_there"] = ["s_hnfn_overthere", "s_hnfn_theyreoverthere", "s_hnfn_rightthere"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["surprise"] = ["s_hurc_surprisedeffort", "s_hurc_surprisedeffort_01", "s_hurc_surprisedeffort_02", "s_hurc_bollocks", "s_hurc_ohshit"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["report_reply_idle"] = ["s_idrr_gotnothing", "s_idrr_secure", "s_idrr_clearhere", "s_idrr_allclear", "s_idrr_goodhere", "s_idrr_allquiet", "s_idrr_areassecure"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["react_first"] = ["s_idrc_huh", "s_idrc_hmph", "s_idrc_hrm", "s_idrc_eh", "s_idrc_hm", "s_idrc_wha"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["react_second"] = ["s_idrc_yourebloodyjokingwha", "s_idrc_thebloodyhellisgoing", "s_idrc_whatthehellisthat"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["react_multi"] = ["s_idrm_whosoutthere", "s_idrm_okaywhatthefuck", "s_idrm_whatisthisshit"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["react_interrupt"] = ["s_idli_missedyourlastover", "s_idli_yougood", "s_idli_sayagainover"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["react_noreply"] = ["s_idli_doyoureadme", "s_idli_youcopy", "s_idli_youreceivingme"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["order_investigate"] = ["s_idio_gocheckit", "s_idio_checkitout", "s_idio_gocheckthatout"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["confirming"] = ["s_idlc_roger", "s_idlc_copy", "s_idlc_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["inv_ask_first"] = ["s_idia_whatwasit", "s_idia_findanything", "s_idia_seeanything", "s_idia_yougotanything", "s_idia_whatdyoufind"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["inv_ask_second"] = ["s_idia_stillnothing", "s_idia_anythingthistime", "s_idia_whatwasitthistime", "s_idia_findanythingthistime", "s_idia_stilldidntfindanythi"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["resp_sound_first"] = ["s_idir_nothingnovisual", "s_idir_nahweresecure", "s_idir_negativewereclear", "s_idir_nothingnobody"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["order_check_together"] = ["s_idit_letsgocheckitout", "s_idit_letscheckitwatchmyba", "s_idit_letsgocheckcoverme"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["covering_investigate"] = ["s_idit_covering", "s_idit_imwithyou", "s_idit_gotyoucovered"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["team_return_idle"] = ["s_idid_okayletsheadback", "s_idid_weregoodhereletsgetb", "s_idid_backtoourpostsletsgo"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["alert_corpse_name"] = ["s_alcn_itsking", "s_alcn_itsadams", "s_alcn_itsbaker", "s_alcn_itsbarry", "s_alcn_itsbilly", "s_alcn_itschapman", "s_alcn_itscolin", "s_alcn_itsedwards", "s_alcn_itsfisher", "s_alcn_itsgeorge", "s_alcn_itsgrant", "s_alcn_itshall", "s_alcn_itsjames", "s_alcn_itsmatthews", "s_alcn_itsmorgan", "s_alcn_itsparker", "s_alcn_itsrichards", "s_alcn_itsroberts", "s_alcn_itsshaw", "s_alcn_itsstevens", "s_alcn_itsthomas", "s_alcn_itsturner", "s_alcn_itswilliams"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["ask_heard_that"] = ["s_alre_youhearthat", "s_alre_youheardthattoo", "s_alre_youheardthatright"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["ask_saw_that"] = ["s_alre_didyouseethat", "s_alre_yougeteyesonthat", "s_alre_youcatchthat"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["have_something"] = ["s_alre_imighthavesomething", "s_alre_ithinkihavesomething", "s_alre_igotapossiblethreat"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["heard_something"] = ["s_alre_iheardsomething", "s_alre_heardsomethingnearme", "s_alre_iheardanoise"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["saw_something"] = ["s_alre_isawsomething", "s_alre_thoughtisawsomething", "s_alre_ithinksomeonesnearme"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["react_resp"] = ["s_alrr_yeah", "s_alrr_afirm", "s_alrr_yeahrogerthat"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["alert_ask"] = ["s_alia_seeanything", "s_alia_yougotsomething", "s_alia_anything", "s_alia_gotanything"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["alert_patrol"] = ["s_alip_illpullsecurityheret", "s_alip_illsecuretheareakeep", "s_alip_headbackillpullsecur", "s_alip_ivegotthisareagetbac"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["report_reply_search"] = ["s_alir_negativenothingyet", "s_alir_nothingfornow", "s_alir_negativegotnothing", "s_alir_notseeinganything", "s_alir_sofarsogood", "s_alir_igotnothingyet", "s_alir_goodsofar", "s_alir_nothing", "s_alir_nothingsofar", "s_alir_weregoodfornow", "s_alir_itsclearsofar"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["warn_spotted"] = ["s_wrnf_heygetthefuckback", "s_wrnf_heyyougetthefuckoutt", "s_wrnf_getbackgetbackrightn"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["warn_report"] = ["s_wrnr_hadanunknowninsideth", "s_wrnr_hadanunknowninsideth_01", "s_wrnr_anunknownwasintheare"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["warn_conv"] = ["s_wrni_scaredthehelloutofem", "s_wrni_probablyshittingthem", "s_wrni_whatthehellweretheyd", "s_wrni_whatthefuckweretheyt"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["warn_conv_reply"] = ["s_wrir_almostgotthemselvesk", "s_wrir_iwasreadytodumpthatm", "s_wrir_luckytheydidntcatcha"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["warn_attack"] = ["s_wrnk_heyiwarnedyou", "s_wrnk_youwerewarned", "s_wrnk_heyyoujustfuckedup"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["ask_enemy_loc"] = ["s_unwl_wheredthatcomefrom", "s_unwl_whereditcomefrom", "s_unwl_wherethehellarethey"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["enemy_loc_resp"] = ["s_unrs_idontknowbutthatwasa", "s_unrs_ididntseeem", "s_unrs_idontbloodyknow", "s_unrs_novisualdidntseeem"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["report_target_water"] = ["s_awrr_targetsinthewater", "s_awrr_gotavisualtheyreinth", "s_awrr_iseeeminthewater", "s_awrr_inthewaterinthewater", "s_awrr_enemyinthewater", "s_awrr_theyremovinginthewat", "s_awrr_heytheyreinthewater"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["at_my_location"] = ["s_awrr_righthere", "s_awrr_onmeonme", "s_awrr_myposition", "s_awrr_righthererighthere", "s_awrr_onme", "s_awrr_theyrerighthere", "s_awrr_overhere", "s_awrr_theyreoverhere"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["found_target"] = ["s_awrr_gotem", "s_awrr_iseeem", "s_awrr_foundem", "s_awrr_hey", "s_awrr_visual", "s_awrr_targetspotted"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["found_you"] = ["s_awrr_iseeyoubastard", "s_awrr_foundyou", "s_awrr_igotyou", "s_awrr_gotyou", "s_awrr_ifoundyou"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["order_check_last"] = ["s_advo_moveonemgo", "s_advo_forceuponemgo", "s_advo_pushtheirpositiongo"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["lost_target"] = ["s_lkpl_frustratedgrunttheyr", "s_lkpl_frustratedgrunttheyr_01", "s_lkpl_frustratedgruntnovis", "s_lkpl_frustratedgrunttheyg"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["lost_target_water"] = ["s_lkpw_theywentunderwater", "s_lkpw_theyreinthewater", "s_lkpw_theyjumpedinthewater", "s_lkpw_targetsinthewater"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["ask_target_location"] = ["s_lklr_gotavisual", "s_lklr_youseeem", "s_lklr_whatstheirlocation", "s_lklr_wherearethey", "s_lklr_wherethefuckarethey", "s_lklr_getmealocation"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["target_still_close"] = ["s_lkpc_theywerehere", "s_lkpc_theywererighthere", "s_lkpc_theycantbefar", "s_lkpc_theyreclose", "s_lkpc_theyrehiding", "s_lkpc_theygottabeclose", "s_lkpc_theydidntmakeitfar", "s_lkpc_theyrestillheresomew"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["clearing_east"] = ["s_cmhs_checkingeast", "s_cmhs_securingeast", "s_cmhs_movingeast"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["clearing_west"] = ["s_cmhs_checkingwest", "s_cmhs_securingwest", "s_cmhs_movingwest"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["clearing_south"] = ["s_cmhs_securingsouth", "s_cmhs_movingsouth", "s_cmhs_checkingsouth"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["clearing_north"] = ["s_cmhs_securingnorth", "s_cmhs_movingnorth", "s_cmhs_checkingnorth"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["good_hunting"] = ["s_hnts_staysharp", "s_hnts_stayfrosty", "s_hnts_keepittight"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["moving"] = ["s_hntm_movingnow", "s_hntm_moving", "s_hntm_movingtherenow"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["moving_alone"] = ["s_hntm_iminbound", "s_hntm_immoving", "s_hntm_immovingnow"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["ask_found_anything"] = ["s_aqhr_gotanything", "s_aqhr_findanything", "s_aqhr_gotavisual", "s_aqhr_anyvisual", "s_aqhr_whatdoyougot", "s_aqhr_yougotsomething"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["reply_found_nothing"] = ["s_aqhr_novisualonthetarget", "s_aqhr_nosignofem", "s_aqhr_novisual"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["report_investigating"] = ["s_aqhr_immovingin", "s_aqhr_imcheckingitout", "s_aqhr_movingtosecure"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["area_clear"] = ["s_aqhr_thisareassecure", "s_aqhr_securehere", "s_aqhr_areasecure"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["order_dir"] = ["s_aqhs_securethatarea", "s_aqhs_checkthatway", "s_aqhs_cordonthatarea", "s_aqhs_clearthatarea"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["order_dir_resp"] = ["s_aqhs_illsearchthisway", "s_aqhs_illcheckoverhere", "s_aqhs_illtakethisway", "s_aqhs_illsecurethisarea"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["hunt"] = ["s_aqhb_wherethefuckareyou", "s_aqhb_motherfuckers", "s_aqhb_yourehidingiknowyour", "s_aqhb_youreheresomewherear", "s_aqhb_comeonout", "s_aqhb_gonnafindyou", "s_aqhb_wheredyoufuckinggo"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["hunt_reactions"] = ["s_ahnr_surprisedinttenserea", "s_ahnr_surprisedinttenserea_01", "s_ahnr_surprisedinttenserea_02"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["cmb_reactions"] = ["s_aqcr_surprisedinttenserea", "s_aqcr_surprisedinttenserea_01", "s_aqcr_surprisedinttenserea_02"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["whizby_resp"] = ["s_aqal_itcamefromoverthere", "s_aqal_itcamefromthatway", "s_aqal_itwasfromoverthere"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["hunt_cornercheck"] = ["s_aqho_checkyourcorners", "s_aqho_checkthosecorners", "s_aqho_checkcornersfindem"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["hunt_order_hold"] = ["s_aqho_hold", "s_aqho_standfast", "s_aqho_holdup"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["alert_search_orders"] = ["s_aqao_searchoverthere", "s_aqao_checkoverthere", "s_aqao_gothatway", "s_aqao_checkthatway", "s_aqao_securethatarea", "s_aqao_searchthatway"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["attack_orders"] = ["s_aato_thresher"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["hunt_report_alert"] = ["s_aqlo_cordonandsearchthear", "s_aqlo_fanoutsearchthearea", "s_aqlo_cordonofftheareafind"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_solo"] = [];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_solo"][0] = ["s_idsl_alqatalatakesoveralm", "s_idsl_devgruandkortacmovei", "s_idsl_alongcomeswhitelotus", "s_idsl_blackmous", "s_idsl_legionwellweknowwhat", "s_idsl_thencrowngetsinvolve", "s_idsl_soaqbringinthecartel", "s_idsl_cartelsetsupshop", "s_idsl_thosecowboysfollowem", "s_idsl_andnowyouhavethispha", "s_idsl_somewouldcallthatapr", "s_idsl_icallitatargetrichen"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_solo"][1] = ["s_idsl_sharpenup", "s_idsl_complacencykills", "s_idsl_youknowthemomentyoug", "s_idsl_somelittlefuckerisgo", "s_idsl_sostaysharp", "s_idsl_dontletemgetthedropo", "s_idsl_wellbedoneherebefore"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_solo"][2] = ["s_idsl_cartelandaq", "s_idsl_neverthoughtidliketo", "s_idsl_shouldhavejuststayed", "s_idsl_orchosenothergroupst", "s_idsl_morecapablegroups", "s_idsl_bestsmugglersinthewo", "s_idsl_iftheyweresmarttheyd", "s_idsl_anyonewhoworkswithaq"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_solo"][3] = ["s_idsl_shouldnthavecomehere", "s_idsl_theterrorists", "s_idsl_thecartel", "s_idsl_andalltherestofem", "s_idsl_gonnaridthisplaceofy"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_solo"][4] = ["s_idsl_imapeacekeepingsoldi", "s_idsl_imapeacekeepingsoldi_01", "s_idsl_imapeacekeepingsoldi_02", "s_idsl_imaviolentbastardand"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_solo"][5] = ["s_idsl_shouldntbemuchlonger", "s_idsl_anotherhour", "s_idsl_maybetwo", "s_idsl_thenyoucangetsomeshu", "s_idsl_orasmoke", "s_idsl_justwatchyourcorners", "s_idsl_dontgetsloppy"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_solo"][6] = ["s_idsl_hummingasong", "s_idsl_hummingasong_01", "s_idsl_hummingasong_02"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_solo"][7] = ["s_idsl_clear", "s_idsl_justlikethelasttime", "s_idsl_fiftypoundssaysitscl", "s_idsl_gonnabearichmanbythe"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_solo"][8] = ["s_idsl_touchpointpull", "s_idsl_drivetoeyeline", "s_idsl_lockin", "s_idsl_squeezetrigger", "s_idsl_recoiltargetsdown", "s_idsl_bobsyouruncle"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_convo"] = [];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_conv"][0] = ["s_idcv_wherewereyoubeforeth", "s_idcv_allover", "s_idcv_everbeentourzikstan", "s_idcv_yeahgotfamilythere", "s_idcv_wellthatmakestwoofus", "s_idcv_smallworldeh", "s_idcv_toorightmate"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_conv"][1] = ["s_idcv_youseenanycartelarou", "s_idcv_negative", "s_idcv_youknowthebosselsinn", "s_idcv_whataboutem", "s_idcv_ihearitsawoman", "s_idcv_okay", "s_idcv_imjustsaying", "s_idcv_yeahiknowwhatyouresa", "s_idcv_dontreadintoitmateju", "s_idcv_okaywithwhat", "s_idcv_yknowengaging", "s_idcv_youhavinalaugh", "s_idcv_whenthetimecomesyouc", "s_idcv_ifthetimecomesshellb"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_conv"][2] = ["s_idcv_queencapturesrookh8", "s_idcv_rooktod3", "s_idcv_queentoa8", "s_idcv_pawnc3", "s_idcv_queentoa4check", "s_idcv_kingtoe1", "s_idcv_pawntof4", "s_idcv_sneakybastardpawntof", "s_idcv_kingc1", "s_idcv_rooktod2", "s_idcv_queentoa7resign", "s_idcv_pissoff"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_conv"][3] = ["s_idcv_interrogative", "s_idcv_goahead", "s_idcv_whydidthechickencros", "s_idcv_fuckinhellwhy", "s_idcv_togettotheidiotshous", "s_idcv_whosthere", "s_idcv_thechicken"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_conv"][4] = ["s_idcv_gotanything", "s_idcv_negativeyou", "s_idcv_nothing", "s_idcv_letsgiveittenthenswe", "s_idcv_wegotreconup", "s_idcv_airassetshavebeentas", "s_idcv_sowereourownrecongot"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_conv"][5] = ["s_idcv_latestintelshowsaqan", "s_idcv_howmanyfighters", "s_idcv_adozenmaybemore", "s_idcv_wecanhandlethat", "s_idcv_itsnotthemimconcerne", "s_idcv_whothen", "s_idcv_everyoneelse", "s_idcv_yourenotgettingsofto", "s_idcv_theresadifferencebet", "s_idcv_justkeepyourweaponre", "s_idcv_wecouldusereinforcem", "s_idcv_mostofourassetsareti", "s_idcv_yougoodonweaponsanda", "s_idcv_toppedoffandrightasr", "s_idcv_okayletsstaysharp"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_conv"][6] = ["s_idcv_clear", "s_idcv_allclear", "s_idcv_watchforgreensmoketh", "s_idcv_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_conv"][7] = ["s_idcv_impullingrecceyester", "s_idcv_aqorcartel", "s_idcv_neithersotheyresetti", "s_idcv_howfar", "s_idcv_around800meterssothe", "s_idcv_areconteam", "s_idcv_negativeitwascivilia", "s_idcv_noshitwhatdyoudo", "s_idcv_whatihadtoiwatchedit", "s_idcv_welldonttellmewhowon"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_conv"][8] = ["s_idcv_anysignofaqorcartel", "s_idcv_heardsomethinggoingd", "s_idcv_rogerthatmakesureyou", "s_idcv_wayaheadofyou", "s_idcv_letskeepaneyeonthata", "s_idcv_copymaybewellseesome", "s_idcv_anymovementandyoucal", "s_idcv_solidcopy"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK"]["idle_conv"][9] = ["s_idcv_wehitanaqstrongholdl", "s_idcv_anycasualties", "s_idcv_noneitwasmint", "s_idcv_actionableintel", "s_idcv_unknownatthistime", "s_idcv_maybeitcanleadustoth", "s_idcv_lookedliketheyhadint", "s_idcv_evenus", "s_idcv_wellsee", "s_idcv_soundslikeweneedtohi"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["report_idle"] = ["s_irpr_gotanything", "s_irpr_status", "s_irpr_sitrep", "s_irpr_yougood", "s_irpr_report"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["idle_name"] = ["s_idnm_king", "s_idnm_adams", "s_idnm_baker", "s_idnm_barry", "s_idnm_billy", "s_idnm_chapman", "s_idnm_colin", "s_idnm_edwards", "s_idnm_fisher", "s_idnm_george", "s_idnm_grant", "s_idnm_hall", "s_idnm_james", "s_idnm_matthews", "s_idnm_morgan", "s_idnm_parker", "s_idnm_richards", "s_idnm_roberts", "s_idnm_shaw", "s_idnm_stevens", "s_idnm_thomas", "s_idnm_turner", "s_idnm_williams"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["reply_hear_you"] = ["s_idrp_rogergoahead", "s_idrp_thisisactualgoahead", "s_idrp_goahead", "s_idrp_go", "s_idrp_goforactual", "s_idrp_thisisactual"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["idle_conf_name"] = ["s_idcn_doyoucopy", "s_idcn_king", "s_idcn_adams", "s_idcn_baker", "s_idcn_barry", "s_idcn_billy", "s_idcn_chapman", "s_idcn_colin", "s_idcn_edwards", "s_idcn_fisher", "s_idcn_george", "s_idcn_grant", "s_idcn_hall", "s_idcn_james", "s_idcn_matthews", "s_idcn_morgan", "s_idcn_parker", "s_idcn_richards", "s_idcn_roberts", "s_idcn_shaw", "s_idcn_stevens", "s_idcn_thomas", "s_idcn_turner", "s_idcn_williams"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["hunt_name"] = ["s_hnnm_king", "s_hnnm_adams", "s_hnnm_baker", "s_hnnm_barry", "s_hnnm_billy", "s_hnnm_chapman", "s_hnnm_colin", "s_hnnm_edwards", "s_hnnm_fisher", "s_hnnm_george", "s_hnnm_grant", "s_hnnm_hall", "s_hnnm_james", "s_hnnm_matthews", "s_hnnm_morgan", "s_hnnm_parker", "s_hnnm_richards", "s_hnnm_roberts", "s_hnnm_shaw", "s_hnnm_stevens", "s_hnnm_thomas", "s_hnnm_turner", "s_hnnm_williams"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["react_noreply"] = ["s_idli_areyoureceivingme", "s_idli_doyoureadme", "s_idli_doyoucopy"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["react_interrupt"] = ["s_idli_missedyourlastsayaga", "s_idli_commscheck", "s_idli_sayagainyourlastover", "s_idli_areyougood", "s_idli_sayagainover", "s_idli_missedyourlastover"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["confirming"] = ["s_idlc_roger", "s_idlc_copy", "s_idlc_copythat"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["signoff"] = ["s_idls_out", "s_idls_actualout", "s_idls_staysharp", "s_idls_out_01"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["alert_corpse_name"] = ["s_alcn_itsking", "s_alcn_itsadams", "s_alcn_itsbaker", "s_alcn_itsbarry", "s_alcn_itsbilly", "s_alcn_itschapman", "s_alcn_itscolin", "s_alcn_itsedwards", "s_alcn_itsfisher", "s_alcn_itsgeorge", "s_alcn_itsgrant", "s_alcn_itshall", "s_alcn_itsjames", "s_alcn_itsmatthews", "s_alcn_itsmorgan", "s_alcn_itsparker", "s_alcn_itsrichards", "s_alcn_itsroberts", "s_alcn_itsshaw", "s_alcn_itsstevens", "s_alcn_itsthomas", "s_alcn_itsturner", "s_alcn_itswilliams"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["inv_patrol"] = ["s_alip_continueyourpatrolst", "s_alip_getbacktoyourrouteke", "s_alip_returntoyourpatrolke"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["wait_target_surface"] = ["s_lkwr_whentheygoforairtake", "s_lkwr_whentheycomeupyourec", "s_lkwr_whentheycomeupforair", "s_lkwr_waitforthemtocomeupt", "s_lkwr_waitforthemtosurface", "s_lkwr_theyllhavetosurfacew"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["order_find_target"] = ["s_cmho_weneedalocationonthe", "s_cmho_locatethetargetnow", "s_cmho_huntthemdown"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["order_find_perimeter"] = ["s_cmho_getthisarealockeddow", "s_cmho_securetheperimeter", "s_cmho_iwantthisarealockedd"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["order_search_water"] = ["s_cmho_searchthewater", "s_cmho_checkthewater", "s_cmho_theywereinthewater", "s_cmho_watchthewater", "s_cmho_keepyoureyesonthewat"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["good_hunting"] = ["s_hnts_goodhunting", "s_hnts_staysharpoutthere", "s_hnts_out", "s_aisg_copystaysharp"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["ask_found_anything"] = ["s_aqhr_whatsyourstatus", "s_aqhr_whatveyougot", "s_aqhr_givemeasitrep", "s_aqhr_sitrep", "s_aqhr_didyoufindanything", "s_aqhr_tellmeyouhavesomethi"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["hunt_report_alert"] = ["s_aqhr_allteamswehaveenemyi", "s_aqhr_allteamsperimeterisb", "s_aqhr_allteamsenemyisinsid", "s_aqlo_fanoutsecuretheperim", "s_aqlo_setcontainmentfindth", "s_aqlo_spreadoutsearchthear"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["order_stay_aware"] = ["s_aqho_dontletthesebastards", "s_aqho_keepyourguardup", "s_aqho_dontletyourguarddown"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["order_stay_alert"] = ["s_aqho_eyesopen", "s_aqho_keepittight", "s_aqho_staysharp"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["order_continue_search"] = ["s_aqho_keepsearchingthearea", "s_aqho_keepsweeping", "s_aqho_keeplookingforem"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["ask_how_copy"] = ["s_idcm_howcopy", "s_idcm_doyoucopy", "s_idcm_commscheck"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["inv_no_response"] = ["s_iinr_hesradiosilent", "s_iinr_hesnotresponding", "s_iinr_hesnotoncomms", "s_iinr_icantreachhim"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["inv_patrol_noresp"] = ["s_iinr_stingraydidntcheckin", "s_iinr_stingrayisntrespondi", "s_iinr_icantreachstingray", "s_iinr_stingrayisntoncomms"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["order_get_visual"] = ["s_iinr_ineedyoutocheckitout", "s_iinr_doyouhaveavisualonth", "s_iinr_checkitoutmakesureno", "s_iinr_seeifyoucanfindoutwh"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["report_search"] = ["s_aias_sitrep", "s_aias_whatsyourstatus", "s_aias_findanything", "s_aias_gotanything", "s_aias_status"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["report_alert"] = ["s_airp_allteamssharpenupwem", "s_airp_allteamstheperimeter", "s_airp_allteamspossibleenem", "s_airp_allteamssetsecurityw"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["warn_reply"] = ["s_wrpl_iftheyreturnyourecle", "s_wrpl_youseethemagainsortt", "s_wrpl_iftheyreturnyourecle_01"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["report_target_location"] = ["s_chrp_doesanyonehaveavisua", "s_chrp_talktomegentswhatsth", "s_chrp_cmonladsineedalocati", "s_chrp_allteamsdoyouhaveavi"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["ally_missing_multi"] = ["s_alms_multipleteamsarentre", "s_alms_anotherteamfailedtor", "s_alms_wevelostcontactwitha", "s_alms_anotherteamlostcomms"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["order_search_start"] = ["s_aior_searchthearea", "s_aior_pullsecuritysweepthe", "s_aior_securetheperimeter"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["order_report_back"] = ["s_aior_soundoffifyoufindsom", "s_aior_reportbackifyoufinda", "s_aior_usecommsifyoufindsom"];
  level.battlechatter._id_ED774F98C3EFAE87["RUK_L"]["hunt_patrol_noresp"] = ["s_hpnr_stingrayisntrespondi", "s_hpnr_stingraydidntcheckin", "s_hpnr_stingrayisntanswerin", "s_hpnr_icantreachstingray"];

  if(!scripts\common\utility::ismp()) {
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["enemy_moving_up"] = ["m_etca_onesgettingclose", "m_etca_onesmovingup"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["left"] = ["m_posn_ontheleft", "m_posn_leftside"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["right"] = ["m_posn_lookontheright", "m_posn_rightside"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["order_attack"] = ["m_ator_shootthem", "m_ator_attack", "m_ator_fireyourweapon"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["using_grenade"] = ["m_atac_throwinggrenade", "m_atac_grenadeout"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["attacking"] = ["m_atac_attacking", "m_atac_engaging", "m_atac_firing"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["movingup"] = ["m_tcac_immovingup", "m_tcac_movingforward", "m_tcac_movingup"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["reloading"] = ["m_tcac_changingmags", "m_tcac_imreloading"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["moving"] = ["m_tcac_moving", "m_tcac_immoving", "m_tcac_movingnow"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["getting_cover"] = ["m_tcac_takingcover", "m_tcac_movingtocover"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["enemy_using_flash"] = ["m_eata_flashbang", "m_eata_flashbangwatchout"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["enemy_using_grenade"] = ["m_eata_grenade", "m_eata_grenade_01", "m_eata_grenadegetback"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["enemy_using_rpg"] = ["m_eata_rpg", "m_eata_rocket"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["enemy_attacking"] = ["m_eata_imtakingfire", "m_eata_contact", "m_eata_takingeffectivefire"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["enemy_moving"] = ["m_etca_onesmoving", "m_etca_iseeonemoving"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["enemy_getting_cover"] = ["m_etca_theyretakingcover", "m_etca_enemytakingcover"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["enemy_reloading"] = ["m_etca_onesreloading", "m_etca_iseeonereloading"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["target_getting_cover"] = ["m_ttca_hesgoingforcover", "m_ttca_hestryingtohide"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["target_reloading"] = ["m_ttca_hesreloading", "m_ttca_hestryingtoreload"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["target_moving"] = ["m_ttca_hesmoving", "m_ttca_heyhesmoving"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["target_moving_up"] = ["m_ttca_hesmovingup", "m_ttca_hesmovingourway"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["enemy_soldiers"] = ["m_enmy_iseethem", "m_enmy_iseeenemies", "m_enmy_enemies"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["aquired_target"] = ["m_aqen_hesrightthere", "m_aqen_icanseehim", "m_aqen_ifoundhim"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["neg_target"] = ["m_aqen_where", "m_aqen_idontseeanyone", "m_aqen_whereishe"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["enemy_exposed"] = ["m_exco_onesoutofcover", "m_exco_gotoneintheopen", "m_exco_onesintheopenyouseeh"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["target_exposed"] = ["m_exco_hesoutofcover", "m_exco_hesmovingfromcover"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["youre_exposed"] = ["m_exco_takecover", "m_exco_gettocover", "m_exco_getbehindsomething"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["target_covered"] = ["m_exco_hesincover", "m_exco_hestakingcover"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["killfirm_enemy"] = ["m_firm_gotone", "m_firm_enemydown", "m_firm_downedone"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["killfirm_target"] = ["m_firm_ishothim", "m_firm_igothim"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["casualties"] = ["m_casu_werelosingmen", "m_casu_weregettingkilledout"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["copy"] = ["m_conf_copy", "m_conf_copythat", "m_conf_roger"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["low_ammo"] = ["m_stat_ineedammunition", "m_stat_ineedammo", "m_stat_whohasammo"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["wounded"] = ["m_stat_imhit", "m_stat_medic"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["wounded_enemy"] = ["m_aens_iwoundedone", "m_aens_ihitone"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["wounded_target"] = ["m_atas_heshurt", "m_atas_ihithim"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["coverme"] = ["m_tcor_coverme", "m_tcor_ineedcover"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["casualty"] = ["m_canm_dude", "m_canm_theykilledoneofours", "m_canm_theykilledhim"];
    level.battlechatter._id_ED774F98C3EFAE87["LVS"]["suppressing"] = ["m_aqsp_gotyoucovered", "m_aqsp_imcoveringyou"];
  }

  if(!scripts\common\utility::issp()) {
    return;
  }
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["left"] = ["m_posn_theyreflankingleft", "m_posn_leftside", "m_posn_left", "m_posn_checkleft"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["right"] = ["m_posn_rightside", "m_posn_theyreflankingright", "m_posn_right", "m_posn_checkright"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["order_attack"] = ["m_ator_engage", "m_ator_weaponsfree", "m_ator_dustem", "m_ator_weaponshot", "m_ator_openfire"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["using_smoke"] = ["m_atac_throwingsmoke", "m_atac_tossingsmokegrenade"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["using_flash"] = ["m_atac_flashout", "m_atac_throwingflashgrenade"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["using_grenade"] = ["m_atac_fragout", "m_atac_grenadeout"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["using_molotov"] = ["m_atac_throwingmolotov", "m_atac_molotovout"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["reloading"] = ["m_tcac_reloading", "m_tcac_changingmags"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["moving"] = ["m_tcac_moving"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["enemy_using_flash"] = ["m_eata_flashincoming"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["enemy_using_grenade"] = ["m_eata_grenade", "m_eata_grenademove", "m_eata_incoming"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["enemy_using_molotov"] = ["m_eata_molotov", "m_eata_molotovgetback"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["enemy_using_rpg"] = ["m_eata_rpg", "m_eata_rpgtakecover"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["enemy_attacking"] = ["m_eata_takingeffectivefire", "m_eata_contact", "m_eata_imtakingfire"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["enemy_soldier"] = ["m_enmy_xrayspotted", "m_enmy_xrayhere"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["enemy_soldiers"] = ["m_enmy_multiplexrays", "m_enmy_visualontargets", "m_enmy_multipletargets"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["aquired_target"] = ["m_aqen_gotavisual", "m_aqen_gotavisualonhim", "m_aqen_iseehim", "m_aqen_iseethebastard"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["neg_target"] = ["m_aqen_novisual", "m_aqen_idontseehim", "m_aqen_novisualonhim"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["enemy_exposed"] = ["m_exco_onesintheopen", "m_exco_onesintheopen_01", "m_exco_gotoneintheopen"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["youre_exposed"] = ["m_exco_findcover"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["target_exposed"] = ["m_exco_hesintheopen", "m_exco_theyreintheopen", "m_exco_hevemovingfromcover"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["target_covered"] = ["m_exco_hesbehindcover", "m_exco_hesgotcover", "m_exco_hestakingcover"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["killfirm_bigrig"] = ["m_firm_xraydown"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["killfirm_enemy"] = ["m_firm_droppedem", "m_firm_shooterdown"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["killfirm_target"] = ["m_firm_slottedthatone"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["killfirm_truck"] = ["m_firm_truckdestroyed", "m_firm_enemytruckdown"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["killfirm_helo"] = ["m_firm_helodestroyed", "m_firm_enemyhelodestroyed"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["praise"] = ["m_pras_nicelyfuckindone", "m_pras_fuckinbrilliant", "m_pras_thatllfuckindoit"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["low_ammo"] = ["m_stat_ammosrunninglow", "m_stat_imlowonammo"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["wounded"] = ["m_stat_imhit"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["enemy_sniper"] = ["m_enws_takingsniperfire", "m_enws_paineffortsniperstay"];
  level.battlechatter._id_ED774F98C3EFAE87["pric"]["checkfire"] = ["m_chck_checkyourbloodyfire", "m_chck_watchyourfire", "m_chck_paingruntbloodyhelly", "m_chck_paingrunthowdamoppet"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["left"] = ["m_posn_leftside", "m_posn_left", "m_posn_checkleft", "m_posn_theyreflankingleft"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["right"] = ["m_posn_rightside", "m_posn_theyreflankingright", "m_posn_right", "m_posn_checkright"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["order_attack"] = ["m_ator_engage", "m_ator_weaponsfree", "m_ator_shootem", "m_ator_weaponshot", "m_ator_openfire"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["using_smoke"] = ["m_atac_throwingsmoke", "m_atac_tossingsmokegrenade"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["using_flash"] = ["m_atac_flashout", "m_atac_throwingflashgrenade"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["using_grenade"] = ["m_atac_fragout", "m_atac_grenadeout"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["using_molotov"] = ["m_atac_throwingmolotov", "m_atac_molotovout"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["reloading"] = ["m_tcac_reloading", "m_tcac_changingmags"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["moving"] = ["m_tcac_moving"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["enemy_using_flash"] = ["m_eata_flashincoming"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["enemy_using_grenade"] = ["m_eata_grenade", "m_eata_grenademove", "m_eata_incoming"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["enemy_using_molotov"] = ["m_eata_molotov", "m_eata_molotovgetback"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["enemy_using_rpg"] = ["m_eata_rpg", "m_eata_rpgtakecover"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["enemy_attacking"] = ["m_eata_takingeffectivefire", "m_eata_contact", "m_eata_imtakingfire"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["enemy_soldier"] = ["m_enmy_threatspotted", "m_enmy_enemy"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["enemy_soldiers"] = ["m_enmy_enemies", "m_enmy_visualontargets", "m_enmy_multipletargets"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["aquired_target"] = ["m_aqen_gotavisual", "m_aqen_gotavisualonhim", "m_aqen_iseehim", "m_aqen_iseethebastard"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["neg_target"] = ["m_aqen_novisual", "m_aqen_idontseehim", "m_aqen_novisualonhim"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["enemy_exposed"] = ["m_exco_onesintheopen", "m_exco_onesintheopen_01", "m_exco_gotoneintheopen"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["youre_exposed"] = ["m_exco_findcover"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["target_exposed"] = ["m_exco_hesintheopen", "m_exco_theyreintheopen", "m_exco_hevemovingfromcover"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["target_covered"] = ["m_exco_hesbehindcover", "m_exco_hesgotcover", "m_exco_hestakingcover"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["killfirm_bigrig"] = ["m_firm_enemydown"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["killfirm_enemy"] = ["m_firm_droppedone", "m_firm_targetdown"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["killfirm_target"] = ["m_firm_gotthatsumbitch"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["killfirm_truck"] = ["m_firm_truckdestroyed", "m_firm_enemytruckdown"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["killfirm_helo"] = ["m_firm_tookouttheirhelo", "m_firm_enemyhelodestroyed"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["praise"] = ["m_pras_thatswhatimtalkinabo", "m_pras_hellyeah", "m_pras_nicefuckinwork"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["low_ammo"] = ["m_stat_imrunninglow", "m_stat_ammosgettinglow"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["wounded"] = ["m_stat_imhit"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["enemy_sniper"] = ["m_enws_takingsniperfire", "m_enws_paineffortsniperstay"];
  level.battlechatter._id_ED774F98C3EFAE87["grav"]["checkfire"] = ["m_chck_watchwhereyoureshoot", "m_chck_checkfire", "m_chck_dontshootatmedumbass", "m_chck_checkyourdamnfire"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["left"] = ["m_posn_leftside", "m_posn_left", "m_posn_checkleft", "m_posn_theyreflankingleft"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["right"] = ["m_posn_rightside", "m_posn_theyreflankingright", "m_posn_right", "m_posn_checkright"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["order_attack"] = ["m_ator_engage", "m_ator_weaponsfree", "m_ator_dustem", "m_ator_weaponshot", "m_ator_openfire"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["using_smoke"] = ["m_atac_throwingsmoke", "m_atac_tossingsmokegrenade"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["using_flash"] = ["m_atac_flashout", "m_atac_throwingflashgrenade"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["using_grenade"] = ["m_atac_fragout", "m_atac_grenadeout"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["using_molotov"] = ["m_atac_throwingmolotov", "m_atac_molotovout"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["reloading"] = ["m_tcac_reloading", "m_tcac_changingmags"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["moving"] = ["m_tcac_moving"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["enemy_using_flash"] = ["m_eata_flashincoming"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["enemy_using_grenade"] = ["m_eata_grenade", "m_eata_grenademove", "m_eata_incoming"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["enemy_using_molotov"] = ["m_eata_molotov", "m_eata_molotovgetback"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["enemy_using_rpg"] = ["m_eata_rpg", "m_eata_rpgtakecover"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["enemy_attacking"] = ["m_eata_takingeffectivefire", "m_eata_contact", "m_eata_imtakingfire"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["enemy_soldier"] = ["m_enmy_xrayspotted", "m_enmy_xrayhere"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["enemy_soldiers"] = ["m_enmy_multiplexrays", "m_enmy_visualontargets", "m_enmy_multipletargets"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["aquired_target"] = ["m_aqen_gotavisual", "m_aqen_gotavisualonhim", "m_aqen_iseehim", "m_aqen_iseethebastard"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["neg_target"] = ["m_aqen_novisual", "m_aqen_idontseehim", "m_aqen_novisualonhim"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["enemy_exposed"] = ["m_exco_onesintheopen", "m_exco_onesintheopen_01", "m_exco_gotoneintheopen"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["youre_exposed"] = ["m_exco_findcover"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["target_exposed"] = ["m_exco_hesintheopen", "m_exco_theyreintheopen", "m_exco_hevemovingfromcover"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["target_covered"] = ["m_exco_hesbehindcover", "m_exco_hesgotcover", "m_exco_hestakingcover"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["killfirm_bigrig"] = ["m_firm_xraydown"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["killfirm_enemy"] = ["m_firm_droppedem", "m_firm_droppedanxray"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["killfirm_target"] = ["m_firm_brassedemup"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["killfirm_truck"] = ["m_firm_truckdestroyed", "m_firm_enemytruckdown"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["killfirm_helo"] = ["m_firm_helodestroyed", "m_firm_enemyhelodestroyed"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["praise"] = ["m_pras_solidmate", "m_pras_niceone", "m_pras_fuckinright"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["low_ammo"] = ["m_stat_ammosrunninglow", "m_stat_imlowonammo"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["wounded"] = ["m_stat_imhit"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["enemy_sniper"] = ["m_enws_takingsniperfire", "m_enws_paineffortsniperstay"];
  level.battlechatter._id_ED774F98C3EFAE87["gazz"]["checkfire"] = ["m_chck_checkyourbloodyfire", "m_chck_watchyourfire", "m_chck_paingruntbloodyhellw", "m_chck_paingruntcheckfirech"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["using_molotov"] = ["m_atac_throwingmolotov", "m_atac_molotovout"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["left"] = ["m_posn_leftside", "m_posn_left", "m_posn_checkleft", "m_posn_theyreflankingleft"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["right"] = ["m_posn_rightside", "m_posn_theyreflankingright", "m_posn_right", "m_posn_checkright"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["order_attack"] = ["m_ator_engage", "m_ator_shootem", "m_ator_dropem", "m_ator_openup", "m_ator_openfire"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["using_smoke"] = ["m_atac_throwingsmoke", "m_atac_tossingsmokegrenade"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["using_flash"] = ["m_atac_flashout", "m_atac_throwingflashgrenade"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["using_grenade"] = ["m_atac_fragout", "m_atac_grenadeout"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["reloading"] = ["m_tcac_reloading", "m_tcac_changingmags"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["moving"] = ["m_tcac_moving"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["enemy_using_flash"] = ["m_eata_flashincoming"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["enemy_using_grenade"] = ["m_eata_grenade", "m_eata_grenademove", "m_eata_incoming"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["enemy_using_molotov"] = ["m_eata_molotov", "m_eata_molotovgetback"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["enemy_using_rpg"] = ["m_eata_rpg", "m_eata_rpgtakecover"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["enemy_attacking"] = ["m_eata_takingeffectivefire", "m_eata_contact", "m_eata_imtakingfire"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["enemy_soldier"] = ["m_enmy_targetspotted", "m_enmy_enemy"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["enemy_soldiers"] = ["m_enmy_multipletargets", "m_enmy_visualontargets", "m_enmy_enemies"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["aquired_target"] = ["m_aqen_gotavisual", "m_aqen_gotavisualonhim", "m_aqen_iseehim", "m_aqen_goteyeson"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["neg_target"] = ["m_aqen_novisual", "m_aqen_idontseehim", "m_aqen_cantfindhim"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["enemy_exposed"] = ["m_exco_onesintheopen", "m_exco_onesintheopen_01", "m_exco_gotoneintheopen"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["youre_exposed"] = ["m_exco_findcover"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["target_exposed"] = ["m_exco_hesintheopen", "m_exco_theyreintheopen", "m_exco_hevemovingfromcover"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["target_covered"] = ["m_exco_hesbehindcover", "m_exco_hesgotcover", "m_exco_hestakingcover"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["killfirm_bigrig"] = ["m_firm_targetdown"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["killfirm_enemy"] = ["m_firm_droppedem", "m_firm_enemydown"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["killfirm_target"] = ["m_firm_igotem"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["killfirm_truck"] = ["m_firm_theirtrucksdown", "m_firm_enemytruckdown"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["killfirm_helo"] = ["m_firm_helodestroyed", "m_firm_enemyhelodestroyed"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["praise"] = ["m_pras_goodworkhermano", "m_pras_ahuevo", "m_pras_niceone"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["low_ammo"] = ["m_stat_ammosrunninglow", "m_stat_imlowonammo"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["wounded"] = ["m_stat_imhit"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["enemy_sniper"] = ["m_enws_takingsniperfire", "m_enws_paineffortsniperstay"];
  level.battlechatter._id_ED774F98C3EFAE87["alej"]["checkfire"] = ["m_chck_checkfirecheckfire", "m_chck_heywatchyourfire", "m_chck_paingruntshoottheene", "m_chck_paingruntcheckyourfi"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["enemy_attacking"] = ["m_eata_imtakingfire", "m_eata_takingeffectivefire", "m_eata_contact"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["left"] = ["m_posn_leftside", "m_posn_left", "m_posn_checkleft", "m_posn_theyreflankingleft"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["right"] = ["m_posn_rightside", "m_posn_theyreflankingright", "m_posn_right", "m_posn_checkright"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["order_attack"] = ["m_ator_engage", "m_ator_shootem", "m_ator_dropem", "m_ator_openup", "m_ator_openfire"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["using_smoke"] = ["m_atac_throwingsmoke", "m_atac_tossingsmokegrenade"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["using_flash"] = ["m_atac_flashout", "m_atac_throwingflashgrenade"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["using_grenade"] = ["m_atac_fragout", "m_atac_grenadeout"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["using_molotov"] = ["m_atac_throwingmolotov", "m_atac_molotovout"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["reloading"] = ["m_tcac_reloading", "m_tcac_changingmags"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["moving"] = ["m_tcac_moving"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["enemy_using_flash"] = ["m_eata_flashincoming"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["enemy_using_grenade"] = ["m_eata_grenade", "m_eata_grenademove", "m_eata_incoming"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["enemy_using_molotov"] = ["m_eata_molotov", "m_eata_molotovgetback"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["enemy_using_rpg"] = ["m_eata_rpg", "m_eata_rpgtakecover"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["enemy_soldier"] = ["m_enmy_targetspotted", "m_enmy_enemy"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["enemy_soldiers"] = ["m_enmy_multipletargets", "m_enmy_visualontargets", "m_enmy_enemies"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["aquired_target"] = ["m_aqen_gotavisual", "m_aqen_gotavisualonhim", "m_aqen_iseehim", "m_aqen_goteyeson"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["neg_target"] = ["m_aqen_novisual", "m_aqen_idontseehim", "m_aqen_cantfindhim"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["enemy_exposed"] = ["m_exco_onesintheopen", "m_exco_onesintheopen_01", "m_exco_gotoneintheopen"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["youre_exposed"] = ["m_exco_findcover"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["target_exposed"] = ["m_exco_hesintheopen", "m_exco_theyreintheopen", "m_exco_hevemovingfromcover"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["target_covered"] = ["m_exco_hesbehindcover", "m_exco_hesgotcover", "m_exco_hestakingcover"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["killfirm_bigrig"] = ["m_firm_targetdown"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["killfirm_enemy"] = ["m_firm_droppedem", "m_firm_enemydown"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["killfirm_target"] = ["m_firm_igotem"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["killfirm_truck"] = ["m_firm_theirtrucksdown", "m_firm_enemytruckdown"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["killfirm_helo"] = ["m_firm_helodestroyed", "m_firm_enemyhelodestroyed"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["praise"] = ["m_pras_goodworkhermano", "m_pras_ahuevo", "m_pras_niceone"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["low_ammo"] = ["m_stat_ammosrunninglow", "m_stat_imlowonammo"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["wounded"] = ["m_stat_imhit"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["enemy_sniper"] = ["m_enws_takingsniperfire", "m_enws_paineffortsniperstay"];
  level.battlechatter._id_ED774F98C3EFAE87["rodo"]["checkfire"] = ["m_chck_checkfirecheckfire", "m_chck_heywatchyourfire", "m_chck_paingruntshoottheene", "m_chck_paingruntcheckyourfi"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["low_ammo"] = ["m_stat_ineedmags"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["left"] = ["m_posn_watchleft", "m_posn_theyreflankingleft"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["right"] = ["m_posn_watchright", "m_posn_theyreflankingright", "m_posn_checkright"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["order_attack"] = ["m_ator_engage", "m_ator_cutemdown", "m_ator_pickemoff"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["using_smoke"] = ["m_atac_throwingsmoke", "m_atac_tossingsmokegrenade"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["using_flash"] = ["m_atac_flashout", "m_atac_throwingflashgrenade"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["using_grenade"] = ["m_atac_fragout", "m_atac_grenadeout"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["using_molotov"] = ["m_atac_throwingmolotov", "m_atac_molotovout"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["reloading"] = ["m_tcac_reloading", "m_tcac_changingmags"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["moving"] = ["m_tcac_moving"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["enemy_using_flash"] = ["m_eata_flashincoming"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["enemy_using_grenade"] = ["m_eata_grenade", "m_eata_gettocover", "m_eata_incoming"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["enemy_using_molotov"] = ["m_eata_molotov", "m_eata_molotovgetback"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["enemy_using_rpg"] = ["m_eata_rpg", "m_eata_rpgtakecover"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["enemy_attacking"] = ["m_eata_takingeffectivefire", "m_eata_contact", "m_eata_takingfire"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["enemy_soldier"] = ["m_enmy_targetspotted", "m_enmy_enemyhere"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["enemy_soldiers"] = ["m_enmy_multipleenemyhere", "m_enmy_visualontheenemy", "m_enmy_multipletargetsright"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["aquired_target"] = ["m_aqen_iseehim"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["youre_exposed"] = ["m_exco_takecover"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["target_covered"] = ["m_exco_hesbehindcover"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["killfirm_bigrig"] = ["m_firm_xraydown"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["killfirm_enemy"] = ["m_firm_sortedthatone", "m_firm_dustedem"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["killfirm_target"] = ["m_firm_slottedem"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["killfirm_truck"] = ["m_firm_enemytruckdestroyed", "m_firm_enemytruckisdown"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["killfirm_helo"] = ["m_firm_gottheirhelo", "m_firm_enemyheloisdown"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["praise"] = ["m_pras_nicelydone", "m_pras_fuckinacemate", "m_pras_thatwassoundmate"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["wounded"] = ["m_stat_painefforttookaround"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["enemy_sniper"] = ["m_enws_snipersonme", "m_enws_paineffortsniper"];
  level.battlechatter._id_ED774F98C3EFAE87["ghos"]["checkfire"] = ["m_chck_paineffortcheckyerbl", "m_chck_paineffortdontshootm", "m_chck_paineffortcheckyourf", "m_chck_paineffortwatchyourb"];
}