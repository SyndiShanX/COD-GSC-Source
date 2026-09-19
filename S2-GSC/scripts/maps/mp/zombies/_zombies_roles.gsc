/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\_zombies_roles.gsc
******************************************************/

init() {
  level._id_AB43 = 0;
}

_id_7BF6() {
  _id_0533::_id_7BCE("role_ability_camo_zm", _id_0537::init, _id_0537::_id_3662, _id_0537::_id_2F9E);
  _id_0533::_id_7BCE("role_ability_mad_minute_zm", _id_0538::init, _id_0538::_id_3662, _id_0538::_id_2F9E);
  _id_0533::_id_7BCE("role_ability_melee_frenzy_zm", _id_0539::init, _id_0539::_id_3662, _id_0539::_id_2F9E);
  _id_0533::_id_7BCE("role_ability_taunt_zm", _id_053B::init, _id_053B::_id_3662, _id_053B::_id_2F9E);
  _id_0533::_id_7BCE("role_ability_stunning_burst_zm", _id_053A::init, _id_053A::_id_3662, _id_053A::_id_2F9E);
}

onplayerconnect(var_0) {
  var_0._id_7ECB = 1200;

  if(common_scripts\utility::_id_562E(0)) {
    var_1 = getarraykeys(level._id_7ED0);

    if(isDefined(var_1) && var_1.size > 0)
      var_0._id_7A3F = common_scripts\utility::random(var_1);
  }
}

_id_6B81() {
  if(common_scripts\utility::_id_562E(0)) {
    if(isDefined(self._id_7A3F))
      _id_0586::_id_078C(self._id_7A3F);
  }
}

_id_6AB2(var_0) {
  self endon("death");
  self endon("begin_last_stand");

  if(!_id_0547::_id_5565(self.rentingability, var_0)) {}

  self._id_90CC++;
  level notify("special_ability_used");
  var_1 = self getentitynumber();
  _luinotifyeventextra(&"activate_special_teammate", 3, var_1, var_0, 1);
  _id_0555::issprinting("ability", self, var_0);
  thread _id_054E::_id_7486(var_0);
  level._id_400E[level._id_400E.size] = ["assassin_set 4 -1", self];
  level._id_400E[level._id_400E.size] = ["bat_elite_set 4 -1", self];

  if(level._id_AB43) {
    thread _id_6AB3();
    _id_0586::_id_078E(var_0);
    common_scripts\utility::_id_0603();
    var_2 = undefined;

    for(;;) {
      self waittill("weapon_change", var_3);

      if(var_3 == var_0) {
        break;
      }
    }

    thread _id_956B(var_0);

    switch (var_0) {
      case "role_ability_melee_frenzy_zm":
      case "role_ability_mad_minute_zm":
      case "role_ability_taunt_zm":
      case "role_ability_camo_zm":
      case "role_ability_stunning_burst_zm":
      default:
        wait 0.26;
        break;
    }
  }

  if(!isDefined(self._id_7ECC)) {
    var_4 = 1;

    if(_id_0547::_id_4BA7("specialty_class_specialist_zm"))
      var_4 = 0.75;

    self._id_7ECB = self._id_7ECB + 400 * var_4;
    self._id_7ECB = get_additional_scaling_value();
  } else {
    self._id_7ECC = undefined;
    self setclientomnvar("ui_zm_free_ability", 0);
  }

  thread disableabilityondowned(var_0);
}

get_additional_scaling_value() {
  if(isDefined(level.zmb_zm_roles_exponential_cost))
    return self._id_7ECB * level.zmb_zm_roles_exponential_cost;
  else
    return self._id_7ECB;
}

disableabilityondowned(var_0) {
  self endon("DisabledRoleAbility");
  self waittill("enter_last_stand");
  _id_0533::_id_2F9E(var_0);
}

_id_956B(var_0) {
  switch (var_0) {
    case "role_ability_melee_frenzy_zm":
    case "role_ability_mad_minute_zm":
    case "role_ability_taunt_zm":
    case "role_ability_camo_zm":
    case "role_ability_stunning_burst_zm":
    default:
      wait 0.44;
      break;
  }

  var_1 = _id_0547::_id_AB2B();
  common_scripts\utility::_id_0617();
  _id_0586::_id_078E(var_1);
  self notify("zm_role_putaway");
}

_id_6AB3() {
  self endon("zm_role_putaway");
  common_scripts\utility::_id_A70A("death", "begin_last_stand");
  common_scripts\utility::_id_0617();
}

_id_6B84(var_0, var_1, var_2) {
  if(0 && isDefined(var_2))
    var_0 = var_2;

  var_3 = 0;

  if(var_3 && maps\mp\_utility::gameflag("double_points"))
    var_0 = int(var_0 * 2);

  var_5 = var_0 / self._id_7ECB;
  _id_0533::_id_0F37(var_5);
}

_id_4789() {
  foreach(var_1 in level.players) {
    if(maps\mp\_utility::isreallyalive(var_1))
      var_1 _id_0533::_id_0F37(1.0, 1, 1);
  }
}