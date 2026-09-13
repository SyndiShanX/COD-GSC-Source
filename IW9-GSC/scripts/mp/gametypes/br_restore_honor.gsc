/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_restore_honor.gsc
*****************************************************/

main() {
  thread _id_DEEE3B97BF9C0945();
}

_id_DEEE3B97BF9C0945() {
  waitframe();

  if(!scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
    return;
  }
  init();
}

init() {
  if(!getdvarint("dvar_1AB9AA4653578A35", 0)) {
    return;
  }
  if(!isDefined(level._id_547167A7517600FB)) {
    level._id_2D15C14A954FF12F = 1;
    level._id_547167A7517600FB = spawnStruct();
    level._id_547167A7517600FB._id_24965A7089C6B47A = getdvarint("dvar_2C8635F347EA972D", 1);
    level._id_547167A7517600FB._id_979579D51694236F = getdvarint("dvar_A4C7037D860F5BBE", -1);
    level._id_547167A7517600FB._id_3FE43CDCBBA60AF2 = level._id_547167A7517600FB._id_24965A7089C6B47A < 0 || level._id_547167A7517600FB._id_979579D51694236F < 0;
    level._id_547167A7517600FB._id_D16D58B66481C4FA = getdvarint("dvar_BFC514885DFAF54C", 1);
    level._id_547167A7517600FB._id_B8DEACFFE796AA73 = getdvarint("dvar_DC16BB276A55C9D2", 0);
    level._id_547167A7517600FB._id_723B8F7CB71CEB11 = getdvarint("dvar_4B591F969E031959", 100);
    level._id_547167A7517600FB._id_9F47268324F609B3 = getdvarint("dvar_987A35850DF3F8F5", 300);
    level._id_547167A7517600FB._id_A5354AFEB0D5DFCC = ::_id_BA3878714EF393C0;
    level._id_547167A7517600FB._id_5B72B9E0891944AE = ::_id_AFED796D371945AA;
    level._id_547167A7517600FB._id_770C1AF7032592A5 = ::_id_875B34323268FF76;
    level._id_547167A7517600FB._id_87206CFBD04971FA = ::_id_CC2205717CEE9F9E;
    level._id_547167A7517600FB._id_E393BF4026D0C393 = ::_id_DDCB9338C5CD1D29;
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerrespawn);
    level._id_547167A7517600FB._id_CD5114896D171E9E = [];
    level._id_547167A7517600FB._id_41B267143C79F8B2 = [];
    level._id_547167A7517600FB._id_33F442F7770C83DC = [];
    level._id_547167A7517600FB._id_F7D29CEF55A5FB26 = "splash_list_br_restore_honor";
  }

  _id_876794C543D6E89D();
}

_id_876794C543D6E89D() {
  game["dialog"]["restorehonor_marking_tag"] = "rshn_wzan_rhnd";
  game["dialog"]["restorehonor_honor_restored"] = "rshn_wzan_rhns";
  game["dialog"]["restorehonor_teammate_honor_restored"] = "rshn_wzan_rhnq";
  game["dialog"]["restorehonor_dishonorable_death"] = "rshn_wzan_rhnr";
}

_id_BA3878714EF393C0(player) {
  if(!scripts\engine\utility::array_contains(level._id_547167A7517600FB._id_CD5114896D171E9E, player.guid)) {
    level._id_547167A7517600FB._id_CD5114896D171E9E = scripts\engine\utility::array_add(level._id_547167A7517600FB._id_CD5114896D171E9E, player.guid);

    if(istrue(player.isdisconnecting)) {
      return;
    }
    if(player _id_6DCE1B0C83D90047() && !player _id_5F0F11B66142DFBC())
      _id_3261A382FF970350("restorehonor_marking_tag", player);
  }
}

