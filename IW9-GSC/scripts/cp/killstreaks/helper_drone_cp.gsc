/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\helper_drone_cp.gsc
******************************************************/

helper_drone_init() {
  _id_294D813E5D00B68C::_id_98A4E2A877EF7BB1();
  _id_21873023C0473044::_id_C260CD16A5C5A2D9();
  scripts\cp_mp\utility\script_utility::registersharedfunc("helper_drone", "watchMarkingEntStatus", ::markent_watchmarkingentstatus_cp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("helper_drone", "get_mark_ui_duration", ::get_mark_ui_duration);
  scripts\cp_mp\utility\script_utility::registersharedfunc("helper_drone", "get_outer_reticle_targets", ::get_outer_reticle_targets);
  scripts\cp_mp\utility\script_utility::registersharedfunc("helper_drone", "customMarkDuration", ::_id_4BFF904F72560737);
  scripts\cp_mp\utility\script_utility::registersharedfunc("supers", "superUseFinished", _id_56EF8D52FE1B48A1::superusefinished);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isInLastStand", _id_0AFB7E332AEE4BF2::player_in_laststand);
  scripts\cp_mp\utility\script_utility::registersharedfunc("assault_drone", "explode", ::_id_F09621755C154350);
  _id_04A2AA8B66AC796D = getarraykeys(level.helperdronesettings);

  foreach(streakname in _id_04A2AA8B66AC796D) {
    hitstokill = level.helperdronesettings[streakname].hitstokill;

    if(isDefined(hitstokill)) {
      scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data(streakname, hitstokill);
      scripts\cp\vehicles\damage_cp::set_weapon_hit_damage_data_for_vehicle("emp_grenade_mp", hitstokill, streakname);
    }
  }
}

get_mark_ui_duration() {
  return 90;
}

_id_4BFF904F72560737() {
  return 90;
}

get_mark_target_array() {
  return level.spawned_enemies;
}

get_outer_reticle_targets(config) {
  _id_2C04E0036A6164B9 = 3000;
  _id_B11567DD924E0A86 = _id_2C04E0036A6164B9 * _id_2C04E0036A6164B9;
  _id_413171B8B9E8BEE0 = [];
  _id_7C18D93982D63713 = cos(70);
  guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(guy in guys) {
    if(distancesquared(self.origin, guy.origin) < _id_B11567DD924E0A86) {
      if(scripts\engine\utility::within_fov(self.origin, self.angles, guy.origin, _id_7C18D93982D63713))
        _id_413171B8B9E8BEE0[_id_413171B8B9E8BEE0.size] = guy;
    }
  }

  return _id_413171B8B9E8BEE0;
}

markent_watchmarkingentstatus_cp(_id_161E86C260D6864C) {
  level endon("game_ended");
  _id_161E86C260D6864C.target endon("unmarked_" + _id_161E86C260D6864C.targetnum);
  _id_161E86C260D6864C.target thread _id_995178E171593EC0(_id_161E86C260D6864C, self);
  scripts\engine\utility::waittill_any_3("explode", "death", "leaving");
  wait 15;

  if(isDefined(level._id_0301EB5985C867E8)) {
    foreach(player in level.players) {
      player notify("tracker_removed");
      _id_161E86C260D6864C.target thread[[level._id_0301EB5985C867E8]](player);
    }

    waitframe();
  }

  _id_6D68CFDF0836123C::_id_8BF0338C7A157C29(_id_161E86C260D6864C);
}

_id_995178E171593EC0(_id_161E86C260D6864C, drone) {
  self waittill("death");
  drone _id_6D68CFDF0836123C::_id_8BF0338C7A157C29(_id_161E86C260D6864C);
}

_id_F09621755C154350(drone, config, _id_4FAC8B8CE36E09F1, _id_D9B2677826930BF7, _id_28D4A6F776C18B73, _id_BD21744EB1B623FE) {
  _id_FC9AC45209F959BB = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC9AC45209F959BB.size; _id_AC0E594AC96AA3A8++) {
    if(distance(drone.origin, _id_FC9AC45209F959BB[_id_AC0E594AC96AA3A8].origin) > 250) {
      continue;
    }
    if(issubstr(_id_FC9AC45209F959BB[_id_AC0E594AC96AA3A8].agent_type, "riotshield") || _id_FC9AC45209F959BB[_id_AC0E594AC96AA3A8] scripts\cp\utility::isjuggernaut())
      _id_FC9AC45209F959BB[_id_AC0E594AC96AA3A8] notify("flashbang", drone.origin, 1, undefined, drone, "allies");

    if(_id_FC9AC45209F959BB[_id_AC0E594AC96AA3A8] scripts\cp\utility::isjuggernaut()) {
      damage = 100;

      if(isDefined(_id_FC9AC45209F959BB[_id_AC0E594AC96AA3A8].armorhealth) && _id_FC9AC45209F959BB[_id_AC0E594AC96AA3A8].armorhealth > 0)
        damage = max(100, int(_id_FC9AC45209F959BB[_id_AC0E594AC96AA3A8].armorhealth * 0.9));

      _id_FC9AC45209F959BB[_id_AC0E594AC96AA3A8] dodamage(damage, drone.origin, drone, drone, "MOD_EXPLOSIVE");
    }
  }
}