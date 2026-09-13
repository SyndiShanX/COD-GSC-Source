/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\cp_safehouse_util.gsc
****************************************************/

slamcamoverlay(_id_AD4DD16F29E24B77, _id_F61019386E1B1034, _id_DFAB0807D83A77FE) {
  overlay = newclienthudelem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.foreground = 1;

  if(isDefined(_id_AD4DD16F29E24B77) && _id_AD4DD16F29E24B77 > 0)
    overlay.alpha = 0;
  else
    overlay.alpha = 1;

  overlay setshader("black", 640, 480);

  if(isDefined(_id_AD4DD16F29E24B77) && _id_AD4DD16F29E24B77 > 0) {
    self notify("fadeDown_start");
    overlay fadeovertime(_id_AD4DD16F29E24B77);
    overlay.alpha = 1.0;
    wait(_id_AD4DD16F29E24B77);
    self notify("fadeDown_complete");
  }

  if(isDefined(_id_F61019386E1B1034) && _id_F61019386E1B1034 > 0)
    wait(_id_F61019386E1B1034);

  self notify("fadeUp_start");

  if(!isDefined(_id_DFAB0807D83A77FE))
    _id_DFAB0807D83A77FE = 0.5;

  if(_id_DFAB0807D83A77FE > 0) {
    overlay fadeovertime(_id_DFAB0807D83A77FE);
    overlay.alpha = 0.0;
    wait(_id_DFAB0807D83A77FE);
  }

  self notify("fadeUp_complete");

  if(isDefined(overlay))
    overlay destroy();
}

kill_all_enemies() {
  _id_18A73A64992DD07D::stop_all_groups();
  level.ambient_spawning_paused = 1;

  foreach(_id_C8C0E3CBCE8F401A in level.agentarray) {
    if(!istrue(_id_C8C0E3CBCE8F401A.isactive)) {
      continue;
    }
    _id_C8C0E3CBCE8F401A.nocorpse = 1;
    _id_C8C0E3CBCE8F401A dodamage(_id_C8C0E3CBCE8F401A.health + 1000, _id_C8C0E3CBCE8F401A.origin, undefined, undefined, "MOD_EXPLOSIVE", "iw8_la_rpapa7_mp_friendly");
  }

  level.ambient_spawning_paused = 0;
}

regroup_blackscreen(player, _id_AD170C2B0C7A7FB2, _id_892708EFF6520B44, _id_AD170B2B0C7A7D7F) {
  if(!isDefined(player))
    player = self;

  player endon("disconnect");
  player disableweapons();
  player scripts\cp\utility::freezecontrolswrapper(1);
  player setclientomnvar("ui_hide_hud", 1);
  fullscreen_overlay = newclienthudelem(player);
  fullscreen_overlay.x = 0;
  fullscreen_overlay.y = 0;
  fullscreen_overlay setshader("black", 640, 480);
  fullscreen_overlay.alignx = "left";
  fullscreen_overlay.aligny = "top";
  fullscreen_overlay.sort = 1;
  fullscreen_overlay.horzalign = "fullscreen";
  fullscreen_overlay.vertalign = "fullscreen";
  fullscreen_overlay.alpha = 1;
  fullscreen_overlay.foreground = 1;
  level waittill(_id_AD170C2B0C7A7FB2);
  player thread show_regroup_text(_id_892708EFF6520B44);
  level waittill(_id_AD170B2B0C7A7D7F);
  player setclientomnvar("ui_chyron_on", 0);
  player setclientomnvar("ui_hide_hud", 0);
  player scripts\cp\utility::freezecontrolswrapper(0);
  player enableweapons();
  fullscreen_overlay fadeovertime(2);
  fullscreen_overlay.alpha = 0.5;
  wait 2;
  fullscreen_overlay destroy();
}

toggle_safehouse_settings(_id_41D8BF229CF29051) {
  if(istrue(_id_41D8BF229CF29051)) {
    level.disable_hotjoin_via_ac130 = 1;
    level.dogtag_revive = 1;
    level.disable_munitions = 1;
    level.spawninsafehouse = 1;
  } else {
    if(!istrue(level.relic_dogtags)) {
      level.disable_hotjoin_via_ac130 = 0;
      level.dogtag_revive = 0;
    }

    level.disable_munitions = 0;
    level.spawninsafehouse = 0;
  }

  level notify("toggle_safehouse_settings", _id_41D8BF229CF29051);

  if(_id_41D8BF229CF29051) {
    level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
    level.post_loadout_spawn_func = ::post_loadout_spawn_func;
  } else {
    level thread scripts\cp\cp_kidnapper::togglekidnappers(1);
    level.post_loadout_spawn_func = undefined;
  }

  foreach(player in level.players)
  player toggle_player_settings(_id_41D8BF229CF29051);
}

