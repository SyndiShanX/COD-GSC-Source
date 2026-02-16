/*******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_adventure_quest.gsc
*******************************************************/

init() {
  setdvarifuninitialized("#x32535cbad8d55b097", 0);
  level.br_quests_enabled = getdvarint("#x32535cbad8d55b097", 0) != 0;

  if(!istrue(level.br_quests_enabled)) {
    return;
  }
  level.br_queststashlocations = scripts\engine\utility::getStructArray("quest_stash_location", "targetname");

  if(level.br_queststashlocations.size < 0) {
    level.br_quests_enabled = 0;
  }
}

_id_C52A(var_0) {
  level.br_queststashlocations = scripts\engine\utility::array_remove(level.br_queststashlocations, var_0);
}

_id_EDD3(var_0) {
  if(!istrue(level.br_quests_enabled)) {
    self iprintlnbold("Item is disabled");
    return;
  }

  var_1 = _id_48B1();
  _id_E386(var_1);
}

_id_48B1() {
  if(!isDefined(level.br_queststashlocations)) {
    level.br_queststashlocations = scripts\engine\utility::getStructArray("quest_stash_location", "targetname");
  }

  return scripts\engine\utility::random(level.br_queststashlocations);
}

_id_E386(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("com_plasticcase_beige_big_iw6");
  var_1 makeuseable();
  var_1 setcursorhint("HINT_NOICON");
  var_1 setuseholdduration("duration_medium");
  var_1 sethintrequiresholding(1);
  var_1 sethintdisplayfov(360);
  var_1 setusefov(360);
  var_1 setuserange(150);
  var_1 sethintstring(&"MP_BR_USE_PLUNDER_CACHE");
  var_1 setasgametypeobjective();
  var_1 hide();
  var_2 = (var_0.origin[0], var_0.origin[1], 1000);
  var_2 = var_2 + scripts\engine\math::_id_BFF0() * randomintrange(100, 900);
  var_1._id_CFAC = spawn("script_model", var_2);
  self setclientomnvar("ui_br_adventure_search_area", var_1._id_CFAC);
  var_1 thread _id_E743();
  _id_1147(self, var_1);
  _id_0A99::_id_D5EA(37, undefined, 5);
  var_3 = _id_07F9::_id_C57D(1);
  var_1._id_A8DA = var_3;

  if(var_3 != -1) {
    _id_07F9::_id_A867(var_3, "active", (0, 0, 0));
    _id_07F9::_id_FB97(var_3, var_1._id_CFAC.origin);
    _id_07F9::_id_FB9E(var_3, "active");
    _id_07F9::_id_FB8F(var_3, "ui_mp_br_mapmenu_icon_atm");
    _id_07F9::_id_FB98(var_3, 1);
    _id_07F9::_id_A89F(var_3);
  }

  var_1 _id_E742(self.team);
  var_4 = "ammo_crate_use";
  self playlocalsound(var_4);
}

_id_E742(var_0) {
  foreach(var_2 in level.players) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(var_2.team == var_0) {
      self _meth_80E0(var_2);
      _id_07F9::_id_A89D(self._id_A8DA, var_2);
      self showtoplayer(var_2);
      continue;
    }

    _id_E741(var_2);
  }
}

_id_E741(var_0) {
  self disableplayeruse(var_0);
  self _meth_81AE(var_0);
  _id_07F9::_id_A89E(self._id_A8DA, var_0);
}

_id_E743() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);
    thread _id_FED6(var_0);
  }
}

_id_7048() {
  level endon("game_ended");
  level endon("end_sonar_think");
  var_0 = "breach_warning_beep_04";

  for(;;) {
    wait 0.1;

    foreach(var_6, var_2 in level._id_2AB4) {
      level._id_2AB4[var_6]--;

      if(var_2 <= 0) {
        var_3 = level._id_2A9A[var_6];
        var_4 = var_3._id_E01C._id_CFAC;
        var_5 = distance2d(var_3.origin, var_4.origin);

        if(var_5 < 1500) {
          if(!isDefined(var_3._id_5BAA)) {
            var_3 _id_0A99::_id_D5EA(38, undefined, 5);
            var_3._id_5BAA = 1;
          }

          var_3 playlocalsound(var_0);
        }

        level._id_2AB4[var_6] = _id_2EFA(var_3);
      }
    }
  }
}

_id_1147(var_0, var_1) {
  var_0._id_E01C = var_1;

  if(!isDefined(level._id_2AB4)) {
    level._id_2AB4 = [];
    level._id_2A9A = [];
    level._id_2AB4[var_0.guid] = _id_2EFA(var_0);
    level._id_2A9A[var_0.guid] = var_0;
    level thread _id_7048();
  } else {
    level._id_2A9A[var_0.guid] = var_0;
    level._id_2AB4[var_0.guid] = _id_2EFA(var_0);
  }
}

_id_C534(var_0) {
  if(!isDefined(level._id_2AB4)) {
    return;
  }
  level._id_2AB4 = scripts\engine\utility::_id_1BC6(level._id_2AB4, var_0.guid);

  if(level._id_2AB4.size == 0) {
    level notify("end_sonar_think");
    level._id_2AB4 = undefined;
    level._id_2A9A = undefined;
  }
}

_id_2EFA(var_0) {
  var_1 = var_0._id_E01C;
  var_2 = distance2d(var_0.origin, var_1.origin);
  var_2 = clamp(var_2 / 75, 2, 15);
  return int(var_2);
}

_id_FED6(var_0) {
  _id_C534(var_0);
  self hide();
  self makeunusable();
  self.origin = self.origin + (0, 0, -500);
  var_0 _id_0A99::_id_D5EA(39, undefined, 5);
  _id_07F9::_id_C799(self._id_A8DA);
  self delete();
}