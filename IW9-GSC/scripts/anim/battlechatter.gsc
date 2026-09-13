/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\battlechatter.gsc
***********************************************/

init_battlechatter() {
  setdvarifuninitialized("bcs_enable", 1);
  setdvarifuninitialized("bcs_debug", 0);
  setdvarifuninitialized("dvar_44EF18550505E010", 0);
  setdvarifuninitialized("dvar_350B154807F4D745", 0);
  setdvarifuninitialized("dvar_5AEA525F549D2546", 0);

  if(isDefined(level.battlechatter) || getdvarint("bcs_enable") == 0) {
    return;
  }
  level.battlechatter = spawnStruct();
  level.battlechatter.states = [];
  level.battlechatter._id_6ADA3242ACD08CF5 = [];
  level.battlechatter.names = [];
  level.battlechatter.events = [];
  level.battlechatter._id_AE16228B86A3F433 = [];
  setdvarifuninitialized("dvar_495535A4877B324D", "off");
  setdvarifuninitialized("dvar_87DCA5163728CE02", "off");
  setdvarifuninitialized("dvar_0CE7CFDF8678EDB2", "off");
  setdvarifuninitialized("dvar_70AAEC0E43322FEA", "off");
  setdvarifuninitialized("bcs_allowsamevoiceresponse", "off");
  setdvarifuninitialized("dvar_702217AE066916B9", "");
  setdvarifuninitialized("dvar_21778F568437CD09", "");
  setdvarifuninitialized("debug_bcprint", "off");
  setdvarifuninitialized("dvar_1C663353DAE9FAB0", "off");
  setdvarifuninitialized("debug_bcprintdump", "off");
  setdvarifuninitialized("debug_bcprintdumptype", "csv");
  setdvarifuninitialized("debug_bcshowqueue", "off");
  anim.bcprintfailprefix = "^1***** BCS FAILURE: ";
  anim.bcprintwarnprefix = "^3***** BCS WARNING: ";
  _id_50EEB9595C6D6E1B::_id_BD1704B44A1A730E();
  _id_2F7FD2639DB2A57B();
  _id_90826D80AA1736CB("idle", _id_50EEB9595C6D6E1B::_id_F06007E1F432CE27);
  _id_90826D80AA1736CB("investigate", _id_50EEB9595C6D6E1B::_id_F6C7D545B09F9F0A);
  _id_90826D80AA1736CB("hunt", _id_50EEB9595C6D6E1B::_id_7CE36B78C85185C2);
  _id_90826D80AA1736CB("combat", _id_50EEB9595C6D6E1B::_id_F5154A3D477820D9);
  _id_3769E5550BED355B("default", level._id_2957DE46170ADAD1._id_FD6906DC66B503B4, level._id_2957DE46170ADAD1._id_4C433DC943A4B16E);
  _id_3769E5550BED355B("idle", level._id_2957DE46170ADAD1._id_FD6906DC66B503B4, level._id_2957DE46170ADAD1._id_4C433DC943A4B16E);
  _id_3769E5550BED355B("hunt", level._id_2957DE46170ADAD1._id_AC5D474FFE947F53, level._id_2957DE46170ADAD1._id_8FB4E94454C2B089);
  _id_3769E5550BED355B("combat", level._id_2957DE46170ADAD1._id_DE220EE05772F786, level._id_2957DE46170ADAD1._id_D4692DEEC4B3B23C);
  _id_7AEDD2357AECC5A6("curious", _id_50EEB9595C6D6E1B::_id_1D268B003B51A5B3);
  _id_7AEDD2357AECC5A6("announce", _id_50EEB9595C6D6E1B::_id_91AE298FCC3884C2);
  _id_7AEDD2357AECC5A6("return_to_idle", _id_50EEB9595C6D6E1B::_id_E64DBAAAE396FBB8);
  _id_7AEDD2357AECC5A6("reach_investigate", _id_50EEB9595C6D6E1B::_id_22D252D6CFA50EDD);
  _id_7AEDD2357AECC5A6("enter_hunt", _id_50EEB9595C6D6E1B::_id_F4671F61A3031990);
  _id_7AEDD2357AECC5A6("join_combat", _id_50EEB9595C6D6E1B::_id_881AB22021BE3C6B);
  _id_7AEDD2357AECC5A6("enter_combat", _id_50EEB9595C6D6E1B::_id_6237814879B07FBF);

  foreach(_id_81A329728ABB79E4 in level.battlechatter.events)
  _id_81A329728ABB79E4 scripts\engine\utility::deck_shuffle();

  level._id_FB605061A3778884 = scripts\engine\utility::_id_53C4C53197386572(level._id_FB605061A3778884, 200);
  level._id_FDE5B385CC96729A = scripts\engine\utility::_id_53C4C53197386572(level._id_FDE5B385CC96729A, squared(level._id_FB605061A3778884));
  level._id_798AA343368F724E = scripts\engine\utility::_id_53C4C53197386572(level._id_798AA343368F724E, 650);
  level._id_C1ED820E79E07B7C = scripts\engine\utility::_id_53C4C53197386572(level._id_C1ED820E79E07B7C, squared(level._id_798AA343368F724E));
  level._id_8893859DE4351996 = scripts\engine\utility::_id_53C4C53197386572(level._id_8893859DE4351996, 850);
  level._id_56D55334BE8BC44B = scripts\engine\utility::_id_53C4C53197386572(level._id_56D55334BE8BC44B, squared(level._id_8893859DE4351996));
  level._id_63A73645A8E030AD = scripts\engine\utility::_id_53C4C53197386572(level._id_63A73645A8E030AD, 1400);
  level._id_DEFB33E34EB9DEE7 = scripts\engine\utility::_id_53C4C53197386572(level._id_DEFB33E34EB9DEE7, squared(level._id_63A73645A8E030AD));
  level._id_587DE0E7B537210A = scripts\engine\utility::_id_53C4C53197386572(level._id_587DE0E7B537210A, 2000);
  level._id_B4360CAB4806D3A0 = scripts\engine\utility::_id_53C4C53197386572(level._id_B4360CAB4806D3A0, squared(level._id_587DE0E7B537210A));

  if(isDefined(anim.squads)) {
    foreach(squad in anim.squads)
    squad init_squadbattlechatter();
  }

  anim._id_417D31A4284FD63F = ::init_squadbattlechatter;

  if(!isDefined(anim.bcs_locations))
    _id_2FAEE9E4CF862D61();

  _id_00433D8F78F7E5FB::bcs_setup_countryids();
  level thread _id_1EA9D53684D11626();
  level thread _id_078405469B3060FA();
}

_id_078405469B3060FA() {
  level endon("battlechatter disabled");

  for(;;) {
    level waittill("bc_notify", _id_C2C1AB2C183FF85B);

    foreach(data in _id_C2C1AB2C183FF85B) {
      if(data.entity _id_C0DA17570A24346C(data.category, data.params)) {
        continue;
      }
      category = data.category;

      switch (category) {
        case "stealth_state_change":
          data.entity thread _id_1AC4F948BB0D1255(data);
          break;
        case "moving":
          if(!_id_8F59CAA9212FCC56())
            data.entity _id_D54E84A9513B0E45("coverme", "coverme", 0, 1, 5);

          break;
        case "suppressing":
          if(!_id_8F59CAA9212FCC56())
            data.entity _id_D54E84A9513B0E45("coverfire", ["copy", 0.2, "suppressing"], 0, 1, 5);

          break;
        case "moving_up":
          if(!_id_8F59CAA9212FCC56()) {
            data.entity _id_166E0B70304FC0BE("movement");
            data.entity _id_50EEB9595C6D6E1B::_id_42C77C7F13A1BEB8();
          }

          break;
        case "initial_combat":
          data.entity _id_50EEB9595C6D6E1B::_id_1AE088B4C06D0525();
          break;
        case "first_combat":
          data.entity _id_50EEB9595C6D6E1B::_id_8FA36B2CE712A5BB();
          break;
        case "last_known_position":
          if(data._id_1C9CB43BCF3EB16D == "losing_target")
            data.entity _id_50EEB9595C6D6E1B::_id_E2D4E5C64D62278E(data._id_CAC102B2D7B66836);
          else if(data._id_1C9CB43BCF3EB16D == "lost_target")
            data.entity _id_D54E84A9513B0E45("lost_target", "ask_target_location", 0, 2, 5);
          else if(data._id_1C9CB43BCF3EB16D == "cease_fire")
            data.entity _id_D54E84A9513B0E45("cease_fire", "hunt_order_hold", 0, 2, 5);

          break;
        case "hunt":
          if(data._id_1C9CB43BCF3EB16D == "combat_hunt" && (!scripts\common\utility::issp() || isalive(level.player)))
            data.entity _id_D54E84A9513B0E45("combat_hunt", "hunt_cornercheck", 0, 2, 5);
          else if(data._id_1C9CB43BCF3EB16D == "hunt")
            data.entity _id_D54E84A9513B0E45("hunt", "hunt", 0, 2, 5);

          break;
        case "combat_state_change":
          if(data._id_1C9CB43BCF3EB16D == "combat_unaware")
            data.entity _id_D54E84A9513B0E45("combat_unaware", "cmb_reactions", 0, 2, 5);

          break;
        case "investigateevent":
          if(data._id_1C9CB43BCF3EB16D == "investigateposreached") {
            if(isDefined(data.params[2]) && data.params[2] == "saw_corpse") {
              return;
            }
            data.entity _id_50EEB9595C6D6E1B::_id_E46D9FD4C3250863();
          }

          break;
        case "incoming_vehicle_response":
          if(data._id_1C9CB43BCF3EB16D == "dodge_vehicle_start")
            data.entity _id_D54E84A9513B0E45("incoming_vehicle_response", scripts\engine\utility::random(["hunt_reactions", "cmb_reactions"]), 1, 0);

          break;
      }
    }
  }
}