toggle_player_settings(_id_41D8BF229CF29051) {
  player = self;

  if(_id_41D8BF229CF29051) {
    player setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");
    player thread viewmodel_demeanor();
    player disableweaponswitch();
    player disableoffhandweapons();
    player allowmelee(0);
    player allowsupersprint(0);
    player allowsprint(0);
    player allowads(0);
    player allowcrouch(0);
    player allowprone(0);
    player allowmantle(0);
    player allowjump(0);
    player setclientomnvar("ui_briefing", 1);
    player.allowednormaldemeanor = 0;
    player.ignoreme = 1;
  } else {
    player notify("normal_demeanor");
    player setdemeanorviewmodel("normal");
    player enableweaponswitch();
    player enableoffhandweapons();
    player allowmelee(1);
    player allowsupersprint(1);
    player allowsprint(1);
    player allowads(1);
    player allowcrouch(1);
    player allowprone(1);
    player allowmantle(1);
    player allowjump(1);
    player setclientomnvar("ui_briefing", 0);
    player.allowednormaldemeanor = 1;
    player.ignoreme = 0;
  }
}

viewmodel_demeanor() {
  self endon("normal_demeanor");
  self notify("viewmodel_demeanor");
  self endon("viewmodel_demeanor");

  for(;;) {
    self waittill("loadout_given");
    wait 2;

    if(istrue(self.allowednormaldemeanor)) {
      self setdemeanorviewmodel("normal");
      continue;
    }

    self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");
  }
}

edit_loadout_think(struct) {
  level endon("game_ended");
  model = spawn("script_model", struct.origin);
  model setModel("tag_origin");
  model scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_DWN_TWN_OBJECTIVES/DWN_TWN_LOADOUT", 25, "duration_short", "hide", 256, 65, 64, 65);
  model.headicon = createheadicon(model);
  setheadiconimage(model.headicon, "hud_icon_survival_weapon");
  setheadiconsnaptoedges(model.headicon, 0);
  setheadiconmaxdistance(model.headicon, 1024);
  setheadiconnaturaldistance(model.headicon, 30);
  setheadiconzoffset(model.headicon, 10);

  for(;;) {
    model waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
      continue;
    }
    player thread edit_loadout(model);
  }
}

edit_loadout(interaction) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  level thread _id_54DAC17E1C475546(self, interaction);
  interaction disableplayeruse(self);
  self setclientomnvar("cp_open_cac", -1);
  self setclientomnvar("ui_options_menu", 2);
  scripts\engine\utility::waittill_any_2("loadout_given", "loadout_menu_closed");
  wait 1;
  self setclientomnvar("cp_open_cac", -2);
  interaction enableplayeruse(self);
}

_id_54DAC17E1C475546(player, interaction) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("loadout_menu_closed");
  player waittill("last_stand_start");
  level thread _id_61F53ED6CFDE56B4(player, interaction);
  player setclientomnvar("cp_open_cac", -2);
  player clearsoundsubmix("cp_store_duck", 1);
}

_id_61F53ED6CFDE56B4(player, interaction) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("revive");
  player waittill("respawn_player");

  if(isDefined(interaction) && isPlayer(player))
    interaction enableplayeruse(player);
}

mission_select_think(_id_AA1ED8F12D71A7A5) {
  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    self makeunusable();
    scripts\cp\cp_dialogue::stop_current_dialogue();
    thread run_mission(_id_AA1ED8F12D71A7A5);
    level notify("mission_selected", _id_AA1ED8F12D71A7A5);
    self.used = 1;
    return;
  }
}

run_mission(_id_AA1ED8F12D71A7A5) {
  scripts\engine\utility::delaythread(2, scripts\cp\cp_objectives::run_objective, _id_AA1ED8F12D71A7A5, "primary");
}

safehouse_revive_and_move_players(_id_FEFF3079E90EC019) {
  foreach(index, player in level.players) {
    inlaststand = 0;

    if(_id_0AFB7E332AEE4BF2::player_in_laststand(player))
      inlaststand = 1;

    player thread player_move(_id_FEFF3079E90EC019, index, inlaststand);
  }
}

