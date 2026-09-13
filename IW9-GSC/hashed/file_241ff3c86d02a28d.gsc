/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_241ff3c86d02a28d.gsc
***********************************************/

_id_80D68C9701E1AEA5(data) {
  level._id_AF7D80856E5AE6C0 = spawnStruct();
  level._id_AF7D80856E5AE6C0.circleradius = getdvarint("dvar_D2585EC2C64A9F34", 300);
  level._id_AF7D80856E5AE6C0._id_E3AA1DE9D96E0086 = getdvarint("dvar_1D6B7E1F5EAB0397", 700);
  level._id_AF7D80856E5AE6C0.bombtimer = getdvarfloat("dvar_5670AE3DC42B22FF", 50.0);
  level._id_AF7D80856E5AE6C0._id_0CA7A26C1E01B30A = getdvarfloat("dvar_11C996694EC6BC7D", 3.0);
  level._id_AF7D80856E5AE6C0._id_7F494A83DE6CFB1E = getdvarint("dvar_0152094CCA50E086", 1);
  level._id_AF7D80856E5AE6C0._id_82A01CE31B77AC5C = getdvarfloat("dvar_4F66FA15A2FB52A5", 750);
  initanims();
  level._effect["hostage_bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_hostage", ::_id_B7A8186B8098B13F);
  _id_03314ADD7998AB13::_id_B713F2D39B34540F(data, ::_id_D871FFA09FD34EFE, _id_F0C7539DC72C3DFD());
}

_id_D871FFA09FD34EFE(_id_AA1ED8F12D71A7A5, node) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_AA1ED8F12D71A7A5);
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_C17A05D80BAF63A8;
  _id_B8EBE3F71A08AB40.funcs["onPlayerJoined"] = ::_id_15BD4F5A3DA26FBA;
  _id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"] = ::_id_64B4CC14AF5FCBF9;
  _id_B8EBE3F71A08AB40.funcs["onTeamAssigned"] = ::_id_48EF78129771C52B;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_497633646487B841;
  _id_B8EBE3F71A08AB40.funcs["onCancel"] = ::_id_55CFF0A19D87F7B0;
  _id_B8EBE3F71A08AB40.ref = "dmz_hostage";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  _id_B8EBE3F71A08AB40.node = node;
  _id_47E9B099C2D0B060 = _id_4948CDF739393D2D::_id_BBE42D7091BEDFC5(node.origin, "hostage_forts");
  _id_4948CDF739393D2D::_id_4E6DD86684152B17(_id_47E9B099C2D0B060, "hostage_door");
  _id_4948CDF739393D2D::_id_5D8264355DB47371(_id_47E9B099C2D0B060, 0, 1, 0, 0, undefined, undefined, undefined, undefined, 1, 0);
  _id_B8EBE3F71A08AB40._id_47E9B099C2D0B060 = _id_47E9B099C2D0B060;
  _id_B8EBE3F71A08AB40._id_23D42B1195DDA679 = node._id_23D42B1195DDA679;
  node._id_23D42B1195DDA679.info = _id_5307834CD39B435C::_id_A4181028915C44FA(node._id_23D42B1195DDA679, 0);
  return _id_B8EBE3F71A08AB40;
}

_id_C17A05D80BAF63A8() {
  self._id_EFA8EF05B190D7D0.origin = self.node.origin;
  self.node.inuse = 1;
  _id_79B9C85900392AD6 = _id_6C4E8CEA70BF4B6D::_id_AB50F62A3A730400(self._id_47E9B099C2D0B060.origin, level._id_AF7D80856E5AE6C0.circleradius);
  _id_6C4E8CEA70BF4B6D::_id_325390EDB051CD5D("Hostage_Dmz", [_id_79B9C85900392AD6], level._id_AF7D80856E5AE6C0.circleradius + level._id_AF7D80856E5AE6C0._id_E3AA1DE9D96E0086);
  self.curorigin = _id_79B9C85900392AD6;
  self.offset3d = (0, 0, 750);
  _id_6C4E8CEA70BF4B6D::_id_C847BFD52C064289(self.curorigin + self.offset3d, "rescue");
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.icon, 1);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.icon, 0);
  self.door_opened = 0;
  self._id_65513AD5397A67EF = "hostage" + gettime();
  _id_BD0BDE6807000DAE();
  _id_B6B601986DCAD85A();

  if(!isDefined(self.hostage)) {
    _id_8250FD658E3AAE32();
    _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
    return;
  }

  _id_14F7745B0A1250DB();
}

_id_15BD4F5A3DA26FBA(player) {
  player._id_65513AD5397A67EF = self._id_65513AD5397A67EF;
  players = scripts\mp\utility\teams::getteamdata(player.team, "players");

  if(!isDefined(self.bombexploded))
    self.instance enablescriptableplayeruse(player);
  else if(isDefined(self.carryingplayer))
    self.instance disablescriptableplayeruse(player);
  else
    self.instance enablescriptableplayeruse(player);
}

_id_64B4CC14AF5FCBF9(player) {
  player._id_65513AD5397A67EF = undefined;

  if(isDefined(self.carryingplayer) && self.carryingplayer == player)
    drophostage(1);

  self.instance disablescriptableplayeruse(player);
}

_id_48EF78129771C52B(_id_FABF84450735DD93) {
  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_hostage_assigned", _id_FABF84450735DD93);
  _id_6C4E8CEA70BF4B6D::_id_E54DF8560BF7DC64(_id_FABF84450735DD93);
  _id_6C4E8CEA70BF4B6D::_id_DFFCBCE998C9EE50(_id_FABF84450735DD93);
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  self.instance setscriptablepartstate("dmz_hostage", "usable", 0);

  foreach(player in level.players)
  self.instance disablescriptableplayeruse(player);

  foreach(player in players)
  self.instance enablescriptableplayeruse(player);

  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hostage_rescue_assigned", _id_FABF84450735DD93);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_hostage_start", 1.5, "dmz_hostage_start_classic");
  thread _id_D2A6B6D52AC64120(_id_FABF84450735DD93);
}

_id_497633646487B841(_id_FABF84450735DD93) {
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hostage_rescue_approach", _id_FABF84450735DD93, 2.0);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_hostage_approach", 0.0);
}

_id_55CFF0A19D87F7B0(_id_FABF84450735DD93) {
  self.failure = 1;
  _id_8250FD658E3AAE32();

  if(isDefined(self.carryingplayer))
    thread drophostage(1);

  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_hostage_rescue_failed", 1.0, "dmz_hostage_rescue_failed_classic");
  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
}

_id_8250FD658E3AAE32() {
  if(istrue(self._id_0AF8D4CC519C65DE)) {
    return;
  }
  self._id_0AF8D4CC519C65DE = 1;

  if(!istrue(self._id_2F893D4A9CBF8A5C)) {
    if(isDefined(self._id_90FB369A18926018)) {
      foreach(player in self._id_90FB369A18926018)
      scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.icon, player);
    }

    _id_6C4E8CEA70BF4B6D::_id_2476DAEFA3384C5E();
    _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();
  }

  if(isDefined(self.instance))
    self.instance freescriptable();

  if(isDefined(self.heli) && isDefined(self.heli._id_0902A7FFCFF8AA65)) {
    foreach(player in self.heli._id_0902A7FFCFF8AA65)
    player _id_5307834CD39B435C::_id_A9F268ABD153B713();
  }

  if(!istrue(self._id_2F893D4A9CBF8A5C))
    _id_6C4E8CEA70BF4B6D::_id_45BD3184FF146B46(self.teams[0]);
}

_id_CB2F74520E05756F(_id_FABF84450735DD93) {
  _id_8250FD658E3AAE32();

  if(!istrue(self._id_2F893D4A9CBF8A5C)) {
    if(isDefined(_id_FABF84450735DD93)) {
      thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hostage_rescue_hostage_exfil", _id_FABF84450735DD93, 2.0);
      _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_hostage_exfilled", "hostage", self._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11, _id_FABF84450735DD93);
      _id_6C4E8CEA70BF4B6D::_id_CD4F277CF0D6A560(_id_FABF84450735DD93);
      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "", 0.0);
      _id_6A8EC730B2BFA844::_id_496B109DC14FA57D(self);
    } else if(isDefined(self.teams[0]))
      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(self.teams[0], "dmz_hostage_rescue_failed", 0.0, "dmz_hostage_rescue_failed_classic");

    _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3(_id_FABF84450735DD93);
  }
}

_id_BD0BDE6807000DAE() {
  foreach(door in self._id_47E9B099C2D0B060._id_E2CD8AA8B46D18AC) {
    door._id_B8EBE3F71A08AB40 = self;
    door scriptabledoorclose();
    door._id_65513AD5397A67EF = self._id_65513AD5397A67EF;
    door._id_8E6BA9B12787EB1D = 1;
  }

  _id_4948CDF739393D2D::_id_68A6379D51E7DBC2(self._id_47E9B099C2D0B060, undefined, ::_id_BF35C0838580CF50);
}

_id_BF35C0838580CF50(door, player) {
  if(isDefined(door._id_B8EBE3F71A08AB40)) {
    if(isDefined(door.node.script_noteworthy) && door.node.script_noteworthy == "lockMe")
      door thread _id_AA49AD82E62A035F();
  }
}

_id_AA49AD82E62A035F() {
  while(self scriptabledoorisclosed())
    waitframe();

  self._id_B8EBE3F71A08AB40.door_opened = 1;
}

_id_D2A6B6D52AC64120(_id_FABF84450735DD93) {
  self endon("task_ended");
  self endon("abort_rescue_timer");

  while(!istrue(self.door_opened))
    waitframe();

  self.hostage.invulnerable = undefined;
  _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hostage_rescue_loud", _id_FABF84450735DD93);
  self.state = "player_entered_building";
  thread _id_795B60C4AE5793A2(_id_FABF84450735DD93);
}

_id_795B60C4AE5793A2(_id_FABF84450735DD93) {
  if(istrue(self._id_66B657AD4E581EDA) || isDefined(self.bombexploded) && !self.bombexploded) {
    return;
  }
  self endon("task_ended");
  self endon("abort_rescue_timer");

  if(istrue(self._id_AD3AC58C52D589D7)) {
    return;
  }
  self._id_AD3AC58C52D589D7 = 1;
  timer = level._id_AF7D80856E5AE6C0.bombtimer;
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_hostage_breach", 1.0, "dmz_hostage_breach_classic");
  thread _id_68C8358014264E66(timer);
  scripts\mp\objidpoolmanager::objective_set_show_progress(self.icon, 1);
  bombexploded = _id_D0A5788403AC6DDF(timer);

  if(isDefined(bombexploded))
    self.bombexploded = bombexploded;

  foreach(player in self._id_90FB369A18926018) {
    scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.icon, player);
    scripts\mp\objidpoolmanager::objective_unpin_player(self.icon, player);
  }

  if(isDefined(self.bombexploded) && self.bombexploded == 0)
    scripts\mp\objidpoolmanager::objective_set_show_progress(self.icon, 0);

  if(istrue(self.bombexploded)) {
    self notify("bomb_exploded");

    if(isDefined(self.hostage) && self.hostage.health > 0)
      self.hostage dodamage(1000, self.hostage.origin);

    effect = "hostage_bomb_explosion";
    _id_408F3E834E201526 = self.c4.origin + (0, 0, 50);
    _id_EFDFC6EBE7A152C5 = spawnfx(level._effect[effect], _id_408F3E834E201526);
    _id_EFDFC6EBE7A152C5 thread scripts\engine\utility::_id_B4B04DE87729A6F3(10.0);
    triggerfx(_id_EFDFC6EBE7A152C5);
    physicsexplosionsphere(_id_408F3E834E201526, 200, 100, 3);
    playrumbleonposition("grenade_rumble", self.c4.origin);
    earthquake(0.25, 0.5, self.c4.origin, 500);
    playsoundatpos(_id_408F3E834E201526, "exp_bombsite_lr");
    radiusdamage(self.c4.origin + (0, 0, 50), 200, 500, 10, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hostage_rescue_exploded", self.teams[0], 2.0);
  }

  if(isDefined(self.c4))
    self.c4 delete();
}