_id_1AC4F948BB0D1255(data) {
  previousstate = data.params[0];
  currentstate = data.params[1];
  _id_2A130B858DB198CB = _id_A07ABD440B7A33FE(data._id_CAC102B2D7B66836);

  if(previousstate == 4 || previousstate == currentstate) {
    return;
  }
  switch (currentstate) {
    case 0:
      return _id_50EEB9595C6D6E1B::_id_E64DBAAAE396FBB8(previousstate);
    case 1:
      if(_id_2A130B858DB198CB)
        return _id_50EEB9595C6D6E1B::_id_23A29830A84AF4CF();
      else
        return _id_50EEB9595C6D6E1B::_id_BBB539FD7C238608();
    case 2:
      return _id_50EEB9595C6D6E1B::_id_F4671F61A3031990();
    case 3:
      if(previousstate < 2) {
        if(_id_2A130B858DB198CB) {
          return _id_50EEB9595C6D6E1B::_id_64E63285A83E3EFE();
          return;
        }

        return _id_50EEB9595C6D6E1B::_id_1AE088B4C06D0525();
        return;
        return;
      }

      return _id_50EEB9595C6D6E1B::_id_6237814879B07FBF();
      return;
  }
}

_id_45A69522DD934D18(dist) {
  level._id_587DE0E7B537210A = 2048;
  level._id_B4360CAB4806D3A0 = squared(level._id_587DE0E7B537210A);
}

_id_33BDD4AD6AA14EDC(overrides) {
  level._id_2957DE46170ADAD1 = overrides;
}

_id_2F7FD2639DB2A57B() {
  if(!isDefined(level._id_2957DE46170ADAD1)) {
    level._id_2957DE46170ADAD1 = spawnStruct();
    level._id_2957DE46170ADAD1._id_FD6906DC66B503B4 = 10;
    level._id_2957DE46170ADAD1._id_4C433DC943A4B16E = 16;
    level._id_2957DE46170ADAD1._id_AC5D474FFE947F53 = 4;
    level._id_2957DE46170ADAD1._id_8FB4E94454C2B089 = 12;
    level._id_2957DE46170ADAD1._id_DE220EE05772F786 = 1;
    level._id_2957DE46170ADAD1._id_D4692DEEC4B3B23C = 2;
    return;
  }
}

init_squadbattlechatter() {
  squad = self;
  squad.chatinitialized = 1;
  squad notify("squad chat initialized");
}

bcsenabled() {
  return isDefined(level.battlechatter);
}

bcs_setup_voice(voice, countryid, _id_46119EE4018A3E10, _id_790E7A69F5C40B30, _id_4189AF81D34B8804, _id_010E927A072C477B) {
  if(!isDefined(_id_790E7A69F5C40B30))
    _id_790E7A69F5C40B30 = 0;

  anim.usedids[voice] = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_46119EE4018A3E10; _id_AC0E594AC96AA3A8++) {
    anim.usedids[voice][_id_AC0E594AC96AA3A8] = spawnStruct();
    anim.usedids[voice][_id_AC0E594AC96AA3A8].count = 0;
    anim.usedids[voice][_id_AC0E594AC96AA3A8].npcid = "" + (_id_AC0E594AC96AA3A8 + 1);
  }

  anim.countryids[voice] = countryid;
  anim._id_6D557183AF1D1DB5[countryid] = _id_4189AF81D34B8804;
  anim._id_7F532A5DC6603698[countryid] = _id_010E927A072C477B;
}

_id_2FAEE9E4CF862D61() {
  triggers = getEntArray("trigger_multiple", "code_classname");
  _id_00A4162F1221E6A6 = [];

  foreach(trigger in triggers) {
    if(!issubstr(trigger.classname, "trigger_multiple_bcs")) {
      continue;
    }
    _id_00A4162F1221E6A6[_id_00A4162F1221E6A6.size] = trigger;
    trigger.location = getsubstr(trigger.classname, 24, trigger.classname.size);

    if(trigger.spawnflags & 1)
      trigger.islandmark = 1;
  }

  level.battlechatter._id_00A4162F1221E6A6 = _id_00A4162F1221E6A6;
}

shutdown_battlechatter() {
  level.battlechatter = undefined;
  level notify("battlechatter disabled");
}

_id_1EA9D53684D11626() {
  level endon("battlechatter disabled");
  wait 1;

  for(;;) {
    players = level.players;
    _id_0B474BF710C850DA = 0;

    for(_id_AC0E424AC96A7113 = 0; _id_AC0E424AC96A7113 < players.size; _id_AC0E424AC96A7113++) {
      player = players[_id_AC0E424AC96A7113];

      if(!isalive(player) || !isDefined(player.origin)) {
        continue;
      }
      if(istrue(player._id_7887F3C24E400953)) {
        continue;
      }
      player thread _id_F46983DFFE232870();
      _id_0B474BF710C850DA++;

      if(_id_0B474BF710C850DA >= 5) {
        _id_0B474BF710C850DA = 0;
        waitframe();
      }
    }

    waitframe();
  }
}

_id_F46983DFFE232870() {
  self endon("death_or_disconnect");
  self._id_7887F3C24E400953 = 1;
  _id_310236DBF257FBB5 = _id_FD9E4CB348A5F283(self.origin, level._id_8893859DE4351996);
  _id_310236DBF257FBB5 = sortbydistance(_id_310236DBF257FBB5, self.origin);
  count = min(_id_310236DBF257FBB5.size, 10);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++) {
    waitframe();
    _id_3114816C58D0AA74 = (_id_AC0E594AC96AA3A8 + 1) / count;

    if(scripts\engine\utility::_id_51D76700600CEBE3((1 - _id_3114816C58D0AA74) * 15)) {
      continue;
    }
    guy = _id_310236DBF257FBB5[_id_AC0E594AC96AA3A8];

    if(!isalive(guy) || !isDefined(guy.battlechatter) || istrue(guy.battlechatter._id_91892EB738FD74CD)) {
      continue;
    }
    team = guy.team;
    origin = guy.origin;

    if(!isDefined(team) || !isDefined(origin)) {
      continue;
    }
    if(isDefined(guy.battlechatter._id_E71D143C0A460C23) && gettime() < guy.battlechatter._id_E71D143C0A460C23) {
      continue;
    }
    state = guy _id_16DCE705F14F4B84();

    if(!isDefined(state) || !isDefined(guy.team)) {
      continue;
    }
    if(state == "dead" || guy.team == "neutral") {
      continue;
    }
    if(state == "combat" && guy _id_8F59CAA9212FCC56()) {
      continue;
    }
    guy thread _id_4F4F4B31F8A95D9F(state);

    if(scripts\common\utility::issp())
      guy _id_AF3A6677D4327AAE();
    else
      guy _id_B145367392D5843D();

    break;
  }

  self._id_7887F3C24E400953 = 0;
}

_id_AF3A6677D4327AAE(_id_CC748B6D457627FE, _id_0492D858D989A382) {
  if(!isDefined(_id_CC748B6D457627FE))
    _id_CC748B6D457627FE = _id_42A6E01190025613(_id_16DCE705F14F4B84()) / 1000;

  if(!isDefined(self.origin) || !isDefined(self.team))
    return _id_B145367392D5843D(_id_CC748B6D457627FE, _id_0492D858D989A382);

  foreach(ai in _id_FD9E4CB348A5F283(self.origin, level._id_798AA343368F724E, self.team))
  ai _id_B145367392D5843D(_id_CC748B6D457627FE, _id_0492D858D989A382);
}

_id_B145367392D5843D(_id_CC748B6D457627FE, _id_0492D858D989A382) {
  if(!isDefined(self.battlechatter)) {
    return;
  }
  if(!isDefined(_id_CC748B6D457627FE))
    _id_00427B650BA00795 = _id_42A6E01190025613(_id_16DCE705F14F4B84());
  else
    _id_00427B650BA00795 = _id_CC748B6D457627FE * 1000;

  self.battlechatter._id_E71D143C0A460C23 = gettime() + _id_00427B650BA00795;

  if(istrue(_id_0492D858D989A382))
    self.battlechatter._id_3C94D4874D436201 = gettime() + _id_00427B650BA00795;
}

_id_3769E5550BED355B(state, min_delay, max_delay) {
  level.battlechatter._id_6ADA3242ACD08CF5[state] = [min_delay, max_delay];
}

_id_42A6E01190025613(state) {
  range = level.battlechatter._id_6ADA3242ACD08CF5[state];

  if(!isDefined(range))
    range = level.battlechatter._id_6ADA3242ACD08CF5["default"];

  return randomfloatrange(range[0], range[1]) * 1000;
}

_id_90826D80AA1736CB(state, func) {
  if(!isDefined(level.battlechatter)) {
    return;
  }
  level.battlechatter.states[state] = func;
}

_id_4F4F4B31F8A95D9F(state) {
  self endon("death");

  if(!isDefined(level.battlechatter)) {
    return;
  }
  func = level.battlechatter.states[state];

  if(!isDefined(func)) {
    return;
  }
  self.battlechatter._id_91892EB738FD74CD = 1;
  result = self[[func]]();
  self.battlechatter._id_91892EB738FD74CD = undefined;
  return result;
}

_id_BF23E005E136DC90(_id_9144967162969CD7, _id_927B3199642B75FC, priority, timeout, cooldown, _id_BA7E8AD2868EF874) {
  if(!isDefined(level.battlechatter.events[_id_9144967162969CD7]))
    level.battlechatter.events[_id_9144967162969CD7] = scripts\engine\utility::create_deck();

  event = spawnStruct();
  event._id_927B3199642B75FC = _id_927B3199642B75FC;
  event.priority = priority;
  event.timeout = timeout;
  event.cooldown = cooldown;
  event._id_BA7E8AD2868EF874 = _id_BA7E8AD2868EF874;
  index = level.battlechatter.events[_id_9144967162969CD7].items.size;
  level.battlechatter.events[_id_9144967162969CD7].items[index] = event;
}

_id_7AEDD2357AECC5A6(_id_9144967162969CD7, func) {
  if(!isDefined(level.battlechatter.events[_id_9144967162969CD7]))
    level.battlechatter.events[_id_9144967162969CD7] = scripts\engine\utility::create_deck();

  index = level.battlechatter.events[_id_9144967162969CD7].items.size;
  level.battlechatter.events[_id_9144967162969CD7].items[index] = func;
}

