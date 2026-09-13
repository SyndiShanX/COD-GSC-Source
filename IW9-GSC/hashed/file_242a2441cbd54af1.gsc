/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_242a2441cbd54af1.gsc
***********************************************/

main() {
  thread _id_407E0F6FC77840B3::main();
  scripts\cp\tripwire_cp::init();
  scripts\cp_mp\tripwire::precachetrap("tripwire_trap_frag", "offhand_wm_grenade_mike67", 1);
  scripts\engine\utility::flag_wait("cp_jugg_maze_create_script_completed");
  _id_18AF78602B67B70C::_id_F331637729C41AA1("laser_section_ai", _id_407E0F6FC77840B3::_id_885D722C75B8B444);
  level._id_EF796AC0B0326726 = ::_id_5D07E8092CB10167;
  level._id_04056F15D39BCF78 = ::_id_4A2FEAC0DC1352A6;
  level._id_42354BFD2F2F8439 = undefined;
  level.skip_nav_check_on_spectate_respawn = 1;
  level.disable_start_spawn_on_navmesh = 1;
  level._id_F107BD5B4C54277E = ::_id_F107BD5B4C54277E;
  level._id_A359CB3E2BFA1964 = 0;
  level._id_9EEAB63C54988C55 = 0;
  level._id_359C318944444B78 = 0;
  level._id_318CEAE290567709 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0, 1, 0);
  level._id_8EE9C5604A4FB6C0 = 1024;
  level._id_460285F52F6BC514 = 1;
  scripts\engine\scriptable_door::_id_29BA88E5CE21F3FD(::_id_31C405AA2D21F0B5);
  scripts\engine\scriptable_door::_id_E37078F3D00EF312(::_id_42974A5D66E156B8);
  scripts\engine\scriptable_door::_id_87D7BE37D61CBAE3(::_id_20381C7B081C3F54);
  scripts\engine\scriptable::scriptable_adddamagedcallback(::_id_19BF2E0DFFA89EBC);
  thread _id_5826D89504B62568();

  if(getdvarint("dvar_733A1D9498A8DDD4", 1) == 0) {
    thread _id_8D7A8DE15EAA0B92();
    thread _id_2D41FDCF5C1175A8();
  } else
    level._id_BD139197F6CCA041 = 1;

  thread scripts\cp\coop_stealth::_id_778F9D9E0731E729();
  thread _id_A0C20755300001AA();
  thread _id_0DD51362FF2131A2();
  thread _id_531C536DCD04E20F::_id_40761E15A68A9D19();
  scripts\cp\utility::_id_119B3F1336549DDB("laser_mines_mines", undefined);

  if(getdvarint("dvar_A3A5CBE8DD44C5BA", 0) == 0) {
    if(!isDefined(level._id_18E49A0C7828BE42)) {
      _id_E6BCCE1FA7065344();
      thread _id_A6B15BB60621A60E();
    }
  }
}

_id_5826D89504B62568() {
  if(istrue(level._id_378BE3B1BD759734)) {
    return;
  }
  door = getEnt("easter_egg_laser_door", "targetname");
  door_clip = getEnt("easter_egg_laser_door_clip", "targetname");
  door_clip linkTo(door);
  _id_CED54E0BD7F2F1A9 = scripts\engine\utility::getStruct("easter_egg_laser_door_closed_origin", "targetname");
  door rotateYaw(90, 0.1);
  door.origin = _id_CED54E0BD7F2F1A9.origin;
}

_id_A0C20755300001AA() {
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("rock_spawn", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9E4E1482CB40C9C5.size; _id_AC0E594AC96AA3A8++) {
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdropinfo(_id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8].origin, _id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8].angles);
    _id_32E00752C95AAD17 = "brloot_rock";
    item = _id_66122A002AFF5D57::spawnpickup(_id_32E00752C95AAD17, _id_06FE80416B4BE165, undefined, undefined, undefined, 0);
  }
}

_id_F107BD5B4C54277E(_id_1CAC9684F46E935C, _id_FF03DED389B65A7D) {
  level endon("game_ended");
  level._id_CD59367309B1C64C = 1;
  _id_8502165817EFF3F4("The whole mine tunnel blew up.");
  thread _id_0AACD1A8DA2E127D();

  foreach(player in level.players) {
    player playlocalsound("cp_raid4_deathwipe_lr");

    if(istrue(player.inlaststand)) {
      player.shouldskipdeathsshield = 1;

      while(isalive(player)) {
        player dodamage(self.maxhealth, self.origin);
        waitframe();
      }
    }

    player notify("equip_deploy_cancel");
    player._id_1983AF7858AA2ABA = 1;
    player.shouldskipdeathsshield = 1;
    player.shouldskiplaststand = 1;
    player.nocorpse = 1;
    player.skipcorpse = 1;
    player._id_230A3287F9AD2965 = 1;
    player.ability_invulnerable = undefined;
    player _id_66122A002AFF5D57::_id_F0A8D592BDDE9818();
    player scripts\cp\utility::_id_4CBAED764C116A25(1);
    player _id_25845ACA699D038D::setdamageflag(1, 0);

    if(isDefined(self))
      player dodamage(player.maxhealth + 666, self.origin, self, self, "MOD_EXPLOSIVE", "claymore_radial_mp");
    else
      player dodamage(player.maxhealth + 666, player.origin, undefined, undefined, "MOD_EXPLOSIVE", "claymore_radial_mp");

    if(getdvarint("dvar_9011CF79C92FF4C8", 0)) {
      radiusdamage(player.origin, 82, 1000, 333, undefined, "MOD_EXPLOSIVE", "claymore_radial_mp");
      level thread _id_2204B41C7F95F49E(player);
    }

    thread scripts\cp_mp\utility\game_utility::_id_852712268D005332(player, 1, 1);
  }

  scripts\cp\utility::_id_9EE08F0499763465("laser_mines_mines");

  foreach(ai in getaiarray("axis"))
  ai _id_18A73A64992DD07D::script_kill_ai(undefined);

  _id_D5312FCD650A54EC = undefined;

  if(isDefined(_id_1CAC9684F46E935C)) {
    _id_8727333314C5EE5B = getdvarint("dvar_7E5BB2D1E24B408F", 0);
    _id_D5312FCD650A54EC = "cp_mine_fail";

    switch (_id_8727333314C5EE5B) {
      case 0:
        _id_D5312FCD650A54EC = "cp_mine_fail";
        break;
      case 1:
        _id_D5312FCD650A54EC = "cp_mine_fail_2";
        break;
      case 2:
        _id_D5312FCD650A54EC = "cp_mine_fail_3";
        break;
      case 3:
        _id_D5312FCD650A54EC = "cp_mine_fail_4";
        break;
    }

    if(scripts\engine\utility::is_equal(_id_1CAC9684F46E935C, level.farah))
      _id_D5312FCD650A54EC = "cp_mine_fail_farah";
    else if(scripts\engine\utility::is_equal(_id_1CAC9684F46E935C, level.price))
      _id_D5312FCD650A54EC = "cp_mine_fail_price";
    else if(scripts\engine\utility::is_equal(_id_1CAC9684F46E935C, level.alex))
      _id_D5312FCD650A54EC = "cp_mine_fail_alex";

    _id_8502165817EFF3F4("^1" + _id_1CAC9684F46E935C.name + "^7 TRIGGERED THE LASERS");
  } else {
    if(isDefined(self.lastattacker)) {
      _id_1CAC9684F46E935C = self.lastattacker;
      _id_D5312FCD650A54EC = "cp_mine_fail";

      if(scripts\engine\utility::is_equal(_id_1CAC9684F46E935C, level.farah))
        _id_D5312FCD650A54EC = "cp_mine_fail_farah";
      else if(scripts\engine\utility::is_equal(_id_1CAC9684F46E935C, level.price))
        _id_D5312FCD650A54EC = "cp_mine_fail_price";
      else if(scripts\engine\utility::is_equal(_id_1CAC9684F46E935C, level.alex))
        _id_D5312FCD650A54EC = "cp_mine_fail_alex";
    }

    _id_8502165817EFF3F4("SOME ONE SHOT A BARREL!!");
  }

  foreach(player in level.players) {
    player scripts\cp_mp\utility\player_utility::_id_82F44F5F304BA91A(1);
    player._id_E5E63A2028402D60 = 1;
  }

  wait 1;
  level notify("kill_firebarrel_threads");

  foreach(_id_A26122AC9285D5DF in level.explosive_barrels) {
    scripts\engine\utility::array_call(_id_A26122AC9285D5DF, ::setscriptablepartstate, "base", "healthy");

    foreach(_id_DDC4E4BDECFF28CD in _id_A26122AC9285D5DF)
    level thread _id_A1E140E4F5D84B86(_id_DDC4E4BDECFF28CD, _id_DDC4E4BDECFF28CD._id_7F5945B55E97B8B0);
  }

  thread _id_26C784319E58ABC6(_id_D5312FCD650A54EC, _id_1CAC9684F46E935C);
  wait 1;
  scripts\engine\utility::flag_set("resetting_mine");

  foreach(ai in getaiarray("axis"))
  ai _id_18A73A64992DD07D::script_kill_ai(undefined);

  if(getdvarint("dvar_068E3DEF35F916BB", 0))
    _id_A690799B59791632(level._id_B3A61E1FD4CE7D8A);

  if(getdvarint("dvar_CEE501805DDCF595", 0) != 0)
    _id_407E0F6FC77840B3::_id_CF412881BF661730(level._id_B3A61E1FD4CE7D8A, 1);

  thread _id_531C536DCD04E20F::_id_40761E15A68A9D19();

  foreach(player in level.players)
  thread scripts\cp_mp\utility\game_utility::_id_852712268D005332(player, 0, 1.75);

  wait 1.5;

  foreach(player in level.players) {
    player thread _id_9AFA04DDBCA5A664();

    if(player _id_098B53A7358927D9::_id_3F422A1C87BD2809()) {
      player.super_activated = 0;
      _id_56EF8D52FE1B48A1::_id_C5EA07DAC9D83685();
      clientnum = player getentitynumber();
      setomnvar("ui_class_power_reloading", clientnum);
      _id_89656F67C2EA228D = 0.2;
      player thread _id_644C18834356D9DC::_id_8F741E1E8E870100(_id_89656F67C2EA228D, 975);
      player _id_56EF8D52FE1B48A1::superusefinished();
      player _id_56EF8D52FE1B48A1::setsuperisinuse(0);
    }

    if(player hasweapon("deploy_sentry_mp"))
      player thread scripts\cp_mp\killstreaks\manual_turret::manualturret_switchbacklastweapon("deploy_sentry_mp", 1);

    if(player hasweapon("cluster_spike_mp"))
      player thread scripts\cp_mp\killstreaks\manual_turret::manualturret_switchbacklastweapon("cluster_spike_mp", 1);

    player thread _id_6D68CFDF0836123C::recondrone_takedeployweapon(1, "ks_remote_drone_mp");
    objweapon = makeweapon("ks_remote_drone_mp");

    if(player hasweapon(objweapon))
      player thread scripts\cp_mp\utility\inventory_utility::getridofweapon(objweapon);
  }

  if(isDefined(_id_FF03DED389B65A7D))
    thread _id_03097CF45C830283(_id_FF03DED389B65A7D, 3.5);

  level._id_CD59367309B1C64C = undefined;
  scripts\engine\utility::flag_clear("resetting_mine");
}

