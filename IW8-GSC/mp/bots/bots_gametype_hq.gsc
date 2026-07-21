/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_hq.gsc
***********************************************/

main() {
  setup_callbacks();
  deactivate_front_trigger_hurt();
}

deactivate_front_trigger_hurt() {
  _id_131DF();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::deactivate_gas_trap;
  level.bot_funcs["_encstr_AA071F6E347B5DD832FA6E4716C9D1EB36B05D3A4BB7EAE6BE16070EE4DBB0D80D"] = ::_id_132DF;
}

_id_131DF() {
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
    var_5 = find_current_radio();

    if(!isDefined(var_5))
      var_5 = scripts\engine\utility::random(level.objectives);

    _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::custom_damageshield([var_5]);
    level.damagepercenthigh[var_5.trigger getentitynumber()] = 1;
    level.bot_gametype_precaching_done = 1;
    thread currlocation(var_5);
  }
}

currlocation(var_0) {
  for(var_1 = scripts\engine\utility::array_remove(level.objectives, var_0); var_1.size > 0; var_1 = scripts\engine\utility::array_remove(var_1, var_2)) {
    var_2 = undefined;
    var_3 = find_current_radio();

    if(isDefined(var_3) && scripts\engine\utility::array_contains(var_1, var_3))
      var_2 = var_3;
    else
      var_2 = scripts\engine\utility::random(var_1);

    _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::custom_damageshield([var_2]);
    level.damagepercenthigh[var_2.trigger getentitynumber()] = 1;
  }
}

deactivate_gas_trap() {
  self notify("_encstr_86540DF61D837FB0C9CF08E03FFEE8");
  self endon("_encstr_86540DF61D837FB0C9CF08E03FFEE8");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("_encstr_ABF30BBF587B195B43BDD44DA8", 0);
  self botsetflag("_encstr_B68D13D9272BDC16C856AFBD264D951B474B3BB2CD", 1);

  for(;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }
    var_0 = find_current_radio();

    if(!isDefined(var_0) || !istrue(var_0.active) || !isDefined(level.damagepercenthigh[var_0.trigger getentitynumber()])) {
      custompassengerwaitfunc();
      self[[self.personality_update_function]]();
      continue;
    }

    var_1 = level.zone scripts\mp\gameobjects::getownerteam();

    if(self.team != var_1) {
      if(!deactivate_gas_trap_cloud_parent(var_0))
        custom_explode_mine(var_0);

      continue;
    }

    var_2 = scripts\engine\utility::get_enemy_team(self.team);
    var_3 = level.zone.touchlist[var_2].size > 0;

    if(var_3) {
      if(!deactivate_gas_trap_cloud_parent(var_0))
        custom_explode_mine(var_0);

      continue;
    }

    if(!deactivate_hacked_console(var_0)) {
      if(deactivate_gas_trap_cloud_parent(var_0)) {
        wait(randomfloat(2));
        custompassengerwaitfunc();
        continue;
      }

      deal_damage_after_time(var_0);
    }
  }
}

find_current_radio() {
  foreach(var_1 in level.objectives) {
    if(isDefined(level.zone) && var_1.trigger == level.zone.trigger)
      return var_1;
  }
}

deactivate_gas_trap_cloud_parent(var_0) {
  if(!scripts\mp\bots\bots_util::bot_is_capturing())
    return 0;

  return isDefined(self.initpayloadpunish) && self.initpayloadpunish == var_0;
}

deactivate_hacked_console(var_0) {
  if(!scripts\mp\bots\bots_util::bot_is_protecting())
    return 0;

  return isDefined(self.initpayloadpunish) && self.initpayloadpunish == var_0;
}

custom_explode_mine(var_0) {
  self.initpayloadpunish = var_0;
  var_1["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"] = var_0.entrance_indices;
  var_1["_encstr_8D9715A8C35F281DB93F3107FF7268CA83581FF20F8F41"] = var_0.get_wave_targetname;
  scripts\mp\bots\bots_strategy::bot_capture_zone(var_0.trigger.origin, var_0.nodes, var_0.trigger, var_1);
}

deal_damage_after_time(var_0) {
  self.initpayloadpunish = var_0;
  var_1 = length(var_0._id_14713.setplacementxpshare) * 2;
  var_2["_encstr_8D9715A8C35F281DB93F3107FF7268CA83581FF20F8F41"] = var_0.get_wave_targetname;
  scripts\mp\bots\bots_strategy::bot_protect_point(var_0.get_wave_targetname.origin, var_1, var_2);
}

custompassengerwaitfunc() {
  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();

  self.initpayloadpunish = undefined;
}

_id_132DF(var_0) {
  if(var_0) {
    var_1 = level.zone scripts\mp\gameobjects::getownerteam();

    if(var_1 == "_encstr_A7A408B9CA5D1D4E2C63" || var_1 == self.team)
      return 0;
  }

  return scripts\mp\bots\bots_strategy::should_start_cautious_approach_default(var_0);
}