_id_AFED796D371945AA(player) {
  _id_2391409EF7B431E1::_id_BC03AA369196F2BF(player, 1);

  if(!scripts\engine\utility::array_contains(level._id_547167A7517600FB._id_CD5114896D171E9E, player.guid)) {
    return;
  }
  level._id_547167A7517600FB._id_CD5114896D171E9E = scripts\engine\utility::array_remove(level._id_547167A7517600FB._id_CD5114896D171E9E, player.guid);

  if(!player _id_6DCE1B0C83D90047()) {
    return;
  }
  if(player _id_5F0F11B66142DFBC()) {
    _id_3261A382FF970350("restorehonor_dishonorable_death", player);
    return;
  }

  _id_D98CB07229C10406 = 0;

  if(player _id_1F4D5F709093B02A()) {
    if(_id_642C5544C38837A2::_id_8192E9B94C7BE3A6(player))
      triggerportableradarping(player.origin, player, level._id_547167A7517600FB._id_9F47268324F609B3);
    else
      _id_D98CB07229C10406 = 1;
  }

  if(player _id_C0330582D11E0B81())
    player _id_6AFF3948CF4CCA03::playerplunderpickup(level._id_547167A7517600FB._id_723B8F7CB71CEB11, undefined, 0);

  if(!_id_D98CB07229C10406 || player _id_C0330582D11E0B81()) {
    if(isDefined(level._id_547167A7517600FB._id_41B267143C79F8B2[player.guid])) {
      level._id_547167A7517600FB._id_41B267143C79F8B2[player.guid]++;
      player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_A8D070D3D7D57E25");
    } else {
      level._id_547167A7517600FB._id_41B267143C79F8B2[player.guid] = 1;
      player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_8A52DCB80A0C251B");
    }

    player thread scripts\mp\hud_message::showsplash("br_restore_honor_success", undefined, undefined, undefined, undefined, level._id_547167A7517600FB._id_F7D29CEF55A5FB26);
  } else
    player thread scripts\mp\hud_message::showsplash("br_restore_honor_scan_failed", undefined, undefined, undefined, undefined, level._id_547167A7517600FB._id_F7D29CEF55A5FB26);

  _id_3261A382FF970350("restorehonor_honor_restored", player);
  player thread _id_0F6BEAD4ABF12F30();
}

_id_875B34323268FF76(player, _id_36602E2A0BA207A2) {
  _id_203465FE295E0E78 = isDefined(_id_36602E2A0BA207A2) && isPlayer(_id_36602E2A0BA207A2);

  if(_id_203465FE295E0E78)
    _id_2391409EF7B431E1::_id_BC03AA369196F2BF(_id_36602E2A0BA207A2, 1);

  if(_id_203465FE295E0E78 && !scripts\engine\utility::array_contains(level._id_547167A7517600FB._id_CD5114896D171E9E, _id_36602E2A0BA207A2.guid)) {
    return;
  }
  level._id_547167A7517600FB._id_CD5114896D171E9E = scripts\engine\utility::array_remove(level._id_547167A7517600FB._id_CD5114896D171E9E, player.guid);

  if(!player _id_6DCE1B0C83D90047()) {
    return;
  }
  if(_id_203465FE295E0E78 && _id_36602E2A0BA207A2 _id_5F0F11B66142DFBC()) {
    _id_3261A382FF970350("restorehonor_dishonorable_death", _id_36602E2A0BA207A2);
    return;
  }

  if(level._id_547167A7517600FB._id_D16D58B66481C4FA) {
    _id_D98CB07229C10406 = 0;

    if(player _id_1F4D5F709093B02A()) {
      if(_id_642C5544C38837A2::_id_8192E9B94C7BE3A6(player))
        triggerportableradarping(player.origin, player, level._id_547167A7517600FB._id_9F47268324F609B3);
      else
        _id_D98CB07229C10406 = 1;
    }

    if(player _id_C0330582D11E0B81())
      player _id_6AFF3948CF4CCA03::playerplunderpickup(level._id_547167A7517600FB._id_723B8F7CB71CEB11, undefined, 0);

    if(!_id_D98CB07229C10406 || player _id_C0330582D11E0B81()) {
      if(isDefined(level._id_547167A7517600FB._id_41B267143C79F8B2[player.guid])) {
        level._id_547167A7517600FB._id_41B267143C79F8B2[player.guid]++;
        player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_C082C1DA9C6227A7");
      } else {
        level._id_547167A7517600FB._id_41B267143C79F8B2[player.guid] = 1;
        player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5CDE41B829FAB1C5");
      }

      player thread scripts\mp\hud_message::showsplash("br_restore_honor_teammate", undefined, undefined, undefined, undefined, level._id_547167A7517600FB._id_F7D29CEF55A5FB26);
    } else
      player thread scripts\mp\hud_message::showsplash("br_restore_honor_failed_teammate", undefined, undefined, undefined, undefined, level._id_547167A7517600FB._id_F7D29CEF55A5FB26);

    _id_3261A382FF970350("restorehonor_honor_restored", player);
    player thread _id_0F6BEAD4ABF12F30();

    if(_id_203465FE295E0E78) {
      _id_3261A382FF970350("restorehonor_teammate_honor_restored", _id_36602E2A0BA207A2);
      _id_36602E2A0BA207A2 thread _id_0F6BEAD4ABF12F30();
    }
  }
}