_id_03097CF45C830283(_id_FF03DED389B65A7D, delay) {
  level endon("game_ended");
  wait(delay);
  _id_FF03DED389B65A7D._id_C1ABC60CE5507E66._id_0788CF296B8CA51A = undefined;
}

_id_0AACD1A8DA2E127D() {
  keys = getarraykeys(level.explosive_barrels);
  barrels = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
    _id_A26122AC9285D5DF = level.explosive_barrels[keys[_id_AC0E594AC96AA3A8]];
    barrels = scripts\engine\utility::array_combine(barrels, _id_A26122AC9285D5DF);
  }

  _id_107E397CB8E396AD = [];

  foreach(player in level.players) {
    _id_C01379099D0A1D6A = sortbydistance(barrels, player.origin);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < int(min(_id_C01379099D0A1D6A.size, 15)); _id_AC0E594AC96AA3A8++)
      _id_107E397CB8E396AD[_id_107E397CB8E396AD.size] = _id_C01379099D0A1D6A[_id_AC0E594AC96AA3A8];
  }

  _id_107E397CB8E396AD = scripts\engine\utility::array_remove_duplicates(_id_107E397CB8E396AD);

  for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_107E397CB8E396AD.size; _id_AC0E5C4AC96AAA41++) {
    _id_DDC4E4BDECFF28CD = _id_107E397CB8E396AD[_id_AC0E5C4AC96AAA41];
    _id_DDC4E4BDECFF28CD _id_479DB0C77BE4CE56("base", "death_short_fx");
  }
}

_id_479DB0C77BE4CE56(part, state) {
  self setscriptablepartstate(part, state);
}

_id_26C784319E58ABC6(_id_D5312FCD650A54EC, _id_1CAC9684F46E935C) {
  level endon("game_ended");
  level notify("mine_showExplosionSplash");
  level endon("mine_showExplosionSplash");

  if(isDefined(_id_D5312FCD650A54EC) && isDefined(_id_1CAC9684F46E935C)) {
    foreach(player in level.players)
    player thread scripts\cp\cp_hud_message::showsplash(_id_D5312FCD650A54EC, undefined, _id_1CAC9684F46E935C, undefined, undefined, undefined);
  }
}

_id_9AFA04DDBCA5A664() {
  self endon("disconnect");
  level endon("game_ended");
  scripts\cp\utility::_id_4CBAED764C116A25(0);
  self._id_E5E63A2028402D60 = undefined;
  scripts\cp_mp\utility\player_utility::_id_82F44F5F304BA91A(0);
}

_id_8502165817EFF3F4(message) {
  if(getdvarint("dvar_77E93B621A8AAD91", 0))
    announcement(message);
}

_id_E84200887348C6BD() {
  scripts\engine\utility::flag_set("slow_motion_active");
  setslowmotion(1, 0.5, 2);
  wait 2;
  wait 1.5;
  setslowmotion(1, 1, 2);
  scripts\engine\utility::flag_clear("slow_motion_active");
}

_id_2204B41C7F95F49E(player) {
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");
  waitframe();

  while(isalive(player)) {
    player.shouldskipdeathsshield = 1;
    player dodamage(player.maxhealth, player.origin, undefined, undefined, "MOD_TRIGGER_HURT");
    waitframe();
  }
}

_id_2D41FDCF5C1175A8() {
  level.atvs = [];
  level._id_507FE054D5119EB8._id_D397FE63BC6BF8D6 = [];
  _id_BFE291B401A9BF2A = scripts\engine\utility::getStructArray("atv_spawn", "targetname");
  scripts\cp\vehicles\atv_cp::atv_cp_createfromstructs(_id_BFE291B401A9BF2A, 3);

  foreach(atv in level.atvs) {
    atv.maxhealth = 666;
    atv.health = atv.maxhealth;
    atv._id_2CE864BD06FB0385 = ::_id_EDD3BF469575C2A2;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(atv);
    level._id_507FE054D5119EB8._id_D397FE63BC6BF8D6 = scripts\engine\utility::array_add(level._id_507FE054D5119EB8._id_D397FE63BC6BF8D6, atv);
    thread _id_A837D837E9F1BD9A(atv);
  }
}

_id_8D7A8DE15EAA0B92() {
  level._id_C8CEED7564E3E219 = getEntArray("speed_trigger", "targetname");

  foreach(_id_D0D7C41824E9AA66 in level._id_C8CEED7564E3E219)
  _id_D0D7C41824E9AA66 thread _id_92333D534E79E86B();
}

_id_92333D534E79E86B() {
  self endon("death");
  level endon("game_ended");
  level endon("mine_section_complete");

  for(;;) {
    self waittill("trigger", entity);

    if(isDefined(entity)) {
      if(isPlayer(entity)) {
        foreach(payload in level._id_507FE054D5119EB8._id_D397FE63BC6BF8D6) {
          if(payload istouching(self)) {
            _id_780041E1B165E581(payload);
            payload.customspeed = scripts\engine\utility::ter_op(getdvarfloat("dvar_DBE3BAB578841EFF", 0) > 0, getdvarfloat("dvar_DBE3BAB578841EFF", 0), float(self.script_noteworthy));
            _id_306086590CA57213(payload);
            payload thread _id_0FAE2C819A8FBEFC(payload);
            payload thread _id_FA734574162CD0DF();

            if(getdvarint("dvar_F1338999BDDD03CB", 0) == 0)
              level thread _id_2BA828779F94A666("allies", level._id_507FE054D5119EB8);
          }
        }

        return;
      }

      if(!entity scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        continue;
      }
      payload = entity;
      _id_780041E1B165E581(payload);
      payload.customspeed = scripts\engine\utility::ter_op(getdvarfloat("dvar_DBE3BAB578841EFF", 0) > 0, getdvarfloat("dvar_DBE3BAB578841EFF", 0), float(self.script_noteworthy));
      _id_306086590CA57213(payload);
      payload thread _id_0FAE2C819A8FBEFC(payload);
      payload thread _id_FA734574162CD0DF();

      if(getdvarint("dvar_F1338999BDDD03CB", 0) == 0)
        level thread _id_2BA828779F94A666("allies", level._id_507FE054D5119EB8);
    }
  }
}

_id_A9210CF034801A19(_id_FA927B0338099D9F, blocked) {
  objectivestruct = level._id_507FE054D5119EB8;

  if(istrue(blocked))
    objective_setlabel(_id_FA927B0338099D9F, &"CP_OBJ_PAYLOAD/BLOCKED");
  else
    objective_setlabel(_id_FA927B0338099D9F, &"CP_OBJ_PAYLOAD/ESCORT");
}

_id_A837D837E9F1BD9A(atv) {
  level._id_507FE054D5119EB8._id_0EC9392B7DF7312F = scripts\cp\cp_objectives::requestworldid(69);
  objective_setplayintro(level._id_507FE054D5119EB8._id_0EC9392B7DF7312F, 1);
  objective_state(level._id_507FE054D5119EB8._id_0EC9392B7DF7312F, "current");
  objective_icon(level._id_507FE054D5119EB8._id_0EC9392B7DF7312F, "icon_waypoint_objective_general");
  objective_setzoffset(level._id_507FE054D5119EB8._id_0EC9392B7DF7312F, 64);
  objective_onentity(level._id_507FE054D5119EB8._id_0EC9392B7DF7312F, atv);
  objective_setlabel(level._id_507FE054D5119EB8._id_0EC9392B7DF7312F, &"CP_OBJ_PAYLOAD/ESCORT");
  objective_sethot(level._id_507FE054D5119EB8._id_0EC9392B7DF7312F, 0);
  _id_CBD3F7020EC784E3 = scripts\engine\utility::getStruct("payload_obj_start_01", "targetname");
  _id_BA0030FC5A7F6D45 = _id_CBD3F7020EC784E3;
  atv.pathing_array = [];

  for(atv.pathing_array[0] = _id_BA0030FC5A7F6D45.origin; isDefined(_id_BA0030FC5A7F6D45.target); atv.pathing_array[atv.pathing_array.size] = _id_BA0030FC5A7F6D45.origin)
    _id_BA0030FC5A7F6D45 = scripts\engine\utility::getStruct(_id_BA0030FC5A7F6D45.target, "targetname");

  atv.health = 30000;
  atv.totalhealth = 30000;
  atv.nexthealthtiercalledout = 80;
  atv.disable_player_collision_damage = 1;
  _id_473D8BDF00AA1996 = [];
  amount = atv.pathing_array.size;
  currentpoint = undefined;
  _id_A414823CB904BF00 = _id_CBD3F7020EC784E3.origin;
  atv.customspeed = scripts\engine\utility::ter_op(getdvarfloat("dvar_DBE3BAB578841EFF", 0) > 0, getdvarfloat("dvar_DBE3BAB578841EFF", 0), 10);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < amount; _id_AC0E594AC96AA3A8++) {
    if(isDefined(atv.pathing_array[_id_AC0E594AC96AA3A8 + 1]))
      currentpoint = atv.pathing_array[_id_AC0E594AC96AA3A8 + 1];

    _id_D530F6290FEC0A8C = get_duration_between_points(_id_A414823CB904BF00, currentpoint, atv.customspeed, 1);
    _id_473D8BDF00AA1996[_id_473D8BDF00AA1996.size] = min(_id_D530F6290FEC0A8C, 20);
    _id_A414823CB904BF00 = currentpoint;
  }

  atv thread _id_0FAE2C819A8FBEFC(atv);
  atv thread _id_FA734574162CD0DF();
  atv thread _id_68FC32D7542C915F(_id_A414823CB904BF00);
  atv _meth_648766DDD39F403C(0.2);
  atv startpathnodes(atv.pathing_array, _id_473D8BDF00AA1996);
  atv.veh_pathtype = "constrained";
  waitframe();
  _id_780041E1B165E581(atv);

  if(getdvarint("dvar_F1338999BDDD03CB", 0) == 0)
    level thread _id_2BA828779F94A666("allies", level._id_507FE054D5119EB8);
  else {
    atv.customspeed = scripts\engine\utility::ter_op(getdvarfloat("dvar_DBE3BAB578841EFF", 0) > 0, getdvarfloat("dvar_DBE3BAB578841EFF", 0), 10);
    level thread _id_306086590CA57213(atv);
  }
}