player_move(_id_FEFF3079E90EC019, index, inlaststand) {
  self endon("disconnect");
  _id_FEFF3079E90EC019[index].angles = scripts\engine\utility::ter_op(isDefined(_id_FEFF3079E90EC019[index].angles), _id_FEFF3079E90EC019[index].angles, (0, 0, 0));
  self.respawn_forcespawnorigin = _id_FEFF3079E90EC019[index].origin;
  self.respawn_forcespawnangles = _id_FEFF3079E90EC019[index].angles;

  if(istrue(inlaststand))
    _id_0AFB7E332AEE4BF2::instant_revive(self);

  if(isDefined(self.currentturret))
    self.currentturret notify("kill_turret", 0, 0);

  if(isDefined(level.choppergunners)) {
    foreach(gunner in level.choppergunners)
    gunner scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_returnplayer(0, 0);
  }

  if(isDefined(self.helperdrone))
    self.helperdrone scripts\cp_mp\killstreaks\helper_drone::_id_06EDFDA4764129E3(0);

  if(istrue(self isonladder())) {
    self setOrigin(getgroundposition(self.origin + anglesToForward(self.angles) * -50, 16));
    wait 0.1;
  }

  player_vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(player_vehicle)) {
    seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(player_vehicle, self);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(player_vehicle, seatid, self, undefined, 1);
  }

  self setOrigin(_id_FEFF3079E90EC019[index].origin);
  self setplayerangles(_id_FEFF3079E90EC019[index].angles);
}

num_players_in_safehouse(volume) {
  _id_A25A40BDD7BF4112 = 0;

  if(isDefined(volume)) {
    foreach(player in level.players) {
      if(player istouching(volume))
        _id_A25A40BDD7BF4112++;
    }
  }

  return _id_A25A40BDD7BF4112;
}

safehouse_regroup(_id_D2A2486A309653CA, flagname) {
  index = 0;
  _id_4ACCC3DBB1732233 = 0;

  while(index < 31) {
    _id_50109AF25B2B0AF2 = num_players_in_safehouse(_id_D2A2486A309653CA);
    _id_926AA1E4673BB544 = get_respawning_players();

    if(_id_50109AF25B2B0AF2 && _id_926AA1E4673BB544.size == 0) {
      level notify("player_entered_safehouse_vol");

      if(_id_50109AF25B2B0AF2 == level.players.size) {
        if(!_id_4ACCC3DBB1732233) {
          thread scripts\cp\utility::objective_update("safehouse_return_timer", 6, undefined, undefined, 1, undefined, 1, 1);
          _id_4ACCC3DBB1732233 = 1;
          index = int(max(index, 25));
        }
      } else if(!_id_4ACCC3DBB1732233) {
        thread scripts\cp\utility::objective_update("safehouse_return_timer", 30, 20, 10, 1, undefined, 1, 1);
        _id_4ACCC3DBB1732233 = 1;
      }

      index++;
    } else {
      if(_id_4ACCC3DBB1732233) {
        scripts\cp\cp_objectives::lua_objective_complete("safehouse_return_timer");
        thread scripts\cp\utility::objective_update("safehouse_return");
        _id_4ACCC3DBB1732233 = 0;
      }

      index = 0;
    }

    wait 1;
  }

  if(isDefined(flagname) && scripts\engine\utility::flag_exist(flagname))
    scripts\engine\utility::flag_set(flagname);
}

get_respawning_players() {
  guys = [];

  foreach(player in level.players) {
    if(istrue(player.queued_up_to_respawn) || istrue(player isparachuting()) || istrue(player isskydiving()) || istrue(self.isreviving) || istrue(self.beingrevived))
      guys[guys.size] = player;
  }

  return guys;
}

safehouse_create_loot(loot_boxes) {
  foreach(_id_FFA1C8C5E081786D in loot_boxes)
  _id_FFA1C8C5E081786D thread scripts\cp\utility::create_fake_loot();
}

toggle_safehouse_doors(frozen, pos, radius, name, key) {
  _id_786FD7C325A6D910 = getentitylessscriptablearray("scriptable_" + name, key, pos, radius);

  foreach(_id_26BAEFB3804B52C3 in _id_786FD7C325A6D910) {
    if(_id_26BAEFB3804B52C3 scriptableisdoor()) {
      if(frozen) {
        timeout = 0;
        _id_26BAEFB3804B52C3 scriptabledoorclose();

        while(!_id_26BAEFB3804B52C3 scriptabledoorisclosed() && timeout < 10) {
          wait 0.1;
          timeout++;
        }

        _id_26BAEFB3804B52C3 scriptabledoorfreeze(1);
        continue;
      }

      _id_26BAEFB3804B52C3 scriptabledoorfreeze(0);
    }
  }
}

wait_for_door_open(pos, radius, name, key) {
  _id_786FD7C325A6D910 = getentitylessscriptablearray("scriptable_" + name, key, pos, radius);

  foreach(_id_26BAEFB3804B52C3 in _id_786FD7C325A6D910) {
    if(_id_26BAEFB3804B52C3 scriptableisdoor())
      _id_26BAEFB3804B52C3 thread wait_for_open();
  }
}

wait_for_open() {
  while(self scriptabledoorisclosed())
    wait 1;

  level notify("safehouse_door_opened");
}

