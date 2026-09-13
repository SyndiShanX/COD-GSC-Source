/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\raid_utility.gsc
***********************************************/

raid_init_func() {
  level.disable_global_vehicle_spawn = 1;
  level.vehicle_ai_can_shoot_after_reload = 1;
  level.dogtag_revive = 1;
  level.disable_hotjoin_via_ac130 = 1;
  level.custom_player_hotjoin_func = undefined;
  level.respawn_func = undefined;
  level.getspawnpoint = ::getraidspawnpoint;
  init_out_of_bounds_triggers();
  scripts\cp\coop_stealth::coop_stealth_init();

  if(!scripts\engine\utility::flag_exist("raid_active"))
    scripts\engine\utility::flag_init("raid_active");

  scripts\engine\utility::flag_set("raid_active");
  level.disable_hotjoin_via_ac130 = 1;

  if(getDvar("dvar_1935265A4DBD5E02", "") == "raid_coop_escort")
    _id_6425D54AF3CD5A44::enable_lbravo_player_infil();
}

raid_is_starting() {
  _id_5875D74244BD62C3 = ["raid_coop_escort", "raid_coop_push", "raid_coop_defuse", "raid_coop_escape"];
  _id_DDAC31817B064B95 = getDvar("ui_mapname");
  _id_892708EFF6520B44 = getDvar(_func_2EF675C13CA1C4AF("dvar_287B3B75F2C14FE9", _id_DDAC31817B064B95), "");
  return isDefined(_id_892708EFF6520B44) && scripts\engine\utility::array_contains(_id_5875D74244BD62C3, _id_892708EFF6520B44);
}

set_raid_checkpoint(_id_CBEBDDA3F6116F5C, _id_3DD6AB95808352DC) {
  _id_DDAC31817B064B95 = getDvar("ui_mapname");
  _id_892708EFF6520B44 = _func_2EF675C13CA1C4AF("dvar_287B3B75F2C14FE9", _id_DDAC31817B064B95);
  setDvar(_id_892708EFF6520B44, _id_CBEBDDA3F6116F5C);
  level.raid_player_initial_spawner_script_noteworthy = _id_3DD6AB95808352DC;
}

getraidspawnpoint() {
  if(isDefined(level.raid_player_start_pos_array))
    return _id_116171939929AF39::getassignedspawnpoint(level.raid_player_start_pos_array);
  else if(isDefined(level.raid_player_initial_spawner_script_noteworthy))
    return _id_116171939929AF39::getassignedspawnpoint(scripts\engine\utility::getStructArray(level.raid_player_initial_spawner_script_noteworthy, "script_noteworthy"));
  else
    return _id_116171939929AF39::getassignedspawnpoint(scripts\engine\utility::getStructArray("default_player_start", "targetname"));
}

select_random_spawners(_id_B8C9EE08C9DB35F6) {
  _id_1A977EA95154CBA4 = scripts\engine\utility::getStructArray(_id_B8C9EE08C9DB35F6, "targetname");
  _id_1A977EA95154CBA4 = remove_spawners_that_can_be_seen(_id_1A977EA95154CBA4);

  if(_id_1A977EA95154CBA4.size == 0)
    return undefined;

  if(_id_1A977EA95154CBA4.size > 1)
    _id_1A977EA95154CBA4 = remove_most_recently_used_spawner(_id_1A977EA95154CBA4);

  if(_id_1A977EA95154CBA4.size == 1)
    return _id_1A977EA95154CBA4[0];

  for(_id_AC0E594AC96AA3A8 = 5; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--)
    _id_1A977EA95154CBA4 = scripts\engine\utility::array_randomize(_id_1A977EA95154CBA4);

  _id_F1DBE8FACAAB13B7 = _id_1A977EA95154CBA4[0];
  return _id_F1DBE8FACAAB13B7;
}

remove_spawners_that_can_be_seen(_id_1A977EA95154CBA4) {
  result = [];

  foreach(spawner in _id_1A977EA95154CBA4) {
    if(can_be_seen_by_any_player(spawner)) {
      continue;
    }
    result[result.size] = spawner;
  }

  return result;
}

can_be_seen_by_any_player(spawner) {
  foreach(player in level.players) {
    if(spawnsighttrace(undefined, player getEye(), spawner.origin))
      return 1;
  }

  return 0;
}

remove_most_recently_used_spawner(_id_1A977EA95154CBA4) {
  foreach(spawner in _id_1A977EA95154CBA4) {
    if(!isDefined(spawner.lastspawntime))
      spawner.lastspawntime = 0;
  }

  _id_F3FB2B400EAB94B1 = 0;
  _id_E9BAD229FF8D0D8E = undefined;

  foreach(spawner in _id_1A977EA95154CBA4) {
    if(spawner.lastspawntime > _id_F3FB2B400EAB94B1) {
      _id_F3FB2B400EAB94B1 = spawner.lastspawntime;
      _id_E9BAD229FF8D0D8E = spawner;
    }
  }

  if(isDefined(_id_E9BAD229FF8D0D8E))
    _id_1A977EA95154CBA4 = scripts\engine\utility::array_remove(_id_1A977EA95154CBA4, _id_E9BAD229FF8D0D8E);

  return _id_1A977EA95154CBA4;
}