get_duration_between_points(startpos, endpos, speed, _id_AC43678ED65C8B44) {
  dist = distance(startpos, endpos);

  if(istrue(_id_AC43678ED65C8B44))
    dist = dist * 0.0568182;

  _id_58824A41B5315792 = dist / speed;

  if(_id_58824A41B5315792 < 0.05)
    _id_58824A41B5315792 = 0.05;

  return _id_58824A41B5315792;
}

_id_EDD3BF469575C2A2(data) {
  modifier = 33.33;

  if(istrue(data.isrearcriticaldamage))
    data.damage = int(data.damage * 3 * modifier);
  else
    data.damage = int(data.damage * 2 * modifier);

  return 1;
}

_id_FA734574162CD0DF() {
  level endon("game_ended");
  self endon("payload_reached_goal");
  self notify("payload_watchForPayloadDamage");
  self endon("payload_watchForPayloadDamage");
  self waittill("death");
  objectivestruct = level._id_507FE054D5119EB8;
  objectivestruct._id_DF757593A1787925 = 1;
  objectivestruct notify("payload_apc_destroyed");
  objectivestruct notify("payload_objective_done");
  _id_8850D9F771525016 = scripts\engine\utility::random(level.players);

  if(isDefined(_id_8850D9F771525016))
    thread scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_8850D9F771525016, "stat_C8122B0900BA529D");

  if(!isDefined(level.armsrace_caches_defended))
    level.armsrace_caches_defended = 0;

  if(level.armsrace_caches_defended <= 0) {
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
    objectivestruct.failedmission = 1;
  }
}

_id_68FC32D7542C915F(_id_B7AB7579B3C791B1) {
  level endon("game_ended");
  self endon("death");
  objectivestruct = level._id_507FE054D5119EB8;

  while(distance(self.origin, _id_B7AB7579B3C791B1) > 100)
    wait 0.5;

  self notify("payload_reached_goal");
  waitframe();
  objectivestruct thread _id_780041E1B165E581(self);
  objectivestruct notify("payload_objective_done");
  _id_8850D9F771525016 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("allies"));

  if(isDefined(_id_8850D9F771525016)) {
    waittime = level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_8850D9F771525016, "stat_2F4FCDB5F53AF5CA");

    if(isDefined(waittime))
      wait(waittime + 1.5);
  }

  level._id_BD139197F6CCA041 = 1;
}

_id_0FAE2C819A8FBEFC(payload) {
  level endon("game_ended");
  self endon("death");
  self notify("payload_watchForPlayersInFront");
  self endon("payload_watchForPlayersInFront");
  level endon("mine_section_complete");

  for(;;) {
    frontpoint = scripts\cp\utility::get_point_in_local_ent_space(payload, (128, 0, 0));

    if(is_a_player_near(frontpoint, 64)) {
      level._id_507FE054D5119EB8._id_D37808A2EE7DD4AB = 1;
      _id_A9210CF034801A19(level._id_507FE054D5119EB8._id_0EC9392B7DF7312F, 1);
      _id_780041E1B165E581(payload);
    } else {
      level._id_507FE054D5119EB8._id_D37808A2EE7DD4AB = 0;
      _id_A9210CF034801A19(level._id_507FE054D5119EB8._id_0EC9392B7DF7312F, 0);
    }

    wait 1;
  }
}

is_a_player_near(point, distance) {
  foreach(player in level.players) {
    if(distance(player.origin, point) <= distance)
      return 1;
  }

  return 0;
}

_id_9399FC86660D5D86(_id_27FDFAAC7F98E382, _id_830905E5C2645826, _id_76FC9C72CBF75ECA) {
  level endon("game_ended");
  level endon(_id_830905E5C2645826);

  if(!isDefined(_id_76FC9C72CBF75ECA))
    _id_76FC9C72CBF75ECA = squared(120);

  for(;;) {
    if(scripts\cp\utility::are_all_players_nearby(_id_27FDFAAC7F98E382.origin, _id_76FC9C72CBF75ECA)) {
      level notify(_id_830905E5C2645826);
      return;
    }

    wait 1;
  }
}

_id_2BA828779F94A666(team, objectivestruct) {
  level endon("game_ended");
  self notify("payload_watchForPlayerProximity");
  self endon("payload_watchForPlayerProximity");
  level endon("mine_section_complete");
  objectivestruct endon("payload_apc_destroyed");
  payload = level._id_507FE054D5119EB8._id_D397FE63BC6BF8D6[0];
  payload endon("payload_reached_goal");
  payload endon("death");
  _id_5B249E3D30D30B9A = "stopped";
  _id_297A5E5B735CE586 = "";

  while(!istrue(objectivestruct._id_DF757593A1787925)) {
    if(istrue(objectivestruct.ispayloadstunned) || istrue(objectivestruct.ispayloadpaused) || istrue(objectivestruct._id_D37808A2EE7DD4AB)) {
      _id_297A5E5B735CE586 = "";
      wait 2;
      continue;
    }

    players = scripts\cp\utility::getplayersinteam(team);
    _id_8DF5E4888693968F = 0;

    foreach(player in players) {
      if(distance(player.origin, payload.origin) <= 133)
        _id_8DF5E4888693968F++;
    }

    if(_id_8DF5E4888693968F > 0 || istrue(objectivestruct.ispayloadautomaticallymoving))
      _id_5B249E3D30D30B9A = "moving";
    else
      _id_5B249E3D30D30B9A = "stopped";

    if(_id_5B249E3D30D30B9A != _id_297A5E5B735CE586) {
      _id_297A5E5B735CE586 = _id_5B249E3D30D30B9A;

      if(_id_5B249E3D30D30B9A == "moving")
        level thread _id_306086590CA57213(payload);
      else
        level thread _id_780041E1B165E581(payload);
    }

    wait 1;
  }
}

_id_780041E1B165E581(atv) {
  speed = getdvarfloat("dvar_33CB8FE5B4EF69DF", atv.customspeed);
  atv vehicle_setspeedimmediate(0, speed, speed);
  atv vehicle_cleardrivingstate();
  atv childthread _id_24E4405CF93F20ED::_id_C4D871CCF375FB3B();
}

_id_306086590CA57213(atv) {
  speed = getdvarfloat("dvar_33CB8FE5B4EF69DF", atv.customspeed);
  atv _meth_65AA053C077C003A(0);
  atv resumespeed(speed);
}

_id_AB1910B1FE79295E() {
  level._id_4EA46C6946A1E56F = getEnt("endOfScriptTrigger_mine", "targetname");
  level._id_4EA46C6946A1E56F.origin = (-1278.36, 8640.55, -3701.25);
  level._id_4EA46C6946A1E56F thread _id_BDC427F957C93E9F();
}

_id_C5B3082A763524BE(objectivestruct) {
  while(!isDefined(level._id_9E60A17EF1BA5BD9))
    waitframe();

  objectivestruct._id_D31685C0A626FF37 = scripts\cp\cp_objectives::requestworldid("mine" + objectivestruct.index, 1 + int(objectivestruct.index));
  objective_setplayintro(objectivestruct._id_D31685C0A626FF37, 1);
  objective_setplayoutro(objectivestruct._id_D31685C0A626FF37, 1);
  objective_setlocation(objectivestruct._id_D31685C0A626FF37, 0, level._id_9E60A17EF1BA5BD9.origin);
  objective_state(objectivestruct._id_D31685C0A626FF37, "current");
  objective_icon(objectivestruct._id_D31685C0A626FF37, "icon_waypoint_objective_general");
  level._id_9E60A17EF1BA5BD9._id_D31685C0A626FF37 = objectivestruct._id_D31685C0A626FF37;
}

_id_BDC427F957C93E9F() {
  self endon("death");
  level endon("game_ended");
  _id_9399FC86660D5D86(self, "players_reached_jugg_maze");
  return;
}

_id_383F128FBDC68574() {
  _id_3F20D39AA8BDC920();
}

