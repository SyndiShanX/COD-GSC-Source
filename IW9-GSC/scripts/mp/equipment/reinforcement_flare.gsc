/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\reinforcement_flare.gsc
********************************************************/

main() {
  level thread _id_566F849E77540164();
}

_id_566F849E77540164() {
  level endon("game_ended");
  level waittill("init_supers");
  init();
}

init() {
  scripts\mp\supers::_id_53110A12409D01DA("super_reinforcement_flare", undefined, undefined, ::_id_ABEFBDBD41128E07, undefined, undefined);
  scripts\cp_mp\utility\script_utility::registersharedfunc("reinforcement_flare", "grenadeUsed", ::_id_304D5FA1128C5A76);
  level._id_EED57E4583118823 = spawnStruct();
  level._id_EED57E4583118823.type = getdvarint("dvar_FE6D7336B7F92218", 3);
  level._id_EED57E4583118823.delay = getdvarint("dvar_9791C5E947B42F3F", 1);
  level._id_EED57E4583118823._id_52C848ED985B69BF = getdvarint("dvar_B6D7A4020F569C04", 5000);
  level._id_EED57E4583118823._id_14C8C6253FA5E1EE = getdvarint("dvar_578EA151AE11D179", 1.0);
  level._id_EED57E4583118823._id_A1D415AB15D07845 = getdvarint("dvar_3C8C43E7F91BAEE4", 0);
  level._id_EED57E4583118823._id_D7397C466EE881E3 = 0;
  init_anim();
  _id_030AFC24CC88C8D3();
}

#using_animtree("script_model");

init_anim() {
  notes = getnotetracktimes(%misc_vm_flare_gun_fire, "reinforcement_flare_fired");
  total = getanimlength(%misc_vm_flare_gun_fire);

  if(notes.size > 0)
    level._id_EED57E4583118823._id_D7397C466EE881E3 = total * notes[0];
}

_id_030AFC24CC88C8D3() {}

_id_ABEFBDBD41128E07() {
  _id_AFE6989E38932FD3 = _id_59DD9B163E569A63();

  if(!_id_0BE3F53A872E6984(_id_AFE6989E38932FD3, 1))
    return 0;

  self.super.isactive = 1;
  self _meth_8A340E416D4D11ED();
  thread _id_1D40065A3C6120DA();
  return 1;
}

_id_1D40065A3C6120DA() {
  thread _id_917BDAEF968DC5B4();
  wait(level._id_EED57E4583118823._id_D7397C466EE881E3);
  self _meth_F9594EE32C931A2E();
  _id_AFE6989E38932FD3 = _id_59DD9B163E569A63();

  if(!_id_0BE3F53A872E6984(_id_AFE6989E38932FD3, istrue(level._id_EED57E4583118823._id_A1D415AB15D07845))) {
    scripts\mp\supers::refundsuper();
    return 0;
  }

  thread _id_81973EAC6CDA5DE8();
  _id_BD86834DAFC95671(_id_AFE6989E38932FD3);
  wait(level._id_EED57E4583118823.delay);
  thread scripts\mp\hud_message::showsplash("br_squadmate_revived");
  scripts\mp\utility\points::_id_0366980B6A8796AE("stat_6CE458A0C07FD247");
  _id_715028F54BAD19A1::_id_885C6DAF0ECE2CF6(1, 0);
  scripts\cp_mp\challenges::_id_D997435895422ECC("super_reinforcement_flare", 0);
}

_id_0BE3F53A872E6984(_id_AFE6989E38932FD3, _id_1604D9F4D5CC32D7) {
  if(!scripts\mp\utility\player::_id_AD443BBCDCF37B85(self))
    return 0;

  if(istrue(_id_1604D9F4D5CC32D7)) {
    if(self _meth_6F55D55CCFF20D14())
      return _id_022F07D1048D1A37("reinforcement_flare_underwater", 1);

    if(_id_7511C0CBD6C3F1CF())
      return _id_022F07D1048D1A37("reinforcement_flare_not_enough_space", 2);
  }

  if(_id_AFE6989E38932FD3.size < 1)
    return _id_022F07D1048D1A37("reinforcement_flare_nobody_to_respawn", 3);

  return 1;
}

_id_917BDAEF968DC5B4() {
  weapon = makeweapon("reinforcement_flare_mp_br");
  scripts\cp_mp\utility\weapon_utility::_id_F19F8B4CF085ECBD(weapon);
}

_id_7511C0CBD6C3F1CF() {
  startpos = self getorigin();
  endpos = startpos + (0, 0, level._id_EED57E4583118823._id_52C848ED985B69BF);
  _id_05ED27D399605829 = scripts\engine\trace::create_contents(0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0);
  _id_1AC16B7E89C07B85 = scripts\engine\trace::ray_trace_passed(startpos, endpos, self, _id_05ED27D399605829);
  return !_id_1AC16B7E89C07B85;
}