_id_58D2ED1E4ECAE7BB(_id_9144967162969CD7, _id_D93390A0D7E03633) {
  if(!isDefined(level.battlechatter.events)) {
    return;
  }
  if(!isDefined(level.battlechatter.events[_id_9144967162969CD7])) {
    return;
  }
  _id_8AD814EB875ED1C2 = [];

  foreach(index, _id_4E26918D4DD88782 in level.battlechatter.events[_id_9144967162969CD7].items) {
    if(_id_4E26918D4DD88782 == _id_D93390A0D7E03633) {
      if(level.battlechatter.events[_id_9144967162969CD7].index > index)
        level.battlechatter.events[_id_9144967162969CD7].index--;

      continue;
    }

    _id_8AD814EB875ED1C2[_id_8AD814EB875ED1C2.size] = _id_4E26918D4DD88782;
  }

  level.battlechatter.events[_id_9144967162969CD7].items = _id_8AD814EB875ED1C2;
}

_id_C0DA17570A24346C(_id_9144967162969CD7, params) {
  if(!_id_5D6CFAE8BA773D66(self))
    return 1;

  if(!isDefined(level.battlechatter.events[_id_9144967162969CD7]))
    return 0;

  event = level.battlechatter.events[_id_9144967162969CD7] scripts\engine\utility::deck_draw();

  if(isarray(params))
    params = scripts\engine\utility::array_removeundefined(params);

  if(isfunction(event))
    thread _id_5D265B4FCA61F070::call_with_params_script(event, params);
  else
    thread _id_D54E84A9513B0E45(_id_9144967162969CD7, event._id_927B3199642B75FC, event.priority, event.timeout, event.cooldown, event._id_BA7E8AD2868EF874);

  return 1;
}

_id_4D19743DBA541BE4() {
  return ["axis", "allies", "neutral", "team3"];
}

_id_CDA75FB378A679EB() {
  return ["axis", "allies", "team3"];
}

getenemyteams() {
  return ["axis", "team3"];
}

_id_2B3A4945AE9FAF96() {
  return ["allies", "neutral"];
}

_id_D54E84A9513B0E45(name, _id_927B3199642B75FC, priority, timeout, cooldown, _id_BA7E8AD2868EF874) {
  _id_3A7AEA3989AE851A = _id_6345913274A2CA6A(name, _id_927B3199642B75FC, priority, timeout, cooldown, _id_BA7E8AD2868EF874);
  return _id_55BF3F231C0283CC(_id_3A7AEA3989AE851A);
}

_id_55BF3F231C0283CC(_id_3A7AEA3989AE851A) {
  _id_7D2852D02216C876 = scripts\engine\utility::_id_53C4C53197386572(self._id_868E98CF48B92CFB, self);

  if(!istrue(_id_3A7AEA3989AE851A._id_D4380FBE5B18F83C) && !_id_7D2852D02216C876 _id_D8462B621401984A()) {
    _id_3A7AEA3989AE851A._id_E304CBC83D937A51 = 1;
    return 0;
  }

  if(isDefined(_id_3A7AEA3989AE851A.name) && !_id_EAD4BED232D015ED(_id_3A7AEA3989AE851A.name)) {
    _id_3A7AEA3989AE851A._id_E304CBC83D937A51 = 1;
    return 0;
  }

  if(scripts\common\utility::issp())
    _id_7D2852D02216C876 _id_AF3A6677D4327AAE();
  else
    _id_7D2852D02216C876 _id_B145367392D5843D();

  _id_7D2852D02216C876 _id_E23B0906B02CD179(_id_3A7AEA3989AE851A.name, _id_3A7AEA3989AE851A.cooldown);
  level.battlechatter notify("chatter_added", _id_3A7AEA3989AE851A);
  _id_3A7AEA3989AE851A thread _id_AC907769B9D391CB();
  return _id_3A7AEA3989AE851A;
}

_id_B9CC4FF760926456(name, _id_927B3199642B75FC, priority, timeout, cooldown, _id_BA7E8AD2868EF874) {
  _id_3A7AEA3989AE851A = _id_6345913274A2CA6A(name, _id_927B3199642B75FC, priority, timeout, cooldown, _id_BA7E8AD2868EF874);
  return _id_F6E959DB9FB34FF3(_id_3A7AEA3989AE851A);
}

_id_F6E959DB9FB34FF3(_id_3A7AEA3989AE851A) {
  _id_55BF3F231C0283CC(_id_3A7AEA3989AE851A);
  _id_67445F0A05BFCFAD(_id_3A7AEA3989AE851A);
}

_id_67445F0A05BFCFAD(_id_3A7AEA3989AE851A) {
  if(!istrue(_id_3A7AEA3989AE851A._id_E304CBC83D937A51))
    _id_3A7AEA3989AE851A waittill("finished_or_cancelled");

  return _id_3A7AEA3989AE851A._id_0F5E6316C2383F5F;
}

_id_AC907769B9D391CB() {
  self._id_0F5E6316C2383F5F = 0;
  self._id_E304CBC83D937A51 = 0;
  self._id_7D2852D02216C876._id_44E1869B50A57309 = self.scope;
  self._id_7D2852D02216C876 notify("started_queue_wait", self);
  cancelled = self._id_9A4096E3A9B92412[self.scope] _id_5D265B4FCA61F070::_id_0F2A79001721945A(self, self.timeout, self._id_BA7E8AD2868EF874);
  self._id_7D2852D02216C876 notify("finished_queue_wait", self, cancelled);

  if(!istrue(cancelled) && (istrue(self._id_D4380FBE5B18F83C) || scripts\engine\utility::_id_53C4C53197386572(self._id_7D2852D02216C876._id_868E98CF48B92CFB, self._id_7D2852D02216C876) _id_D8462B621401984A())) {
    level.battlechatter notify("chatter_started", self);
    self._id_7D2852D02216C876._id_EC9F57E7698BAFFB = self.priority;

    foreach(ent in self._id_9A4096E3A9B92412)
    ent _id_5D265B4FCA61F070::_id_797820CAD48747EF(self);

    self notify("proceeded");

    while(isDefined(self._id_0F5E6316C2383F5F) && !self._id_0F5E6316C2383F5F)
      self._id_0F5E6316C2383F5F = _id_A9C351DED2CF6CE4();

    if(scripts\engine\utility::is_dead_or_dying(self._id_7D2852D02216C876)) {
      self._id_7D2852D02216C876 _id_5D265B4FCA61F070::_id_5510C489D7F09128(0, 0);

      if(isDefined(self._id_B1CC80F4B3875F46))
        self._id_6727329A89208345 _id_D54E84A9513B0E45(self.name + "_interrupt", self._id_B1CC80F4B3875F46, 1, 0, 1);
    }

    if(istrue(self._id_0F5E6316C2383F5F))
      self._id_7D2852D02216C876 _id_E23B0906B02CD179(self.name, self.cooldown);

    foreach(ent in self._id_9A4096E3A9B92412)
    ent _id_5D265B4FCA61F070::remove_vo_data(self);
  } else
    self notify("proceeded");

  _id_5D265B4FCA61F070::_id_AB8711048F02259D(self._id_9A4096E3A9B92412);
  self._id_7D2852D02216C876 notify("chatter_finished_or_cancelled", self);
  level.battlechatter notify("chatter_finished_or_cancelled", self);
  self._id_E304CBC83D937A51 = 1;
  self notify("finished_or_cancelled");
}

_id_A9C351DED2CF6CE4() {
  if(scripts\engine\utility::is_dead_or_dying(self._id_7D2852D02216C876)) {
    if(isDefined(self._id_B1CC80F4B3875F46)) {
      _id_66F86D312021D93A();
      self._id_927B3199642B75FC = self._id_B1CC80F4B3875F46;
      self.index = 0;
      self._id_B1CC80F4B3875F46 = undefined;
    } else
      return;
  }

  self._id_7D2852D02216C876 notify("stop_bcs_sequence");
  self._id_7D2852D02216C876 endon("death");
  self._id_7D2852D02216C876 endon("stop_bcs_sequence");
  self._id_7D2852D02216C876 endon("removed from battleChatter");
  _id_344578FB5C1F5325 = self._id_7D2852D02216C876;

  foreach(_id_A490EDBA2726EC98 in self._id_BA7E8AD2868EF874) {
    if(isent(_id_A490EDBA2726EC98) || isstruct(_id_A490EDBA2726EC98)) {
      _id_344578FB5C1F5325 = _id_A490EDBA2726EC98;
      continue;
    }

    if(isstring(_id_A490EDBA2726EC98))
      _id_344578FB5C1F5325 endon(_id_A490EDBA2726EC98);
  }

  if(!isDefined(self._id_927B3199642B75FC) || !isDefined(self.index)) {
    return;
  }
  vo_queue = level._id_60DF2B6C3887B3EB[self._id_7D2852D02216C876.team].vo_queue;

  if(vo_queue.size > 0 && vo_queue[0].priority > self.priority) {
    return;
  }
  if(self.index >= self._id_927B3199642B75FC.size)
    return 1;

  self.alias = undefined;

  if(scripts\common\utility::issp())
    self._id_7D2852D02216C876 _id_AF3A6677D4327AAE();
  else
    self._id_7D2852D02216C876 _id_B145367392D5843D();

  _id_1F7FD473E2E3E8AA = self._id_927B3199642B75FC[self.index];
  self.index++;

  if(isstring(_id_1F7FD473E2E3E8AA)) {
    self.alias = _id_5B9DB2CB162B207A(_id_1F7FD473E2E3E8AA);

    if(!soundexists(self.alias)) {
      if(istrue(self._id_B7B89212841EAA3F)) {
        self._id_B7B89212841EAA3F = undefined;
        return 0;
      }

      return;
    }

    if(!istrue(self._id_D4380FBE5B18F83C) && !scripts\engine\utility::_id_53C4C53197386572(self._id_7D2852D02216C876._id_868E98CF48B92CFB, self._id_7D2852D02216C876) _id_D8462B621401984A()) {
      return;
    }
    if(!_id_5D265B4FCA61F070::_id_6CF6A58C99522E20(self._id_9A4096E3A9B92412[self.scope]._id_261AAF24A09D231D, 1)) {
      return;
    }
    _id_0F5E6316C2383F5F = self._id_7D2852D02216C876 _id_5D265B4FCA61F070::_id_7B52F05DA542C2FF(self.alias, self._id_F6E387B9F5A2B39C, self._id_9A4096E3A9B92412[self.scope], self._id_5C1322185369EFCD);

    if(!istrue(_id_0F5E6316C2383F5F)) {
      return;
    }
    return 0;
  } else if(isnumber(_id_1F7FD473E2E3E8AA)) {
    if(_id_1F7FD473E2E3E8AA <= 0)
      return 0;

    wait(_id_1F7FD473E2E3E8AA);
    return 0;
  } else if(isent(_id_1F7FD473E2E3E8AA) || isstruct(_id_1F7FD473E2E3E8AA)) {
    result = _id_66F86D312021D93A(_id_1F7FD473E2E3E8AA);

    if(isint(result) && result == 0)
      return;
    else
      return 0;
  } else if(isfunction(_id_1F7FD473E2E3E8AA)) {
    result = self[[_id_1F7FD473E2E3E8AA]]();

    if(isDefined(result)) {
      if(isint(result) && result == 0) {
        return;
      }
      if(isarray(result))
        self._id_927B3199642B75FC = scripts\engine\utility::_id_EF4B3DF86351AA00(self._id_927B3199642B75FC, result, self.index);
      else
        self._id_927B3199642B75FC = scripts\engine\utility::array_insert(self._id_927B3199642B75FC, result, self.index);
    }

    return 0;
  } else if(isarray(_id_1F7FD473E2E3E8AA)) {
    self._id_927B3199642B75FC = scripts\engine\utility::_id_EF4B3DF86351AA00(self._id_927B3199642B75FC, _id_1F7FD473E2E3E8AA, self.index);
    return 0;
  }

  return;
}