play_overlord_howcopy_vo(_id_B2BC8B6FD1D16561) {
  _id_356974BDF96A636E = [];
  _id_356973BDF96A613B = [];
  _id_356974BDF96A636E[_id_356974BDF96A636E.size] = "dx_cps_kama_convo_start_10";
  _id_356974BDF96A636E[_id_356974BDF96A636E.size] = "dx_cps_kama_convo_start_20";
  _id_356974BDF96A636E[_id_356974BDF96A636E.size] = "dx_cps_kama_convo_start_30";
  _id_356973BDF96A613B[_id_356973BDF96A613B.size] = "dx_cps_lass_convo_start_10";
  _id_356973BDF96A613B[_id_356973BDF96A613B.size] = "dx_cps_lass_convo_start_20";
  _id_356973BDF96A613B[_id_356973BDF96A613B.size] = "dx_cps_lass_convo_start_30";
  _id_9FF666D3B44E5BAD = undefined;

  if(isDefined(_id_B2BC8B6FD1D16561)) {
    if(_id_B2BC8B6FD1D16561 == "kama")
      _id_9FF666D3B44E5BAD = scripts\engine\utility::random(_id_356974BDF96A636E);
    else if(_id_B2BC8B6FD1D16561 == "lass")
      _id_9FF666D3B44E5BAD = scripts\engine\utility::random(_id_356973BDF96A613B);
  } else if(scripts\engine\utility::cointoss())
    _id_9FF666D3B44E5BAD = scripts\engine\utility::random(_id_356974BDF96A636E);
  else
    _id_9FF666D3B44E5BAD = scripts\engine\utility::random(_id_356973BDF96A613B);

  level _id_166B4F052DA169A7::try_to_play_vo_on_team(_id_9FF666D3B44E5BAD, "allies");
  play_operator_reply_vo(undefined, "conv_generic_reply");
}

play_operator_reply_vo(_id_0DE3CAB686C13BA9, _id_097A10ADF707C9AF) {
  _id_45D25409ACB2D4F9 = scripts\cp\utility::getplayersinteam("allies");
  _id_0932DE1A48F2FAED = [];

  foreach(player in _id_45D25409ACB2D4F9) {
    if(player scripts\cp_mp\utility\player_utility::_isalive())
      _id_0932DE1A48F2FAED[_id_0932DE1A48F2FAED.size] = player;
  }

  _id_8850D9F771525016 = scripts\engine\utility::random(_id_0932DE1A48F2FAED);

  if(isDefined(_id_0DE3CAB686C13BA9))
    _id_8850D9F771525016 = _id_0DE3CAB686C13BA9;

  waittime = level scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_8850D9F771525016, _id_097A10ADF707C9AF);

  if(isfloat(waittime))
    wait(waittime);

  wait(0.4 + randomfloat(0.4));
}

safehouse_hotjoin_func() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", player);

    if(istrue(level.spawninsafehouse))
      player thread safehouse_spawn();
  }
}

safehouse_spawn() {
  self endon("disconnect");
  player = self;
  _id_586BD32DF4258AA5 = 0;

  for(;;) {
    if(isDefined(level.current_safehouse_spawn_structs)) {
      foreach(struct in level.current_safehouse_spawn_structs) {
        if(!scripts\cp\utility::any_player_nearby(struct.origin, 64)) {
          if(!isDefined(struct.angles))
            struct.angles = (0, 0, 0);

          player.respawn_forcespawnorigin = struct.origin;
          player.respawn_forcespawnangles = struct.angles;
          player setOrigin(struct.origin);
          player setplayerangles(struct.angles);
          player dontinterpolate();
          player toggle_player_settings(1);
          _id_586BD32DF4258AA5 = 1;
        }
      }
    }

    if(_id_586BD32DF4258AA5) {
      return;
    }
    wait 0.05;
  }
}

post_loadout_spawn_func() {
  self endon("disconnect");
  level endon("game_ended");

  while(isnullweapon(self getcurrentprimaryweapon()))
    wait 0.05;

  weaponobj = self getcurrentprimaryweapon();
  self setspawnweapon(weaponobj, 1);

  if(istrue(level.spawninsafehouse)) {
    self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");
    toggle_player_settings(1);
    self.player_latespawn_safehouse = 1;
  }
}

show_regroup_text(_id_892708EFF6520B44) {
  _id_DDAC31817B064B95 = getDvar("ui_mapname");
  _id_A1F826C73E18485B = "cp/" + _id_DDAC31817B064B95 + "_objectives.csv";
  _id_D31685C0A626FF37 = int(tablelookup(_id_A1F826C73E18485B, 1, _id_892708EFF6520B44, 0));
  self setclientomnvar("ui_hide_hud", 0);
  self setclientomnvar("ui_chyron_mission_index", _id_D31685C0A626FF37);
  self setclientomnvar("ui_chyron_on", 1);
  wait 5;
  level notify("regroup_text_done");
}