_id_3F20D39AA8BDC920() {
  _id_18A73A64992DD07D::registerambientgroup("intro_section_a", 4, 4, 4, 0.05, undefined, "intro_section_a", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_section_a", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_section_catwalk_a", 2, 2, 2, 0.05, undefined, "intro_section_catwalk_a", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_section_catwalk_a", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_section_catwalk_b", 1, 1, 1, 0.05, undefined, "intro_section_catwalk_b", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_section_catwalk_b", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_section_catwalk_c", 2, 2, 2, 0.05, undefined, "intro_section_catwalk_c", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_section_catwalk_c", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_section_b", 1, 1, 1, 0.05, undefined, "intro_section_b", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_section_b", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_section_c", 5, 5, 5, 0.05, undefined, "intro_section_c", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_section_c", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_room_a", 3, 3, 3, 0.05, undefined, "intro_room_a", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_room_a", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_room_ab", 3, 3, 3, 0.05, undefined, "intro_room_ab", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_room_ab", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_room_b", 6, 6, 6, 0.05, undefined, "intro_room_b", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_room_b", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_room_c", 8, 8, 8, 0.05, undefined, "intro_room_c", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_room_c", ::_id_14FE3380FA58FDF5);
  _id_18A73A64992DD07D::registerambientgroup("intro_reinforcements_final", 8, 8, 8, 0.05, undefined, "intro_reinforcements_final", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_reinforcements_final", ::_id_00F596B70FD6B78E);
  _id_18A73A64992DD07D::registerambientgroup("intro_reinforcements_first", 6, 6, 6, 0.05, undefined, "intro_reinforcements_first", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_reinforcements_first", ::_id_00F596B70FD6B78E);
  _id_18A73A64992DD07D::registerambientgroup("intro_reinforcements_second", 6, 6, 6, 0.05, undefined, "intro_reinforcements_second", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_reinforcements_second", ::_id_00F596B70FD6B78E);
}

_id_F161C068112045E3(event) {
  _id_7B64EABBDC923F61 = ["silenced_shot", "silenced_shot_impact", "death", "ally_killed", "ally_damaged", "footstep", "footstep_sprint", "footstep_walk", "gunshot_impact", "projectile_impact"];
  _id_1F3A015EEC95CC1E = ["silenced_shot", "silenced_shot_impact", "death", "ally_killed", "ally_damaged", "footstep", "footstep_walk", "footstep_sprint"];

  if(scripts\engine\utility::array_contains(_id_7B64EABBDC923F61, event.typeorig)) {
    if(isDefined(event.origin)) {
      if(!self hastacvis(event.origin, 1) && !_id_CA53F38B1EB70113(event.origin, 1, level._id_8EE9C5604A4FB6C0))
        return 1;
      else {}
    }
  }

  if(_id_D4A08728BF86E790(event) && scripts\engine\utility::array_contains(_id_1F3A015EEC95CC1E, event.typeorig))
    return 1;

  if(_id_9A9B91C11482389F(event))
    return 1;

  if(event.typeorig == "grenade danger" && event.type != "cover_blown") {
    if(isDefined(event.entity.weapon_name) && issubstr(event.entity.weapon_name, "flash")) {
      _id_106C6FA2ECA424EA = 262144;

      if(!self hastacvis(event.origin))
        return 1;
    }
  }

  if(isDefined(event.type) && event.type == "combat" || event.type == "cover_blown")
    return 0;

  return 0;
}

_id_D4A08728BF86E790(ent) {
  return abs(ent.origin[2] - self.origin[2]) > 120;
}

_id_9A9B91C11482389F(event) {
  _id_9AE80645C2B78E8A = [];

  if(isDefined(self.stealth._id_90CDC499FC2BDDD7))
    _id_9AE80645C2B78E8A = scripts\cp\utility::array_merge(_id_9AE80645C2B78E8A, self.stealth._id_90CDC499FC2BDDD7);

  if(scripts\engine\utility::array_contains(_id_9AE80645C2B78E8A, event.typeorig))
    return 1;

  _id_1C01519BD9CEC9A6 = event.typeorig == "grenade danger" && isDefined(event.entity) && isDefined(event.entity.weapon_name) && scripts\engine\utility::is_equal(event.entity.weapon_name, "geiger_counter_mp");

  if(_id_1C01519BD9CEC9A6)
    return 1;

  _id_4A3A80533AD1E7B0 = 0;

  if(getdvarint("dvar_1994C3FB0C180F74", 1))
    _id_4A3A80533AD1E7B0 = event.typeorig == "grenade danger" && !isDefined(event.entity);

  if(_id_4A3A80533AD1E7B0)
    return 1;

  return 0;
}

_id_CA53F38B1EB70113(origin, _id_7E6761D0C6470CA2, dist) {
  if(!isDefined(_id_7E6761D0C6470CA2))
    _id_7E6761D0C6470CA2 = 1;

  if(_id_7E6761D0C6470CA2 && !scripts\engine\utility::within_fov(self.origin, self.angles, origin, cos(180)))
    return 0;

  _id_67245ACC80F2296D = _id_CABCC7C3E8682497();
  _id_C127D102DD2295C3 = _id_0B071913D4B91319();

  if(!isDefined(dist))
    dist = 1024;

  if(!_id_86C6AFB41A6C383B(_id_67245ACC80F2296D, origin, dist))
    return 0;

  if(_id_86C6AFB41A6C383B(_id_67245ACC80F2296D, origin, level.stealth.damage_sight_range))
    return 1;

  if(_id_7E6761D0C6470CA2) {
    if(isai(self) && !self aipointinfov(origin))
      return 0;
  }

  _id_125435EA93CCA389 = level._id_318CEAE290567709;
  return scripts\engine\trace::ray_trace_passed(_id_67245ACC80F2296D, origin, [self], _id_125435EA93CCA389);
}

_id_86C6AFB41A6C383B(start, end, dist) {
  if(!isDefined(start) || !isDefined(end))
    return 0;

  return distancesquared(start, end) <= dist * dist;
}

_id_CABCC7C3E8682497() {
  if(isDefined(self._id_18718F98529A77D8)) {
    if(self._id_695601297697AB71 == gettime())
      return self._id_18718F98529A77D8;

    if(isDefined(self._id_DF2EC152343705D2) && self._id_DF2EC152343705D2 == self.origin)
      return self._id_18718F98529A77D8;
  }

  if(isai(self))
    self._id_18718F98529A77D8 = self getEye();
  else {
    self._id_18718F98529A77D8 = self gettagorigin("tag_eye");
    self._id_DF2EC152343705D2 = self.origin;
  }

  self._id_695601297697AB71 = gettime();
  return self._id_18718F98529A77D8;
}

_id_0B071913D4B91319() {
  if(isDefined(self._id_2B5F8CE7DE8E2AF2)) {
    if(self._id_BE76BF1CCA511D73 == gettime())
      return self._id_2B5F8CE7DE8E2AF2;

    if(isDefined(self._id_87B23FA7022B1C46) && self._id_87B23FA7022B1C46 == self.angles)
      return self._id_2B5F8CE7DE8E2AF2;
  }

  self._id_2B5F8CE7DE8E2AF2 = self gettagangles("tag_eye");
  self._id_BE76BF1CCA511D73 = gettime();
  return self._id_2B5F8CE7DE8E2AF2;
}

_id_F033CE8FEFC9CFDA(group_name, func) {
  setup_soldier_stealth(group_name, func);
  _id_BBAECC3D1A13A428(group_name);
  scripts\stealth\utility::set_stealth_func("event_investigate", ::_id_F161C068112045E3);
  scripts\stealth\utility::set_stealth_func("event_cover_blown", ::_id_F161C068112045E3);
  scripts\stealth\utility::set_stealth_func("event_combat", ::_id_F161C068112045E3);
  thread _id_80DC965028D873A2("downstairs");
  _id_07CE00325DB4A194();

  if(istrue(level._id_5F4F92A8E2B137E7)) {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }
    spawner = self.spawner;
    _id_3B2C9CA866EA9EAC = scripts\engine\utility::ter_op(isDefined(spawner.target), scripts\engine\utility::getStruct(spawner.target, "targetname"), scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("dock_edge", "targetname"), 1024));
    self._id_97DB6F81BA0702E3 = 1000;
    self.stealth.script_nexthuntpos = _id_3B2C9CA866EA9EAC.origin;
    self[[self.fnsetstealthstate]]("hunt");
  }
}

_id_07CE00325DB4A194() {
  if(_func_EAC0CD99C9C6D8EE() == "spotted") {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }
    player = scripts\cp\utility::get_closest_living_player();

    if(isDefined(player)) {
      self setgoalpos(player.origin);
      event = spawnStruct();
      event.typeorig = "combat";
      event.type = "combat";
      event.origin = player.origin;
      event.investigate_pos = player.origin;
      self[[self.fnsetstealthstate]]("combat", event);
    }

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
      self getenemyinfo(level.players[_id_AC0E594AC96AA3A8]);

    _id_18A73A64992DD07D::set_goal_radius(2048);
    return;
  }
}

_id_14FE3380FA58FDF5(group_name, func) {
  setup_soldier_stealth(group_name, func);
  scripts\stealth\utility::set_stealth_func("event_investigate", ::_id_F161C068112045E3);
  scripts\stealth\utility::set_stealth_func("event_cover_blown", ::_id_F161C068112045E3);
  scripts\stealth\utility::set_stealth_func("event_combat", ::_id_F161C068112045E3);
  thread _id_80DC965028D873A2("downstairs");
  _id_07CE00325DB4A194();

  if(istrue(level._id_5F4F92A8E2B137E7)) {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }
    self[[self.fnsetstealthstate]]("hunt");
  }
}

_id_123701A00E645E19() {
  self.script_forcegrenade = 1;
  self.grenadeammo = 255;
  self.grenadesafedist = 200;
}

_id_D24590F588A71CA2() {
  _id_C729D49D406ACED8 = scripts\cp\utility::get_closest_living_player();

  if(!isDefined(_id_C729D49D406ACED8))
    _id_C729D49D406ACED8 = scripts\engine\utility::getclosest(self.origin, level.players);

  thread _id_43A45E199254CE4F(_id_C729D49D406ACED8);
}

_id_43A45E199254CE4F(player) {
  self endon("death");
  self getenemyinfo(player);
  self.lastenemysightpos = player.origin;

  if(getdvarint("dvar_53839302A8032F77", 1) != 0)
    self._id_5323A94889EFF1DE = 1;

  self.goalradius = 2048;
  self.aggressivemode = 1;
  self setgoalentity(player);
  thread _id_6DAE2816A58B8A6D(player);
}

_id_6DAE2816A58B8A6D(player) {
  self endon("death");
  self endon("stop_player_seek");
  _id_7E1EC739AE6C0015 = 1200;
  _id_016D0BB7FD27FCFC = distance(self.origin, player.origin);

  for(;;) {
    wait 2;
    self clearbtgoal(0);
    self getenemyinfo(player);
    self setgoalentity(player);
    _id_016D0BB7FD27FCFC = _id_016D0BB7FD27FCFC - 175;

    if(_id_016D0BB7FD27FCFC < _id_7E1EC739AE6C0015) {
      _id_016D0BB7FD27FCFC = _id_7E1EC739AE6C0015;
      return;
    }
  }
}