_id_6345913274A2CA6A(name, _id_927B3199642B75FC, priority, timeout, cooldown, _id_BA7E8AD2868EF874) {
  _id_3A7AEA3989AE851A = spawnStruct();
  _id_3A7AEA3989AE851A.name = name;
  _id_3A7AEA3989AE851A.scope = scripts\engine\utility::_id_53C4C53197386572(level.battlechatter.scope, "team");
  _id_3A7AEA3989AE851A.owner = self;
  _id_3A7AEA3989AE851A._id_7D2852D02216C876 = self;
  _id_3A7AEA3989AE851A._id_9A4096E3A9B92412 = _id_5D265B4FCA61F070::_id_028E38EEFD3CC4AB();
  _id_3A7AEA3989AE851A._id_79498ADF23C51E6A = 1;

  if(!isarray(_id_927B3199642B75FC))
    _id_927B3199642B75FC = [_id_927B3199642B75FC];

  _id_3A7AEA3989AE851A.index = 0;
  _id_3A7AEA3989AE851A._id_927B3199642B75FC = _id_927B3199642B75FC;
  _id_3A7AEA3989AE851A._id_D4380FBE5B18F83C = isDefined(level.battlechatter) && isDefined(self.battlechatter) && istrue(self.battlechatter.friendlyfire_force) && name == "friendlyfire";
  _id_3A7AEA3989AE851A.priority = scripts\engine\utility::_id_53C4C53197386572(priority, 0);
  _id_3A7AEA3989AE851A.timeout = scripts\engine\utility::_id_53C4C53197386572(timeout, 1);
  _id_3A7AEA3989AE851A.cooldown = scripts\engine\utility::_id_53C4C53197386572(cooldown, 0);
  _id_3A7AEA3989AE851A._id_BA7E8AD2868EF874 = scripts\engine\utility::_id_53C4C53197386572(_id_BA7E8AD2868EF874, []);
  _id_3A7AEA3989AE851A._id_F6E387B9F5A2B39C = 1;

  if(!isarray(_id_3A7AEA3989AE851A._id_BA7E8AD2868EF874))
    _id_3A7AEA3989AE851A._id_BA7E8AD2868EF874 = [_id_3A7AEA3989AE851A._id_BA7E8AD2868EF874];

  return _id_3A7AEA3989AE851A;
}

_id_0A4BA1099AC49C74(_id_927B3199642B75FC) {
  foreach(_id_1F7FD473E2E3E8AA in _id_927B3199642B75FC) {
    if(isarray(_id_1F7FD473E2E3E8AA)) {
      result = _id_0A4BA1099AC49C74(_id_1F7FD473E2E3E8AA);

      if(isDefined(result))
        return result;
    }

    if(isent(_id_1F7FD473E2E3E8AA))
      return _id_1F7FD473E2E3E8AA;
  }
}

_id_C2AAFBDBD7FF7B82(_id_927B3199642B75FC) {
  foreach(_id_1F7FD473E2E3E8AA in _id_927B3199642B75FC) {
    if(isarray(_id_1F7FD473E2E3E8AA)) {
      result = _id_C2AAFBDBD7FF7B82(_id_1F7FD473E2E3E8AA);

      if(isDefined(result))
        return result;
    }

    if(isstring(_id_1F7FD473E2E3E8AA))
      return _id_1F7FD473E2E3E8AA;
  }
}

_id_5B9DB2CB162B207A(_id_A5ADF7CA3DDC0CFD) {
  if(isstartstr(_id_A5ADF7CA3DDC0CFD, "dx_"))
    return _id_A5ADF7CA3DDC0CFD;

  if(!isstartstr(_id_A5ADF7CA3DDC0CFD, "~") && !isstartstr(_id_A5ADF7CA3DDC0CFD, "c_") && !isstartstr(_id_A5ADF7CA3DDC0CFD, "s_"))
    _id_A5ADF7CA3DDC0CFD = self._id_7D2852D02216C876 _id_50EEB9595C6D6E1B::_id_AC566E2D34BCCAA2(_id_A5ADF7CA3DDC0CFD);

  if(!isDefined(_id_A5ADF7CA3DDC0CFD))
    return "";

  if(isstartstr(_id_A5ADF7CA3DDC0CFD, "dx_"))
    return _id_A5ADF7CA3DDC0CFD;

  _id_F75BA7B0D6A4B1CB = strtok(_id_A5ADF7CA3DDC0CFD, "_");
  _id_B5517D24E9DC9A49 = scripts\engine\utility::_id_53C4C53197386572(_id_8AF9F89D6344A3DF(self._id_7D2852D02216C876), "");
  countryid = scripts\engine\utility::_id_53C4C53197386572(self._id_7D2852D02216C876.battlechatter.countryid, "");

  if(isDefined(self._id_7D2852D02216C876.battlechatter._id_96A045A4858E3F20))
    countryid = self._id_7D2852D02216C876.battlechatter._id_96A045A4858E3F20;

  if(_id_F75BA7B0D6A4B1CB.size > 2) {
    if(isDefined(countryid)) {
      if(_id_F75BA7B0D6A4B1CB[0] == "s")
        _id_F75BA7B0D6A4B1CB[0] = anim._id_7F532A5DC6603698[countryid];
      else
        _id_F75BA7B0D6A4B1CB[0] = anim._id_6D557183AF1D1DB5[countryid];
    }

    if(!isDefined(countryid) || !isDefined(_id_F75BA7B0D6A4B1CB[0]))
      _id_F75BA7B0D6A4B1CB[0] = "hrcm";
  }

  switch (_id_F75BA7B0D6A4B1CB.size) {
    case 4:
      return "dx_bc_" + _id_F75BA7B0D6A4B1CB[0] + "_" + _id_F75BA7B0D6A4B1CB[1] + "_" + _id_B5517D24E9DC9A49 + "_" + _id_F75BA7B0D6A4B1CB[2] + "_" + _id_F75BA7B0D6A4B1CB[3];
    case 3:
      return "dx_bc_" + _id_F75BA7B0D6A4B1CB[0] + "_" + _id_F75BA7B0D6A4B1CB[1] + "_" + _id_B5517D24E9DC9A49 + "_" + _id_F75BA7B0D6A4B1CB[2];
    case 2:
      return "dx_bc_" + _id_F75BA7B0D6A4B1CB[0] + "_" + _id_B5517D24E9DC9A49 + "_" + _id_F75BA7B0D6A4B1CB[1];
    case 1:
      if(istrue(self._id_7D2852D02216C876.battlechatter._id_F9D07E5FA610B560))
        return "dx_guid" + _id_F75BA7B0D6A4B1CB[0];
      else
        return "dx_guid" + _id_F75BA7B0D6A4B1CB[0] + "_" + _id_B5517D24E9DC9A49;
    default:
  }
}

_id_A02D91C29D53A43C(_id_A5ADF7CA3DDC0CFD) {
  if(!isDefined(level.battlechatter._id_642ABCB792D36A72))
    _id_FA9C799417080957();

  if(isDefined(level.battlechatter._id_642ABCB792D36A72[_id_A5ADF7CA3DDC0CFD]))
    return level.battlechatter._id_642ABCB792D36A72[_id_A5ADF7CA3DDC0CFD] scripts\engine\utility::deck_draw();
  else
    return _id_A5ADF7CA3DDC0CFD;
}

_id_FA9C799417080957() {
  level.battlechatter._id_642ABCB792D36A72 = [];
}

_id_8AF9F89D6344A3DF(_id_7D2852D02216C876) {
  if(isDefined(_id_7D2852D02216C876.battlechatter._id_510A786F345DCCD9))
    return tolower(_id_7D2852D02216C876.battlechatter._id_510A786F345DCCD9);

  npcid = scripts\engine\utility::_id_53C4C53197386572(_id_7D2852D02216C876.battlechatter.npcid, "");

  if(npcid.size == 4)
    return tolower(npcid);

  countryid = scripts\engine\utility::_id_53C4C53197386572(_id_7D2852D02216C876.battlechatter.countryid, "");

  if(isDefined(_id_7D2852D02216C876.battlechatter._id_96A045A4858E3F20))
    countryid = _id_7D2852D02216C876.battlechatter._id_96A045A4858E3F20;

  return tolower(countryid + npcid);
}