_id_CC2205717CEE9F9E(enemy, owner) {
  _id_203465FE295E0E78 = isDefined(owner) && isPlayer(owner);

  if(_id_203465FE295E0E78) {
    _id_2391409EF7B431E1::_id_BC03AA369196F2BF(owner, 1);

    if(scripts\engine\utility::array_contains(level._id_547167A7517600FB._id_CD5114896D171E9E, owner.guid))
      level._id_547167A7517600FB._id_CD5114896D171E9E = scripts\engine\utility::array_remove(level._id_547167A7517600FB._id_CD5114896D171E9E, owner.guid);
  }

  enemy scripts\mp\utility\points::_id_0366980B6A8796AE("stat_C164717864E640FF");

  if(level._id_547167A7517600FB._id_B8DEACFFE796AA73 > 0) {
    quantity = level._id_547167A7517600FB._id_B8DEACFFE796AA73;
    _id_3466C10973E9C476 = _id_6AFF3948CF4CCA03::getplundernamebyamount(quantity);
    _id_60227BFF1E9478CC = spawnStruct();
    _id_60227BFF1E9478CC.scriptablename = _id_3466C10973E9C476;
    _id_60227BFF1E9478CC._id_8598D3D3BC3D9CEB = 1;
    _id_60227BFF1E9478CC.count = quantity;
    _id_60227BFF1E9478CC.origin = enemy.origin;
    enemy _id_7E52B56769FA7774::_id_EFDDDF60C5DB058C(_id_60227BFF1E9478CC);
    enemy _id_6AFF3948CF4CCA03::playerplunderpickup(quantity, undefined, 1, 1);
    enemy scripts\cp_mp\challenges::onpickupitem("plunder");
  }
}

_id_6DCE1B0C83D90047() {
  if(level._id_547167A7517600FB._id_3FE43CDCBBA60AF2 || !isDefined(level._id_547167A7517600FB._id_41B267143C79F8B2[self.guid]))
    return 1;

  return level._id_547167A7517600FB._id_41B267143C79F8B2[self.guid] < level._id_547167A7517600FB._id_24965A7089C6B47A || level._id_547167A7517600FB._id_41B267143C79F8B2[self.guid] < level._id_547167A7517600FB._id_979579D51694236F;
}

_id_C0330582D11E0B81() {
  if(level._id_547167A7517600FB._id_24965A7089C6B47A == 0)
    return 0;
  else if(level._id_547167A7517600FB._id_24965A7089C6B47A < 0 || !isDefined(level._id_547167A7517600FB._id_41B267143C79F8B2[self.guid]))
    return 1;

  return level._id_547167A7517600FB._id_41B267143C79F8B2[self.guid] < level._id_547167A7517600FB._id_24965A7089C6B47A;
}

_id_1F4D5F709093B02A() {
  if(level._id_547167A7517600FB._id_979579D51694236F == 0)
    return 0;
  else if(level._id_547167A7517600FB._id_979579D51694236F < 0 || !isDefined(level._id_547167A7517600FB._id_41B267143C79F8B2[self.guid]))
    return 1;

  return level._id_547167A7517600FB._id_41B267143C79F8B2[self.guid] < level._id_547167A7517600FB._id_979579D51694236F;
}

_id_5F0F11B66142DFBC() {
  if(isDefined(level._id_547167A7517600FB._id_33F442F7770C83DC[self.guid]) && isDefined(self.team)) {
    foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
      if(player.guid == level._id_547167A7517600FB._id_33F442F7770C83DC[self.guid])
        return 1;
    }

    return 0;
  } else
    return 0;
}

_id_DDCB9338C5CD1D29(player, attacker) {
  if(!isDefined(player) || !isDefined(attacker)) {
    return;
  }
  if(player == attacker || !isPlayer(attacker) && !isagent(attacker)) {
    if(isDefined(player.laststanddowneddata) && (!isDefined(player.laststanddowneddata.attacker) || isagent(player.laststanddowneddata.attacker)))
      level._id_547167A7517600FB._id_33F442F7770C83DC[player.guid] = undefined;
    else
      level._id_547167A7517600FB._id_33F442F7770C83DC[player.guid] = player.guid;
  } else
    level._id_547167A7517600FB._id_33F442F7770C83DC[player.guid] = attacker.guid;
}

onplayerrespawn() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(isDefined(self)) {
    if(scripts\engine\utility::array_contains(level._id_547167A7517600FB._id_CD5114896D171E9E, self.guid) && !_id_5F0F11B66142DFBC()) {
      wait 2;
      _id_21C19CFC7139D773::_id_1976438A8865AC27("br_ftue_restore_honor");
    }
  }
}

_id_0F6BEAD4ABF12F30() {
  scripts\cp_mp\challenges::_id_8359CADD253F9604(self, "restore_honor_complete", 1);
}

_id_3261A382FF970350(dialog, player) {
  _id_668B93C688B30136 = game["dialog"][dialog];
  _id_2CEDCC356F1B9FC8::brleaderdialogplayer(dialog, player, 0, 1, undefined, undefined, "dx_br_seal_");
}