_id_36A68D2EA9C75B0D(_id_F9FA10E07F13F5FD) {
  if(issubstr(_id_F9FA10E07F13F5FD, "ar_laser"))
    return "ar_laser";

  if(issubstr(_id_F9FA10E07F13F5FD, "ar"))
    return "ar";

  if(issubstr(_id_F9FA10E07F13F5FD, "shotgun"))
    return "shotgun";

  if(issubstr(_id_F9FA10E07F13F5FD, "sniper"))
    return "sniper";

  if(issubstr(_id_F9FA10E07F13F5FD, "lmg"))
    return "lmg";

  return _id_F9FA10E07F13F5FD;
}

_id_BBAECC3D1A13A428(group) {
  _id_A664AAD02EE98BD2 = "molotov_mp";
  _id_F9FA10E07F13F5FD = self.spawner.script_noteworthy;
  _id_F9FA10E07F13F5FD = _id_36A68D2EA9C75B0D(_id_F9FA10E07F13F5FD);

  switch (_id_F9FA10E07F13F5FD) {
    case "cartel_shotgun":
    case "shotgun":
      body = "body_sp_opforce_al_qatala_shotgun_1_2";
      head = "head_sp_opforce_al_qatala_ar";
      _id_A664AAD02EE98BD2 = "molotov_mp";
      break;
    case "sniper":
      body = "body_sp_opforce_al_qatala_sniper_1_2";
      head = "head_sp_opforce_al_qatala_ar";
      _id_A664AAD02EE98BD2 = "frag_grenade_mp";
      break;
    case "lmg":
      body = "body_sp_opforce_al_qatala_lmg_1_2";
      head = "head_sp_opforce_al_qatala_ar";
      _id_A664AAD02EE98BD2 = "semtex_mp";
      break;
    case "smg":
      body = "body_sp_opforce_al_qatala_smg_1_2";
      head = "head_sp_opforce_al_qatala_ar";
      _id_A664AAD02EE98BD2 = "smoke_grenade_mp";
      break;
    case "ar_laser":
    case "ar":
      body = "body_sp_opforce_al_qatala_ar_1_2";
      head = "head_sp_opforce_al_qatala_ar";
      _id_A664AAD02EE98BD2 = "flash_mp";
      break;
    default:
      body = "body_sp_opforce_al_qatala_tier_2_1_1";
      head = "head_sp_opforce_al_qatala_tier_2_1_1";
      break;
  }
}

_id_07D1DB2BA1A39D29(body, head, weapon, _id_A664AAD02EE98BD2, helmet) {
  self setModel(body);

  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self attach(head, "", 1);
  self.headmodel = head;

  if(isDefined(helmet)) {
    self attach(helmet, "", 1);
    self.hatmodel = helmet;
  }

  _id_1C0C872AA3BF0CB0::flashlight_on();
  self laseron();
}

_id_00F596B70FD6B78E(group_name, func) {
  setup_soldier_stealth(group_name, func);
  _id_9F4D554E3AE3D383(group_name);
  self.maxfacenewenemydist = 4000;
  self.baseaccuracy = getdvarfloat("dvar_9F78280356EF4531", 2.0);

  if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]())
    thread _id_D24590F588A71CA2();
  else {
    foreach(player in level.players) {
      if(!istrue(player.inlaststand))
        scripts\engine\utility::delaycall(0.1, ::getenemyinfo, player);
    }

    _id_18A73A64992DD07D::set_goal_radius(2048);
    player = scripts\cp\utility::get_closest_living_player();

    if(isDefined(player)) {
      self setgoalpos(player.origin);
      event = spawnStruct();
      event.typeorig = "combat";
      event.type = "combat";
      event.origin = player.origin;
      event.investigate_pos = player.origin;
      self[[self.fnsetstealthstate]]("combat", event);
      thread _id_D24590F588A71CA2();
      return;
    }

    self[[self.fnsetstealthstate]]("hunt");
  }
}

_id_9F4D554E3AE3D383(group) {
  if(_id_18A73A64992DD07D::is_specified_unittype("juggernaut") || _id_18A73A64992DD07D::is_specified_unittype("dog")) {
    self _meth_B11B5190B03C861C("");
    self.combatmode = "no_cover";
    self._id_2626D6897D71B728 = 2000;
    return;
  }

  _id_A664AAD02EE98BD2 = "frag_grenade_mp";
  _id_16C92180949DB961();
}

_id_16C92180949DB961() {
  _id_1C0C872AA3BF0CB0::flashlight_on();
  self laseron();
}

setup_soldier_stealth(group_name, func) {
  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    self.ignoreall = 1;

  if(_id_18A73A64992DD07D::is_specified_unittype("juggernaut")) {
    self _meth_B11B5190B03C861C("");
    self.combatmode = "no_cover";
    self._id_2626D6897D71B728 = 2000;
  }

  if(istrue(self.bhasriotshieldattached))
    self._id_2626D6897D71B728 = 1400;

  scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);

  if(getdvarint("dvar_14212EBE71FA1B35", 0) != 0) {
    self _meth_95D5375059C2A022("cp_raid1_intro");
    self _meth_D493E7FE15E5EAF4("cp_raid1_intro");
  } else {
    self _meth_95D5375059C2A022("cp_jugg_maze_stealth_section");
    self _meth_D493E7FE15E5EAF4("cp_jugg_maze_stealth_section");
  }

  self._id_D4C11C85EE9C6A42 = 1500;
  self._id_A4709D00B598B7BF = 1;
  _id_123701A00E645E19();

  if(!_id_2B79931B08683E0A::isshotgunai())
    self _meth_9215CE6FC83759B9(4000);
}

_id_1C8C03372BADE56E() {
  self endon("death_or_disconnect");
  self endon("last_stand");
  scripts\engine\utility::ent_flag_wait("player_spawned_with_loadout");
  scripts\cp\utility::giveperk("specialty_sixth_sense");
  scripts\cp\utility::giveperk("specialty_hack");
  thread scripts\cp\execution::_id_94C333BD965E6685();
}

_id_5D07E8092CB10167(stealth_group, _id_65661AE3A873C9AE) {
  if(isDefined(stealth_group) && isstring(stealth_group)) {
    if(!isDefined(level._id_72069798E35CC6BC[stealth_group]))
      level._id_72069798E35CC6BC[stealth_group] = 0;

    level._id_72069798E35CC6BC[stealth_group]++;
    level._id_892990D1B2DA4A65 = 4000000;

    switch (stealth_group) {
      default:
        level thread _id_62B762D8A739DE9E(_id_65661AE3A873C9AE);
        break;
    }
  } else
    level thread _id_62B762D8A739DE9E(_id_65661AE3A873C9AE);
}

_id_62B762D8A739DE9E(_id_65661AE3A873C9AE, _id_C8FCFEAE020541D9) {
  if(!istrue(_id_C8FCFEAE020541D9)) {
    if(_func_EAC0CD99C9C6D8EE() != "spotted" && !istrue(_id_65661AE3A873C9AE)) {
      return;
    }
    if(level._id_A359CB3E2BFA1964 < 1 && level._id_9EEAB63C54988C55 < 1 && level._id_359C318944444B78 < 1) {
      thread _id_922DE60337409A17();
      return;
    }
  }

  wait 2;

  if(_func_EAC0CD99C9C6D8EE() != "spotted") {
    return;
  }
  if(!istrue(level._id_942F39C640EF7CDE)) {
    if(!isDefined(level._id_F75A58E27E264659))
      level._id_F75A58E27E264659 = getEntArray("pa_system", "targetname");

    foreach(_id_CDCD3C78F5177DB6 in level._id_F75A58E27E264659)
    thread scripts\cp\coop_stealth::_id_C72B7181608C8607(_id_CDCD3C78F5177DB6, 1);

    level._id_942F39C640EF7CDE = 1;
    scripts\engine\utility::flag_set("sounded_alarm");
  }

  thread _id_9E5571DD747F3333();
  level._id_B640E3525916BD06 = 1;

  if(!isDefined(level._id_6EE49CDEB94917B3))
    level._id_6EE49CDEB94917B3 = getEnt("reinforcements_first_trigger", "targetname");

  if(!isDefined(level._id_E4259B1F13BE67DF))
    level._id_E4259B1F13BE67DF = getEnt("reinforcements_second_trigger", "targetname");

  if(!isDefined(level._id_7A491C0AF7FF297C))
    level._id_7A491C0AF7FF297C = getEnt("reinforcements_trigger", "targetname");

  _id_FF72167D32441E3A = 0;

  foreach(player in level.players) {
    if(player istouching(level._id_6EE49CDEB94917B3))
      _id_FF72167D32441E3A = 1;
  }

  _id_D0F896DBDFB07FB0 = 0;

  foreach(player in level.players) {
    if(player istouching(level._id_E4259B1F13BE67DF))
      _id_D0F896DBDFB07FB0 = 1;
  }

  _id_3AD2BE7D5E488DDC = 0;

  foreach(player in level.players) {
    if(player istouching(level._id_7A491C0AF7FF297C))
      _id_3AD2BE7D5E488DDC = 1;
  }
}

_id_5E5D5AC433C8E1CA(name) {
  if(_id_C21568605A0EB71E(name)) {
    if(isDefined(level._id_C7927AECF45A7AED)) {
      foreach(door in level._id_C7927AECF45A7AED) {
        if(!istrue(door._id_A16669FDD0578E00)) {
          _id_B092780F9EC4496E(door);

          foreach(player in level.players)
          door enablescriptableplayeruse(player);

          if(isDefined(door.nearbysnakecams)) {
            foreach(snakecam in door.nearbysnakecams) {
              foreach(player in level.players)
              snakecam enablescriptableplayeruse(player);
            }
          }
        }
      }
    }

    if(!scripts\engine\utility::array_contains(level.active_spawn_modules, name))
      _id_18A73A64992DD07D::run_spawn_module(name);
  }
}