_id_C5F095386A46F1E8(type) {
  type = scripts\engine\utility::_id_53C4C53197386572(type, "stealth");

  switch (type) {
    case "stealth":
      _id_543E5B04347FF90C = getDvar("dvar_495535A4877B324D") != "off";
      return scripts\engine\utility::ter_op(_id_543E5B04347FF90C, "otn_", "cst_");
    case "custom":
      return "vom_";
    default:
      _id_543E5B04347FF90C = getDvar("dvar_87DCA5163728CE02") != "off";
      return scripts\engine\utility::ter_op(_id_543E5B04347FF90C, "otn_", "cbc_");
  }
}

_id_5CACC2EE536504AE() {
  if(isDefined(level._id_B2FF82EC901486E4))
    return level._id_B2FF82EC901486E4;

  mapname = getDvar("mapname");

  switch (getsubstr(mapname, 0, 3)) {
    case "mp_":
      if(getsubstr(mapname, 0, 6) == "mp_br_")
        level._id_B2FF82EC901486E4 = "br";
      else
        level._id_B2FF82EC901486E4 = "mp";

      break;
    case "cp_":
      level._id_B2FF82EC901486E4 = "cp";
      break;
    default:
      level._id_B2FF82EC901486E4 = "sp";
      break;
  }

  return level._id_B2FF82EC901486E4;
}

getlocation() {
  if(!isDefined(level.battlechatter._id_00A4162F1221E6A6)) {
    return;
  }
  _id_00A4162F1221E6A6 = self getistouchingentities(level.battlechatter._id_00A4162F1221E6A6);

  if(_id_00A4162F1221E6A6.size == 0) {
    return;
  }
  locations = [];

  foreach(trigger in _id_00A4162F1221E6A6) {
    _id_2DAB9FB88C214A2E = isDefined(trigger.islandmark) && level.player istouching(trigger);

    if(_id_2DAB9FB88C214A2E || !isDefined(trigger.location)) {
      continue;
    }
    locations[locations.size] = trigger.location;
  }

  return scripts\engine\utility::random(locations);
}

_id_5D6CFAE8BA773D66(guy) {
  if(!isDefined(level.battlechatter) || !isDefined(self.battlechatter))
    return 0;

  team = scripts\engine\utility::_id_53C4C53197386572(guy.team, "");
  _id_B2118E1EC1B42F84 = !istrue(guy.battlechatterallowed);
  _id_B9DCC79EDA6D673D = isDefined(level._id_EDCE163BBAB4F0CE) && istrue(level._id_EDCE163BBAB4F0CE[team]);
  _id_6ACC9F79D4246175 = istrue(level._id_91A8C7ABDF195C70);
  return !_id_B2118E1EC1B42F84 && !_id_B9DCC79EDA6D673D && !_id_6ACC9F79D4246175;
}

_id_D8462B621401984A(_id_0F35FEAE42B2B331, _id_9B7F602C247C3953) {
  if(scripts\engine\utility::is_dead_or_dying(self) || !isDefined(self.team) || !isDefined(self.origin) || !_id_5D6CFAE8BA773D66(self))
    return 0;

  if(isDefined(_id_0F35FEAE42B2B331) && _id_16DCE705F14F4B84() != _id_0F35FEAE42B2B331)
    return 0;

  if(isDefined(_id_9B7F602C247C3953) && !self seerecently(_id_9B7F602C247C3953, 2))
    return 0;

  if(istrue(self.in_melee_death))
    return 0;

  if(istrue(self._animactive) && !istrue(self.battlechatter._id_7BE5DBF61CA23F11))
    return 0;

  if(isPlayer(self))
    return 1;

  if(self _meth_E74BDD9282B22AA0())
    return 0;

  if(!_id_2AA175082BDB56F5(self.origin, level._id_63A73645A8E030AD).size > 0)
    return 0;

  return 1;
}

bc_prefix(type) {
  return "dx_" + _id_C5F095386A46F1E8(type) + _id_8AF9F89D6344A3DF(self) + "_";
}

_id_EAD4BED232D015ED(name, players) {
  if(!isDefined(players)) {
    if(scripts\common\utility::issp())
      players = [level.player];
    else
      players = _id_2AA175082BDB56F5(self.origin, level._id_63A73645A8E030AD);
  }

  foreach(player in players) {
    if(!isDefined(player._id_9D0C877B6E13853E) || !isDefined(player._id_9D0C877B6E13853E[self.team])) {
      continue;
    }
    if(!isDefined(player._id_9D0C877B6E13853E[self.team][name])) {
      continue;
    }
    if(gettime() < player._id_9D0C877B6E13853E[self.team][name])
      return 0;
  }

  return 1;
}

_id_161BD3732C0AFBCE(name, duration, players) {
  if(!_id_EAD4BED232D015ED(name, players))
    return 0;

  _id_E23B0906B02CD179(name, duration, players);
  return 1;
}

_id_E23B0906B02CD179(name, duration, players) {
  if(!isDefined(name) || !isDefined(duration) || !isDefined(self.origin)) {
    return;
  }
  if(!isDefined(players)) {
    if(scripts\common\utility::issp())
      players = [level.player];
    else
      players = _id_2AA175082BDB56F5(self.origin, level._id_63A73645A8E030AD);
  }

  foreach(player in players) {
    if(!isDefined(player._id_9D0C877B6E13853E))
      player._id_9D0C877B6E13853E = [];

    if(!isDefined(player._id_9D0C877B6E13853E[self.team]))
      player._id_9D0C877B6E13853E[self.team] = [];

    player._id_9D0C877B6E13853E[self.team][name] = gettime() + duration * 1000;

    if(scripts\common\utility::ismp())
      player._id_9D0C877B6E13853E[self.team] = _id_AB7DF904AA60D433(player._id_9D0C877B6E13853E[self.team], 5);
  }
}

_id_166E0B70304FC0BE(name) {
  if(!isDefined(name) || !isDefined(self.origin)) {
    return;
  }
  if(scripts\common\utility::issp())
    players = [level.player];
  else
    players = _id_2AA175082BDB56F5(self.origin, level._id_63A73645A8E030AD);

  foreach(player in players) {
    if(!isDefined(player._id_9D0C877B6E13853E)) {
      continue;
    }
    if(!isDefined(player._id_9D0C877B6E13853E[self.team])) {
      continue;
    }
    player._id_9D0C877B6E13853E[self.team][name] = undefined;
  }
}

_id_66F86D312021D93A(_id_65E9C81367809607) {
  if(!isDefined(_id_65E9C81367809607))
    _id_65E9C81367809607 = self._id_6727329A89208345;

  if(!isDefined(_id_65E9C81367809607))
    _id_65E9C81367809607 = _id_8451AA32BA010750();

  if(isint(_id_65E9C81367809607) && _id_65E9C81367809607 == 0)
    return 0;

  foreach(ent in self._id_9A4096E3A9B92412)
  ent _id_5D265B4FCA61F070::remove_vo_data(self);

  self._id_6727329A89208345 = self._id_7D2852D02216C876;
  self._id_7D2852D02216C876 = _id_65E9C81367809607;
  self._id_7D2852D02216C876._id_EC9F57E7698BAFFB = self.priority;
  self._id_9A4096E3A9B92412 = self._id_7D2852D02216C876 _id_5D265B4FCA61F070::_id_028E38EEFD3CC4AB();

  foreach(ent in self._id_9A4096E3A9B92412)
  ent _id_5D265B4FCA61F070::_id_797820CAD48747EF(self);
}

_id_8451AA32BA010750() {
  _id_AEB2E2CDC9405F3A = self._id_7D2852D02216C876 _id_D8C3C539BC71C7AF();

  if(isDefined(_id_AEB2E2CDC9405F3A))
    return _id_AEB2E2CDC9405F3A;

  return 0;
}

_id_BDE53006F0CC5D4E() {
  _id_AEB2E2CDC9405F3A = self._id_7D2852D02216C876 getclosestfriendlyspeaker();

  if(isDefined(_id_AEB2E2CDC9405F3A))
    return _id_AEB2E2CDC9405F3A;

  return 0;
}

_id_6BA4614B08327D38() {
  _id_AEB2E2CDC9405F3A = self._id_7D2852D02216C876 _id_6B500FAE7C3E61DA();

  if(isDefined(_id_AEB2E2CDC9405F3A))
    return _id_AEB2E2CDC9405F3A;

  return 0;
}

_id_78A4669238A942E8() {
  _id_00AE17C5A8B1BC1B = _id_D04239C1E5B61876();

  if(!isDefined(_id_00AE17C5A8B1BC1B))
    return getaiarray(self.team);

  _id_6FB4CCB6F62E8796 = [];

  foreach(guy in getaiarray(self.team)) {
    if(guy == self) {
      continue;
    }
    _id_2F410612188F54AB = guy _id_D04239C1E5B61876();

    if(isDefined(_id_2F410612188F54AB) && _id_2F410612188F54AB < _id_00AE17C5A8B1BC1B)
      _id_6FB4CCB6F62E8796[_id_6FB4CCB6F62E8796.size] = guy;
  }

  return _id_6FB4CCB6F62E8796;
}

_id_078BE0FAE168F6D5() {
  _id_00AE17C5A8B1BC1B = _id_D04239C1E5B61876();

  if(!isDefined(_id_00AE17C5A8B1BC1B))
    return getaiarray(self.team);

  _id_0C1719142D64CE43 = [];

  foreach(guy in getaiarray(self.team)) {
    if(guy == self) {
      continue;
    }
    _id_2F410612188F54AB = guy _id_D04239C1E5B61876();

    if(isDefined(_id_2F410612188F54AB) && _id_2F410612188F54AB > _id_00AE17C5A8B1BC1B)
      _id_0C1719142D64CE43[_id_0C1719142D64CE43.size] = guy;
  }

  return _id_0C1719142D64CE43;
}

_id_401EC0642C92D2EB() {
  return scripts\engine\utility::ter_op(self.team == "axis" || self.team == "team3", "allies", "bad_guys");
}