_id_022F07D1048D1A37(hint, _id_401C3A2E68AAB0FD) {
  self playlocalsound("br_pickup_deny");
  scripts\mp\utility\lower_message::setlowermessageomnvar(hint, undefined, 5);
  _id_715028F54BAD19A1::_id_885C6DAF0ECE2CF6(0, _id_401C3A2E68AAB0FD);
  return 0;
}

_id_59DD9B163E569A63() {
  list = [];
  squad = scripts\mp\utility\teams::getteamdata(self.team, "players");

  foreach(_id_8F7040E569EC9E98 in squad) {
    if(!isDefined(_id_8F7040E569EC9E98) || _id_8F7040E569EC9E98 == self) {
      continue;
    }
    if(_id_8F7040E569EC9E98 _id_A36DFAFC12F9A469())
      list[list.size] = _id_8F7040E569EC9E98;
  }

  return list;
}

_id_A36DFAFC12F9A469() {
  return _id_2CEDCC356F1B9FC8::iseligibleforteamrevive() || _id_2CEDCC356F1B9FC8::_id_8F0E6614368F64C2();
}

_id_81973EAC6CDA5DE8() {
  location = self.origin;

  if(self tagexists("tag_weapon_right"))
    location = self gettagorigin("tag_weapon_right");

  _id_BDF786BE066C860B = getDvar("dvar_58D8DFA7B8338078", "");

  if(_id_BDF786BE066C860B != "")
    level _id_64ACB6CE534155B7::utilflare_shootflare(location, _id_BDF786BE066C860B);
  else
    level _id_64ACB6CE534155B7::utilflare_shootflare(location, "reinforcement_flare");

  thread _id_E02EB68B52EE2576();
}

_id_E02EB68B52EE2576() {
  player = self;
  player endon("death_or_disconnect");
  player setscriptablepartstate("ReinforcementFlare", "on", 0);
  wait(level._id_EED57E4583118823._id_14C8C6253FA5E1EE);
  player setscriptablepartstate("ReinforcementFlare", "off", 0);
}

_id_BD86834DAFC95671(_id_AFE6989E38932FD3) {
  if(level._id_EED57E4583118823.type == 3)
    _id_AFE6989E38932FD3 = scripts\engine\utility::array_randomize_objects(_id_AFE6989E38932FD3);
  else if(level._id_EED57E4583118823.type == 2)
    _id_AFE6989E38932FD3 = scripts\mp\utility\script::quicksort(_id_AFE6989E38932FD3, ::_id_AE1F6E9C36DBAF8D);

  if(scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "zxp")
    _id_AFE6989E38932FD3 = scripts\mp\utility\script::quicksort(_id_AFE6989E38932FD3, ::_id_7BB4E78EF31BC46E);

  if(level._id_EED57E4583118823.type == 1) {
    foreach(_id_8F7040E569EC9E98 in _id_AFE6989E38932FD3)
    _id_5BAB271917698DC4::_id_2A11E499A21720EC(_id_8F7040E569EC9E98, self, 0);
  } else {
    _id_A4A43A5FCA0097EF = _id_AFE6989E38932FD3[0];

    if(istrue(_id_A4A43A5FCA0097EF._id_632BAD3EDB4E449E)) {
      foreach(_id_8F7040E569EC9E98 in _id_AFE6989E38932FD3) {
        if(!istrue(_id_8F7040E569EC9E98._id_632BAD3EDB4E449E)) {
          _id_A4A43A5FCA0097EF = _id_8F7040E569EC9E98;
          break;
        }
      }
    }

    _id_5BAB271917698DC4::_id_2A11E499A21720EC(_id_A4A43A5FCA0097EF, self, 0);
  }
}

_id_AE1F6E9C36DBAF8D(_id_52A462A16496CF97, _id_52A463A16496D1CA) {
  if(!isDefined(_id_52A462A16496CF97._id_014110AD8D5069E7))
    _id_52A462A16496CF97._id_014110AD8D5069E7 = -1;

  if(!isDefined(_id_52A463A16496D1CA._id_014110AD8D5069E7))
    _id_52A463A16496D1CA._id_014110AD8D5069E7 = -1;

  return _id_52A462A16496CF97._id_014110AD8D5069E7 <= _id_52A463A16496D1CA._id_014110AD8D5069E7;
}

_id_7BB4E78EF31BC46E(_id_52A462A16496CF97, _id_52A463A16496D1CA) {
  return !istrue(_id_52A462A16496CF97.iszombie) && istrue(_id_52A463A16496D1CA.iszombie);
}

_id_304D5FA1128C5A76(grenade) {
  if(isDefined(grenade))
    grenade delete();
}