/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1410.gsc
**************************************/

_id_2A99() {
  common_scripts\utility::_id_092C("death_sticky", "vfx/zombie/abilities_perks/zmb_death_zmb_turn");
  common_scripts\utility::_id_092C("tesla_death_explosion", "vfx/explosion/zmb_tesla_death_suicide_explosion");
  common_scripts\utility::_id_092C("death_stun", "vfx/sparks/tesla_death_stun_sparks");
  common_scripts\utility::_id_092C("head_sparks", "vfx/unique/no_fx");
  common_scripts\utility::_id_092C("tesla_death_ambience", "vfx/zombie/tesla_guns/zmb_npc_tesla_tube_death_idle");
  _id_054D::_id_7BC6(::_id_29A5);
}

_id_29A5(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = self;

  if(!_id_0547::_id_5565(var_5, "teslagun_zm_death")) {
    return;
  }
  if(_id_0547::_id_5565(var_4, "MOD_MELEE")) {
    return;
  }
  if(var_2 == _id_0580::_id_4382()) {
    return;
  }
  _id_0580::_id_98FD(var_0, var_1, var_11, "j_head", var_4, var_5, ::_id_7788, "death_stun");
}

_id_55EF(var_0, var_1) {
  var_2 = self;

  if(common_scripts\utility::_id_562E(var_2._id_5560))
    return 0;

  if(common_scripts\utility::_id_562E(var_1._id_4B2A))
    return 0;

  if(isDefined(var_2._id_0A4B)) {
    switch (var_2._id_0A4B) {
      case "zombie_berserker":
      case "zombie_generic":
        break;
      default:
        return 0;
    }
  }

  if(isDefined(level._id_94DA)) {
    var_3 = distance(var_2.origin, level._id_94DA) < _id_418A();
    var_4 = _id_0580::_id_4385() - level._id_94DB < 0.5;

    if(var_3 && var_4)
      return 0;
  }

  return 1;
}

_id_7788(var_0, var_1) {
  var_2 = self;

  if(common_scripts\utility::_id_562E(var_2._id_5560)) {
    return;
  }
  if(var_2 _id_55EF(var_0, var_1)) {
    var_1._id_4B2A = 1;
    var_2._id_5560 = 1;
    var_3 = _id_0580::getcurrentprimaryweapon(var_0, var_1.player, ::_id_5995, _id_4324());
    var_2 thread _id_0547::_id_7D1A("tesla_shock", [var_3], 4);
    level._id_94DA = var_2.origin;
    level._id_94DB = _id_0580::_id_4385();
    var_4 = maps\mp\gametypes\zombies::_id_1E59() * 1;
    _id_0580::_id_98E9(var_2.origin, _id_41DC(), var_1.player, var_2, var_1._id_953E, (0.666667, 0.423529, 0.223529), var_4);
  } else
    var_2 thread _id_0580::_id_98EE(var_0, var_1.player, var_1._id_8CD7, var_1._id_953E, 1, "head_sparks");
}

_id_94DC(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 scragentsetgoalentity(var_0);
  var_1._id_2A97 = var_0;
  var_0._id_5561 = 1;
  self._id_2A97 waittill("death");
  self._id_2A97 = undefined;
}

_id_5994(var_0) {
  var_1 = self;
  var_1 waittill("death");
  playFX(common_scripts\utility::_id_44F5("tesla_death_explosion"), var_1.origin);
  var_1 _id_0378::_id_8D74("aud_ww_death_explode");
  var_2 = maps\mp\gametypes\zombies::_id_1E59() * 3;
  _id_0580::_id_98E9(var_1.origin, _id_418A(), var_0.player, undefined, "teslagun_zm_death", (0.666667, 0.423529, 0.223529), var_2);
}

_id_5993() {
  return "sprint";
}

_id_5995(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 thread _id_5994(var_0);
  _playfxontag(common_scripts\utility::_id_44F5("death_sticky"), var_1, "j_neck");
  var_2 = 0;

  while(!var_2) {
    var_3 = [];
    var_4 = [];
    var_5 = [];

    foreach(var_7 in _id_0547::_id_408F()) {
      if(var_7 == var_1) {
        continue;
      }
      if(common_scripts\utility::_id_562E(var_7._id_5560)) {
        var_3 = common_scripts\utility::_id_0F6F(var_3, var_7);
        continue;
      }

      if(common_scripts\utility::_id_562E(var_7._id_5560)) {
        var_4 = common_scripts\utility::_id_0F6F(var_4, var_7);
        continue;
      }

      var_5 = common_scripts\utility::_id_0F6F(var_5, var_7);
    }

    var_7 = common_scripts\utility::_id_4461(var_1.origin, var_5);

    if(!isDefined(var_7))
      var_7 = common_scripts\utility::_id_4461(var_1.origin, var_4);

    if(!isDefined(var_7))
      var_7 = common_scripts\utility::_id_4461(var_1.origin, var_3);

    if(!isDefined(var_7)) {
      var_2 = 1;
      break;
    }

    var_1._id_00CA = 1;
    var_1 thread _id_94DC(var_7);

    if(isDefined(var_1._id_0A4B) && common_scripts\utility::_id_0F79(["zombie_exploder", "zombie_generic", "zombie_heavy", "zombie_berserker"], var_1._id_0A4B))
      var_1._id_297D = ::_id_5993;

    while(!var_2) {
      wait 0.7;

      if(!isDefined(var_1._id_2A97)) {
        break;
      }

      var_1 scragentsetgoalentity(var_1._id_2A97);

      if(distance(var_1.origin, var_1._id_2A97.origin) < _id_418B())
        var_2 = 1;
    }
  }

  var_1 thread _id_0580::_id_98EE(var_1.origin, var_0.player, "MOD_ENERGY", "teslagun_zm_death", 1);
}

_id_41DC() {
  return 240;
}

_id_418B() {
  return 100;
}

_id_418A() {
  return 228;
}

_id_4324() {
  return 1.2;
}