_id_06E80D82709FAEFD() {
  npcid = undefined;

  if(isDefined(self.battlechatter))
    npcid = self.battlechatter.npcid;

  _id_65E9C81367809607 = _id_248A7374A1A0605A(self.origin, _id_78A4669238A942E8(), npcid);

  if(!isDefined(_id_65E9C81367809607))
    _id_65E9C81367809607 = getclosestfriendlyspeaker(self.team);

  return _id_65E9C81367809607;
}

_id_A271B08319EA86AE() {
  npcid = undefined;

  if(isDefined(self.battlechatter))
    npcid = self.battlechatter.npcid;

  _id_65E9C81367809607 = _id_248A7374A1A0605A(self.origin, _id_078BE0FAE168F6D5(), npcid);

  if(!isDefined(_id_65E9C81367809607))
    _id_65E9C81367809607 = getclosestfriendlyspeaker(self.team);

  return _id_65E9C81367809607;
}

_id_6B500FAE7C3E61DA() {
  npcid = undefined;

  if(isDefined(self.battlechatter))
    npcid = self.battlechatter.npcid;

  _id_65E9C81367809607 = _id_B1AB02CFBFD12E43(_id_78A4669238A942E8(), npcid);

  if(!isDefined(_id_65E9C81367809607))
    _id_65E9C81367809607 = _id_D8C3C539BC71C7AF(self.team);

  return _id_65E9C81367809607;
}

_id_E5E9DB75FE72E36F() {
  npcid = undefined;

  if(isDefined(self.battlechatter))
    npcid = self.battlechatter.npcid;

  _id_65E9C81367809607 = _id_B1AB02CFBFD12E43(_id_078BE0FAE168F6D5(), npcid);

  if(!isDefined(_id_65E9C81367809607))
    _id_65E9C81367809607 = _id_D8C3C539BC71C7AF(self.team);

  return _id_65E9C81367809607;
}

getclosestfriendlyspeaker(team, _id_0F35FEAE42B2B331, _id_877945E6D268BA99, maxdist) {
  team = scripts\engine\utility::_id_53C4C53197386572(team, self.team);
  maxdist = scripts\engine\utility::_id_53C4C53197386572(maxdist, level._id_798AA343368F724E);

  if(!isDefined(team) || team == "dead") {
    return;
  }
  npcid = undefined;

  if(isDefined(self.battlechatter) && isDefined(self.battlechatter.npcid))
    npcid = self.battlechatter.npcid;

  return _id_248A7374A1A0605A(self.origin, _id_FD9E4CB348A5F283(self.origin, maxdist, team), npcid, _id_0F35FEAE42B2B331, _id_877945E6D268BA99);
}

_id_64BB0212D4B3E7FB(team, _id_0F35FEAE42B2B331, _id_877945E6D268BA99, maxdist) {
  if(!isDefined(self.enemy) || !isDefined(self.enemy.team)) {
    return;
  }
  team = scripts\engine\utility::_id_53C4C53197386572(team, self.enemy.team);
  maxdist = scripts\engine\utility::_id_53C4C53197386572(maxdist, level._id_798AA343368F724E);
  return _id_248A7374A1A0605A(self.origin, _id_FD9E4CB348A5F283(self.origin, maxdist, team), undefined, _id_0F35FEAE42B2B331, _id_877945E6D268BA99);
}

_id_D8C3C539BC71C7AF(team, _id_0F35FEAE42B2B331, _id_877945E6D268BA99, maxdist) {
  team = scripts\engine\utility::_id_53C4C53197386572(team, self.team);
  maxdist = scripts\engine\utility::_id_53C4C53197386572(maxdist, level._id_798AA343368F724E);
  npcid = undefined;

  if(isDefined(self.battlechatter))
    npcid = self.battlechatter.npcid;

  return _id_B1AB02CFBFD12E43(_id_FD9E4CB348A5F283(self.origin, maxdist, team), npcid, _id_0F35FEAE42B2B331, _id_877945E6D268BA99);
}

_id_08DB2AA6F0377958(team, _id_0F35FEAE42B2B331, _id_877945E6D268BA99, maxdist) {
  if(!isDefined(self.enemy) || !isDefined(self.enemy.team)) {
    return;
  }
  team = scripts\engine\utility::_id_53C4C53197386572(team, self.enemy.team);
  maxdist = scripts\engine\utility::_id_53C4C53197386572(maxdist, level._id_798AA343368F724E);
  return _id_B1AB02CFBFD12E43(_id_FD9E4CB348A5F283(self.origin, maxdist, team), undefined, _id_0F35FEAE42B2B331, _id_877945E6D268BA99);
}

_id_248A7374A1A0605A(origin, _id_76AD5066F013D2C9, _id_639EAECD84BDDC70, _id_0F35FEAE42B2B331, _id_877945E6D268BA99) {
  _id_8C93298E4787C0F5 = undefined;
  _id_A1533963D72D6C08 = undefined;
  _id_9B7F602C247C3953 = undefined;

  if(istrue(_id_877945E6D268BA99))
    _id_9B7F602C247C3953 = self;

  foreach(guy in _id_76AD5066F013D2C9) {
    if(issentient(self) && guy == self) {
      continue;
    }
    if(guy _id_5D265B4FCA61F070::_id_754C9897F3B89964() || !guy _id_D8462B621401984A(_id_0F35FEAE42B2B331, _id_9B7F602C247C3953) || scripts\engine\utility::is_equal(guy.battlechatter.npcid, _id_639EAECD84BDDC70)) {
      continue;
    }
    if(isDefined(guy.battlechatter) && istrue(guy.battlechatter._id_732DF8DB084AB0C5)) {
      continue;
    }
    distsq = distance2dsquared(guy.origin, origin);

    if(!isDefined(_id_8C93298E4787C0F5) || distsq < _id_8C93298E4787C0F5) {
      _id_8C93298E4787C0F5 = distsq;
      _id_A1533963D72D6C08 = guy;
    }
  }

  return _id_A1533963D72D6C08;
}

_id_B1AB02CFBFD12E43(_id_76AD5066F013D2C9, _id_639EAECD84BDDC70, _id_0F35FEAE42B2B331, _id_877945E6D268BA99) {
  _id_11345957EE7529A7 = undefined;
  _id_9B7F602C247C3953 = undefined;

  if(istrue(_id_877945E6D268BA99))
    _id_9B7F602C247C3953 = self;

  foreach(guy in _id_76AD5066F013D2C9) {
    if(issentient(self) && guy == self) {
      continue;
    }
    if(guy _id_5D265B4FCA61F070::_id_754C9897F3B89964() || !guy _id_D8462B621401984A(_id_0F35FEAE42B2B331, _id_9B7F602C247C3953)) {
      continue;
    }
    if(isDefined(guy.battlechatter) && scripts\engine\utility::is_equal(guy.battlechatter.npcid, _id_639EAECD84BDDC70)) {
      continue;
    }
    if(!isDefined(guy._id_E5CF232129F9EC01))
      return guy;

    if(!isDefined(_id_11345957EE7529A7) || guy._id_E5CF232129F9EC01 < _id_11345957EE7529A7._id_E5CF232129F9EC01)
      _id_11345957EE7529A7 = guy;
  }

  return _id_11345957EE7529A7;
}

getspeakers(team) {
  team = scripts\engine\utility::_id_53C4C53197386572(team, self.team);
  _id_76AD5066F013D2C9 = [];

  foreach(guy in getaiarray(team)) {
    if(guy _id_D8462B621401984A())
      _id_76AD5066F013D2C9[_id_76AD5066F013D2C9.size] = guy;
  }

  return _id_76AD5066F013D2C9;
}

_id_2AA175082BDB56F5(origin, radius) {
  if(scripts\common\utility::issp() && distancesquared(origin, level.player.origin) < squared(radius))
    return [level.player];

  if(isDefined(level._id_C3D9CEBA74248998))
    return [[level._id_C3D9CEBA74248998]](origin, radius);

  return [];
}

_id_FD9E4CB348A5F283(origin, radius, team) {
  if(isDefined(level._id_1DA0697A602F5A04))
    return [[level._id_1DA0697A602F5A04]](origin, radius, team);

  if(isDefined(team))
    return getaiarrayinradius(origin, radius, team);

  return getaiarrayinradius(origin, radius);
}

_id_E457176B043F3F8B(radius) {
  if(!isDefined(self.enemy) || !isDefined(self.enemy.origin) || !isDefined(self.enemy.team))
    return [];

  radius = scripts\engine\utility::_id_53C4C53197386572(radius, level._id_587DE0E7B537210A);
  enemies = _id_FD9E4CB348A5F283(self.enemy.origin, radius, self.enemy.team);

  if(isDefined(self.team) && self.team != "allies" && self.team != "neutral") {
    players = _id_2AA175082BDB56F5(self.enemy.origin, radius);
    enemies = scripts\engine\utility::array_combine(enemies, players);
  }

  return enemies;
}

_id_A9328A64687886FB(target, radius) {
  return distancesquared(target.origin, self.origin) < squared(radius);
}

_id_CD250B4591E6BC01(_id_595B006B359C3DDE, _id_3AB040F5CFCEFBBB) {
  if(isDefined(self.voice) && issubstr(self.voice, "female"))
    return _id_3AB040F5CFCEFBBB;

  return _id_595B006B359C3DDE;
}

_id_1609EF297B7A32CF(enemy, _id_646A5CD9726E8B01, _id_8B254BBEF9B6B110, enemies) {
  if(isDefined(self.battlechatter) && scripts\engine\utility::is_equal(enemy, self.battlechatter.target))
    return _id_646A5CD9726E8B01;

  if(!scripts\common\utility::ismp() && !isDefined(enemies))
    enemies = _id_E457176B043F3F8B();

  if(!scripts\common\utility::ismp() && enemies.size > 1)
    return _id_8B254BBEF9B6B110;

  return _id_646A5CD9726E8B01;
}

_id_D4148681450730E1(target) {
  guy = self;

  if(istrue(self._id_79498ADF23C51E6A))
    guy = self._id_7D2852D02216C876;

  target = scripts\engine\utility::_id_53C4C53197386572(target, guy.enemy);
  guy _id_011BCC851AFAF707(target);
}