_id_68C8358014264E66(timer) {
  level endon("game_ended");
  self endon("task_ended");
  self endon("bomb_defused");
  wait(timer);
  self.instance setscriptablepartstate("dmz_hostage", "unusable", 0);
}

_id_D0A5788403AC6DDF(timer) {
  level endon("game_ended");
  self endon("task_ended");
  self endon("bomb_defused");
  self endon("abort_rescue_timer");
  self._id_90FB369A18926018 = [];
  currenttime = gettime();
  offset = 1000 * level._id_AF7D80856E5AE6C0._id_0CA7A26C1E01B30A;
  _id_F28399727742EB23 = int(currenttime + 1000 * timer + offset);
  _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;
  thread _id_C98C343E42951EA2(_id_F28399727742EB23, offset);

  while(_id_C301D652D9A73075 > 0) {
    currenttime = gettime();
    _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;

    if(_id_C301D652D9A73075 < 0) {
      break;
    }

    self._id_78122E18403A8DC4 = [];
    _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");

    foreach(player in _id_E2B2BBD9E6539F11) {
      if(distance2dsquared(player.origin, self._id_47E9B099C2D0B060.origin) < 1048576)
        self._id_78122E18403A8DC4[self._id_78122E18403A8DC4.size] = player;
    }

    progress = (_id_C301D652D9A73075 - offset) / (timer * 1000.0);

    if(progress > 0.0) {
      self._id_90FB369A18926018 = _id_F69E0B0E05FD9B85(self._id_78122E18403A8DC4, self._id_90FB369A18926018);
      scripts\mp\objidpoolmanager::objective_set_progress(self.icon, progress);
    } else {
      scripts\mp\objidpoolmanager::_id_17DB39BD195CC5B1(self.icon);
      self._id_28275934186417C8 = 1;
    }

    waitframe();
  }

  return 1;
}

_id_C98C343E42951EA2(_id_F28399727742EB23, offset) {
  level endon("game_ended");
  self endon("task_ended");
  self endon("abort_rescue_timer");
  self endon("bomb_exploded");
  self endon("bomb_defused");
  currenttime = gettime();
  _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;

  while(_id_C301D652D9A73075 > 0) {
    currenttime = gettime();
    _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;

    if(_id_C301D652D9A73075 <= 0 + offset) {
      if(_id_C301D652D9A73075 <= 250) {
        if(soundexists("hostage_warning_beep_05"))
          self.c4 playSound("hostage_warning_beep_05");
      } else if(_id_C301D652D9A73075 <= 750) {
        if(soundexists("hostage_warning_beep_04"))
          self.c4 playSound("hostage_warning_beep_04");
      } else if(_id_C301D652D9A73075 <= 1500) {
        if(soundexists("hostage_warning_beep_03"))
          self.c4 playSound("hostage_warning_beep_03");
      } else if(soundexists("hostage_warning_beep_02"))
        self.c4 playSound("hostage_warning_beep_02");

      wait 0.25;
      continue;
    }

    if(_id_C301D652D9A73075 <= 10000 + offset) {
      if(soundexists("hostage_warning_beep_02"))
        self.c4 playSound("hostage_warning_beep_02");

      wait 0.5;
      continue;
    }

    if(soundexists("hostage_warning_beep_01"))
      self.c4 playSound("hostage_warning_beep_01");

    wait 1.0;
  }
}

_id_F69E0B0E05FD9B85(_id_78122E18403A8DC4, _id_90FB369A18926018) {
  _id_5C882C8F7BB9C72A = scripts\engine\utility::array_combine(_id_78122E18403A8DC4, _id_90FB369A18926018);
  _id_F6FD7B0E73C3270C = _id_90FB369A18926018;

  foreach(player in _id_5C882C8F7BB9C72A) {
    if(!isDefined(player)) {
      continue;
    }
    if(!scripts\engine\utility::array_contains(_id_90FB369A18926018, player) && scripts\engine\utility::array_contains(_id_78122E18403A8DC4, player)) {
      if(scripts\mp\objidpoolmanager::_id_CE702E5925E31FC9(self.icon, player, 2, 2, &"MP_DMZ_MISSIONS/HOSTAGE_BAR_TITLE")) {
        scripts\mp\objidpoolmanager::objective_pin_player(self.icon, player);
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.icon, player);
        _id_F6FD7B0E73C3270C = scripts\engine\utility::array_add(_id_F6FD7B0E73C3270C, player);
      }

      continue;
    }

    if(scripts\engine\utility::array_contains(_id_90FB369A18926018, player) && !scripts\engine\utility::array_contains(_id_78122E18403A8DC4, player)) {
      scripts\mp\objidpoolmanager::objective_unpin_player(self.icon, player);
      scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.icon, player);
      _id_F6FD7B0E73C3270C = scripts\engine\utility::array_remove(_id_F6FD7B0E73C3270C, player);
    }
  }

  return _id_F6FD7B0E73C3270C;
}

_id_C0CCB94FCFE50916() {
  self endon("task_ended");
  self.hostage thread _id_8DC13537721B3C2D();

  while(isDefined(self.hostage) && self.hostage.health > 0 && !istrue(self.bombexploded))
    waitframe();

  if(istrue(self.failure)) {
    return;
  }
  self.failure = 1;

  if(isDefined(self._id_90758EFDE9B783B7))
    self._id_90758EFDE9B783B7 delete();

  if(!istrue(self._id_2F893D4A9CBF8A5C)) {
    _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_hostage_failure", "hostage", 0, self.teams[0]);

    if(isDefined(self.teams[0]) && !istrue(self.bombexploded))
      thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hostage_rescue_shot", self.teams[0], 1.5);

    if(isDefined(self._id_90FB369A18926018)) {
      foreach(player in self._id_90FB369A18926018) {
        scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.icon, player);
        scripts\mp\objidpoolmanager::objective_unpin_player(self.icon, player);
      }
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.icon);
    scripts\mp\objidpoolmanager::objective_set_show_progress(self.icon, 0);
    self._id_B0F4BF8621B96C0A[0] scripts\cp_mp\utility\game_utility::_id_04EAF685BC40A3B9();
  }

  thread _id_CB2F74520E05756F();
}

_id_B7A8186B8098B13F(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(part != "dmz_hostage") {
    return;
  }
  if(!isDefined(instance._id_B8EBE3F71A08AB40)) {
    return;
  }
  if(!istrue(instance._id_B8EBE3F71A08AB40._id_2F893D4A9CBF8A5C) && (!isDefined(instance._id_B8EBE3F71A08AB40.teams[0]) || player.team != instance._id_B8EBE3F71A08AB40.teams[0])) {
    return;
  }
  if(istrue(player.isdeploying)) {
    return;
  }
  if(istrue(player._id_35DADE814E13D3CE)) {
    return;
  }
  if(isDefined(level._id_6828253DB80AB6F1)) {
    if(isDefined(level._id_6828253DB80AB6F1[0]) && isDefined(level._id_6828253DB80AB6F1[0]._id_DC9CB1E7A8AA6621)) {
      if(isDefined(level._id_6828253DB80AB6F1[0]._id_DC9CB1E7A8AA6621._id_4BF7D94A7A835E41) && level._id_6828253DB80AB6F1[0]._id_DC9CB1E7A8AA6621._id_4BF7D94A7A835E41 == player)
        return;
    }
  }

  if(state == "usable" && isDefined(instance.hostage)) {
    if(isDefined(instance._id_B8EBE3F71A08AB40._id_84E79AB809A8EEA3)) {
      return;
    }
    instance setscriptablepartstate("dmz_hostage", "unusable");
    _id_B8EBE3F71A08AB40 = instance._id_B8EBE3F71A08AB40;
    _id_B8EBE3F71A08AB40.c4 hide();
    bomb = _id_B8EBE3F71A08AB40 _id_CADC5181C3B67E3F(player);
    thread _id_6C4E8CEA70BF4B6D::_id_D86771EDADBA8B4A(instance, _id_B8EBE3F71A08AB40, player);
    _id_8B07FA3892A3A8A4 = 0;

    while(_id_8B07FA3892A3A8A4 < level._id_AF7D80856E5AE6C0._id_0CA7A26C1E01B30A) {
      if(!isDefined(instance) || instance._id_A4CF15C49F3E9EEF || istrue(_id_B8EBE3F71A08AB40.failure) || !scripts\mp\utility\player::_id_AD443BBCDCF37B85(player)) {
        if(isDefined(player))
          player notifyonplayercommandremove("cancel", "+weapnext");

        _id_B8EBE3F71A08AB40 _id_0DB896F4486CA187(player, bomb);
        _id_B8EBE3F71A08AB40.c4 show();

        if(!istrue(_id_B8EBE3F71A08AB40.failure) && isDefined(instance)) {
          instance setscriptablepartstate("dmz_hostage", "usable");

          foreach(_id_6EE5484560EC747C in level.players)
          instance disablescriptableplayeruse(_id_6EE5484560EC747C);

          _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(instance._id_B8EBE3F71A08AB40.teams[0], "players");

          foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612)
          instance enablescriptableplayeruse(_id_F0EA4030349A33D5);
        }

        return 0;
      }

      _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + level.framedurationseconds;
      waitframe();
    }

    if(isDefined(player))
      player notifyonplayercommandremove("cancel", "+weapnext");

    if(istrue(instance._id_B8EBE3F71A08AB40.failure)) {
      instance._id_B8EBE3F71A08AB40 _id_0DB896F4486CA187(player, bomb);

      if(isDefined(_id_B8EBE3F71A08AB40.c4))
        _id_B8EBE3F71A08AB40.c4 delete();

      return;
    }

    instance._id_B8EBE3F71A08AB40.state = "rescued";
    instance.hostage notify("play_dialog");
    instance._id_B8EBE3F71A08AB40.bombexploded = 0;
    instance._id_B8EBE3F71A08AB40 notify("bomb_defused");

    if(isDefined(instance._id_B8EBE3F71A08AB40._id_90FB369A18926018)) {
      foreach(_id_70ABE2C111C6F7FB in instance._id_B8EBE3F71A08AB40._id_90FB369A18926018) {
        scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(instance._id_B8EBE3F71A08AB40.icon, _id_70ABE2C111C6F7FB);
        scripts\mp\objidpoolmanager::objective_unpin_player(instance._id_B8EBE3F71A08AB40.icon, player);
      }
    }

    scripts\mp\objidpoolmanager::_id_6AE37618BB04EA60(instance._id_B8EBE3F71A08AB40.icon);
    instance._id_B8EBE3F71A08AB40 _id_0DB896F4486CA187(player, bomb);

    if(isDefined(_id_B8EBE3F71A08AB40.c4))
      _id_B8EBE3F71A08AB40.c4 delete();

    if(istrue(_id_B8EBE3F71A08AB40.failure)) {
      return;
    }
    player playSound("mp_dmz_hostage_unzip");
    instance._id_B8EBE3F71A08AB40.dropposition = instance.position;
    instance setscriptablepartstate("dmz_hostage", "remaining");

    foreach(guy in level.players)
    instance disablescriptableplayeruse(guy);

    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(instance._id_B8EBE3F71A08AB40.teams[0], "players");

    foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612)
    instance enablescriptableplayeruse(_id_F0EA4030349A33D5);

    scripts\mp\objidpoolmanager::update_objective_position(instance._id_B8EBE3F71A08AB40.icon, instance._id_B8EBE3F71A08AB40.hostage.origin + (0, 0, 30));
    instance._id_B8EBE3F71A08AB40._id_B0F4BF8621B96C0A[0] scripts\cp_mp\utility\game_utility::_id_04EAF685BC40A3B9();
    instance._id_B8EBE3F71A08AB40._id_B0F4BF8621B96C0A[0] scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(instance._id_B8EBE3F71A08AB40._id_23D42B1195DDA679.origin);
    instance._id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_hostage_success", instance._id_B8EBE3F71A08AB40.teams[0]);
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hostage_rescue_win", instance._id_B8EBE3F71A08AB40.teams[0], 2.0);
    instance._id_B8EBE3F71A08AB40 thread _id_0DF48D309A8BC55A();
    _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(instance._id_B8EBE3F71A08AB40.teams[0], "dmz_hostage_rescue", 1.0, "dmz_hostage_rescue_classic");
  } else if(state == "remaining" && isDefined(instance.hostage)) {
    instance setscriptablepartstate("dmz_hostage", "unusable");
    instance._id_B8EBE3F71A08AB40 _id_6E98EEED96B1D4B2(player, instance.hostage);
  } else if(state == "following" && isDefined(instance.hostage))
    instance._id_B8EBE3F71A08AB40 drophostage();
}

