/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_404f1aef8aea990.gsc
***********************************************/

init() {
  if(!scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    return;
  }
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_server_exit_level", ::_id_69DDF7A3E512A18A);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_on_player_disconnect", ::on_player_disconnect);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_on_player_spawned", ::_id_061A6648C0A01CAD);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_update_weapon_stats", ::_id_6A347A3138EC63E1);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_prematch_over", ::_id_37F53CF222F43271);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_on_bot_set_difficulty", ::_id_488BFC3E01722743);
}

_id_69DDF7A3E512A18A() {
  foreach(player in level.players) {
    data = spawnStruct();
    data.player = player;
    data.player.pers["telemetry"]._id_7FF2028C00F8827D = 1;
    _id_CE976EE0200475A2(data);
  }
}

_id_CE976EE0200475A2(data) {
  player = data.player;

  if(!isDefined(player.pers["telemetry"]._id_C804FA67733B8EF5)) {
    if(!_id_4A6760982B403BAD::_id_0892570944F6B6A2(player)) {
      return;
    }
    if(istrue(player._id_06A91D0E80CC504E) && !istrue(level.gameended)) {
      return;
    }
    _id_E6D7DE89AE05A160 = -1;
    _id_DCFE556F7026A6FD = 0;

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      if(isDefined(player.pers["br_place"]))
        _id_E6D7DE89AE05A160 = player.pers["br_place"];

      if(!isDefined(player.pers["br_survival_time"]) && isDefined(level.starttime)) {
        gameendtime = level.gameendtime;

        if(!isDefined(gameendtime))
          gameendtime = gettime();

        player.pers["br_survival_time"] = gameendtime - level.starttime;
        _id_DCFE556F7026A6FD = player.pers["br_survival_time"];
      }
    }

    _id_501F7F9E330F28B6 = "";
    _id_4876357EA766AE0C = "";

    if(isbot(player)) {
      _id_501F7F9E330F28B6 = player botgetdifficulty();

      if(isDefined(player._id_E2055BF088954E86))
        _id_4876357EA766AE0C = player._id_E2055BF088954E86;
    }

    player dlog_recordplayerevent("dlog_event_mobile_player_match_end", ["place", _id_E6D7DE89AE05A160, "survival_time", _id_DCFE556F7026A6FD, "bot_difficulty", _id_501F7F9E330F28B6, "bot_mind_personality", _id_4876357EA766AE0C]);
    player.pers["telemetry"]._id_C804FA67733B8EF5 = 1;
  }
}

on_player_disconnect(data) {
  if(!scripts\mp\flags::gameflag("prematch_done"))
    _id_6B12CC412AA6EA91(data);

  _id_CE976EE0200475A2(data);
}

_id_061A6648C0A01CAD(player) {
  if(!_id_4A6760982B403BAD::_id_0892570944F6B6A2(player)) {
    return;
  }
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    _id_5CFF4E1849051FA3 = player.pers["telemetry"]._id_5CFF4E1849051FA3;

    if(!isDefined(_id_5CFF4E1849051FA3)) {
      _id_5CFF4E1849051FA3 = spawnStruct();
      player.pers["telemetry"]._id_5CFF4E1849051FA3 = _id_5CFF4E1849051FA3;
      _id_5CFF4E1849051FA3._id_29D9D2428185616D = 0;
    } else
      _id_5CFF4E1849051FA3._id_29D9D2428185616D++;
  }
}

_id_37F53CF222F43271() {
  if(istrue(getdvarint("dvar_B46C28F676772BD2", 0)) || istrue(level.skipprematch)) {
    return;
  }
  foreach(player in level.players) {
    data = spawnStruct();
    data.player = player;
    _id_6B12CC412AA6EA91(data);
  }
}

_id_488BFC3E01722743(data) {
  bot = data.bot;

  if(!isbot(bot)) {
    return;
  }
  bot dlog_recordplayerevent("dlog_event_mobile_bot_set_difficulty", ["difficulty", data.difficulty]);
}

