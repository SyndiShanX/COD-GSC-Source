/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_koth.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_koth();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::deactivate_minigun;
  level.bot_funcs["_encstr_AA071F6E347B5DD832FA6E4716C9D1EB36B05D3A4BB7EAE6BE16070EE4DBB0D80D"] = ::_id_132E0;
}

setup_bot_koth() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  var_0 = 0;

  foreach(var_2 in level.objectives) {
    var_2 thread _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::monitor_zone_control();
    var_3 = 0;

    if(istrue(var_2.trigger.trigger_off)) {
      var_2.trigger scripts\engine\utility::trigger_on();
      var_3 = 1;
    }

    var_2.nodes = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::bot_get_valid_nodes_in_trigger(var_2.trigger);

    if(var_3)
      var_2.trigger scripts\engine\utility::trigger_off();
  }

  level.death_info_func = 1;

  if(!var_0) {
    level.deactivate_battle_station = 1;
    var_5 = level.zone;

    if(!isDefined(var_5))
      var_5 = scripts\engine\utility::random(level.objectives);

    _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::custom_damageshield([var_5]);
    level.damagepercentmedium[var_5.trigger getentitynumber()] = 1;
    level.bot_gametype_precaching_done = 1;
    thread custom_damage_handler(var_5);
  }
}

custom_damage_handler(var_0) {
  for(var_1 = scripts\engine\utility::array_remove(level.objectives, var_0); var_1.size > 0; var_1 = scripts\engine\utility::array_remove(var_1, var_2)) {
    var_2 = undefined;
    var_3 = level.zone;

    if(isDefined(var_3) && scripts\engine\utility::array_contains(var_1, var_3))
      var_2 = var_3;
    else
      var_2 = scripts\engine\utility::random(var_1);

    _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::custom_damageshield([var_2]);
    level.damagepercentmedium[var_2.trigger getentitynumber()] = 1;
  }
}

deactivate_minigun() {
  self notify("_encstr_81C30FC47B8E7D5BBD3A34EBE8342DB9DA");
  self endon("_encstr_81C30FC47B8E7D5BBD3A34EBE8342DB9DA");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("_encstr_ABF30BBF587B195B43BDD44DA8", 0);
  self botsetflag("_encstr_B68D13D9272BDC16C856AFBD264D951B474B3BB2CD", 1);
  var_0 = undefined;
  var_1 = level.zone;

  for(;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(level.zone) || !isDefined(level.damagepercentmedium[level.zone.trigger getentitynumber()])) {
      if(scripts\mp\bots\bots_util::bot_is_defending())
        scripts\mp\bots\bots_strategy::bot_defend_stop();

      self.initpayloadpunish = undefined;
      self[[self.personality_update_function]]();
      continue;
    }

    if(var_1 != level.zone) {
      var_0 = undefined;
      var_1 = level.zone;
    }

    if(!istrue(level.zone.trigger.trigger_off) && isDefined(level.zoneendtime) && !isDefined(var_0) && !level.zonerandomlocationorder && level.deactivate_battle_station) {
      var_2 = level.zoneendtime - gettime();

      if(var_2 > 0 && var_2 < 10000) {
        var_3 = level.zone scripts\mp\gameobjects::getownerteam() == self.team;

        if(!var_3) {
          var_4 = level.zone._id_14713.radius * 6;

          if(var_2 < 5000)
            var_4 = level.zone._id_14713.radius * 3;

          var_5 = distance(level.zone._id_14713.center, self.origin);

          if(var_5 > var_4)
            var_0 = deathsdoorsfx();
        } else {
          var_6 = scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team);
          var_7 = ceil(var_6 / 2);

          if(var_2 < 5000)
            var_7 = ceil(var_6 / 3);

          var_8 = damagestateref(level.zone);

          if(var_8 + 1 > var_7)
            var_0 = deathsdoorsfx();
        }
      }
    }

    var_9 = level.zone;

    if(istrue(var_0)) {
      var_10 = (level.prevzoneindex + 1) % level.objectives.size;

      if(var_10 == 0)
        var_10 = 1;

      var_9 = level.objectives[scripts\engine\utility::string(var_10)];
    }

    if(!deactivate_gas_trap_puddles(var_9))
      custom_ground_vehicle_death_func(var_9);
  }
}

deathsdoorsfx() {
  if(level.zonerandomlocationorder)
    return 0;
  else {
    var_0 = self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592");
    var_1 = 0;

    if(var_0 == 1)
      var_1 = 0.1;
    else if(var_0 == 2)
      var_1 = 0.5;
    else if(var_0 == 3)
      var_1 = 0.8;

    return randomfloat(1.0) < var_1;
  }
}

damagestateref(var_0) {
  return dangernotifyplayersinrange(var_0).size;
}

dangernotifyplayersinrange(var_0) {
  var_1 = [];

  foreach(var_3 in level.participants) {
    if(var_3 != self && scripts\mp\utility\entity::isteamparticipant(var_3) && istestclient(self, var_3)) {
      if(var_3 istouching(level.zone.trigger)) {
        if(!isai(var_3) || var_3 deactivate_gas_trap_puddles(var_0))
          var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

deactivate_gas_trap_puddles(var_0) {
  if(!scripts\mp\bots\bots_util::bot_is_capturing())
    return 0;

  return self.initpayloadpunish == var_0;
}

custom_ground_vehicle_death_func(var_0) {
  self.initpayloadpunish = var_0;
  var_1["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"] = var_0.entrance_indices;
  var_1["_encstr_8D9715A8C35F281DB93F3107FF7268CA83581FF20F8F41"] = var_0.get_wave_targetname;
  scripts\mp\bots\bots_strategy::bot_capture_zone(var_0.trigger.origin, var_0.nodes, var_0.trigger, var_1);
}

_id_132E0(var_0) {
  if(var_0) {
    var_1 = level.zone scripts\mp\gameobjects::getownerteam();

    if(var_1 == "_encstr_A7A408B9CA5D1D4E2C63" || var_1 == self.team)
      return 0;
  }

  return scripts\mp\bots\bots_strategy::should_start_cautious_approach_default(var_0);
}