#using_animtree("script_model");

initanims() {
  level.scr_animtree["player_pickup_hostage"] = #animtree;
  level.scr_anim["player_pickup_hostage"]["pickup_front_crouch"] = % iw9_mp_hostage_pickup_crouch_8;
  level.scr_animname["player_pickup_hostage"]["pickup_front_crouch"] = "iw9_mp_hostage_pickup_crouch_8";
  level.scr_eventanim["player_pickup_hostage"]["pickup_front_crouch"] = "pickup_front_crouch";
  level.scr_anim["player_pickup_hostage"]["pickup_front_stand"] = % iw9_mp_hostage_pickup_stand_8;
  level.scr_animname["player_pickup_hostage"]["pickup_front_stand"] = "iw9_mp_hostage_pickup_stand_8";
  level.scr_eventanim["player_pickup_hostage"]["pickup_front_stand"] = "pickup_front_stand";
  level.scr_anim["player_pickup_hostage"]["pickup_back_crouch"] = % iw9_mp_hostage_pickup_crouch_2;
  level.scr_animname["player_pickup_hostage"]["pickup_back_crouch"] = "iw9_mp_hostage_pickup_crouch_2";
  level.scr_eventanim["player_pickup_hostage"]["pickup_back_crouch"] = "pickup_back_crouch";
  level.scr_anim["player_pickup_hostage"]["pickup_back_stand"] = % iw9_mp_hostage_pickup_stand_2;
  level.scr_animname["player_pickup_hostage"]["pickup_back_stand"] = "iw9_mp_hostage_pickup_stand_2";
  level.scr_eventanim["player_pickup_hostage"]["pickup_back_stand"] = "pickup_back_stand";
  level.scr_anim["player_pickup_hostage"]["pickup_right_crouch"] = % iw9_mp_hostage_pickup_crouch_6;
  level.scr_animname["player_pickup_hostage"]["pickup_right_crouch"] = "iw9_mp_hostage_pickup_crouch_6";
  level.scr_eventanim["player_pickup_hostage"]["pickup_right_crouch"] = "pickup_right_crouch";
  level.scr_anim["player_pickup_hostage"]["pickup_right_stand"] = % iw9_mp_hostage_pickup_stand_6;
  level.scr_animname["player_pickup_hostage"]["pickup_right_stand"] = "iw9_mp_hostage_pickup_stand_6";
  level.scr_eventanim["player_pickup_hostage"]["pickup_right_stand"] = "pickup_right_stand";
  level.scr_anim["player_pickup_hostage"]["pickup_left_crouch"] = % iw9_mp_hostage_pickup_crouch_4;
  level.scr_animname["player_pickup_hostage"]["pickup_left_crouch"] = "iw9_mp_hostage_pickup_crouch_4";
  level.scr_eventanim["player_pickup_hostage"]["pickup_left_crouch"] = "pickup_left_crouch";
  level.scr_anim["player_pickup_hostage"]["pickup_left_stand"] = % iw9_mp_hostage_pickup_stand_4;
  level.scr_animname["player_pickup_hostage"]["pickup_left_stand"] = "iw9_mp_hostage_pickup_stand_4";
  level.scr_eventanim["player_pickup_hostage"]["pickup_left_stand"] = "pickup_left_stand";
  level.scr_anim["player_pickup_hostage"]["pickup_front_crouch_vm"] = % iw9_mp_hostage_vm_pickup_crouch_8;
  level.scr_animname["player_pickup_hostage"]["pickup_front_crouch_vm"] = "iw9_mp_hostage_vm_pickup_crouch_8";
  level.scr_eventanim["player_pickup_hostage"]["pickup_front_crouch_vm"] = "pickup_front_crouch_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_front_stand_vm"] = % iw9_mp_hostage_vm_pickup_stand_8;
  level.scr_animname["player_pickup_hostage"]["pickup_front_stand_vm"] = "iw9_mp_hostage_vm_pickup_stand_8";
  level.scr_eventanim["player_pickup_hostage"]["pickup_front_stand_vm"] = "pickup_front_stand_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_back_crouch_vm"] = % iw9_mp_hostage_vm_pickup_crouch_2;
  level.scr_animname["player_pickup_hostage"]["pickup_back_crouch_vm"] = "iw9_mp_hostage_vm_pickup_crouch_2";
  level.scr_eventanim["player_pickup_hostage"]["pickup_back_crouch_vm"] = "pickup_back_crouch_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_back_stand_vm"] = % iw9_mp_hostage_vm_pickup_stand_2;
  level.scr_animname["player_pickup_hostage"]["pickup_back_stand_vm"] = "iw9_mp_hostage_vm_pickup_stand_2";
  level.scr_eventanim["player_pickup_hostage"]["pickup_back_stand_vm"] = "pickup_back_stand_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_right_crouch_vm"] = % iw9_mp_hostage_vm_pickup_crouch_6;
  level.scr_animname["player_pickup_hostage"]["pickup_right_crouch_vm"] = "iw9_mp_hostage_vm_pickup_crouch_6";
  level.scr_eventanim["player_pickup_hostage"]["pickup_right_crouch_vm"] = "pickup_right_crouch_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_right_stand_vm"] = % iw9_mp_hostage_vm_pickup_stand_6;
  level.scr_animname["player_pickup_hostage"]["pickup_right_stand_vm"] = "iw9_mp_hostage_vm_pickup_stand_6";
  level.scr_eventanim["player_pickup_hostage"]["pickup_right_stand_vm"] = "pickup_right_stand_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_left_crouch_vm"] = % iw9_mp_hostage_vm_pickup_crouch_4;
  level.scr_animname["player_pickup_hostage"]["pickup_left_crouch_vm"] = "iw9_mp_hostage_vm_pickup_crouch_4";
  level.scr_eventanim["player_pickup_hostage"]["pickup_left_crouch_vm"] = "pickup_left_crouch_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_left_stand_vm"] = % iw9_mp_hostage_vm_pickup_stand_4;
  level.scr_animname["player_pickup_hostage"]["pickup_left_stand_vm"] = "iw9_mp_hostage_vm_pickup_stand_4";
  level.scr_eventanim["player_pickup_hostage"]["pickup_left_stand_vm"] = "pickup_left_stand_vm";
  level.scr_animtree["hostage_pickup"] = #animtree;
  level.scr_anim["hostage_pickup"]["pickup_front_crouch"] = % iw9_mp_hostage_pickedup_crouch_8;
  level.scr_animname["hostage_pickup"]["pickup_front_crouch"] = "iw9_mp_hostage_pickedup_crouch_8";
  level.scr_eventanim["hostage_pickup"]["pickup_front_crouch"] = "hostage_pickup_front_crouch";
  level.scr_anim["hostage_pickup"]["pickup_front_stand"] = % iw9_mp_hostage_pickedup_stand_8;
  level.scr_animname["hostage_pickup"]["pickup_front_stand"] = "iw9_mp_hostage_pickedup_stand_8";
  level.scr_eventanim["hostage_pickup"]["pickup_front_stand"] = "hostage_pickup_front_stand";
  level.scr_anim["hostage_pickup"]["pickup_back_crouch"] = % iw9_mp_hostage_pickedup_crouch_2;
  level.scr_animname["hostage_pickup"]["pickup_back_crouch"] = "iw9_mp_hostage_pickedup_crouch_2";
  level.scr_eventanim["hostage_pickup"]["pickup_back_crouch"] = "hostage_pickup_back_crouch";
  level.scr_anim["hostage_pickup"]["pickup_back_stand"] = % iw9_mp_hostage_pickedup_stand_2;
  level.scr_animname["hostage_pickup"]["pickup_back_stand"] = "iw9_mp_hostage_pickedup_stand_2";
  level.scr_eventanim["hostage_pickup"]["pickup_back_stand"] = "hostage_pickup_back_stand";
  level.scr_anim["hostage_pickup"]["pickup_right_crouch"] = % iw9_mp_hostage_pickedup_crouch_6;
  level.scr_animname["hostage_pickup"]["pickup_right_crouch"] = "iw9_mp_hostage_pickedup_crouch_6";
  level.scr_eventanim["hostage_pickup"]["pickup_right_crouch"] = "hostage_pickup_right_crouch";
  level.scr_anim["hostage_pickup"]["pickup_right_stand"] = % iw9_mp_hostage_pickedup_stand_6;
  level.scr_animname["hostage_pickup"]["pickup_right_stand"] = "iw9_mp_hostage_pickedup_stand_6";
  level.scr_eventanim["hostage_pickup"]["pickup_right_stand"] = "hostage_pickup_right_stand";
  level.scr_anim["hostage_pickup"]["pickup_left_crouch"] = % iw9_mp_hostage_pickedup_crouch_4;
  level.scr_animname["hostage_pickup"]["pickup_left_crouch"] = "iw9_mp_hostage_pickedup_crouch_4";
  level.scr_eventanim["hostage_pickup"]["pickup_left_crouch"] = "hostage_pickup_left_crouch";
  level.scr_anim["hostage_pickup"]["pickup_left_stand"] = % iw9_mp_hostage_pickedup_stand_4;
  level.scr_animname["hostage_pickup"]["pickup_left_stand"] = "iw9_mp_hostage_pickedup_stand_4";
  level.scr_eventanim["hostage_pickup"]["pickup_left_stand"] = "hostage_pickup_left_stand";
  level.scr_animtree["hostage_pickup_sm"] = #animtree;
  level.scr_anim["hostage_pickup_sm"]["pickup_front_crouch_vm"] = % iw9_mp_hostage_vm_pickedup_crouch_8;
  level.scr_animname["hostage_pickup_sm"]["pickup_front_crouch_vm"] = "iw9_mp_hostage_vm_pickedup_crouch_8";
  level.scr_eventanim["hostage_pickup_sm"]["pickup_front_crouch_vm"] = "hostage_pickup_front_crouch_vm";
  level.scr_anim["hostage_pickup_sm"]["pickup_front_stand_vm"] = % iw9_mp_hostage_vm_pickedup_stand_8;
  level.scr_animname["hostage_pickup_sm"]["pickup_front_stand_vm"] = "iw9_mp_hostage_vm_pickedup_stand_8";
  level.scr_eventanim["hostage_pickup_sm"]["pickup_front_stand_vm"] = "hostage_pickup_front_stand_vm";
  level.scr_anim["hostage_pickup_sm"]["pickup_back_crouch_vm"] = % iw9_mp_hostage_vm_pickedup_crouch_2;
  level.scr_animname["hostage_pickup_sm"]["pickup_back_crouch_vm"] = "iw9_mp_hostage_vm_pickedup_crouch_2";
  level.scr_eventanim["hostage_pickup_sm"]["pickup_back_crouch_vm"] = "hostage_pickup_back_crouch_vm";
  level.scr_anim["hostage_pickup_sm"]["pickup_back_stand_vm"] = % iw9_mp_hostage_vm_pickedup_stand_2;
  level.scr_animname["hostage_pickup_sm"]["pickup_back_stand_vm"] = "iw9_mp_hostage_vm_pickedup_stand_2";
  level.scr_eventanim["hostage_pickup_sm"]["pickup_back_stand_vm"] = "hostage_pickup_back_stand_vm";
  level.scr_anim["hostage_pickup_sm"]["pickup_right_crouch_vm"] = % iw9_mp_hostage_vm_pickedup_crouch_6;
  level.scr_animname["hostage_pickup_sm"]["pickup_right_crouch_vm"] = "iw9_mp_hostage_vm_pickedup_crouch_6";
  level.scr_eventanim["hostage_pickup_sm"]["pickup_right_crouch_vm"] = "hostage_pickup_right_crouch_vm";
  level.scr_anim["hostage_pickup_sm"]["pickup_right_stand_vm"] = % iw9_mp_hostage_vm_pickedup_stand_6;
  level.scr_animname["hostage_pickup_sm"]["pickup_right_stand_vm"] = "iw9_mp_hostage_vm_pickedup_stand_6";
  level.scr_eventanim["hostage_pickup_sm"]["pickup_right_stand_vm"] = "hostage_pickup_right_stand_vm";
  level.scr_anim["hostage_pickup_sm"]["pickup_left_crouch_vm"] = % iw9_mp_hostage_vm_pickedup_crouch_4;
  level.scr_animname["hostage_pickup_sm"]["pickup_left_crouch_vm"] = "iw9_mp_hostage_vm_pickedup_crouch_4";
  level.scr_eventanim["hostage_pickup_sm"]["pickup_left_crouch_vm"] = "hostage_pickup_left_crouch_vm";
  level.scr_anim["hostage_pickup_sm"]["pickup_left_stand_vm"] = % iw9_mp_hostage_vm_pickedup_stand_4;
  level.scr_animname["hostage_pickup_sm"]["pickup_left_stand_vm"] = "iw9_mp_hostage_vm_pickedup_stand_4";
  level.scr_eventanim["hostage_pickup_sm"]["pickup_left_stand_vm"] = "hostage_pickup_left_stand_vm";
}