_id_3D42F01CB9BC4DBE() {
  _id_011BCC851AFAF707(undefined);
}

_id_011BCC851AFAF707(target) {
  if(isDefined(self.origin) && isDefined(self.team)) {
    foreach(ally in _id_FD9E4CB348A5F283(self.origin, level._id_587DE0E7B537210A, self.team)) {
      if(isDefined(ally.battlechatter))
        ally.battlechatter.target = target;
    }
  } else if(isDefined(self.battlechatter))
    self.battlechatter.target = target;
}

_id_2E5E8E46D56CE70D(array) {
  return array[randomint(array.size)];
}

_id_995427FD22BD4928(base, count) {
  if(!isDefined(level.battlechatter._id_AE16228B86A3F433[base])) {
    array = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++)
      array[_id_AC0E594AC96AA3A8] = base + _id_AC0E594AC96AA3A8;

    level.battlechatter._id_AE16228B86A3F433[base] = scripts\engine\utility::create_deck(array, 1, 1, 1);
  }

  return level.battlechatter._id_AE16228B86A3F433[base] scripts\engine\utility::deck_draw();
}

_id_D04239C1E5B61876() {
  if(!isDefined(self.airank))
    return undefined;

  switch (self.airank) {
    case "private":
      return 0;
    case "sergeant":
      return 1;
    case "lieutenant":
      return 2;
    case "captain":
      return 3;
    case "major":
      return 4;
    case "colonel":
      return 5;
    case "general":
      return 6;
    default:
      return undefined;
  }
}

_id_B6B75579E4DBC957() {
  if(!isDefined(level.battlechatter._id_38D1DE6D4017E745)) {
    _id_38D1DE6D4017E745 = [];

    foreach(ai in getaiarray()) {
      if(isDefined(ai.callsign))
        _id_38D1DE6D4017E745[_id_38D1DE6D4017E745.size] = ai.callsign;
    }

    if(_id_38D1DE6D4017E745.size > 0)
      level.battlechatter._id_38D1DE6D4017E745 = scripts\engine\utility::create_deck(_id_38D1DE6D4017E745);
  }

  if(isDefined(level.battlechatter._id_38D1DE6D4017E745))
    self.callsign = level.battlechatter._id_38D1DE6D4017E745 scripts\engine\utility::deck_draw();
}

addeventplaybcs(type, name, modifier, delay, _id_623F50CE1F43FDB8, _id_F8048727716242B0) {
  self endon("death");
  self endon("removed from battleChatter");
  self endon("cancel speaking");
  self endon("stop event play bcs");

  if(!isDefined(modifier)) {
    return;
  }
  if(isDefined(delay))
    wait(delay);

  if(name == "state_change")
    executed = _id_C0DA17570A24346C(modifier);
  else
    executed = _id_C0DA17570A24346C("announce", [modifier, _id_623F50CE1F43FDB8]);
}

_id_2A14E530337DEDC3() {
  radio = self._id_7D2852D02216C876 _id_5D265B4FCA61F070::_id_52846CD9B5EFEAFE();
  radio.battlechatter.npcid = "l1r";
  radio.name = "Team Leader (Radio)";
  return radio;
}

_id_573B9FF9ED152518(guy, _id_F9D07E5FA610B560) {
  if(!isDefined(guy))
    guy = self._id_7D2852D02216C876;

  if(!isDefined(guy.voice) || !isDefined(guy.battlechatter)) {
    return;
  }
  radio = spawnStruct();
  radio._id_868E98CF48B92CFB = guy;
  radio._id_ED56B39B72558E56 = 1;
  radio.battlechatterallowed = 1;
  radio.team = scripts\engine\utility::_id_53C4C53197386572(self.team, "allies");
  radio.battlechatter = spawnStruct();

  if(!isDefined(guy.battlechatter.countryid))
    guy.battlechatter.countryid = "AQS";

  if(istrue(_id_F9D07E5FA610B560)) {
    radio.battlechatter._id_F9D07E5FA610B560 = 1;
    radio.battlechatter._id_37962CA7989C729A = guy.battlechatter.countryid + "_L";
    radio.battlechatter.name = "actual";

    switch (guy.battlechatter.countryid) {
      case "PMC":
        _id_C9A4D98959C0D476 = ["pmcl"];
        break;
      case "CTM":
        _id_C9A4D98959C0D476 = ["crtl"];
        break;
      case "CFS":
        _id_C9A4D98959C0D476 = ["kgfl"];
        break;
      case "AQS":
      default:
        _id_C9A4D98959C0D476 = ["aqld"];
    }
  } else {
    _id_C9A4D98959C0D476 = [];

    foreach(_id_CF9DFCA32AF33B39 in anim.usedids[guy.voice]) {
      if(!scripts\engine\utility::is_equal(_id_CF9DFCA32AF33B39.npcid, guy.battlechatter.npcid))
        _id_C9A4D98959C0D476[_id_C9A4D98959C0D476.size] = _id_CF9DFCA32AF33B39.npcid;
    }
  }

  radio.battlechatter.countryid = guy.battlechatter.countryid;
  radio.battlechatter.npcid = scripts\engine\utility::random(_id_C9A4D98959C0D476);
  return radio;
}

_id_592F13F1A0E078FF(guy) {
  return _id_573B9FF9ED152518(guy, 1);
}

getname() {
  if(!isDefined(self.battlechatter) || !isDefined(self.battlechatter.countryid)) {
    return;
  }
  if(!isDefined(self.battlechatter.name)) {
    if(!isDefined(level.battlechatter.names[self.battlechatter.countryid])) {
      _id_00433D8F78F7E5FB::_id_793F0C4DA1FF138F(self.battlechatter.countryid);

      if(!isDefined(level.battlechatter.names[self.battlechatter.countryid]))
        return;
    }

    self.battlechatter.name = level.battlechatter.names[self.battlechatter.countryid] scripts\engine\utility::deck_draw();
  }

  return self.battlechatter.name;
}

_id_47C84E03DCBC5AA7(origin) {
  if(!isDefined(level.players))
    return level.player;
  else if(level.players.size == 0)
    return undefined;

  return sortbydistance(level.players, origin)[0];
}

_id_B98B7A9053D0BCB6(origin) {
  if(!isDefined(origin))
    origin = self.origin;

  _id_06706C5ED8796CA5 = getEntArray("bcs_region", "script_noteworthy");

  foreach(trig in _id_06706C5ED8796CA5) {
    if(ispointinvolume(origin, trig) && isDefined(trig.targetname))
      return trig.targetname;
  }

  return "none";
}

_id_16DCE705F14F4B84() {
  if(scripts\engine\utility::is_dead_or_dying(self))
    return "dead";

  if(isDefined(self.battlechatter._id_B7F16AC1D260657A)) {
    result = self.battlechatter._id_B7F16AC1D260657A;

    if(isfunction(result))
      result = self[[result]]();

    if(isDefined(result))
      return result;
  }

  if(!isDefined(level.stealth))
    return scripts\engine\utility::ter_op(isai(self) && self iscurrentenemyvalid(), "combat", "idle");

  if(isDefined(self.fnisinstealthidle) && [[self.fnisinstealthidle]]())
    return "idle";
  else if(isDefined(self.fnisinstealthinvestigate) && [[self.fnisinstealthinvestigate]]())
    return "investigate";
  else if(isDefined(self.fnisinstealthhunt) && [[self.fnisinstealthhunt]]())
    return "hunt";
  else
    return "combat";
}

addcustombc(array, states, random) {}

setcurrentcustombcevent(event, states, _id_1208CA5973245D19) {}

_id_5EEF3C6F7B003167(state) {
  if(!isDefined(level.battlechatter._id_6D0A11E2E9933FF1) || !isDefined(level.battlechatter._id_6D0A11E2E9933FF1[state]))
    return 0;

  return level.battlechatter._id_6D0A11E2E9933FF1[state].size > 0;
}

_id_37569A0BDDD31694(state) {
  index = level.battlechatter._id_6FE645021A23C52F[state];
  _id_927B3199642B75FC = level.battlechatter._id_6D0A11E2E9933FF1[state][index];
  index++;

  if(index >= level.battlechatter._id_6D0A11E2E9933FF1[state].size)
    level.battlechatter._id_6D0A11E2E9933FF1[state] = [];

  return _id_927B3199642B75FC;
}

_id_AC31838F9EDDE417(array, states, random) {
  if(!isDefined(level.battlechatter._id_6D0A11E2E9933FF1))
    level.battlechatter._id_6D0A11E2E9933FF1 = [];

  if(!isarray(states))
    states = [states];

  foreach(state in states) {
    if(!isDefined(level.battlechatter._id_6D0A11E2E9933FF1[state]))
      level.battlechatter._id_6D0A11E2E9933FF1[state] = [];

    foreach(_id_927B3199642B75FC in array) {
      _id_A61C75B156FC1EE0 = level.battlechatter._id_6D0A11E2E9933FF1[state].size;
      level.battlechatter._id_6D0A11E2E9933FF1[state][_id_A61C75B156FC1EE0] = _id_927B3199642B75FC;
    }
  }
}

getrelativeangles(ent) {
  angles = ent.angles;

  if(!isPlayer(ent)) {
    if(isDefined(self.node))
      angles = self.node.angles;
  }

  return angles;
}

sideisleftright(_id_A66BA9B157533F5A) {
  return _id_A66BA9B157533F5A == "left" || _id_A66BA9B157533F5A == "right";
}

getdirectionfacingflank(_id_A9F94D266B961E6F, vpoint, _id_B157227579E704EF) {
  _id_7004BA7D94D78DF6 = vectortoangles(_id_B157227579E704EF);
  _id_87617967D6BB7D22 = vectortoangles(vpoint - _id_A9F94D266B961E6F);
  angle = _id_7004BA7D94D78DF6[1] - _id_87617967D6BB7D22[1];
  angle = angle + 360;
  angle = int(angle) % 360;

  if(angle > 315 || angle < 45)
    direction = "front";
  else if(angle < 135)
    direction = "right";
  else if(angle < 225)
    direction = "rear";
  else
    direction = "left";

  return direction;
}