create_weapon_pick_ups(_id_79B027651347C05F, _id_F602EBAA140F1C7C, _id_34EB8D1C47EDACB4, weapon_name, _id_39ACC07A4F70F5CA) {
  _id_BDDC1866D91199B8 = scripts\engine\utility::getStructArray(_id_79B027651347C05F, "targetname");

  foreach(_id_5C48EE946AC9771B in _id_BDDC1866D91199B8)
  create_weapon_pick_up(_id_5C48EE946AC9771B, _id_F602EBAA140F1C7C, _id_34EB8D1C47EDACB4, weapon_name, _id_39ACC07A4F70F5CA);
}

create_weapon_pick_up(_id_5C48EE946AC9771B, _id_F602EBAA140F1C7C, _id_34EB8D1C47EDACB4, weapon_name, _id_39ACC07A4F70F5CA) {
  _id_4896A90C402CDBE5 = spawn("script_model", _id_5C48EE946AC9771B.origin);
  _id_4896A90C402CDBE5 setModel(_id_F602EBAA140F1C7C);
  _id_4896A90C402CDBE5.angles = _id_5C48EE946AC9771B.angles;
  _id_4896A90C402CDBE5 thread weapon_pick_up_monitor(_id_4896A90C402CDBE5, _id_34EB8D1C47EDACB4, weapon_name, _id_39ACC07A4F70F5CA);
}

weapon_pick_up_monitor(_id_4896A90C402CDBE5, _id_34EB8D1C47EDACB4, weapon_name, _id_39ACC07A4F70F5CA) {
  _id_4896A90C402CDBE5 endon("death");
  _id_4896A90C402CDBE5 makeusable();
  _id_4896A90C402CDBE5 setHintString(_id_34EB8D1C47EDACB4);
  weapon_obj = _id_2669878CF5A1B6BC::buildweapon(weapon_name, _id_39ACC07A4F70F5CA);

  for(;;) {
    _id_4896A90C402CDBE5 waittill("trigger", player);

    if(player hasweapon(weapon_obj)) {
      player iprintlnbold("Already have this weapon");
      continue;
    }

    break;
  }

  player scripts\cp\utility::_giveweapon(weapon_obj, undefined, undefined, 1);
  player switchtoweapon(weapon_obj);
  _id_4896A90C402CDBE5 delete();
}

raid_mindia_unload_func() {
  self endon("death");
  _id_552455475E744E2B = self;
  _id_FC0AD02808C4F3A2 = ["tag_fastrope_back_le", "tag_fastrope_back_ri", "tag_fastrope_front_le", "tag_fastrope_front_ri"];
  deploy_smoke_grenades_for_infil(_id_552455475E744E2B, _id_FC0AD02808C4F3A2, -128);
}

deploy_smoke_grenades_for_infil(_id_552455475E744E2B, _id_FC0AD02808C4F3A2, _id_29B6333B64DE3FFD) {
  for(_id_AC0E594AC96AA3A8 = 5; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--)
    _id_FC0AD02808C4F3A2 = scripts\engine\utility::array_randomize(_id_FC0AD02808C4F3A2);

  foreach(tag in _id_FC0AD02808C4F3A2) {
    _id_E83155ABEFE7212E = _id_552455475E744E2B gettagorigin(tag);
    _id_53FCCF1DE5AA5EB2 = getgroundposition(_id_E83155ABEFE7212E + (randomfloatrange(-18, 18), randomfloatrange(-18, 18), _id_29B6333B64DE3FFD), 16);
    magicgrenademanual("smoke_grenade_cp_infil", _id_53FCCF1DE5AA5EB2 + (0, 0, 10), (0, 0, -4), 0.05);
    wait 0.5;
  }
}

get_players_not_in_laststand() {
  result = [];

  foreach(player in level.players) {
    if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
      continue;
    }
    result[result.size] = player;
  }

  return result;
}

make_camera_anchor(_id_D5685B7BAEE6505E, _id_F41355A0C5E8B595) {
  camera_anchor = spawn("script_model", _id_D5685B7BAEE6505E);
  camera_anchor setModel("tag_origin");
  camera_anchor.angles = vectortoangles(_id_F41355A0C5E8B595);
  return camera_anchor;
}

fake_exploder(_id_C5A8D1DFFF9456E0, _id_BFD70A93FB5FE72E, _id_B0EA87280B45EE84) {
  playFX(level._effect[_id_C5A8D1DFFF9456E0], _id_BFD70A93FB5FE72E, anglesToForward(_id_B0EA87280B45EE84));
}