_id_9E5571DD747F3333() {
  if(isDefined(level._id_44AF77A334B9AE2C)) {
    level._id_44AF77A334B9AE2C _id_FBBFE6F05EDA5EB1(level._id_44AF77A334B9AE2C);

    foreach(player in level.players)
    level._id_44AF77A334B9AE2C disablescriptableplayeruse(player);
  }
}

_id_922DE60337409A17() {
  level notify("reinforcements_spawnReinforcementsIfWorldIsStillInCombat");
  level endon("reinforcements_spawnReinforcementsIfWorldIsStillInCombat");
  wait 5;

  if(_func_EAC0CD99C9C6D8EE() != "spotted") {
    return;
  }
  _id_62B762D8A739DE9E(1);
}

_id_4A2FEAC0DC1352A6() {
  while(!isDefined(level.stealth))
    waitframe();

  setDvar("dvar_AE9C969DF88E37E1", 5000);
  setDvar("dvar_F72CE39DD23B00D1", 5000);
  setDvar("dvar_CDA36D9770CF5189", 150);
  level.stealth._id_792E4B9A380ADE11 = 5000;
  level.stealth._id_094F8771062F2161 = 5000;
  level.stealth._id_E2E3C78D7DC88605 = 22500;
  _func_4FF17EFD15D01D3F(1300);
  _func_1611D0F6B5F84B9A(1300);
  _func_7AFB89FC511BF315("silenced_shot", 128);
  _func_1A3DD0FBFE26893F("silenced_shot", 256);
  _func_7AFB89FC511BF315("gunshot_teammate", 1024);
  _func_1A3DD0FBFE26893F("gunshot_teammate", 1024);
  level.stealth._id_3495E2E91301FEBD = [];
  level.stealth._id_3495E2E91301FEBD["idle"] = "cp_jugg_maze_stealth_section";
  level.stealth._id_3495E2E91301FEBD["investigate"] = "cp_jugg_maze_stealth_section";
  level.stealth._id_3495E2E91301FEBD["hunt"] = "cp_jugg_maze_stealth_section";
  setDvar("dvar_0DF03D7AC5B31599", 0);

  if(getdvarint("dvar_557F9FB52976C4FE", 0) == 0)
    _func_03875866B3A6D349(1);

  level._id_DA217073B223521A = 1;
}

_id_80DC965028D873A2(location) {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    level thread _id_AA672E8DA9F814D9(location, 0.05);
  }
}

_id_AA672E8DA9F814D9(region, delay) {
  wait(delay);

  switch (region) {
    case "exterior":
      level._id_359C318944444B78++;
      break;
    case "downstairs":
      level._id_A359CB3E2BFA1964++;
      break;
    case "upstairs":
      level._id_9EEAB63C54988C55++;
      break;
  }
}

_id_B108188EDBFC1E04(weapon_obj) {
  attachment = "laserbox_ads02";

  switch (weapon_obj.classname) {
    case "mg":
      attachment = "laserbox_ads02";
      break;
    case "sniper":
      attachment = "laserbox_ads02";
      break;
    case "smg":
      attachment = "lasercyl_ads02";
      break;
    case "spread":
      attachment = "lasercyl_ads02";
      break;
    case "ar":
      attachment = "laserbox_ads02";
      break;
    case "rifle":
      attachment = "laserbox_ads02";
      break;
    case "pistol":
      attachment = "lasercyl_ads02";
      break;
  }

  return attachment;
}

_id_13B2E016B1AB4103(weapon_obj) {
  attachment = "laserbox_ads02";

  switch (weapon_obj.classname) {
    case "mg":
      attachment = "holo03";
      break;
    case "sniper":
      attachment = "thermal02";
      break;
    case "smg":
      attachment = "reflex02_tall";
      break;
    case "spread":
      attachment = "reflex02_tall";
      break;
    case "ar":
      attachment = "holo03";
      break;
    case "rifle":
      attachment = "holo03";
      break;
    case "pistol":
      if(weapon_obj.basename == "iw9_pi_golf17_mp" || weapon_obj.basename == "iw9_pi_golf18_mp" || weapon_obj.basename == "iw9_pi_papa220_mp")
        attachment = "iw9_minireddot02_pstl";
      else
        attachment = "iw9_minireddot02";

      break;
  }

  if(weapon_obj.basename == "iw9_br_msecho_mp")
    attachment = "arscope_therm01_p01";

  return attachment;
}

addattachmenttoweapon(_id_DD515FCF025B2E79, _id_EFFB4AE1788A8B10) {
  variantid = getweaponvariantindex(_id_DD515FCF025B2E79);
  _id_DD515FCF025B2E79 = _id_DD515FCF025B2E79 getnoaltweapon();
  _id_91BBF8D2294A656E = _id_DD515FCF025B2E79.attachmentvarindices;
  attachments = [];

  foreach(attachment, id in _id_91BBF8D2294A656E)
  attachments[attachments.size] = attachment;

  failed = 0;

  if(scripts\engine\utility::array_contains(attachments, _id_EFFB4AE1788A8B10))
    failed = 1;
  else if(!_id_DD515FCF025B2E79 canuseattachment(_id_EFFB4AE1788A8B10))
    failed = 1;

  if(failed)
    return undefined;

  attachments = scripts\cp\utility::weaponattachremoveextraattachments(attachments, _id_DD515FCF025B2E79);
  _id_7809AD191E44FE6A = [];

  foreach(_id_FE8F7703F6313ED4, attachment in attachments)
  _id_7809AD191E44FE6A[_id_FE8F7703F6313ED4] = _id_91BBF8D2294A656E[attachment];

  attachments[attachments.size] = _id_EFFB4AE1788A8B10;
  _id_7809AD191E44FE6A[_id_7809AD191E44FE6A.size] = 0;
  camo = _id_DD515FCF025B2E79.camo;
  stickers = [];

  if(isDefined(_id_DD515FCF025B2E79.stickerslot0))
    stickers[stickers.size] = _id_DD515FCF025B2E79.stickerslot0;

  if(isDefined(_id_DD515FCF025B2E79.stickerslot1))
    stickers[stickers.size] = _id_DD515FCF025B2E79.stickerslot1;

  if(isDefined(_id_DD515FCF025B2E79.stickerslot2))
    stickers[stickers.size] = _id_DD515FCF025B2E79.stickerslot2;

  if(isDefined(_id_DD515FCF025B2E79.stickerslot3))
    stickers[stickers.size] = _id_DD515FCF025B2E79.stickerslot3;

  if(isDefined(_id_DD515FCF025B2E79._id_B39AC546CC8621F8))
    stickers[stickers.size] = _id_DD515FCF025B2E79._id_B39AC546CC8621F8;

  _id_11A1FA68AEB971C0 = scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4();
  _id_DD515FCF025B2E79 = _id_2669878CF5A1B6BC::buildweapon(_id_2669878CF5A1B6BC::getweaponrootname(_id_DD515FCF025B2E79), attachments, camo, "none", variantid, _id_7809AD191E44FE6A, undefined, stickers, _id_11A1FA68AEB971C0);
  return _id_DD515FCF025B2E79;
}

_id_C6477B99E150A457() {
  _id_62B762D8A739DE9E(1, 1);
}

_id_C21568605A0EB71E(group) {
  _id_7540B485C1A55040 = undefined;

  if(isarray(group))
    _id_7540B485C1A55040 = group;
  else
    _id_7540B485C1A55040 = [group];

  _id_D8C114EDA2DADB41 = [];

  foreach(group_name in _id_7540B485C1A55040) {
    _id_5571AE8A9C277A18 = _id_18A73A64992DD07D::get_module_structs_by_groupname(group_name, 1)[0];

    if(isDefined(_id_5571AE8A9C277A18)) {
      _id_D8C114EDA2DADB41 = scripts\engine\utility::array_combine(_id_D8C114EDA2DADB41, _id_5571AE8A9C277A18.ai_spawned);
      _id_D8C114EDA2DADB41 = scripts\engine\utility::array_removedead_or_dying(_id_D8C114EDA2DADB41);
    }
  }

  if(_id_D8C114EDA2DADB41.size > 0)
    return 0;

  return 1;
}

_id_FBBFE6F05EDA5EB1(door) {
  door _meth_9AF4C9B2CC1BF989(1);
  door.blocked = 1;
}

_id_B092780F9EC4496E(door) {
  door _meth_80902296B05BE00A();

  if(isDefined(door._id_5C493302B016B154))
    door._id_5C493302B016B154 _meth_80902296B05BE00A();

  door.blocked = undefined;
  door._id_A16669FDD0578E00 = 1;
}

_id_20381C7B081C3F54(scriptable, player) {}

_id_31C405AA2D21F0B5(scriptable, player) {
  return &"SCRIPT/DOOR_HINT_LOCKED";
}

_id_42974A5D66E156B8(instance, player, _id_85E3240D30E184E7) {
  return 0;
}

watch_for_players_in_front(atv) {
  level endon("game_ended");
  self endon("death");
  objectivestruct = scripts\cp\cp_objectives::getobjectivestructfromref("mineSection");

  for(;;) {
    frontpoint = scripts\cp\utility::get_point_in_local_ent_space(atv, (128, 0, 0));

    if(is_a_player_near(frontpoint, 64))
      _id_780041E1B165E581(atv);
    else {}

    wait 1;
  }
}