normalizecompassdirection(direction) {
  new = undefined;

  switch (direction) {
    case "north":
      new = "n";
      break;
    case "northwest":
      new = "nw";
      break;
    case "west":
      new = "w";
      break;
    case "southwest":
      new = "sw";
      break;
    case "south":
      new = "s";
      break;
    case "southeast":
      new = "se";
      break;
    case "east":
      new = "e";
      break;
    case "northeast":
      new = "ne";
      break;
    case "impossible":
      new = "impossible";
      break;
    default:
      return;
  }

  return new;
}

getdirectioncompass(_id_A9F94D266B961E6F, vpoint) {
  angles = vectortoangles(vpoint - _id_A9F94D266B961E6F);
  angle = angles[1];
  northyaw = getnorthyaw();
  angle = angle - northyaw;

  if(angle < 0)
    angle = angle + 360;
  else if(angle > 360)
    angle = angle - 360;

  if(angle < 22.5 || angle > 337.5)
    direction = "north";
  else if(angle < 67.5)
    direction = "northwest";
  else if(angle < 112.5)
    direction = "west";
  else if(angle < 157.5)
    direction = "southwest";
  else if(angle < 202.5)
    direction = "south";
  else if(angle < 247.5)
    direction = "southeast";
  else if(angle < 292.5)
    direction = "east";
  else if(angle < 337.5)
    direction = "northeast";
  else
    direction = "impossible";

  return direction;
}

getdistancemeters(source, target) {
  _id_E48200809888835A = distance2d(source, target);
  _id_344457E8C065948C = 0.0254 * _id_E48200809888835A;
  return _id_344457E8C065948C;
}

getdistancemetersnormalized(source, target) {
  _id_344457E8C065948C = getdistancemeters(source, target);

  if(_id_344457E8C065948C < 15.0)
    return "10";
  else if(_id_344457E8C065948C < 25.0)
    return "20";
  else if(_id_344457E8C065948C < 35.0)
    return "30";
  else if(_id_344457E8C065948C < 45.0)
    return "40";
  else if(_id_344457E8C065948C < 55.0)
    return "50";
  else if(_id_344457E8C065948C < 65.0)
    return "60";
  else if(_id_344457E8C065948C < 75.0)
    return "70";
  else if(_id_344457E8C065948C < 85.0)
    return "80";
  else if(_id_344457E8C065948C < 95.0)
    return "90";
  else if(_id_344457E8C065948C < 125.0)
    return "100";
  else
    return undefined;
}

getdistancemiles(source, target) {
  _id_E48200809888835A = distance2d(source, target);
  _id_59901E5F803747F0 = 0.0000157828 * _id_E48200809888835A;
  return _id_59901E5F803747F0;
}

getdistancemilesnormalized(source, target) {
  _id_59901E5F803747F0 = getdistancemiles(source, target);

  if(_id_59901E5F803747F0 < 5.0)
    return "4";
  else if(_id_59901E5F803747F0 < 6.0)
    return "5";
  else if(_id_59901E5F803747F0 < 7.0)
    return "6";
  else if(_id_59901E5F803747F0 < 15.0)
    return "10";
  else
    return "15";
}

getfrontarcclockdirection(direction) {
  _id_83840EC99C2D6F0D = "undefined";

  if(direction == "10" || direction == "11")
    _id_83840EC99C2D6F0D = "10";
  else if(direction == "12")
    _id_83840EC99C2D6F0D = direction;
  else if(direction == "1" || direction == "2")
    _id_83840EC99C2D6F0D = "2";

  return _id_83840EC99C2D6F0D;
}

getdirectionfacingclock(_id_C99A285CABF7EC7B, _id_88DAF353E30ACF25, targetorigin) {
  forward = anglesToForward(_id_C99A285CABF7EC7B);
  _id_B157227579E704EF = vectorNormalize(forward);
  _id_7004BA7D94D78DF6 = vectortoangles(_id_B157227579E704EF);
  _id_87617967D6BB7D22 = vectortoangles(targetorigin - _id_88DAF353E30ACF25);
  angle = _id_7004BA7D94D78DF6[1] - _id_87617967D6BB7D22[1];
  angle = angle + 360;
  angle = int(angle) % 360;

  if(angle > 345 || angle < 15)
    direction = "12";
  else if(angle < 45)
    direction = "1";
  else if(angle < 75)
    direction = "2";
  else if(angle < 105)
    direction = "3";
  else if(angle < 135)
    direction = "4";
  else if(angle < 165)
    direction = "5";
  else if(angle < 195)
    direction = "6";
  else if(angle < 225)
    direction = "7";
  else if(angle < 255)
    direction = "8";
  else if(angle < 285)
    direction = "9";
  else if(angle < 315)
    direction = "10";
  else
    direction = "11";

  return direction;
}

getdegreeselevation(_id_88DAF353E30ACF25, targetorigin) {
  _id_CE364178F58A5FDD = targetorigin[2] - _id_88DAF353E30ACF25[2];
  dist = distance2d(_id_88DAF353E30ACF25, targetorigin);
  angle = atan(_id_CE364178F58A5FDD / dist);

  if(angle < 15 || angle > 65)
    return angle;
  else if(angle < 25)
    return 20;
  else if(angle < 35)
    return 30;
  else if(angle < 45)
    return 40;
  else if(angle < 55)
    return 50;
  else if(angle < 65)
    return 60;
}

getvectorrightangle(vdir) {
  return (vdir[1], 0 - vdir[0], vdir[2]);
}

getvectorarrayaverage(_id_52BC30AD1E795FD6) {
  _id_3BA2A35D76E9B9E0 = (0, 0, 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_52BC30AD1E795FD6.size; _id_AC0E594AC96AA3A8++)
    _id_3BA2A35D76E9B9E0 = _id_3BA2A35D76E9B9E0 + _id_52BC30AD1E795FD6[_id_AC0E594AC96AA3A8];

  return (_id_3BA2A35D76E9B9E0[0] / _id_52BC30AD1E795FD6.size, _id_3BA2A35D76E9B9E0[1] / _id_52BC30AD1E795FD6.size, _id_3BA2A35D76E9B9E0[2] / _id_52BC30AD1E795FD6.size);
}

_id_A07ABD440B7A33FE(_id_AE9ACDDA1C693FA6) {
  if(!isDefined(_id_AE9ACDDA1C693FA6))
    return 0;

  if(!istrue(_id_AE9ACDDA1C693FA6.disguised))
    return 0;

  return 1;
}

_id_F0538EA9A819B123(_id_1F7FD473E2E3E8AA) {}

set_battlechatter_variable(team, val) {
  level.battlechatter[team] = val;
  update_battlechatter_hud();
}

update_battlechatter_hud() {}

bcprint_info() {
  self endon("death");
}

battlechatter_canprint() {
  return 0;
}

battlechatter_canprintdump() {
  return 0;
}

battlechatter_print(alias, color) {}

battlechatter_printdump(alias) {}

battlechatter_debugprint(alias, color) {}

battlechatter_printdumpline(_id_65DC0399D91B7F97, str, _id_ED4FB4807F13F624) {}

getaliastypefromsoundalias(alias) {
  if(getsubstr(alias, 0, 6) == "dx_vom")
    _id_803610FF4054C7EB = getsubstr(alias, 7, alias.size);
  else {
    if(self == anim.player)
      _id_DEC9BCCE93873125 = self.battlechatter.countryid + "_";
    else if(getsubstr(alias, 0, 6) == "dx_sbc")
      _id_DEC9BCCE93873125 = bc_prefix("stealth");
    else
      _id_DEC9BCCE93873125 = bc_prefix();

    _id_803610FF4054C7EB = getsubstr(alias, _id_DEC9BCCE93873125.size, alias.size);
  }

  return _id_803610FF4054C7EB;
}

_id_2B9BF190120A5233(_id_CC748B6D457627FE) {
  if(isDefined(self.battlechatter))
    self.battlechatter._id_3C94D4874D436201 = gettime() + _id_CC748B6D457627FE * 1000;
}

_id_8F59CAA9212FCC56() {
  if(!_id_D8462B621401984A("combat"))
    return 1;

  if(scripts\common\utility::issp() && !isalive(level.player))
    return 1;

  if(!_id_45F570789FF9A0FD(3)) {
    if(isDefined(self.battlechatter._id_020E68057B05A543) || !isDefined(self._blackboard))
      return 1;

    if(!_id_9F810AAE92AC7BF1(3))
      self.battlechatter._id_020E68057B05A543 = gettime();

    return 1;
  }

  if(!isDefined(self.battlechatter._id_3C94D4874D436201))
    return 0;

  return self.battlechatter._id_3C94D4874D436201 > gettime();
}

_id_45F570789FF9A0FD(time, _id_877945E6D268BA99) {
  _id_877945E6D268BA99 = scripts\engine\utility::_id_53C4C53197386572(_id_877945E6D268BA99, 0);

  if(istrue(self.pacifist) || istrue(self.ignoreall) || istrue(self.dontevershoot))
    return 0;

  if(!isDefined(self.enemy) || scripts\engine\utility::is_dead_or_dying(self.enemy))
    return 0;

  if(!scripts\common\utility::ismp() && _id_877945E6D268BA99 && !self seerecently(self.enemy, time))
    return 0;

  if(isDefined(self._id_A709FBD9FEA148F6) && scripts\asm\asm::asm_currentstatehasflag(self._id_A709FBD9FEA148F6, "aim"))
    return 1;

  if(_id_9F810AAE92AC7BF1(time))
    return 1;

  return 0;
}

_id_9F810AAE92AC7BF1(time) {
  return self._blackboard._id_060DCAA3D3BE97AB > gettime() - time * 1000;
}

_id_AB7DF904AA60D433(array, _id_20F2244C14CD5D6C) {
  _id_20F2244C14CD5D6C = scripts\engine\utility::_id_53C4C53197386572(_id_20F2244C14CD5D6C, array.size - 1);

  foreach(key, item in array) {
    if(array.size <= _id_20F2244C14CD5D6C)
      return array;

    array[key] = undefined;
  }
}