_id_6E98EEED96B1D4B2(player, hostage) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("last_stand_start");
  level endon("game_ended");
  self.hostage endon("death");
  self endon("task_ended");

  if(!istrue(self._id_0AF8D4CC519C65DE)) {
    self.carryingplayer = player;
    thread _id_82EF6D194918247F(player);
    player._id_859654E0445A36D9 = 1;
    hostage unlink();
    self.instance scriptableclearparententity();
    hostage.invulnerable = 1;
    hostage _id_3B8913DC82881267(player);
    player notify("hostage_pickup_finished");
  }

  if(!istrue(self._id_0AF8D4CC519C65DE)) {
    hostage hide();
    hostage.origin = hostage.origin + (0, 0, 100000);
    self.carryingplayer setcarryobject(_id_58CA3A35159054B1(hostage.model));
    _id_F0C2012AE22CA0D6(self.carryingplayer);

    if(!istrue(self._id_2F893D4A9CBF8A5C)) {
      players = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");

      foreach(_id_F0EA4030349A33D5 in players)
      self._id_B0F4BF8621B96C0A[0] scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(_id_F0EA4030349A33D5);

      scripts\mp\objidpoolmanager::update_objective_position(self.icon, self._id_23D42B1195DDA679.origin);
    }

    self.instance setscriptablepartstate("dmz_hostage", "following");

    foreach(_id_6EE5484560EC747C in level.players)
    self.instance disablescriptableplayeruse(_id_6EE5484560EC747C);

    self.instance enablescriptableplayeruse(self.carryingplayer);
    thread _id_EEDE562CE57290D3();
  }
}

_id_58CA3A35159054B1(model) {
  if(!isDefined(model))
    return "hostage_rescue";

  switch (model) {
    case "civ_amsterdam_male_3_1_dmz":
      return "hostage_civ_male_3_1";
    case "civ_amsterdam_male_3_2_dmz":
      return "hostage_civ_male_3_2";
    case "civ_amsterdam_male_3_3_dmz":
      return "hostage_civ_male_3_3";
    default:
      return "hostage_rescue";
  }
}