_id_E6BCCE1FA7065344() {
  level._id_2473C417153EFC50 = undefined;
  _id_8BDD1937DC080CCA = scripts\engine\utility::getStructArray("laser_sentry_defuse_mines", "script_noteworthy");

  if(!isDefined(level._id_7B5771F0D3E048A0))
    level._id_7B5771F0D3E048A0 = [];

  _id_11811C954BBA79E3::_id_2A227BF43B1B2354(["mine_laser_1", "mine_laser_2", "mine_laser_3", "mine_laser_666"]);

  foreach(_id_FF03DED389B65A7D in _id_8BDD1937DC080CCA) {
    if(istrue(level._id_2473C417153EFC50)) {
      continue;
    }
    _id_FF03DED389B65A7D.turrets = [];
    _id_C3336162B80CD5D1 = scripts\engine\utility::getStructArray(_id_FF03DED389B65A7D.target, "targetname");

    foreach(_id_573F54C927E2EB98 in _id_C3336162B80CD5D1) {
      if(isDefined(_id_573F54C927E2EB98.script_parameters) && _id_573F54C927E2EB98.script_parameters == "hardmode") {
        if(!scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
          continue;
      }

      _id_FF03DED389B65A7D.turrets = scripts\engine\utility::array_add(_id_FF03DED389B65A7D.turrets, _id_3AE866A6DD08DAF9::_id_9C405FFA3BB2DCF0(_id_573F54C927E2EB98, undefined, "electronics_ir_laser_device_rig_skeleton", _id_FF03DED389B65A7D, "mine_laser_1"));
    }

    _id_3AE866A6DD08DAF9::_id_2CC59EA2A67BD2F4(_id_FF03DED389B65A7D, _id_FF03DED389B65A7D.turrets);
    level._id_7B5771F0D3E048A0 = scripts\engine\utility::array_add(level._id_7B5771F0D3E048A0, _id_FF03DED389B65A7D);
  }

  thread _id_213B2A501EBA8632(1);
  level._id_2473C417153EFC50 = 1;
}

_id_B4D7FE2F3E11C660(_id_7F5945B55E97B8B0) {
  if(!isDefined(level._id_D4D95C149887DE1D))
    level._id_D4D95C149887DE1D = [];

  switch (_id_7F5945B55E97B8B0) {
    case 1:
      foreach(struct in level._id_D4D95C149887DE1D) {
        if(struct.targetname == "laser_sound_1") {
          if(isDefined(struct.soundent)) {
            struct.soundent stoploopsound("cp_laser_room");
            struct.soundent delete();
          }
        }
      }

      break;
    case 2:
      foreach(struct in level._id_D4D95C149887DE1D) {
        if(struct.targetname == "laser_sound_1" || struct.targetname == "laser_sound_2") {
          if(isDefined(struct.soundent)) {
            struct.soundent stoploopsound("cp_laser_room");
            struct.soundent delete();
          }
        }
      }

      break;
    case 3:
      foreach(struct in level._id_D4D95C149887DE1D) {
        if(struct.targetname == "laser_sound_1" || struct.targetname == "laser_sound_2") {
          if(isDefined(struct.soundent)) {
            struct.soundent stoploopsound("cp_laser_room");
            struct.soundent delete();
          }
        }
      }
    case 4:
      foreach(struct in level._id_D4D95C149887DE1D) {
        if(isDefined(struct.soundent)) {
          struct.soundent stoploopsound("cp_laser_room");
          struct.soundent delete();
        }
      }

      break;
  }
}

_id_213B2A501EBA8632(_id_7F5945B55E97B8B0) {
  if(!isDefined(level._id_D4D95C149887DE1D))
    level._id_D4D95C149887DE1D = [];

  _id_922FA81A88A8C5F0 = scripts\engine\utility::getStruct("laser_sound_" + _id_7F5945B55E97B8B0, "targetname");
  _id_922FA81A88A8C5F0.soundent = spawn("script_model", _id_922FA81A88A8C5F0.origin);
  _id_922FA81A88A8C5F0.soundent setModel("tag_origin");
  _id_922FA81A88A8C5F0.soundent playLoopSound("cp_laser_room");
  level._id_D4D95C149887DE1D = scripts\engine\utility::array_add(level._id_D4D95C149887DE1D, _id_922FA81A88A8C5F0);
}

_id_A6B15BB60621A60E() {
  level._id_2473C417153EFC50 = undefined;
  _id_8BDD1937DC080CCA = scripts\engine\utility::getStructArray("laser_sentry_defuse_mines_ee", "script_noteworthy");

  if(!isDefined(level._id_7B5771F0D3E048A0))
    level._id_7B5771F0D3E048A0 = [];

  _id_11811C954BBA79E3::_id_2A227BF43B1B2354(["mine_laser_1", "mine_laser_2", "mine_laser_3", "mine_laser_666"]);

  foreach(_id_FF03DED389B65A7D in _id_8BDD1937DC080CCA) {
    if(istrue(level._id_2473C417153EFC50)) {
      continue;
    }
    _id_FF03DED389B65A7D.turrets = [];
    _id_C3336162B80CD5D1 = scripts\engine\utility::getStructArray(_id_FF03DED389B65A7D.target, "targetname");

    foreach(_id_573F54C927E2EB98 in _id_C3336162B80CD5D1) {
      if(isDefined(_id_573F54C927E2EB98.script_parameters) && _id_573F54C927E2EB98.script_parameters == "hardmode") {
        if(!scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
          continue;
      }

      _id_FF03DED389B65A7D.turrets = scripts\engine\utility::array_add(_id_FF03DED389B65A7D.turrets, _id_3AE866A6DD08DAF9::_id_9C405FFA3BB2DCF0(_id_573F54C927E2EB98, undefined, "electronics_ir_laser_device_rig_skeleton", _id_FF03DED389B65A7D, "mine_laser_1"));
    }

    _id_3AE866A6DD08DAF9::_id_2CC59EA2A67BD2F4(_id_FF03DED389B65A7D, _id_FF03DED389B65A7D.turrets);
    level._id_7B5771F0D3E048A0 = scripts\engine\utility::array_add(level._id_7B5771F0D3E048A0, _id_FF03DED389B65A7D);
  }

  level._id_2473C417153EFC50 = 1;
}

_id_0DD51362FF2131A2() {
  level._id_2473C417153EFC50 = undefined;
  _id_8BDD1937DC080CCA = scripts\engine\utility::getStructArray("test_laser_vertical", "script_noteworthy");

  if(!isDefined(level._id_7B5771F0D3E048A0))
    level._id_7B5771F0D3E048A0 = [];

  _id_11811C954BBA79E3::_id_2A227BF43B1B2354(["mine_laser_1", "mine_laser_2", "mine_laser_3", "mine_laser_666"]);

  foreach(_id_FF03DED389B65A7D in _id_8BDD1937DC080CCA) {
    if(istrue(level._id_2473C417153EFC50)) {
      continue;
    }
    _id_FF03DED389B65A7D.turrets = [];
    _id_C3336162B80CD5D1 = scripts\engine\utility::getStructArray(_id_FF03DED389B65A7D.target, "targetname");

    foreach(_id_573F54C927E2EB98 in _id_C3336162B80CD5D1) {
      if(isDefined(_id_573F54C927E2EB98.script_parameters) && _id_573F54C927E2EB98.script_parameters == "hardmode") {
        if(!scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
          continue;
      }

      _id_FF03DED389B65A7D.turrets = scripts\engine\utility::array_add(_id_FF03DED389B65A7D.turrets, _id_3AE866A6DD08DAF9::_id_9C405FFA3BB2DCF0(_id_573F54C927E2EB98, undefined, "electronics_ir_laser_device_vertical_rig_skeleton", _id_FF03DED389B65A7D, "mine_laser_666"));
    }

    _id_3AE866A6DD08DAF9::_id_2CC59EA2A67BD2F4(_id_FF03DED389B65A7D, _id_FF03DED389B65A7D.turrets);
    level._id_7B5771F0D3E048A0 = scripts\engine\utility::array_add(level._id_7B5771F0D3E048A0, _id_FF03DED389B65A7D);
  }

  level._id_2473C417153EFC50 = 1;
}

_id_31BD375C498571FB() {
  level._id_2473C417153EFC50 = undefined;
  _id_8BDD1937DC080CCA = scripts\engine\utility::getStructArray("laser_sentry_defuse_mines_2", "script_noteworthy");

  foreach(_id_FF03DED389B65A7D in _id_8BDD1937DC080CCA) {
    if(istrue(level._id_2473C417153EFC50)) {
      continue;
    }
    _id_FF03DED389B65A7D.turrets = [];
    _id_C3336162B80CD5D1 = scripts\engine\utility::getStructArray(_id_FF03DED389B65A7D.target, "targetname");

    foreach(_id_573F54C927E2EB98 in _id_C3336162B80CD5D1) {
      if(isDefined(_id_573F54C927E2EB98.script_parameters) && _id_573F54C927E2EB98.script_parameters == "hardmode") {
        if(!scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
          continue;
      }

      _id_FF03DED389B65A7D.turrets = scripts\engine\utility::array_add(_id_FF03DED389B65A7D.turrets, _id_3AE866A6DD08DAF9::_id_9C405FFA3BB2DCF0(_id_573F54C927E2EB98, undefined, "electronics_ir_laser_device_rig_skeleton", _id_FF03DED389B65A7D, "mine_laser_2"));
    }

    _id_3AE866A6DD08DAF9::_id_2CC59EA2A67BD2F4(_id_FF03DED389B65A7D, _id_FF03DED389B65A7D.turrets);
    level._id_7B5771F0D3E048A0 = scripts\engine\utility::array_add(level._id_7B5771F0D3E048A0, _id_FF03DED389B65A7D);
  }

  _id_B4D7FE2F3E11C660(1);
  thread _id_213B2A501EBA8632(2);
  level._id_2473C417153EFC50 = 1;
}

_id_31BD365C49856FC8() {
  level._id_2473C417153EFC50 = undefined;
  _id_8BDD1937DC080CCA = scripts\engine\utility::getStructArray("laser_sentry_defuse_mines_3", "script_noteworthy");

  foreach(_id_FF03DED389B65A7D in _id_8BDD1937DC080CCA) {
    if(istrue(level._id_2473C417153EFC50)) {
      continue;
    }
    _id_FF03DED389B65A7D.turrets = [];
    _id_C3336162B80CD5D1 = scripts\engine\utility::getStructArray(_id_FF03DED389B65A7D.target, "targetname");

    foreach(_id_573F54C927E2EB98 in _id_C3336162B80CD5D1) {
      if(isDefined(_id_573F54C927E2EB98.script_parameters) && _id_573F54C927E2EB98.script_parameters == "hardmode") {
        if(!scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
          continue;
      }

      _id_FF03DED389B65A7D.turrets = scripts\engine\utility::array_add(_id_FF03DED389B65A7D.turrets, _id_3AE866A6DD08DAF9::_id_9C405FFA3BB2DCF0(_id_573F54C927E2EB98, undefined, "electronics_ir_laser_device_rig_skeleton", _id_FF03DED389B65A7D, "mine_laser_3"));
    }

    _id_3AE866A6DD08DAF9::_id_2CC59EA2A67BD2F4(_id_FF03DED389B65A7D, _id_FF03DED389B65A7D.turrets);
    level._id_7B5771F0D3E048A0 = scripts\engine\utility::array_add(level._id_7B5771F0D3E048A0, _id_FF03DED389B65A7D);
  }

  _id_B4D7FE2F3E11C660(2);
  thread _id_213B2A501EBA8632(3);
  level._id_2473C417153EFC50 = 1;
}

_id_31BD3D5C49857F2D() {
  _id_B4D7FE2F3E11C660(4);
  level._id_2473C417153EFC50 = undefined;
  _id_8BDD1937DC080CCA = scripts\engine\utility::getStructArray("laser_sentry_defuse_mines_4", "script_noteworthy");
  level._id_DB20A37F4894B4D0 = [];

  foreach(_id_FF03DED389B65A7D in _id_8BDD1937DC080CCA) {
    if(istrue(level._id_2473C417153EFC50)) {
      continue;
    }
    _id_FF03DED389B65A7D.turrets = [];
    _id_C3336162B80CD5D1 = scripts\engine\utility::getStructArray(_id_FF03DED389B65A7D.target, "targetname");

    foreach(_id_573F54C927E2EB98 in _id_C3336162B80CD5D1) {
      if(isDefined(_id_573F54C927E2EB98.script_parameters) && _id_573F54C927E2EB98.script_parameters == "hardmode") {
        if(!scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
          continue;
      }

      _id_FF03DED389B65A7D.turrets = scripts\engine\utility::array_add(_id_FF03DED389B65A7D.turrets, _id_3AE866A6DD08DAF9::_id_9C405FFA3BB2DCF0(_id_573F54C927E2EB98, undefined, "electronics_ir_laser_device_rig_skeleton", _id_FF03DED389B65A7D, "mine_laser_3"));
    }

    _id_3AE866A6DD08DAF9::_id_2CC59EA2A67BD2F4(_id_FF03DED389B65A7D, _id_FF03DED389B65A7D.turrets);
    level._id_DB20A37F4894B4D0 = scripts\engine\utility::array_add(level._id_DB20A37F4894B4D0, _id_FF03DED389B65A7D);
  }

  level._id_2473C417153EFC50 = 1;
}

_id_2367B56419EC69ED() {
  _id_11811C954BBA79E3::_id_2A227BF43B1B2354(["mine_laser_1", "mine_laser_2", "mine_laser_3", "mine_laser_666"]);
  level._id_2473C417153EFC50 = undefined;
  _id_8BDD1937DC080CCA = scripts\engine\utility::getStructArray("laser_sentry_defuse_mines_4_checkpoint", "script_noteworthy");
  level._id_DB20A37F4894B4D0 = [];

  foreach(_id_FF03DED389B65A7D in _id_8BDD1937DC080CCA) {
    if(istrue(level._id_2473C417153EFC50)) {
      continue;
    }
    _id_FF03DED389B65A7D.turrets = [];
    _id_C3336162B80CD5D1 = scripts\engine\utility::getStructArray(_id_FF03DED389B65A7D.target, "targetname");

    foreach(_id_573F54C927E2EB98 in _id_C3336162B80CD5D1) {
      if(isDefined(_id_573F54C927E2EB98.script_parameters) && _id_573F54C927E2EB98.script_parameters == "hardmode") {
        if(!scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
          continue;
      }

      _id_FF03DED389B65A7D.turrets = scripts\engine\utility::array_add(_id_FF03DED389B65A7D.turrets, _id_3AE866A6DD08DAF9::_id_9C405FFA3BB2DCF0(_id_573F54C927E2EB98, undefined, "electronics_ir_laser_device_rig_skeleton", _id_FF03DED389B65A7D, "mine_laser_3"));
    }

    _id_3AE866A6DD08DAF9::_id_2CC59EA2A67BD2F4(_id_FF03DED389B65A7D, _id_FF03DED389B65A7D.turrets);
    level._id_DB20A37F4894B4D0 = scripts\engine\utility::array_add(level._id_DB20A37F4894B4D0, _id_FF03DED389B65A7D);
  }

  level._id_2473C417153EFC50 = 1;
}

_id_DF891834AF7D6F74(_id_7F5945B55E97B8B0, _id_3E998D583C831479) {
  _id_C65FADA6C3C6ADB0 = scripts\engine\utility::getStructArray("barrel_struct_" + _id_7F5945B55E97B8B0, "targetname");

  if(!istrue(_id_3E998D583C831479)) {
    if(!isDefined(level.explosive_barrels))
      level.explosive_barrels = [];

    if(!isDefined(level._id_C269CE5EB91A6F9C))
      level._id_C269CE5EB91A6F9C = [];
  } else {
    level.explosive_barrels = [];
    level._id_C269CE5EB91A6F9C = [];
  }

  level.explosive_barrels["barrel_struct_" + _id_7F5945B55E97B8B0] = [];
  level._id_C269CE5EB91A6F9C["barrel_struct_" + _id_7F5945B55E97B8B0] = [];

  foreach(_id_DDC4E4BDECFF28CD in _id_C65FADA6C3C6ADB0)
  level.explosive_barrels["barrel_struct_" + _id_7F5945B55E97B8B0] = scripts\engine\utility::array_add(level.explosive_barrels["barrel_struct_" + _id_7F5945B55E97B8B0], _id_307E5DDC83950E61(_id_DDC4E4BDECFF28CD, _id_7F5945B55E97B8B0));
}

_id_44A26663C53177AA(_id_236E05B6C65693DE) {
  return getEntArray(_id_236E05B6C65693DE, "targetname");
}

_id_307E5DDC83950E61(_id_DDC4E4BDECFF28CD, _id_7F5945B55E97B8B0) {
  if(getdvarint("dvar_A9C938066DDD4D78", 1) == 0) {
    return;
  }
  scriptable = spawnscriptable("decor_barrels_gameplay_flammable_noent_cp", _id_DDC4E4BDECFF28CD.origin, _id_DDC4E4BDECFF28CD.angles);
  scriptable.parentstruct = _id_DDC4E4BDECFF28CD;
  scriptable.clip = _id_44A26663C53177AA(_id_DDC4E4BDECFF28CD.targetname);
  scriptable._id_7F5945B55E97B8B0 = _id_7F5945B55E97B8B0;
  level thread _id_A1E140E4F5D84B86(scriptable, _id_7F5945B55E97B8B0);
  return scriptable;
}

_id_A1E140E4F5D84B86(scriptable, _id_7F5945B55E97B8B0) {
  scriptable endon("death");
  level endon("game_ended");
  level endon("kill_firebarrel_threads");
  exploded = 0;
  _id_35BBF066F50AC582 = 666;
  attacker = undefined;

  while(!exploded) {
    scriptablestate = scriptable getscriptablepartstate("base");

    if(!isDefined(scriptablestate)) {
      return;
    }
    if(scriptablestate == "death") {
      if(istrue(level._id_CD59367309B1C64C)) {} else if(getdvarint("dvar_15195B1FB82DB59C", 1) != 0) {
        if(isDefined(level._id_F107BD5B4C54277E) && !istrue(level._id_CD59367309B1C64C))
          scriptable thread[[level._id_F107BD5B4C54277E]](undefined);
      }

      if(istrue(scriptable._id_C6C345E46FD51F40))
        level notify("barrelExploded", scriptable.origin);

      exploded = 1;

      if(isDefined(scriptable.lastattacker))
        attacker = scriptable.lastattacker;

      radiusdamage(scriptable.origin, _id_35BBF066F50AC582, 666, 333, attacker, "MOD_EXPLOSIVE", "molotov_mp");

      if(getdvarint("dvar_068E3DEF35F916BB", 0)) {
        if(isDefined(scriptable.parentstruct)) {
          level._id_C269CE5EB91A6F9C["barrel_struct_" + _id_7F5945B55E97B8B0] = scripts\engine\utility::array_add(level._id_C269CE5EB91A6F9C["barrel_struct_" + _id_7F5945B55E97B8B0], scriptable.parentstruct);
          level.explosive_barrels["barrel_struct_" + _id_7F5945B55E97B8B0] = scripts\engine\utility::array_remove(level.explosive_barrels["barrel_struct_" + _id_7F5945B55E97B8B0], scriptable);
          level.explosive_barrels["barrel_struct_" + _id_7F5945B55E97B8B0] = scripts\engine\utility::array_removeundefined(level.explosive_barrels["barrel_struct_" + _id_7F5945B55E97B8B0]);

          if(scriptable getscriptableisreserved())
            scriptable freescriptable();
        }
      }
    }

    waitframe();
  }
}

_id_A690799B59791632(_id_7F5945B55E97B8B0) {
  if(getdvarint("dvar_7C5722DEE06D4B3A", 1) == 0) {
    return;
  }
  if(getdvarint("dvar_8E0B5B9ED93CD7E9", 1) != 0)
    _id_DF891834AF7D6F74(level._id_B3A61E1FD4CE7D8A, 1);

  level._id_C269CE5EB91A6F9C["barrel_struct_" + _id_7F5945B55E97B8B0] = scripts\engine\utility::array_removeundefined(level._id_C269CE5EB91A6F9C["barrel_struct_" + _id_7F5945B55E97B8B0]);

  foreach(_id_DDC4E4BDECFF28CD in level._id_C269CE5EB91A6F9C["barrel_struct_" + _id_7F5945B55E97B8B0])
  level.explosive_barrels["barrel_struct_" + _id_7F5945B55E97B8B0] = scripts\engine\utility::array_add(level.explosive_barrels["barrel_struct_" + _id_7F5945B55E97B8B0], _id_307E5DDC83950E61(_id_DDC4E4BDECFF28CD, _id_7F5945B55E97B8B0));

  level._id_C269CE5EB91A6F9C["barrel_struct_" + _id_7F5945B55E97B8B0] = [];
}

_id_19BF2E0DFFA89EBC(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  level notify("lasers_red_barrel_damaged");

  if(isDefined(instance.type) && instance.type == "decor_barrels_gameplay_flammable_noent_cp")
    instance.lastattacker = eattacker;
}