setup_lights_in_region(targetname) {
  if(isarray(targetname)) {
    foreach(_id_21D9143F1DAA4716 in targetname) {
      lights = getscriptablearray(_id_21D9143F1DAA4716, "targetname");

      foreach(light in lights) {
        light setscriptablepartstate("fixture", "off");
        light.attachedlights = scripts\engine\utility::get_array_of_closest(light.origin, getEntArray("light_spot", "classname"), [], 4, 64);

        foreach(_id_189F587033CB8F18 in light.attachedlights) {
          _id_189F587033CB8F18.og_intensity = _id_189F587033CB8F18 getlightintensity();
          _id_189F587033CB8F18 setlightintensity(0);
        }
      }
    }
  } else {
    lights = getscriptablearray(targetname, "targetname");

    foreach(light in lights) {
      light setscriptablepartstate("fixture", "off");
      light.attachedlights = scripts\engine\utility::get_array_of_closest(light.origin, getEntArray("light_spot", "classname"), [], 4, 64);

      foreach(_id_189F587033CB8F18 in light.attachedlights) {
        _id_189F587033CB8F18.og_intensity = _id_189F587033CB8F18 getlightintensity();
        _id_189F587033CB8F18 setlightintensity(0);
      }
    }
  }
}

clear_lights_based_on_targetname(targetname) {
  if(isarray(targetname)) {
    foreach(_id_21D9143F1DAA4716 in targetname) {
      lights = getscriptablearray(_id_21D9143F1DAA4716, "targetname");

      foreach(light in lights) {
        light setscriptablepartstate("fixture", "off");

        foreach(_id_189F587033CB8F18 in light.attachedlights)
        _id_189F587033CB8F18 setlightintensity(0);
      }
    }
  } else {
    lights = getscriptablearray(targetname, "targetname");

    foreach(light in lights) {
      light setscriptablepartstate("fixture", "off");

      foreach(_id_189F587033CB8F18 in light.attachedlights)
      _id_189F587033CB8F18 setlightintensity(0);
    }
  }
}

init_out_of_bounds_triggers() {
  _id_09E91899E40DD335 = getEntArray("OutOfBounds", "targetname");

  foreach(_id_302BD80BA4197C84 in _id_09E91899E40DD335)
  _id_302BD80BA4197C84.original_origin = _id_302BD80BA4197C84.origin;
}

activate_out_of_bounds_triggers(_id_4EEDC94A49FE48AA) {
  _id_09E91899E40DD335 = getEntArray("OutOfBounds", "targetname");

  foreach(_id_302BD80BA4197C84 in _id_09E91899E40DD335) {
    if(isDefined(_id_302BD80BA4197C84.script_noteworthy) && scripts\engine\utility::array_contains(_id_4EEDC94A49FE48AA, _id_302BD80BA4197C84.script_noteworthy)) {
      _id_302BD80BA4197C84.origin = _id_302BD80BA4197C84.original_origin + (0, 0, int(_id_302BD80BA4197C84.script_parameters));
      continue;
    }

    _id_302BD80BA4197C84.origin = _id_302BD80BA4197C84.original_origin;
  }
}

set_player_hurt_trigger(trig) {
  level endon("game_ended");
  trig endon("death");
  trig endon("trigger_off");
  trig notify("player_hurt_trigger_active");
  trig endon("player_hurt_trigger_active");
  interval = 0.05;
  _id_8C3219C50A024D71 = 5;

  for(;;) {
    trig waittill("trigger", _id_08C251142FC6469A);

    if(!isDefined(_id_08C251142FC6469A)) {
      continue;
    }
    if(!isPlayer(_id_08C251142FC6469A)) {
      continue;
    }
    if(istrue(_id_08C251142FC6469A.spectating)) {
      continue;
    }
    if(!isalive(_id_08C251142FC6469A)) {
      continue;
    }
    if(isDefined(trig.script_damage))
      _id_8C3219C50A024D71 = floor(trig.script_damage);

    _id_08C251142FC6469A dodamage(_id_8C3219C50A024D71, _id_08C251142FC6469A.origin, trig, undefined, "MOD_TRIGGER_HURT");

    if(!istrue(_id_08C251142FC6469A.hurt_trigger_active))
      _id_08C251142FC6469A thread hurt_trigger_manage_dog_tag(_id_08C251142FC6469A.origin, _id_8C3219C50A024D71);

    if(interval > 0.05)
      wait(max(interval - 0.05, 0.05));
  }
}

hurt_trigger_manage_dog_tag(_id_A2FA0B63C56D687A, _id_8C3219C50A024D71) {
  self endon("disconnect");
  self.shouldskipdeathsshield = 1;
  self.hurt_trigger_active = 1;
  self.shouldskiplaststand = 1;
  _id_E7A610607F080166 = self.maxhealth / 20;
  timeout = _id_8C3219C50A024D71 / _id_E7A610607F080166 + 0.1;
  scripts\engine\utility::waittill_any_timeout_1(timeout, "death");

  while(isDefined(self) && !isDefined(self.dogtag))
    wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  offset = (0, 0, 40);

  if(isDefined(self.last_good_pos))
    self.dogtag.origin = self.last_good_pos + offset;
  else
    self.dogtag.origin = getclosestpointonnavmesh(_id_A2FA0B63C56D687A) + offset;

  self.shouldskipdeathsshield = undefined;
  self.hurt_trigger_active = 0;
  self.shouldskiplaststand = 0;
}