_id_8F65AC94AAFE5D3E(animname, spawnpos, _id_B7850001037AA074, bodymodel, headmodel) {
  self.animname = animname;

  if(!isDefined(spawnpos))
    spawnpos = (0, 0, 0);

  if(!isDefined(_id_B7850001037AA074))
    _id_B7850001037AA074 = (0, 0, 0);

  _id_FC77A3EE1C3E72B5 = spawn("script_model", spawnpos);
  _id_FC77A3EE1C3E72B5.angles = _id_B7850001037AA074;
  _id_FC77A3EE1C3E72B5 setModel(bodymodel);
  _id_FC77A3EE1C3E72B5 notsolid();
  self._id_FC77A3EE1C3E72B5 = _id_FC77A3EE1C3E72B5;
  self._id_FC77A3EE1C3E72B5.animname = animname;
  self._id_FC77A3EE1C3E72B5 useanimtree(#animtree);
  self._id_FC77A3EE1C3E72B5.updatedversion = 1;
  head = spawn("script_model", spawnpos);
  head setModel(headmodel);
  head notsolid();
  self._id_FC77A3EE1C3E72B5.head = head;
  self notify("rig_created");
  scripts\engine\utility::waittill_any_2("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(head)) {
    head unlink();
    head delete();
  }

  if(isDefined(_id_FC77A3EE1C3E72B5))
    _id_FC77A3EE1C3E72B5 delete();
}

_id_8277F49F79BFF530(animname, spawnpos, _id_B7850001037AA074) {
  self.animname = animname;

  if(!isDefined(spawnpos))
    spawnpos = (0, 0, 0);

  if(!isDefined(_id_B7850001037AA074))
    _id_B7850001037AA074 = (0, 0, 0);

  if(isPlayer(self))
    self _meth_B88C89BB7CD1AB8E(spawnpos);

  _id_0E3BDA5BE1DB297F = spawn("script_arms", spawnpos, 0, 0, self);
  _id_0E3BDA5BE1DB297F.angles = _id_B7850001037AA074;
  _id_0E3BDA5BE1DB297F.player = self;
  self._id_0E3BDA5BE1DB297F = _id_0E3BDA5BE1DB297F;
  self._id_0E3BDA5BE1DB297F.animname = animname;
  self._id_0E3BDA5BE1DB297F useanimtree(#animtree);
  self._id_0E3BDA5BE1DB297F.updatedversion = 1;
  self playerlinktoabsolute(self._id_0E3BDA5BE1DB297F, "tag_player", 1.0, 0, 0, 0, 0, 1);
  self notify("rig_created");
  scripts\engine\utility::waittill_any_2("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(self)) {
    self unlink();
    thread scripts\cp_mp\utility\inventory_utility::_id_9897D143C3FEEE05();
  }

  if(isDefined(_id_0E3BDA5BE1DB297F))
    _id_0E3BDA5BE1DB297F delete();
}

_id_A3A4A2CDCA554483(animname, spawnpos, _id_B7850001037AA074) {
  self.animname = animname;

  if(!isDefined(spawnpos))
    spawnpos = (0, 0, 0);

  if(!isDefined(_id_B7850001037AA074))
    _id_B7850001037AA074 = (0, 0, 0);

  if(isPlayer(self))
    self _meth_B88C89BB7CD1AB8E(spawnpos);

  _id_54D7B76A2A71E284 = spawn("script_arms", spawnpos, 0, 0, self);
  _id_54D7B76A2A71E284.angles = _id_B7850001037AA074;
  _id_54D7B76A2A71E284.player = self;
  self._id_54D7B76A2A71E284 = _id_54D7B76A2A71E284;
  self._id_54D7B76A2A71E284.animname = animname;
  self._id_54D7B76A2A71E284 useanimtree(#animtree);
  self._id_54D7B76A2A71E284.updatedversion = 1;
  self playerlinktoabsolute(self._id_54D7B76A2A71E284, "tag_player", 1.0, 0, 0, 0, 0, 1);
  self notify("rig_created");
  scripts\engine\utility::waittill_any_2("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(self)) {
    self unlink();
    thread scripts\cp_mp\utility\inventory_utility::_id_9897D143C3FEEE05();
  }

  if(isDefined(_id_54D7B76A2A71E284))
    _id_54D7B76A2A71E284 delete();
}

_id_3B8913DC82881267(player) {
  self._id_44206360497F15C2 = 1;
  player _id_3B64EB40368C1450::set("carry", "vehicle_use", 0);
  player _id_3B64EB40368C1450::set("carry", "melee", 0);
  player _id_3B64EB40368C1450::set("carry", "weapon_switch", 0);
  player _id_3B64EB40368C1450::set("carry", "sprint", 0);
  player _id_3B64EB40368C1450::set("carry", "fire", 0);
  player _id_3B64EB40368C1450::set("carry", "reload", 0);
  player _id_3B64EB40368C1450::set("carry", "weapon_pickup", 0);
  player _id_3B64EB40368C1450::set("carry", "weapon_switch", 0);
  player _id_3B64EB40368C1450::set("carry", "allow_jump", 0);
  player _id_3B64EB40368C1450::set("carry", "gesture", 0);
  player _meth_35501B42058D4DE9();
  player _id_3B64EB40368C1450::set("move_disable", "allow_movement", 0);

  if(istrue(player.insertingarmorplate)) {
    player notify("try_armor_cancel");

    while(isDefined(player.currentweapon) && isDefined(player.currentweapon.basename) && player.currentweapon.basename == "iw9_armor_plate_deploy_mp")
      waitframe();

    waitframe();
  }

  animlength = 0;
  stance = player getstance();

  if(stance == "prone") {
    player setstance("crouch", 1, 1);
    stance = "crouch";
  }

  player._id_280ABCD08CBDCC79 = player getcurrentweapon();
  _id_2B1D0E57C66A43D0 = makeweapon("iw9_gunless_mp");
  player giveweapon(_id_2B1D0E57C66A43D0);
  player._id_73F4B954751A8643 = _id_2B1D0E57C66A43D0;
  result = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(_id_2B1D0E57C66A43D0, 1, 1);

  if(!istrue(result))
    player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(_id_2B1D0E57C66A43D0, 1, 1);

  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("move_disable");
  _id_7C4E2C6A50914434 = (self.origin[0], self.origin[1], player.origin[2]);
  _id_CEBE2632E00D0E2D = vectorNormalize(player.origin - _id_7C4E2C6A50914434);
  _id_82B4F01CE94ED444 = vectordot(_id_CEBE2632E00D0E2D, anglesToForward(self.angles));
  _id_8288E81CE91E5C46 = vectordot(_id_CEBE2632E00D0E2D, anglestoright(self.angles));
  self.origin = player.origin + anglesToForward(player.angles) * 34.672;
  self._id_08EE3FF7543AC0B4 = stance;
  self._id_A1E9BAABC1D61AE3 = undefined;
  anime = "pickup_back_stand";
  _id_CF13EDFFB05EFCD8 = "pickup_back_stand_vm";
  _id_318EEA579595B65E = undefined;

  if(_id_82B4F01CE94ED444 >= 0.707) {
    self._id_A1E9BAABC1D61AE3 = "front";
    anime = "pickup_front_" + stance;
    _id_CF13EDFFB05EFCD8 = "pickup_front_" + stance + "_vm";
    _id_636EC99138E1950A = vectorNormalize(player.origin - self.origin);
    _id_318EEA579595B65E = scripts\mp\utility\script::vectortoanglessafe(_id_636EC99138E1950A, anglestoup(self.angles));
    self.angles = _id_318EEA579595B65E;
  } else if(_id_82B4F01CE94ED444 <= -0.707) {
    self._id_A1E9BAABC1D61AE3 = "back";
    anime = "pickup_back_" + stance;
    _id_CF13EDFFB05EFCD8 = "pickup_back_" + stance + "_vm";
    _id_81554C014CE7839C = vectorNormalize(self.origin - player.origin);
    _id_318EEA579595B65E = scripts\mp\utility\script::vectortoanglessafe(_id_81554C014CE7839C, anglestoup(self.angles));
    self.angles = _id_318EEA579595B65E;
  } else if(_id_8288E81CE91E5C46 >= 0.707) {
    self._id_A1E9BAABC1D61AE3 = "right";
    anime = "pickup_right_" + stance;
    _id_CF13EDFFB05EFCD8 = "pickup_right_" + stance + "_vm";
    _id_81554C014CE7839C = vectorcross(vectorNormalize(self.origin - player.origin), anglestoup(self.angles));
    _id_318EEA579595B65E = scripts\mp\utility\script::vectortoanglessafe(_id_81554C014CE7839C, anglestoup(self.angles));
    self.angles = _id_318EEA579595B65E;
  } else if(_id_8288E81CE91E5C46 <= -0.707) {
    self._id_A1E9BAABC1D61AE3 = "left";
    anime = "pickup_left_" + stance;
    _id_CF13EDFFB05EFCD8 = "pickup_left_" + stance + "_vm";
    _id_636EC99138E1950A = vectorcross(vectorNormalize(player.origin - self.origin), anglestoup(self.angles));
    _id_318EEA579595B65E = scripts\mp\utility\script::vectortoanglessafe(_id_636EC99138E1950A, anglestoup(self.angles));
    self.angles = _id_318EEA579595B65E;
  }

  if(isDefined(_id_318EEA579595B65E))
    self orientmode("face angle 3d", _id_318EEA579595B65E);

  player thread _id_8277F49F79BFF530("player_pickup_hostage", player.origin, player.angles);
  player._id_0E3BDA5BE1DB297F hide();
  player thread _id_A3A4A2CDCA554483("player_pickup_hostage", player.origin, player.angles);

  if(player _meth_C1092F42B6BBE490())
    player._id_54D7B76A2A71E284 hide();
  else
    player._id_54D7B76A2A71E284 showonlytoplayer(player);

  _id_D5B5FFAD0ECA8C36 = spawnStruct();
  _id_D5B5FFAD0ECA8C36 thread _id_8F65AC94AAFE5D3E("hostage_pickup_sm", self.origin, self.angles, self.model, self.headmodel);
  _id_D5B5FFAD0ECA8C36._id_FC77A3EE1C3E72B5 hide();
  _id_D5B5FFAD0ECA8C36._id_FC77A3EE1C3E72B5 showonlytoplayer(player);

  if(isDefined(_id_D5B5FFAD0ECA8C36._id_FC77A3EE1C3E72B5.head)) {
    _id_D5B5FFAD0ECA8C36._id_FC77A3EE1C3E72B5.head hide();
    _id_D5B5FFAD0ECA8C36._id_FC77A3EE1C3E72B5.head showonlytoplayer(player);
    _id_D5B5FFAD0ECA8C36._id_FC77A3EE1C3E72B5.head linkTo(_id_D5B5FFAD0ECA8C36._id_FC77A3EE1C3E72B5, "j_neck", (-9, 1, 0), (0, 0, 0));
  }

  self._id_D5B5FFAD0ECA8C36 = _id_D5B5FFAD0ECA8C36;
  player._id_43E2C0FCF655EBAC = _id_D5B5FFAD0ECA8C36;
  self hidefromplayer(player);
  self.animname = "hostage_pickup";
  self useanimtree(level.scr_animtree["hostage_pickup"]);
  self._blackboard._id_7460B96395361857 = "getting_picked_up";
  animstruct = spawnStruct();
  animstruct.origin = player.origin;
  animstruct.angles = player.angles;
  _id_F514603FEAF5C1E2 = player getmovingplatformparent();

  if(isDefined(_id_F514603FEAF5C1E2) && scripts\cp_mp\utility\killstreak_utility::_id_63BDC8C411A85475(_id_F514603FEAF5C1E2)) {
    _id_D5B5FFAD0ECA8C36._id_FC77A3EE1C3E72B5 linkTo(_id_F514603FEAF5C1E2);
    player._id_54D7B76A2A71E284 linkTo(_id_F514603FEAF5C1E2);
    player playerlinkedoffsetenable();
  }

  animstruct thread scripts\mp\anim::anim_player_solo(player, player._id_0E3BDA5BE1DB297F, anime);
  animstruct thread scripts\common\anim::anim_single_solo(player._id_54D7B76A2A71E284, _id_CF13EDFFB05EFCD8);
  _id_D5B5FFAD0ECA8C36._id_FC77A3EE1C3E72B5 thread scripts\common\anim::anim_single_solo(_id_D5B5FFAD0ECA8C36._id_FC77A3EE1C3E72B5, _id_CF13EDFFB05EFCD8);
  wait(getanimlength(level.scr_anim["player_pickup_hostage"][_id_CF13EDFFB05EFCD8]));
  _id_F514603FEAF5C1E2 = player getmovingplatformparent();

  if(isDefined(_id_F514603FEAF5C1E2) && scripts\cp_mp\utility\killstreak_utility::_id_63BDC8C411A85475(_id_F514603FEAF5C1E2)) {
    _id_D5B5FFAD0ECA8C36._id_FC77A3EE1C3E72B5 unlink();
    player._id_54D7B76A2A71E284 unlink();
    player _meth_1BBFE4913FD10C4A();
  }

  player notify("remove_rig");
  _id_D5B5FFAD0ECA8C36 notify("remove_rig");
  player._id_73F4B954751A8643 = undefined;
  player._id_43E2C0FCF655EBAC = undefined;
  player takeweapon(_id_2B1D0E57C66A43D0);
  _id_04B5B395EA0EA0FB::_id_83DFC273B8E7EFED(player);
  self._id_44206360497F15C2 = undefined;
}

_id_524F22FE698EEB0F(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  _id_B7771CC818B41864(player);
  gunless = makeweapon("iw9_gunless_mp");
  player giveweapon(gunless);
  player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless);

  if(isDefined(player._id_7EBBB0DC14346EAA)) {
    player takeweapon(player._id_7EBBB0DC14346EAA);
    player._id_7EBBB0DC14346EAA = undefined;
    player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(player._id_280ABCD08CBDCC79);
  } else
    player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(player._id_280ABCD08CBDCC79);

  if(isDefined(player._id_280ABCD08CBDCC79))
    player._id_280ABCD08CBDCC79 = undefined;

  player takeweapon(gunless);
  player resetcarryobject();
}

drophostage(_id_9768B22610B34D9D) {
  droporigin = undefined;
  dropangles = undefined;
  _id_037252B7E9C614D8 = undefined;

  if(!isDefined(self.carryingplayer) || !isDefined(self.carryingplayer.origin) || !isDefined(self.carryingplayer.angles)) {
    droporigin = self._id_3D17023B5BFB92CE;
    dropangles = self._id_BFF867759E490124;
    _id_037252B7E9C614D8 = self._id_AB2A8C60478BDD5C;
  } else {
    droporigin = self.carryingplayer.origin;
    dropangles = self.carryingplayer.angles;
    _id_037252B7E9C614D8 = self.carryingplayer getstance();
  }

  _id_7FE2DF4A925ADFFE = undefined;
  _id_9FBC564D9BB976ED = undefined;
  _id_0741196A281686EE = physics_createcontents(["physicscontents_water"]);
  _id_AA517194E54F048B = physics_getclosestpointtosphere(droporigin, 16, 0, _id_0741196A281686EE, [], "physicsquery_any");

  if(istrue(_id_AA517194E54F048B))
    _id_7FE2DF4A925ADFFE = 1;

  contents = physics_createcontents(["physicscontents_playerclip", "physicscontents_glass"]);
  caststart = droporigin;
  castdir = (0, 0, -1);
  _id_64B62CB5DC1E7AF6 = 60;
  castend = caststart + castdir * _id_64B62CB5DC1E7AF6;
  ignorelist = [self.hostage, self.carryingplayer];
  _id_AA517194E54F048B = physics_capsulecast(caststart + (0, 0, 24), castend, 4, 40, (0, 0, 90), contents, ignorelist, "physicsquery_closest");

  if(!isDefined(_id_AA517194E54F048B) || _id_AA517194E54F048B.size <= 0) {
    _id_E07D74D7E0452E2B(_id_9768B22610B34D9D);
    return;
  }

  _id_1D9FB21B4F3023F3 = _id_AA517194E54F048B[0]["entity"];

  if(isDefined(_id_1D9FB21B4F3023F3) && istrue(_id_1D9FB21B4F3023F3._id_E6E657A1FA139548))
    _id_9FBC564D9BB976ED = 1;

  if(isDefined(_id_1D9FB21B4F3023F3) && !_id_0CF6E0046827D08C(_id_1D9FB21B4F3023F3, droporigin) || istrue(_id_7FE2DF4A925ADFFE) && !istrue(_id_9FBC564D9BB976ED)) {
    _id_E07D74D7E0452E2B(_id_9768B22610B34D9D);
    return;
  }

  _id_C72145D539D8D1A1 = _id_AA517194E54F048B[0]["shape_position"];
  _id_2E3BC21C15E7AB6C = _id_AA517194E54F048B[0]["position"];
  spawnpos = _id_C72145D539D8D1A1 - (0, 0, 20);
  _id_7A2D144A06A00B97 = _id_A2A73E5D91D2AAE4(_id_1D9FB21B4F3023F3);

  if(!isDefined(_id_7A2D144A06A00B97) && scripts\common\elevator::_id_0D9D18DAB18EBDED(self.carryingplayer getmovingplatformparent()))
    _id_7A2D144A06A00B97 = self.carryingplayer getmovingplatformparent();

  if(isDefined(_id_7A2D144A06A00B97)) {
    self.hostage.origin = droporigin;
    self.hostage.angles = dropangles;
    self.hostage._id_08EE3FF7543AC0B4 = _id_037252B7E9C614D8;
    _id_A53033C7EC33A23F = _func_D559A384B9C4E7D9(droporigin, _id_7A2D144A06A00B97.origin, _id_7A2D144A06A00B97.angles);
    localangles = _func_848155BE2B7DA2CB(dropangles, _id_7A2D144A06A00B97.angles);

    if(!isDefined(self._id_90758EFDE9B783B7))
      self._id_90758EFDE9B783B7 = spawn("script_origin", droporigin);

    self._id_90758EFDE9B783B7.origin = droporigin;
    _id_F55677B515A572E4 = scripts\cp_mp\utility\killstreak_utility::_id_3C5C5D86EF14420E(_id_7A2D144A06A00B97);

    if(istrue(_id_F55677B515A572E4))
      self._id_90758EFDE9B783B7 linkTo(_id_7A2D144A06A00B97);
    else
      self._id_90758EFDE9B783B7 linkTo(_id_7A2D144A06A00B97, "tag_origin", _id_A53033C7EC33A23F, localangles);

    self.hostage linkTo(self._id_90758EFDE9B783B7);
    thread _id_32281F94A25FDC10(_id_7A2D144A06A00B97);
  } else {
    self.hostage.origin = droporigin;
    self.hostage.angles = dropangles;
    self.hostage._id_08EE3FF7543AC0B4 = _id_037252B7E9C614D8;
  }

  self.hostage show();
  self.hostage.invulnerable = 0;
  _id_6B3AC788A12C0DDA(self.carryingplayer);
  animlength = undefined;

  if(isDefined(self.hostage) && istrue(self.hostage._id_44206360497F15C2) || !isDefined(self.carryingplayer)) {
    self._id_44206360497F15C2 = undefined;

    if(isDefined(self.carryingplayer) && isDefined(self.carryingplayer._id_73F4B954751A8643))
      self.carryingplayer takeweapon(self.carryingplayer._id_73F4B954751A8643);

    waitframe();
  }

  self.hostage._blackboard._id_7460B96395361857 = "getting_dropped";
  animlength = getanimlength(%iw9_mp_hostage_dropped_stand);

  if(!istrue(self.failure))
    self.instance setscriptablepartstate("dmz_hostage", "unusable");

  self.carryingplayer._id_6B9CAB81D9F94C6D = 1;

  if(isDefined(animlength))
    wait(animlength);

  self.carryingplayer._id_6B9CAB81D9F94C6D = undefined;

  if(!istrue(self.failure)) {
    self.instance setscriptablepartstate("dmz_hostage", "remaining");

    if(istrue(self._id_2F893D4A9CBF8A5C)) {
      foreach(player in level.players)
      self.instance enablescriptableplayeruse(player);
    } else {
      foreach(player in level.players)
      self.instance disablescriptableplayeruse(player);

      _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");

      foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612)
      self.instance enablescriptableplayeruse(_id_F0EA4030349A33D5);
    }

    self.hostage._blackboard._id_7460B96395361857 = "dropped";
    self.instance.origin = self.hostage.origin;
    self.instance scriptablesetparententity(self.hostage, (0, 0, 15), (0, 0, 0));

    if(!istrue(self._id_2F893D4A9CBF8A5C)) {
      scripts\mp\objidpoolmanager::update_objective_setzoffset(self.icon, 30);
      scripts\mp\objidpoolmanager::update_objective_onentity(self.icon, self.hostage);
      self._id_B0F4BF8621B96C0A[0] scripts\cp_mp\utility\game_utility::_id_04EAF685BC40A3B9();
    }

    self.carryingplayer = undefined;

    if(isDefined(_id_7A2D144A06A00B97) && isent(_id_7A2D144A06A00B97) && _id_7A2D144A06A00B97 scripts\cp_mp\vehicles\vehicle::isvehicle() && _id_7A2D144A06A00B97.vehiclename == "veh9_palfa")
      _id_7CFC061C84DD495A(_id_7A2D144A06A00B97);
  }
}

_id_333F22BA123F0470() {
  self.carryingplayer endon("hostage_pickup_finished");
  thread _id_A29878FB7AFFBC16();

  for(;;) {
    self.instance.origin = self.hostage.origin;

    if(!istrue(self._id_2F893D4A9CBF8A5C))
      scripts\mp\objidpoolmanager::update_objective_position(self.objidnum, self.hostage.origin + (0, 0, 30));

    wait 0.05;
  }
}

_id_A29878FB7AFFBC16() {
  level endon("disconnect");
  self.carryingplayer waittill("hostage_pickup_finished");
  self._id_90758EFDE9B783B7 unlink();
  self.hostage unlink();
}

_id_E07D74D7E0452E2B(_id_9768B22610B34D9D) {
  if(istrue(_id_9768B22610B34D9D)) {
    self.hostage show();
    self.hostage.invulnerable = 0;
    _id_6B3AC788A12C0DDA(self.carryingplayer);
    self.hostage kill();
  } else
    self.carryingplayer scripts\mp\hud_message::showerrormessage("MP_DMZ_MISSIONS/HOSTAGE_PLACE_ERR");
}

_id_6B3AC788A12C0DDA(player) {
  if(scripts\mp\utility\player::isreallyalive(player) && !scripts\mp\utility\player::isinlaststand(player)) {
    player.playerstreakspeedscale = 0;
    player setmovespeedscale(1);
    thread _id_04B5B395EA0EA0FB::_id_524F22FE698EEB0F(player);
    player skydive_setdeploymentstatus(1);
    player skydive_setbasejumpingstatus(1);
  } else {
    _id_B7771CC818B41864(player);

    if(isDefined(player._id_7EBBB0DC14346EAA)) {
      player takeweapon(player._id_7EBBB0DC14346EAA);
      player._id_7EBBB0DC14346EAA = undefined;
    }

    if(isDefined(player._id_280ABCD08CBDCC79)) {
      if(scripts\mp\utility\player::isinlaststand(player))
        player.laststandoldweaponobj = player._id_280ABCD08CBDCC79;

      player._id_280ABCD08CBDCC79 = undefined;
    }

    player resetcarryobject();
  }

  player._id_859654E0445A36D9 = 0;
  player stopanimscriptsceneevent();
  player notify("remove_rig");

  if(isDefined(self.hostage) && isDefined(self.hostage._id_D5B5FFAD0ECA8C36))
    self.hostage._id_D5B5FFAD0ECA8C36 notify("remove_rig");

  self.carryingplayer._id_6B9CAB81D9F94C6D = undefined;

  if(isDefined(player))
    player notify("drop_hostage");
}

_id_0CF6E0046827D08C(ent, origin) {
  if(isPlayer(ent))
    return 0;

  if(ent getnonstick())
    return 0;

  if(istrue(ent.mountmantlemodel))
    return 0;

  if(isDefined(ent.cover) && isDefined(ent.cover.equipmentref) && ent.cover.equipmentref == "equip_tac_cover")
    return 0;

  if(ent.classname == "misc_turret")
    return 0;

  if(ent.classname == "script_vehicle") {
    if(isDefined(ent.vehiclename) && ent.vehiclename == "veh9_civ_lnd_dirt_bike")
      return 0;

    if(ent scripts\cp_mp\vehicles\vehicle_occupancy::_id_A24042975031E692()) {
      foreach(point in [origin, origin + (0, 0, -10), origin + (0, 0, -20)]) {
        if(ent scripts\cp_mp\vehicles\vehicle_occupancy::_id_4E4CF75E0F7E4184(point))
          return 1;
      }

      return 0;
    }

    return 1;
  }

  return 1;
}

_id_A2A73E5D91D2AAE4(_id_1D9FB21B4F3023F3) {
  if(isDefined(_id_1D9FB21B4F3023F3)) {
    if(scripts\cp_mp\utility\killstreak_utility::_id_3C5C5D86EF14420E(_id_1D9FB21B4F3023F3) || _id_1D9FB21B4F3023F3 scripts\cp_mp\vehicles\vehicle::isvehicle())
      return _id_1D9FB21B4F3023F3;

    return 0;
  }

  return undefined;
}

_id_EEDE562CE57290D3() {
  self.carryingplayer endon("drop_hostage");

  for(;;) {
    if(!isDefined(self.instance)) {
      return;
    }
    if(!isDefined(self.carryingplayer)) {
      return;
    }
    start = self.carryingplayer getEye();
    ignore = [self.carryingplayer];

    if(isDefined(self.heli))
      ignore[ignore.size] = self.heli;

    passed = scripts\engine\trace::sphere_trace_passed(start, start + (0, 0, -25), 25, ignore);

    if(self.carryingplayer isonground() && passed) {
      state = self.instance getscriptablepartstate("dmz_hostage");

      if(isDefined(state) && state != "following") {
        self.instance setscriptablepartstate("dmz_hostage", "following");

        foreach(player in level.players)
        self.instance disablescriptableplayeruse(player);

        self.instance enablescriptableplayeruse(self.carryingplayer);
      }

      forward = 5 * anglesToForward(self.carryingplayer getplayerangles());
      self.instance.origin = start + forward * 0.1;
    } else
      self.instance setscriptablepartstate("dmz_hostage", "unusable");

    waitframe();
  }
}

_id_0CF6E805CE234F5E(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("drop_hostage");
  self endon("task_ended");

  for(;;) {
    self._id_3D17023B5BFB92CE = player.origin;
    self._id_BFF867759E490124 = player.angles;
    self._id_AB2A8C60478BDD5C = player getstance();
    waitframe();
  }
}

_id_32281F94A25FDC10(ent) {
  self endon("hostage_pickup_finished");
  self.hostage endon("death");
  self notify("watchForMovingEntDeath");
  self endon("watchForMovingEntDeath");
  ent waittill("death");
  self.hostage kill(self.hostage.origin);
}

watchforplayerdeath(player) {
  player endon("drop_hostage");
  player scripts\engine\utility::waittill_any_3("death_or_disconnect", "enter_live_ragdoll", "last_stand_start");
  player stopanimscriptsceneevent();
  player notify("remove_rig");
  thread drophostage(1);
}

_id_05AC14A79B2A4DB6(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("drop_hostage");
  self.hostage waittill("death");
  player stopanimscriptsceneevent();
  player notify("remove_rig");

  if(isDefined(player._id_43E2C0FCF655EBAC)) {
    player._id_43E2C0FCF655EBAC notify("remove_rig");
    player._id_43E2C0FCF655EBAC = undefined;
  }

  _id_6B3AC788A12C0DDA(self.carryingplayer);
}

_id_82EF6D194918247F(player) {
  player endon("drop_hostage");
  player endon("hostage_pickup_finished");
  thread _id_0CF6E805CE234F5E(player);
  thread _id_05AC14A79B2A4DB6(player);
  thread watchforplayerdeath(player);
}

_id_F0C2012AE22CA0D6(player) {
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("carry");
  player _id_3B64EB40368C1450::set("carry", "prone", 0);
  player _id_3B64EB40368C1450::set("carry", "slide", 0);
  player _id_3B64EB40368C1450::set("carry", "supersprint", 0);
  player _id_3B64EB40368C1450::set("carry", "mount_side", 0);
  player _id_3B64EB40368C1450::set("carry", "mount_top", 0);
  player _id_3B64EB40368C1450::set("carry", "mantle", 0);
  player _id_3B64EB40368C1450::set("carry", "equipment_secondary", 0);
  player _id_3B64EB40368C1450::set("carry", "equipment_primary", 0);
  player _id_3B64EB40368C1450::set("carry", "supers", 0);
  player _id_3B64EB40368C1450::set("carry", "melee", 0);
  player _id_3B64EB40368C1450::set("carry", "weapon_switch", 0);
  player _id_3B64EB40368C1450::set("carry", "swimming_underwater", 0);
  player _id_3B64EB40368C1450::set("carry", "dtp", 0);
  player _id_3B64EB40368C1450::set("carry", "ladder", 0);
  player _id_3B64EB40368C1450::set("carry", "weapon_pickup", 0);
  player _id_3B64EB40368C1450::set("carry", "weapon_switch_clip", 0);
  player _id_3B64EB40368C1450::set("carry", "killstreaks", 0);
  player _id_3B64EB40368C1450::set("carry", "execution_attack", 0);
  player _id_3B64EB40368C1450::set("carry", "vehicle_use", 0);
  player _id_3B64EB40368C1450::set("carry", "ascender_use", 0);
  player _id_3B64EB40368C1450::set("carry", "ads", 1);
  player skydive_setdeploymentstatus(0);
  player skydive_setbasejumpingstatus(0);
  player.playerstreakspeedscale = -0.25;
  player setmovespeedscale(0.75);
}

_id_B7771CC818B41864(player) {
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("carry");
  player skydive_setdeploymentstatus(1);
  player skydive_setbasejumpingstatus(1);
  player.playerstreakspeedscale = 0;
  player setmovespeedscale(1);
}

_id_CADC5181C3B67E3F(player) {
  self._id_EDA575E1C30414D1 = player;
  bomb = makeweapon("briefcase_bomb_mp");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(bomb, undefined, undefined, 0);
  player setweaponammostock(bomb, 0);
  player setweaponammoclip(bomb, 0);
  player thread scripts\mp\gameobjects::switchtouseweapon(bomb, 1, 1);
  player _id_BF9EC93BEE75F88C(0);
  return bomb;
}

_id_0DB896F4486CA187(player, bomb) {
  lastweaponobj = player scripts\mp\utility\inventory::getlastweapon();

  if(player scripts\mp\utility\killstreak::isjuggernaut())
    lastweaponobj = scripts\mp\juggernaut::jugg_getminigunweapon();
  else if(!player hasweapon(lastweaponobj))
    lastweaponobj = player scripts\mp\utility\inventory::getfirstprimaryweapon();

  player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(lastweaponobj, 0, 1);
  player takeweapon(bomb);
  player _id_BF9EC93BEE75F88C(1);
  self._id_EDA575E1C30414D1 = undefined;
}

_id_BF9EC93BEE75F88C(_id_BD138DE99B3B3507) {
  _id_3B64EB40368C1450::set("hostage_holding_bomb", "allow_movement", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("hostage_holding_bomb", "script_weapon_switch", !_id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("hostage_holding_bomb", "sprint", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("hostage_holding_bomb", "fire", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("hostage_holding_bomb", "reload", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("hostage_holding_bomb", "weapon_pickup", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("hostage_holding_bomb", "weapon_switch", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("hostage_holding_bomb", "allow_jump", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("hostage_holding_bomb", "gesture", _id_BD138DE99B3B3507);
  self _meth_35501B42058D4DE9();

  if(_id_BD138DE99B3B3507)
    scripts\engine\utility::waittill_any_timeout_1(0.8, "bomb_allow_offhands");

  _id_3B64EB40368C1450::set("hostage_holding_bomb", "melee", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("hostage_holding_bomb", "mantle", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("hostage_holding_bomb", "offhand_weapons", _id_BD138DE99B3B3507);

  if(_id_BD138DE99B3B3507) {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("hostage_holding_bomb");
    self _meth_BB04491D50D9E43E();
  }
}

_id_B6B601986DCAD85A() {
  _id_B586C70B173DD02B = scripts\engine\utility::getStructArray(self.node.target, "targetname");
  _id_B586C70B173DD02B = scripts\engine\utility::array_randomize(_id_B586C70B173DD02B);
  self.hostage = undefined;

  foreach(_id_FB1DEF007972B25A in _id_B586C70B173DD02B) {
    if(!isDefined(_id_FB1DEF007972B25A.script_noteworthy) || _id_FB1DEF007972B25A.script_noteworthy != "hostage") {
      continue;
    }
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_FB1DEF007972B25A.origin);
    ai = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF("civilian_mp_dmz_hostage", getclosestpointonnavmesh(_id_FB1DEF007972B25A.origin), _id_FB1DEF007972B25A.angles, "absolute", "mission", undefined, "civs", "civilian", undefined, _id_171F90B9C4C76D44, 1, undefined, 0);

    if(!isDefined(ai)) {
      return;
    }
    ai._id_B582B10663B5B2A9 = 0;
    ai.ignoreme = 1;
    ai.health = 250;
    ai.maxhealth = 250;
    ai.combatmode = "no_cover";
    ai _meth_B661B022700BA72F("script", 1);
    ai._id_A4738C70736D3A61 = ::_id_164927827F9F0870;
    ai _id_010B6724C15A95E8::_id_C434AF0895CC147C("cap_hostage", "civilian_dmz_hostage");
    ai._id_950C1AB89C9C4E2A = 1;
    ai._id_B8EBE3F71A08AB40 = self;
    self.hostage = ai;
    level.agent_funcs[ai.agent_type]["on_damaged"] = _id_48814951E916AF89::_id_779B9979FD853E26;
    ai.invulnerable = 1;
    break;
  }

  if(!isDefined(self.hostage)) {
    return;
  }
  self.instance = spawnscriptable("dmz_hostage", self.hostage.origin, (0, 0, 0));
  self.instance.hostage = self.hostage;
  self.hostage.instance = self.instance;
  self.instance._id_B8EBE3F71A08AB40 = self;
  self.instance setscriptablepartstate("dmz_hostage", "unusable", 0);

  if(!istrue(self._id_2F893D4A9CBF8A5C)) {
    _id_CFC7E6FB663BD626 = self.hostage.origin + anglestoright(self.hostage.angles) * -20.0;
    self.c4 = spawn("script_model", _id_CFC7E6FB663BD626);
    self.c4 setModel("offhand_2h_wm_briefcase_bomb_v0");
    self.c4.issuper = 0;
  }

  thread _id_C0CCB94FCFE50916();
}

_id_164927827F9F0870(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  _id_379485F96865DB6D = isDefined(eattacker) && (isPlayer(eattacker) || isDefined(eattacker.owner) && isPlayer(eattacker.owner));

  if(istrue(_id_379485F96865DB6D) && istrue(level._id_AF7D80856E5AE6C0._id_7F494A83DE6CFB1E)) {
    return;
  }
  _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

_id_14F7745B0A1250DB() {
  _id_B586C70B173DD02B = scripts\engine\utility::getStructArray(self._id_47E9B099C2D0B060.target, "targetname");
  self._id_896452C986F0513B = [];

  if(isDefined(self.hostage) && isDefined(self.hostage.origin))
    _id_B586C70B173DD02B = sortbydistance(_id_B586C70B173DD02B, self.hostage.origin);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B586C70B173DD02B.size; _id_AC0E594AC96AA3A8++) {
    if(self._id_896452C986F0513B.size >= 8) {
      break;
    }

    _id_FB1DEF007972B25A = _id_B586C70B173DD02B[_id_AC0E594AC96AA3A8];

    if(!isDefined(_id_FB1DEF007972B25A.script_noteworthy) || !issubstr(_id_FB1DEF007972B25A.script_noteworthy, "guard")) {
      continue;
    }
    _id_1439F86640D42E34 = "ar";

    if(_id_AC0E594AC96AA3A8 == 1)
      _id_1439F86640D42E34 = "shotgun";

    aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, undefined, "ar", 3);
    enemy = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_FB1DEF007972B25A.origin, _id_FB1DEF007972B25A.angles, "high", "mission", "hostageGuard", undefined, undefined, undefined, self.node._id_B205D90302DA2F07, 0, undefined, 0);

    if(isDefined(enemy)) {
      _id_67F905DFB8137021(enemy, 1);
      enemy _id_120270BD0A747A35::_id_304DA84D9A815C01(enemy.origin, 16);
      enemy._id_B582B10663B5B2A9 = 0;
      self._id_896452C986F0513B[self._id_896452C986F0513B.size] = enemy;

      if(issubstr(aitype, "shotgun")) {
        if(!isDefined(self._id_068C8D20B77D4C93))
          self._id_068C8D20B77D4C93 = enemy;
      }

      thread _id_120270BD0A747A35::_id_B11C1964F528574B(enemy);
    }
  }
}

_id_67F905DFB8137021(agent, _id_6C149286380290A2) {
  _id_A664AAD02EE98BD2 = scripts\engine\utility::random(["concussion_grenade_mp", "smoke_grenade_mp", "flash_grenade_mp"]);
  grenadeammo = getdvarint("dvar_537FA443CE212A8A", 4);
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(undefined, undefined, undefined, _id_A664AAD02EE98BD2, grenadeammo, undefined, undefined);
}

_id_8DC13537721B3C2D() {
  self._id_B8EBE3F71A08AB40 endon("task_ended");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    state = self._id_B8EBE3F71A08AB40.state;

    if(!isDefined(state))
      state = "";

    _id_B09B7AFE082A9239 = scripts\engine\utility::ter_op(isDefined(level._id_B58C6275920EDF51), level._id_B58C6275920EDF51, "dmzc");
    alias = _id_422546A862BEB2C7(state, _id_B09B7AFE082A9239);
    thread _id_5D265B4FCA61F070::_id_E7C1C9DEE13137AA(alias);

    if(state == "rescued") {
      return;
    }
    length = lookupsoundlength(alias);
    scripts\engine\utility::waittill_notify_or_timeout("play_dialog", length / 1000 + 4.0);
  }
}

_id_422546A862BEB2C7(state, _id_DEC9BCCE93873125) {
  _id_8E5A9B658FA525ED = scripts\engine\utility::ter_op(isDefined(level._id_CE11405F66C0872E), level._id_CE11405F66C0872E, "cvm3");
  _id_B4648963B1EF138C = undefined;

  switch (state) {
    case "player_entered_building":
      _id_B4648963B1EF138C = "_creb";
      break;
    case "player_entered_room":
      _id_B4648963B1EF138C = "_crec";
      break;
    case "rescued":
      _id_B4648963B1EF138C = "_cref";
      break;
    default:
      _id_B4648963B1EF138C = "_cire";
      break;
  }

  alias = "dx_br_" + _id_DEC9BCCE93873125 + "_hore_" + _id_8E5A9B658FA525ED + _id_B4648963B1EF138C;
  return alias;
}

_id_0DF48D309A8BC55A() {
  _id_6C4E8CEA70BF4B6D::_id_5314298E777E5688("dmz_hostage_transport");
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hostage_rescue_heli_incoming", self.teams[0], 5.0);
  wait 5;

  if(!istrue(self.failure)) {
    path = _id_5C65D346AC65390C::_id_0ED11AE9FE1ABDEB(self._id_23D42B1195DDA679, self._id_23D42B1195DDA679.origin);

    if(!isDefined(path)) {
      if(!istrue(self.failure))
        thread _id_CB2F74520E05756F(self.teams[0]);

      return;
    }

    _id_A3010F9814A40C8D = undefined;
    players = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");

    if(!isDefined(players)) {
      _id_CB2F74520E05756F();
      return;
    }

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size && !isDefined(_id_A3010F9814A40C8D); _id_AC0E594AC96AA3A8++)
      _id_A3010F9814A40C8D = players[_id_AC0E594AC96AA3A8];

    if(!isDefined(_id_A3010F9814A40C8D)) {
      _id_CB2F74520E05756F();
      return;
    }

    team = _id_A3010F9814A40C8D.team;
    self.heli = _id_5C65D346AC65390C::_id_D05F47D864F18196(_id_A3010F9814A40C8D, path.origin, self._id_23D42B1195DDA679.angles);
    thread _id_5C65D346AC65390C::_id_A5FC6E8F9DF1CCEA(self.heli, self._id_23D42B1195DDA679.origin);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(self.heli, team);
    self.heli._id_675F44ED226AED7D = ::_id_8EBF38FBB99AF797;
    self.heli._id_7B468990DA46C73C = ::_id_F6685FAD77B7F64D;
    self.heli._id_B8EBE3F71A08AB40 = self;
    self.heli._id_23D42B1195DDA679 = self._id_23D42B1195DDA679;
    self.heli._id_6881781E87586753 = 1;
    self.heli._id_A2BA7043631B3392 = 1;
    self.heli thread _id_364AB6A28426C5CE(path);
  } else
    return;

  if(!istrue(self.failure))
    _id_21D5138D3F032DD4();

  if(!isDefined(self._id_540E563BD70483A2)) {
    return;
  }
  if(!istrue(self._id_0AF8D4CC519C65DE))
    scripts\mp\objidpoolmanager::update_objective_onentity(self.icon, self._id_540E563BD70483A2);

  if(!istrue(self.failure))
    self.hostage.invulnerable = 1;

  while(!istrue(self._id_540E563BD70483A2._id_94CF3A68B99AE841))
    self._id_540E563BD70483A2 waittill("exfil_path_started");

  thread _id_2D144609316A301E(self._id_540E563BD70483A2);

  if(!istrue(self.failure))
    thread _id_CB2F74520E05756F(self.teams[0]);
}

_id_7CFC061C84DD495A(heli) {
  if(istrue(heli._id_A2BA7043631B3392)) {
    self.instance setscriptablepartstate("dmz_hostage", "unusable");

    if(!isDefined(self._id_90758EFDE9B783B7))
      self._id_90758EFDE9B783B7 = spawn("script_origin", self.hostage.origin);

    self._id_90758EFDE9B783B7.origin = self.hostage.origin;
    self._id_90758EFDE9B783B7 linkTo(heli);
    self.hostage linkTo(self._id_90758EFDE9B783B7);
    self.hostage.invulnerable = 1;
    self._id_49AD1A873F5F008B = 1;
    self._id_540E563BD70483A2 = heli;
    heli notify("dmz_exfil_hostage_inside");
    self notify("dmz_hostage_inside_heli");
  }
}

_id_364AB6A28426C5CE(path) {
  self endon("death");
  scripts\common\vehicle_paths::vehicle_paths_helicopter(path);

  if(!istrue(self._id_23D42B1195DDA679.info.land))
    self sethoverparams(0, 0, 0);

  if(!istrue(self._id_B8EBE3F71A08AB40._id_0AF8D4CC519C65DE))
    self._id_B8EBE3F71A08AB40 scripts\engine\utility::waittill_any_2("dmz_hostage_inside_heli", "task_ended");

  if(istrue(self._id_B8EBE3F71A08AB40.failure))
    _id_8C05501355CC8322();

  self._id_94CF3A68B99AE841 = 1;
  self notify("exfil_path_started");
  _id_5C65D346AC65390C::_id_18D68B06FA34264B(self);
  path = _id_5C65D346AC65390C::_id_1093B8F392744E3B(self._id_23D42B1195DDA679, self._id_23D42B1195DDA679.origin, level._id_251923794D7ECF20.heliheight);
  thread scripts\common\vehicle_paths::vehicle_paths_helicopter(path);
  wait 8.0;

  if(!istrue(self.failure)) {
    info = _id_5C65D346AC65390C::_id_730C660D9FC6808E(self._id_878914B0358BC7B5, 0, 1, 0, 0);
    _id_5307834CD39B435C::_id_309C0A11484CC0DB(self._id_878914B0358BC7B5, info);
  }

  wait 15;
  thread _id_5C65D346AC65390C::_id_0ED686FCBC5363B3();
}

_id_8EBF38FBB99AF797(player) {
  if(!scripts\engine\utility::array_contains_key(self._id_878914B0358BC7B5, player.guid)) {
    self._id_878914B0358BC7B5[player.guid] = player;
    scripts\mp\outofbounds::enableoobimmunity(player);

    if(!istrue(self._id_B8EBE3F71A08AB40._id_BE20B95D97B75707)) {
      self._id_B8EBE3F71A08AB40._id_BE20B95D97B75707 = 1;
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("hostage_lower_heli", self._id_B8EBE3F71A08AB40.teams[0]);
    }
  }

  if(istrue(self._id_B8EBE3F71A08AB40._id_49AD1A873F5F008B) && isDefined(self._id_75ADB7F3CBE5D522)) {
    if(!isDefined(player._id_A09B2CB47A28054A)) {
      self._id_0902A7FFCFF8AA65[self._id_0902A7FFCFF8AA65.size] = player;
      player thread _id_5307834CD39B435C::_id_496941BF27AF77B1(self.origin, self._id_75ADB7F3CBE5D522, 2000);
    }
  }
}

_id_F6685FAD77B7F64D(player) {
  self._id_878914B0358BC7B5[player.guid] = undefined;

  if(scripts\mp\outofbounds::isoobimmune(player))
    scripts\mp\outofbounds::disableoobimmunity(player);
}

_id_0662CA8C888B5EB6(startnode, heliheight, reverse) {
  if(!isDefined(reverse))
    reverse = 0;

  _id_3FB4A86293ED25A6 = 10;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 1, 1, 0);
  startpos = startnode.origin + (0, 0, heliheight + 600);
  _id_3674D96C61E2DD0D = scripts\engine\utility::ter_op(reverse, startnode.angles[1] + 180, startnode.angles[1]);

  for(yaw = 0; yaw < 360; yaw = yaw + _id_3FB4A86293ED25A6) {
    _id_3674D96C61E2DD0D = _id_3674D96C61E2DD0D + yaw;
    _id_211FC11F4C8566F5 = (0, _id_3674D96C61E2DD0D, 0);
    _id_29006F80487A7787 = startpos;
    _id_DD77D0A6D708AC18 = startpos + anglesToForward(_id_211FC11F4C8566F5) * 18000;
    _id_D4EB961F60968A16 = scripts\engine\trace::sphere_trace(_id_29006F80487A7787, _id_DD77D0A6D708AC18, 100, undefined, contents, 1);

    if(_id_D4EB961F60968A16["fraction"] == 1)
      return _id_DD77D0A6D708AC18;

    if(yaw % 3 == 0)
      waitframe();
  }

  return undefined;
}

_id_21D5138D3F032DD4() {
  self endon("task_ended");

  while(!isDefined(self._id_540E563BD70483A2))
    self waittill("dmz_hostage_inside_heli");
}

_id_9597B6C3F099D3D7() {
  self._id_B8EBE3F71A08AB40 endon("task_ended");

  if(!istrue(self._id_49AD1A873F5F008B))
    self waittill("dmz_exfil_hostage_inside");

  self._id_75ADB7F3CBE5D522 = 5;

  foreach(player in self._id_878914B0358BC7B5) {
    if(!isDefined(player._id_A09B2CB47A28054A)) {
      self._id_0902A7FFCFF8AA65[self._id_0902A7FFCFF8AA65.size] = player;
      player thread _id_5307834CD39B435C::_id_496941BF27AF77B1(self.origin, self._id_75ADB7F3CBE5D522, 2000);
    }
  }

  while(self._id_75ADB7F3CBE5D522 > 0) {
    self._id_75ADB7F3CBE5D522 = self._id_75ADB7F3CBE5D522 - 1;
    wait 1.0;
  }
}

_id_8C05501355CC8322() {
  self endon("death");
  level endon("game_ended");
  _id_C82EFE11C4073AF4 = [];

  for(;;) {
    wait 1.0;
    _id_7408ED52662703D3 = scripts\common\utility::playersincylinder(self.origin, 665, undefined, 500);

    foreach(player in _id_7408ED52662703D3) {
      if(!isDefined(_id_C82EFE11C4073AF4[player.guid]))
        _id_C82EFE11C4073AF4[player.guid] = gettime();

      if(gettime() - _id_C82EFE11C4073AF4[player.guid] > 5000) {
        player scripts\mp\hud_message::showerrormessage("MP_DMZ_MISSIONS/HOSTAGE_HELI_MSG");
        _id_C82EFE11C4073AF4[player.guid] = gettime();
      }
    }

    if(_id_7408ED52662703D3.size == 0) {
      break;
    }
  }
}

_id_2D144609316A301E(heli) {
  heli waittill("death");

  if(isDefined(self.hostage) && isalive(self.hostage) && istrue(self._id_49AD1A873F5F008B))
    self.hostage _id_48814951E916AF89::_id_28B90EB2B591003F();

  if(isDefined(self._id_90758EFDE9B783B7))
    self._id_90758EFDE9B783B7 delete();
}

_id_F0C7539DC72C3DFD() {
  alllocations = scripts\engine\utility::array_randomize(scripts\engine\utility::getStructArray("hostage_setup", "targetname"));
  validlocations = [];
  _id_A940C1AC967427FE = scripts\engine\utility::array_randomize(scripts\engine\utility::getStructArray("dmz_hostage_exfil", "script_noteworthy"));

  foreach(loc in alllocations) {
    isvalid = 1;

    if(!isDefined(loc.target)) {
      continue;
    }
    _id_B586C70B173DD02B = scripts\engine\utility::getStructArray(loc.target, "targetname");

    foreach(_id_FB1DEF007972B25A in _id_B586C70B173DD02B) {
      if(isDefined(_id_FB1DEF007972B25A.script_noteworthy) && _id_FB1DEF007972B25A.script_noteworthy == "hostage") {
        pos = getclosestpointonnavmesh(_id_FB1DEF007972B25A.origin);

        if(distance(pos, _id_FB1DEF007972B25A.origin) > 100) {
          isvalid = 0;
          break;
        }
      }
    }

    if(!isvalid) {
      continue;
    }
    _id_276AC5E84835EA87 = _id_4948CDF739393D2D::_id_BBE42D7091BEDFC5(loc.origin, "hostage_forts");

    if(!isDefined(_id_276AC5E84835EA87)) {
      continue;
    }
    if(distance2dsquared(_id_276AC5E84835EA87.origin, loc.origin) > level._id_AF7D80856E5AE6C0._id_82A01CE31B77AC5C * level._id_AF7D80856E5AE6C0._id_82A01CE31B77AC5C || scripts\engine\utility::array_contains(level._id_F1073FBD45B59A06._id_DF987907A483DF89, _id_276AC5E84835EA87)) {
      continue;
    }
    _id_636C8575D7A7768B = 12000;

    foreach(heli in _id_A940C1AC967427FE) {
      dist = distance(loc.origin, heli.origin);

      if(!istrue(heli.chosen) && dist < _id_636C8575D7A7768B) {
        _id_636C8575D7A7768B = dist;
        loc._id_23D42B1195DDA679 = heli;
      }
    }

    if(isDefined(loc._id_23D42B1195DDA679))
      loc._id_23D42B1195DDA679.chosen = 1;
    else
      isvalid = 0;

    if(isvalid)
      validlocations[validlocations.size] = loc;
  }

  return validlocations;
}