_id_522EBD007AA28658(data) {
  _id_5CFF4E1849051FA3 = self.pers["telemetry"]._id_5CFF4E1849051FA3;

  if(!isDefined(_id_5CFF4E1849051FA3)) {
    return;
  }
  if(data._id_629757F5C9E770D8 == "shots") {
    if(!isDefined(_id_5CFF4E1849051FA3._id_58E50AEE46852766))
      _id_5CFF4E1849051FA3._id_58E50AEE46852766 = data._id_A1D4E7D5EF9DA660;
    else
      _id_5CFF4E1849051FA3._id_58E50AEE46852766 = _id_5CFF4E1849051FA3._id_58E50AEE46852766 + data._id_A1D4E7D5EF9DA660;
  } else if(data._id_629757F5C9E770D8 == "hits") {
    if(!isDefined(_id_5CFF4E1849051FA3.hits))
      _id_5CFF4E1849051FA3.hits = data._id_A1D4E7D5EF9DA660;
    else
      _id_5CFF4E1849051FA3.hits = _id_5CFF4E1849051FA3.hits + data._id_A1D4E7D5EF9DA660;
  } else if(data._id_629757F5C9E770D8 == "kills") {
    if(!isDefined(_id_5CFF4E1849051FA3.kills))
      _id_5CFF4E1849051FA3.kills = data._id_A1D4E7D5EF9DA660;
    else
      _id_5CFF4E1849051FA3.kills = _id_5CFF4E1849051FA3.kills + data._id_A1D4E7D5EF9DA660;
  }
}

_id_6A347A3138EC63E1(data) {
  currenttime = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime());

  if(currenttime <= 0)
    _id_522EBD007AA28658(data);
}

_id_6B12CC412AA6EA91(data) {
  player = data.player;

  if(!isDefined(player.pers["telemetry"]._id_C0E398DB99DB74ED)) {
    if(!_id_4A6760982B403BAD::_id_0892570944F6B6A2(player)) {
      return;
    }
    if(istrue(player._id_06A91D0E80CC504E)) {
      return;
    }
    _id_5CFF4E1849051FA3 = player.pers["telemetry"]._id_5CFF4E1849051FA3;

    if(!isDefined(_id_5CFF4E1849051FA3)) {
      return;
    }
    _id_FDF9B22D16276454 = 0;

    if(isDefined(player.pers["telemetry"]._id_72AC055B0A1C5D26))
      _id_FDF9B22D16276454 = player.pers["telemetry"]._id_72AC055B0A1C5D26;

    _id_29D9D2428185616D = scripts\engine\utility::_id_53C4C53197386572(_id_5CFF4E1849051FA3._id_29D9D2428185616D, 0);
    hits = player.trackingweaponhits;

    if(isDefined(_id_5CFF4E1849051FA3.hits))
      hits = hits + _id_5CFF4E1849051FA3.hits;

    _id_58E50AEE46852766 = scripts\engine\utility::_id_53C4C53197386572(player.trackingweaponshots, 0);

    if(isDefined(_id_5CFF4E1849051FA3._id_58E50AEE46852766))
      _id_58E50AEE46852766 = _id_58E50AEE46852766 + _id_5CFF4E1849051FA3._id_58E50AEE46852766;

    kills = scripts\engine\utility::_id_53C4C53197386572(player.trackingweaponkills, 0);

    if(isDefined(_id_5CFF4E1849051FA3.kills))
      kills = kills + _id_5CFF4E1849051FA3.kills;

    _id_C2ACD5609C794D20 = scripts\engine\utility::_id_53C4C53197386572(player.pers["distanceTotal"], 0.0);
    _id_B92C01F350D85FE3 = 0.0;

    if(isDefined(player.pers["movementUpdateCount"]) && player.pers["movementUpdateCount"] >= 30)
      _id_B92C01F350D85FE3 = player.pers["distanceTotal"] / player.pers["movementUpdateCount"];

    currentweapon = player getcurrentweapon();
    weaponname = currentweapon.basename;
    player dlog_recordplayerevent("dlog_event_mobile_prematch_end", ["spawns", _id_29D9D2428185616D, "kills", kills, "distance_moved", _id_C2ACD5609C794D20, "speed", _id_B92C01F350D85FE3, "shots", _id_58E50AEE46852766, "hits", hits, "last_weapon_at_hand", weaponname, "connect_time", _id_FDF9B22D16276454, "disconnect_time", getsystemtime()]);
    player.pers["telemetry"]._id_C0E398DB99DB74ED = 1;
  }
}