/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6c628ffaa6e93e04.gsc
***********************************************/

main() {
  _id_DDAC31817B064B95 = getDvar("ui_mapname");
  _id_330A39C8A2318332 = ["cp_incur_test", "cp_raid_proto", "cp_port02"];

  if(!scripts\engine\utility::array_contains(_id_330A39C8A2318332, _id_DDAC31817B064B95)) {
    return;
  }
  level._id_9ACECE2C91A612AC = [];
  level._id_0D0CDD7E5E7A1C73 = [];
  level._id_F6369AC62A2BE791 = [];
  level._id_B089CFB80DB783BA = [];
  level._id_015AEFB0736880C4 = 0;
  level._id_F8B6E4096DCA543C = 0;

  if(!isDefined(level._id_756BA500F89AE317))
    level._id_756BA500F89AE317 = [];

  if(!isDefined(level._id_83E3E911DD5933D8))
    level._id_83E3E911DD5933D8 = 800;

  if(!isDefined(level._id_7F1455ABAB6DBA36))
    level._id_7F1455ABAB6DBA36 = 2400;

  if(!isDefined(level._id_0855AD4C400126F5))
    level._id_0855AD4C400126F5 = "cp/cp_incur_default_waves.csv";

  _id_7D1A8A4C10DFFA8A();
  _id_5F6F64A2C015F252();
  _id_8E4F5951EAF3AB71();
  _id_1913EA74A92673DA("prewave", ::_id_DF6AB2F88FE0914D);
  _id_6E6C8EDE1B51FAC1();
}

_id_6E6C8EDE1B51FAC1() {
  for(;;) {
    wave_num = int(max(0, level.wave_num - 1));

    if(!_id_D007C3DB4FA9162F(wave_num)) {
      iprintlnbold("End of wave test, final wave num = " + (wave_num - 1));
      return;
    }

    if(!isDefined(level._id_B089CFB80DB783BA["wave_" + wave_num]))
      level._id_B089CFB80DB783BA["wave_" + wave_num] = 0;

    level._id_015AEFB0736880C4 = 0;
    level._id_F8B6E4096DCA543C = 0;
    scripts\engine\utility::flag_set("incur_wave_active");

    if(_id_58BA0D48F39FDD95(wave_num)) {
      level._id_9ACECE2C91A612AC = _id_7D25EF18B962C160(wave_num);
      level._id_B089CFB80DB783BA["wave_" + wave_num]++;
      level notify("custom_wave", wave_num);
      _id_A418C5630E1E1967 = level._id_9ACECE2C91A612AC["start_func"];
      [[_id_A418C5630E1E1967]]();
      _id_5B8F01AA72991405(wave_num);
    } else {
      level._id_9ACECE2C91A612AC = _id_850A26ED8DE33886(wave_num);
      level._id_B089CFB80DB783BA["wave_" + wave_num]++;

      if(isDefined(level._id_9ACECE2C91A612AC["start_func"]))
        [[level._id_9ACECE2C91A612AC["start_func"]]]();

      _id_2DFDAA178C02FA8B(level._id_9ACECE2C91A612AC);
      level notify("incursion_spawn_cmd_wait_cancel");
      _id_5B8F01AA72991405(wave_num);
    }

    level.wave_num++;
  }
}

_id_5B8F01AA72991405(wave_num) {
  level endon("incursion_downtime_skip");
  scripts\engine\utility::flag_clear("incur_wave_active");
  scripts\engine\utility::flag_set("incur_wave_in_downtime");
  thread _id_691AD3800E5832F7();
  downtime = _id_A4A4EAC9CA801305(wave_num);

  while(downtime > 0) {
    downtime--;
    wait 1;
  }

  scripts\engine\utility::flag_clear("incur_wave_in_downtime");
}

_id_691AD3800E5832F7() {
  level endon("incur_wave_in_downtime");
  level waittill("incursion_downtime_skip");
  scripts\engine\utility::flag_clear("incur_wave_in_downtime");
}

_id_850A26ED8DE33886(wave_num) {
  _id_971097321937D1C5 = [];
  _id_971097321937D1C5["index"] = wave_num;
  _id_971097321937D1C5["downtime"] = _id_A4A4EAC9CA801305(wave_num);
  _id_971097321937D1C5["spawn_cmd"] = _id_BC030743192F6FFB(wave_num);
  _id_971097321937D1C5["start_func"] = _id_E650E3E0F3161D7B(wave_num);
  _id_971097321937D1C5["total_spawn_count"] = 0;

  foreach(_id_2F3A4ADEC7E3D091 in _id_971097321937D1C5["spawn_cmd"])
  _id_971097321937D1C5["total_spawn_count"] = _id_971097321937D1C5["total_spawn_count"] + _id_2F3A4ADEC7E3D091._id_4A6135863D603D11;

  return _id_971097321937D1C5;
}

_id_7D25EF18B962C160(wave_num) {
  _id_971097321937D1C5 = [];
  _id_971097321937D1C5["index"] = wave_num;
  _id_971097321937D1C5["downtime"] = _id_A4A4EAC9CA801305(wave_num);
  _id_971097321937D1C5["start_func"] = _id_E650E3E0F3161D7B(wave_num);
  return _id_971097321937D1C5;
}

_id_0EA76738101A63A0(_id_971097321937D1C5) {
  level notify("incursion_wave_debug");
  level endon("incursion_wave_debug");
  wave_num = _id_971097321937D1C5["index"];
  _id_68769094337CCE41 = "-";
  _id_873B9D60E8EC3C7B = _id_F167CF155C2BFE00(wave_num);

  if(isDefined(_id_873B9D60E8EC3C7B)) {
    _id_68769094337CCE41 = "|";

    foreach(num in _id_873B9D60E8EC3C7B)
    _id_68769094337CCE41 = _id_68769094337CCE41 + (num + "|");
  }

  _id_72D17CA40FEEC6ED = _id_7408AEB59E7521F0(wave_num);
  _id_C49D09A7A440F308 = _id_8D958A59306C6631(wave_num);

  if(!isDefined(_id_C49D09A7A440F308))
    _id_C49D09A7A440F308 = "-";

  downtime = _id_A4A4EAC9CA801305(wave_num);
  _id_8ADBBDF7679F7EB0 = "^6IDX:" + wave_num + "/RND:" + _id_68769094337CCE41;
  _id_8ADBBDF7679F7EB0 = _id_8ADBBDF7679F7EB0 + ("/TYPE:" + _id_72D17CA40FEEC6ED);
  _id_8ADBBDF7679F7EB0 = _id_8ADBBDF7679F7EB0 + ("/FUNC:" + _id_C49D09A7A440F308 + "/DT:" + downtime);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_971097321937D1C5["spawn_cmd"].size; _id_AC0E594AC96AA3A8++) {
    _id_A5516703B3F7D1FF = _id_971097321937D1C5["spawn_cmd"][_id_AC0E594AC96AA3A8];
    _id_8ADBBDF7679F7EB0 = _id_8ADBBDF7679F7EB0 + ("/" + _id_A5516703B3F7D1FF.type);

    if(_id_A5516703B3F7D1FF.type == "ai") {
      _id_8ADBBDF7679F7EB0 = _id_8ADBBDF7679F7EB0 + ("_" + _id_A5516703B3F7D1FF.ai["type"] + ":S" + _id_A5516703B3F7D1FF.ai["spawn_count"] + "R" + _id_A5516703B3F7D1FF.ai["respawn_count"]);
      continue;
    }

    if(_id_A5516703B3F7D1FF.type == "squad") {
      _id_8ADBBDF7679F7EB0 = _id_8ADBBDF7679F7EB0 + ("_" + _id_A5516703B3F7D1FF.squad["type"] + ":S" + _id_A5516703B3F7D1FF.squad["spawn_count"] + "R" + _id_A5516703B3F7D1FF.squad["respawn_count"]);
      continue;
    }

    if(_id_A5516703B3F7D1FF.type == "boss") {
      _id_8ADBBDF7679F7EB0 = _id_8ADBBDF7679F7EB0 + ("_" + _id_A5516703B3F7D1FF._id_E2958F412A7425C0["type"] + ":S" + _id_A5516703B3F7D1FF._id_E2958F412A7425C0["spawn_count"] + "R" + _id_A5516703B3F7D1FF._id_E2958F412A7425C0["respawn_count"]);
      continue;
    }

    if(_id_A5516703B3F7D1FF.type == "wait") {
      _id_B5303A96C5DBDD51 = _id_A5516703B3F7D1FF._id_2E5FCB10BC997907["type"];
      _id_8ADBBDF7679F7EB0 = _id_8ADBBDF7679F7EB0 + ("_" + _id_B5303A96C5DBDD51);

      if(_id_B5303A96C5DBDD51 == "count")
        _id_8ADBBDF7679F7EB0 = _id_8ADBBDF7679F7EB0 + (":" + _id_A5516703B3F7D1FF._id_2E5FCB10BC997907["count"]);
      else if(_id_B5303A96C5DBDD51 == "time")
        _id_8ADBBDF7679F7EB0 = _id_8ADBBDF7679F7EB0 + (":" + _id_A5516703B3F7D1FF._id_2E5FCB10BC997907["time"]);
      else if(_id_B5303A96C5DBDD51 == "flag")
        _id_8ADBBDF7679F7EB0 = _id_8ADBBDF7679F7EB0 + (":" + _id_A5516703B3F7D1FF._id_2E5FCB10BC997907["flag"]);
      else
        _id_8ADBBDF7679F7EB0 = _id_8ADBBDF7679F7EB0 + "";

      continue;
    }

    _id_8ADBBDF7679F7EB0 = _id_8ADBBDF7679F7EB0 + "";
  }

  wait 3;

  for(;;) {
    _id_5D948DD801E0A669 = "^6WAVE #" + level.wave_num + "(" + wave_num + ") - ";
    _id_5D948DD801E0A669 = _id_5D948DD801E0A669 + ("SPAWN:" + level._id_015AEFB0736880C4 + "/" + _id_971097321937D1C5["total_spawn_count"] + " - ");
    _id_5D948DD801E0A669 = _id_5D948DD801E0A669 + ("KILLED:" + level._id_F8B6E4096DCA543C);

    if(isDefined(level._id_594CC2E8454F2A7D))
      _id_5D948DD801E0A669 = _id_5D948DD801E0A669 + level._id_594CC2E8454F2A7D;

    wait 2;
  }
}

_id_2DFDAA178C02FA8B(_id_971097321937D1C5) {
  wave_num = _id_971097321937D1C5["index"];
  wait 2;
  _id_2D83D89C5C271835 = _id_971097321937D1C5["spawn_cmd"];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2D83D89C5C271835.size; _id_AC0E594AC96AA3A8++) {
    _id_296962B0DA92C7F7 = _id_2D83D89C5C271835[_id_AC0E594AC96AA3A8];

    if(_id_296962B0DA92C7F7.type == "ai")
      level thread _id_4B66A2C667EFE69A(_id_296962B0DA92C7F7, _id_971097321937D1C5);
    else if(_id_296962B0DA92C7F7.type == "squad")
      level thread _id_529E305778BCB656(_id_296962B0DA92C7F7, _id_971097321937D1C5);
    else if(_id_296962B0DA92C7F7.type == "boss")
      level thread _id_3699F17A5CF08EF5(_id_296962B0DA92C7F7, _id_971097321937D1C5);
    else if(_id_296962B0DA92C7F7.type == "wait") {
      _id_B5303A96C5DBDD51 = _id_296962B0DA92C7F7._id_2E5FCB10BC997907["type"];

      if(_id_B5303A96C5DBDD51 == "count") {
        min_count = _id_296962B0DA92C7F7._id_2E5FCB10BC997907["count"];
        _id_F5DEE55263216A36(min_count);
      } else if(_id_B5303A96C5DBDD51 == "time") {
        time = _id_296962B0DA92C7F7._id_2E5FCB10BC997907["time"];
        _id_F40CEA9645DBA9D7(time);
      } else if(_id_B5303A96C5DBDD51 == "flag") {
        _id_7B295362196F3D9D = _id_296962B0DA92C7F7._id_2E5FCB10BC997907["flag"];
        _id_663A6CE08B6CE8D0(_id_7B295362196F3D9D);
      } else {}
    } else {}

    level._id_015AEFB0736880C4 = level._id_015AEFB0736880C4 + _id_296962B0DA92C7F7._id_4A6135863D603D11;
  }

  _id_F5DEE55263216A36(0);
}

_id_F5DEE55263216A36(min_count) {
  level endon("incursion_spawn_cmd_wait_cancel");
  min_count = int(min(min_count, level._id_015AEFB0736880C4));

  for(;;) {
    level scripts\engine\utility::waittill_any_timeout_1(1, "wave_enemy_killed");
    waitframe();
    _id_2CFF6B48EEA96941 = level._id_015AEFB0736880C4 - level._id_F8B6E4096DCA543C;

    if(_id_2CFF6B48EEA96941 <= min_count)
      return;
  }
}

_id_F40CEA9645DBA9D7(time) {
  level endon("incursion_spawn_cmd_wait_cancel");

  while(time > 0) {
    wait 1;
    time = time - 1;
  }
}

_id_663A6CE08B6CE8D0(_id_7B295362196F3D9D) {
  level endon("incursion_spawn_cmd_wait_cancel");

  while(!scripts\engine\utility::flag_exist(_id_7B295362196F3D9D))
    wait 0.25;

  scripts\engine\utility::flag_wait(_id_7B295362196F3D9D);
}

_id_529E305778BCB656(_id_2F3A4ADEC7E3D091, _id_971097321937D1C5) {
  _id_6A369A9A45EB381E = _id_2F3A4ADEC7E3D091.squad["type"];
  spawn_count = _id_2F3A4ADEC7E3D091.squad["spawn_count"];
  _id_76FDAB6FB23849E3 = _id_2F3A4ADEC7E3D091.squad["respawn_count"];
  _id_8DAA7EF0C0F67DC1 = level._id_F6369AC62A2BE791;

  if(isDefined(_id_2F3A4ADEC7E3D091.squad["spawners"]))
    _id_8DAA7EF0C0F67DC1 = _id_2F3A4ADEC7E3D091.squad["spawners"];

  wait 5;
  level._id_F8B6E4096DCA543C = level._id_015AEFB0736880C4;
}

_id_3699F17A5CF08EF5(_id_2F3A4ADEC7E3D091, _id_971097321937D1C5) {
  _id_6A369A9A45EB381E = _id_2F3A4ADEC7E3D091._id_E2958F412A7425C0["type"];
  spawn_count = _id_2F3A4ADEC7E3D091._id_E2958F412A7425C0["spawn_count"];
  _id_76FDAB6FB23849E3 = _id_2F3A4ADEC7E3D091._id_E2958F412A7425C0["respawn_count"];
  _id_8DAA7EF0C0F67DC1 = level._id_F6369AC62A2BE791;

  if(isDefined(_id_2F3A4ADEC7E3D091._id_E2958F412A7425C0["spawners"]))
    _id_8DAA7EF0C0F67DC1 = _id_2F3A4ADEC7E3D091._id_E2958F412A7425C0["spawners"];

  wait 5;
  level._id_F8B6E4096DCA543C = level._id_015AEFB0736880C4;
}

_id_4B66A2C667EFE69A(_id_2F3A4ADEC7E3D091, _id_971097321937D1C5) {
  _id_4C3337129231E244 = _id_2F3A4ADEC7E3D091.ai["type"];
  spawn_count = _id_2F3A4ADEC7E3D091.ai["spawn_count"];
  _id_76FDAB6FB23849E3 = _id_2F3A4ADEC7E3D091.ai["respawn_count"];
  _id_8DAA7EF0C0F67DC1 = level._id_F6369AC62A2BE791;

  if(isDefined(_id_2F3A4ADEC7E3D091.ai["spawners"]))
    _id_8DAA7EF0C0F67DC1 = _id_2F3A4ADEC7E3D091.ai["spawners"];

  _id_2F3A4ADEC7E3D091.ai["spawned"] = [];
  _id_F51E59095803AD71 = 5;
  _id_8DAA7EF0C0F67DC1 = _id_935E889B03463E47(_id_8DAA7EF0C0F67DC1, spawn_count);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < spawn_count; _id_AC0E594AC96AA3A8++) {
    soldier = undefined;

    for(_id_7039850C128D0B86 = 0; !isDefined(soldier) && _id_7039850C128D0B86 < _id_F51E59095803AD71; _id_7039850C128D0B86++) {
      spawner = _id_8DAA7EF0C0F67DC1[_id_AC0E594AC96AA3A8];
      soldier = _id_7D810ABC8A7EB35F(_id_4C3337129231E244, spawner.origin, spawner.angles, 0.1);
    }

    soldier thread _id_F969A7FB50D13DAA();
    _id_2F3A4ADEC7E3D091.ai["spawned"][_id_2F3A4ADEC7E3D091.ai["spawned"].size] = soldier;
  }

  while(_id_76FDAB6FB23849E3 > 0) {
    loop = 1;

    while(loop) {
      level waittill("wave_enemy_killed", _id_CD977BE97BC0FC1E);

      foreach(spawned_ai in _id_2F3A4ADEC7E3D091.ai["spawned"]) {
        if(scripts\engine\utility::is_equal(_id_CD977BE97BC0FC1E, spawned_ai)) {
          loop = 0;
          break;
        }
      }
    }

    level thread _id_893EFC2232F3FDDF(_id_2F3A4ADEC7E3D091, _id_4C3337129231E244, _id_8DAA7EF0C0F67DC1, _id_F51E59095803AD71);
    _id_76FDAB6FB23849E3--;
  }
}

_id_893EFC2232F3FDDF(_id_2F3A4ADEC7E3D091, _id_4C3337129231E244, _id_8DAA7EF0C0F67DC1, _id_F51E59095803AD71) {
  soldier = undefined;
  _id_8DAA7EF0C0F67DC1 = _id_935E889B03463E47(_id_8DAA7EF0C0F67DC1, _id_F51E59095803AD71);

  for(_id_7039850C128D0B86 = 0; !isDefined(soldier) && _id_7039850C128D0B86 < _id_F51E59095803AD71; _id_7039850C128D0B86++) {
    spawner = scripts\engine\utility::random(_id_8DAA7EF0C0F67DC1);
    soldier = _id_7D810ABC8A7EB35F(_id_4C3337129231E244, spawner.origin, spawner.angles, 0.1);
  }

  soldier thread _id_F969A7FB50D13DAA();
  _id_2F3A4ADEC7E3D091.ai["spawned"][_id_2F3A4ADEC7E3D091.ai["spawned"].size] = soldier;
}

_id_8E4F5951EAF3AB71() {
  _id_E7EC36F283D5E46F("ar", "actor_enemy_cp_alq_desert_ar", ::_id_ECBA5E1CBDE4CEF2);
  _id_E7EC36F283D5E46F("smg", "actor_enemy_cp_alq_desert_smg", ::_id_B586303507129966);
  _id_E7EC36F283D5E46F("lmg", "actor_enemy_cp_alq_desert_lmg", ::_id_E497BB352ADFF017);
  _id_E7EC36F283D5E46F("shotgun", "actor_enemy_cp_alq_desert_shotgun", ::_id_3A49598BAA629F8D);
  _id_E7EC36F283D5E46F("sniper", "actor_enemy_cp_alq_desert_sniper", ::_id_0D0B21C56E15B96E);
  _id_E7EC36F283D5E46F("rpg", "actor_enemy_cp_alq_desert_rpg", ::_id_C71C7935151864F0);
  _id_E7EC36F283D5E46F("riot", "actor_enemy_cp_rus_riotshield", undefined);
  _id_E7EC36F283D5E46F("jugg", "actor_enemy_cp_rus_juggernaut", undefined);
  _id_E7EC36F283D5E46F("bomber", "actor_enemy_cp_alq_desert_bomber", undefined);
}

_id_E7EC36F283D5E46F(_id_4C3337129231E244, _id_BA479DD35BEB1C73, ai_spawn_func) {
  if(!isDefined(level._id_0D0CDD7E5E7A1C73))
    level._id_0D0CDD7E5E7A1C73 = [];

  level._id_0D0CDD7E5E7A1C73[_id_4C3337129231E244] = [];
  level._id_0D0CDD7E5E7A1C73[_id_4C3337129231E244]["ref_string"] = _id_BA479DD35BEB1C73;

  if(isDefined(ai_spawn_func))
    level._id_0D0CDD7E5E7A1C73[_id_4C3337129231E244]["spawn_func"] = ai_spawn_func;
  else
    level._id_0D0CDD7E5E7A1C73[_id_4C3337129231E244]["spawn_func"] = ::_id_478FC9E323598802;
}

_id_478FC9E323598802(goalradius) {
  if(!isDefined(goalradius))
    goalradius = 1100;

  self.last_goalradius = self.goalradius;
  self.goalradius = goalradius;
  thread _id_72F495A7B15FE660();
}

_id_72F495A7B15FE660(interval) {
  self endon("death");

  if(!isDefined(interval))
    interval = 5;

  for(;;) {
    _id_28E11B47827DA015 = [];

    foreach(player in level.players) {
      self getenemyinfo(player);

      if(isalive(player) && !istrue(player.inlaststand) && !player isparachuting() && !player isskydiving())
        _id_28E11B47827DA015[_id_28E11B47827DA015.size] = player;
    }

    if(_id_28E11B47827DA015.size == 0) {
      wait(interval);
      continue;
    }

    players = sortbydistance(_id_28E11B47827DA015, self.origin);
    _id_C729D49D406ACED8 = players[0];

    if(!isDefined(_id_C729D49D406ACED8._id_197E0CAF87E663B8))
      _id_C729D49D406ACED8._id_197E0CAF87E663B8 = [];
    else
      _id_C729D49D406ACED8._id_197E0CAF87E663B8 = scripts\engine\utility::array_removedead_or_dying(_id_C729D49D406ACED8._id_197E0CAF87E663B8);

    _id_C729D49D406ACED8._id_197E0CAF87E663B8[_id_C729D49D406ACED8._id_197E0CAF87E663B8.size] = self;
    _id_F33F587E225DE2AF = getclosestpointonnavmesh(_id_C729D49D406ACED8.origin);
    self setgoalpos(_id_F33F587E225DE2AF);
    self notify("new_goal_pos", _id_F33F587E225DE2AF, _id_C729D49D406ACED8);
    wait(interval);
  }
}

_id_ECBA5E1CBDE4CEF2() {
  thread _id_478FC9E323598802();
}

_id_3A49598BAA629F8D() {
  thread _id_478FC9E323598802(800);
}

_id_0D0B21C56E15B96E() {
  thread _id_478FC9E323598802(1500);
}

_id_B586303507129966() {
  thread _id_478FC9E323598802();
}

_id_E497BB352ADFF017() {
  thread _id_478FC9E323598802();
}

_id_C71C7935151864F0() {
  thread _id_478FC9E323598802(1500);
}

_id_2FC800F29189D270(_id_4C3337129231E244) {
  _id_81577AD147574D23 = "actor_enemy_cp_alq_desert_ar";

  if(isDefined(level._id_0D0CDD7E5E7A1C73[_id_4C3337129231E244]) && isDefined(level._id_0D0CDD7E5E7A1C73[_id_4C3337129231E244]["ref_string"]))
    _id_81577AD147574D23 = level._id_0D0CDD7E5E7A1C73[_id_4C3337129231E244]["ref_string"];

  return _id_81577AD147574D23;
}

_id_FB1DF44FF5048C09(_id_4C3337129231E244) {
  return level._id_0D0CDD7E5E7A1C73[_id_4C3337129231E244]["spawn_func"];
}

_id_F969A7FB50D13DAA() {
  self waittill("death", attacker, meansofdeath, _id_06B62DB6EEC868E2, damagelocation);
  _id_066691A6C8FDBBD8 = self.origin;
  level._id_F8B6E4096DCA543C++;
  level notify("wave_enemy_killed", self, _id_066691A6C8FDBBD8, attacker, meansofdeath, _id_06B62DB6EEC868E2, damagelocation);
}

_id_7D810ABC8A7EB35F(_id_4C3337129231E244, spawn_pos, _id_0FD901B0C91A0D1F, timeout) {
  soldier = undefined;

  if(!isDefined(timeout))
    timeout = 3;

  _id_81577AD147574D23 = _id_2FC800F29189D270(_id_4C3337129231E244);
  ai_spawn_func = _id_FB1DF44FF5048C09(_id_4C3337129231E244);

  while(timeout > 0) {
    soldier = scripts\mp\mp_agent::spawnnewagentaitype(_id_81577AD147574D23, spawn_pos, _id_0FD901B0C91A0D1F);

    if(isDefined(soldier)) {
      break;
    }

    timeout = timeout - 0.05;
    wait 0.05;
  }

  soldier._id_4C3337129231E244 = _id_4C3337129231E244;

  if(isDefined(soldier))
    soldier thread[[ai_spawn_func]]();

  return soldier;
}

_id_1913EA74A92673DA(_id_17D1BF04D02B84C4, _id_163C4CAA38CE1BB6) {
  level._id_756BA500F89AE317[_id_17D1BF04D02B84C4] = _id_163C4CAA38CE1BB6;
}

_id_7D1A8A4C10DFFA8A() {
  scripts\engine\utility::flag_init("incur_wave_active");
  scripts\engine\utility::flag_init("incur_wave_in_downtime");
}

_id_5F6F64A2C015F252() {
  level._id_F6369AC62A2BE791 = scripts\engine\utility::getStructArray("incur_wave_spawner", "script_noteworthy");

  foreach(spawner in level._id_F6369AC62A2BE791) {
    if(!isDefined(spawner.angles))
      spawner.angles = (0, 0, 0);

    if(isDefined(spawner.target)) {
      _id_AC8ADE1317FCA87C = scripts\engine\utility::getStructArray(spawner.target, "targetname");

      if(isDefined(_id_AC8ADE1317FCA87C)) {
        foreach(_id_5D25F4C38ED211E7 in _id_AC8ADE1317FCA87C) {
          if(!isDefined(_id_5D25F4C38ED211E7.angles))
            _id_5D25F4C38ED211E7.angles = (0, 0, 0);
        }

        spawner._id_AC8ADE1317FCA87C = _id_AC8ADE1317FCA87C;
      }
    }
  }
}

_id_D007C3DB4FA9162F(_id_F95A29F6FCCF4D68) {
  _id_72D17CA40FEEC6ED = _id_7408AEB59E7521F0(_id_F95A29F6FCCF4D68);
  return isDefined(_id_72D17CA40FEEC6ED);
}

_id_7408AEB59E7521F0(_id_F95A29F6FCCF4D68) {
  _id_72D17CA40FEEC6ED = tablelookup(level._id_0855AD4C400126F5, 0, _id_F95A29F6FCCF4D68, 3);

  if(isDefined(_id_72D17CA40FEEC6ED) && _id_72D17CA40FEEC6ED != "")
    return _id_72D17CA40FEEC6ED;

  return undefined;
}

_id_58BA0D48F39FDD95(_id_F95A29F6FCCF4D68) {
  _id_72D17CA40FEEC6ED = _id_7408AEB59E7521F0(_id_F95A29F6FCCF4D68);

  if(isDefined(_id_72D17CA40FEEC6ED)) {
    if(_id_72D17CA40FEEC6ED == "custom")
      return 1;
  }

  return 0;
}

_id_F167CF155C2BFE00(_id_F95A29F6FCCF4D68) {
  _id_24F62112B6090C8A = tablelookup(level._id_0855AD4C400126F5, 0, _id_F95A29F6FCCF4D68, 1);

  if(isDefined(_id_24F62112B6090C8A) && _id_24F62112B6090C8A != "") {
    _id_68769094337CCE41 = strtok(_id_24F62112B6090C8A, " ");
    _id_8A99C1F76756EDE3 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_68769094337CCE41.size; _id_AC0E594AC96AA3A8++)
      _id_8A99C1F76756EDE3[_id_AC0E594AC96AA3A8] = int(_id_68769094337CCE41[_id_AC0E594AC96AA3A8]);

    return _id_8A99C1F76756EDE3;
  } else
    return undefined;
}

_id_AD83D959C8F9C191(_id_F95A29F6FCCF4D68) {
  _id_8A99C1F76756EDE3 = _id_F167CF155C2BFE00(_id_F95A29F6FCCF4D68);

  if(isDefined(_id_8A99C1F76756EDE3) && _id_8A99C1F76756EDE3.size > 0) {
    _id_8A99C1F76756EDE3 = scripts\engine\utility::array_randomize(_id_8A99C1F76756EDE3);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8A99C1F76756EDE3.size; _id_AC0E594AC96AA3A8++) {
      _id_53E3912AB70C938C = _id_8A99C1F76756EDE3[_id_AC0E594AC96AA3A8];

      if(isDefined(level._id_B089CFB80DB783BA["wave_" + _id_53E3912AB70C938C]) && level._id_B089CFB80DB783BA["wave_" + _id_53E3912AB70C938C] > 0) {
        continue;
      }
      return _id_8A99C1F76756EDE3[_id_AC0E594AC96AA3A8];
    }
  } else
    return _id_F95A29F6FCCF4D68;
}

_id_8D958A59306C6631(_id_F95A29F6FCCF4D68) {
  _id_C49D09A7A440F308 = tablelookup(level._id_0855AD4C400126F5, 0, _id_F95A29F6FCCF4D68, 4);

  if(isDefined(_id_C49D09A7A440F308) && _id_C49D09A7A440F308 != "")
    return _id_C49D09A7A440F308;
  else
    return undefined;
}

_id_E650E3E0F3161D7B(_id_F95A29F6FCCF4D68) {
  _id_C49D09A7A440F308 = _id_8D958A59306C6631(_id_F95A29F6FCCF4D68);

  if(isDefined(_id_C49D09A7A440F308) && isDefined(level._id_756BA500F89AE317[_id_C49D09A7A440F308]))
    return level._id_756BA500F89AE317[_id_C49D09A7A440F308];

  return::_id_3CC7A30224EF1CCC;
}

_id_3CC7A30224EF1CCC() {}

_id_A4A4EAC9CA801305(_id_F95A29F6FCCF4D68) {
  downtime = tablelookup(level._id_0855AD4C400126F5, 0, _id_F95A29F6FCCF4D68, 5);

  if(isDefined(downtime) && downtime != "")
    return int(downtime);
  else
    return 0;
}

_id_BC030743192F6FFB(_id_F95A29F6FCCF4D68) {
  _id_2D83D89C5C271835 = [];
  _id_FE2F116617695F12 = 9;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FE2F116617695F12; _id_AC0E594AC96AA3A8++) {
    _id_A07B1C1C332FDBC7 = int(6 + _id_AC0E594AC96AA3A8);
    _id_2D83D89C5C271835[_id_AC0E594AC96AA3A8] = _id_E20AEBD6DB1E1DC1(_id_F95A29F6FCCF4D68, _id_A07B1C1C332FDBC7);
  }

  return _id_2D83D89C5C271835;
}

_id_E20AEBD6DB1E1DC1(_id_F95A29F6FCCF4D68, _id_A07B1C1C332FDBC7) {
  _id_D92B640DBE660660 = tablelookup(level._id_0855AD4C400126F5, 0, _id_F95A29F6FCCF4D68, _id_A07B1C1C332FDBC7);

  if(!isDefined(_id_D92B640DBE660660) || _id_D92B640DBE660660 == "")
    return undefined;

  _id_2F3A4ADEC7E3D091 = spawnStruct();
  _id_BD07421FDD5B1635 = strtok(_id_D92B640DBE660660, " ");
  _id_C544317B9CF651C5 = strtok(_id_BD07421FDD5B1635[0], "_");
  _id_2F3A4ADEC7E3D091.type = _id_C544317B9CF651C5[0];
  _id_2F3A4ADEC7E3D091._id_4A6135863D603D11 = 0;

  if(_id_2F3A4ADEC7E3D091.type == "ai") {
    _id_2F3A4ADEC7E3D091.ai = [];
    _id_2F3A4ADEC7E3D091.ai["type"] = _id_C544317B9CF651C5[1];
    _id_2F3A4ADEC7E3D091.ai["spawn_count"] = int(_id_BD07421FDD5B1635[1]);
    _id_2F3A4ADEC7E3D091.ai["respawn_count"] = int(_id_BD07421FDD5B1635[2]);

    if(isDefined(_id_BD07421FDD5B1635[3]))
      _id_2F3A4ADEC7E3D091.ai["spawners"] = scripts\engine\utility::getStructArray(_id_BD07421FDD5B1635[3], "script_noteworthy");

    _id_2F3A4ADEC7E3D091._id_4A6135863D603D11 = _id_2F3A4ADEC7E3D091.ai["spawn_count"] + _id_2F3A4ADEC7E3D091.ai["respawn_count"];
  } else if(_id_2F3A4ADEC7E3D091.type == "squad") {
    _id_2F3A4ADEC7E3D091.squad = [];
    _id_2F3A4ADEC7E3D091.squad["type"] = _id_C544317B9CF651C5[1];
    _id_2F3A4ADEC7E3D091.squad["spawn_count"] = int(_id_BD07421FDD5B1635[1]);
    _id_2F3A4ADEC7E3D091.squad["respawn_count"] = int(_id_BD07421FDD5B1635[2]);

    if(isDefined(_id_BD07421FDD5B1635[3]))
      _id_2F3A4ADEC7E3D091.squad["spawners"] = scripts\engine\utility::getStructArray(_id_BD07421FDD5B1635[3], "script_noteworthy");

    _id_D77FCCC50C2ACEFD = _id_2F3A4ADEC7E3D091.squad["spawn_count"] + _id_2F3A4ADEC7E3D091.squad["respawn_count"];
    _id_2F3A4ADEC7E3D091._id_4A6135863D603D11 = _id_D77FCCC50C2ACEFD * _id_21F390EBBED7CF10(_id_2F3A4ADEC7E3D091.squad["type"]);
  } else if(_id_2F3A4ADEC7E3D091.type == "boss") {
    _id_2F3A4ADEC7E3D091._id_E2958F412A7425C0 = [];
    _id_2F3A4ADEC7E3D091._id_E2958F412A7425C0["type"] = _id_C544317B9CF651C5[1];
    _id_2F3A4ADEC7E3D091._id_E2958F412A7425C0["spawn_count"] = int(_id_BD07421FDD5B1635[1]);
    _id_2F3A4ADEC7E3D091._id_E2958F412A7425C0["respawn_count"] = int(_id_BD07421FDD5B1635[2]);

    if(isDefined(_id_BD07421FDD5B1635[3]))
      _id_2F3A4ADEC7E3D091._id_E2958F412A7425C0["spawners"] = scripts\engine\utility::getStructArray(_id_BD07421FDD5B1635[3], "script_noteworthy");

    _id_2F3A4ADEC7E3D091._id_4A6135863D603D11 = _id_2F3A4ADEC7E3D091._id_E2958F412A7425C0["spawn_count"] + _id_2F3A4ADEC7E3D091._id_E2958F412A7425C0["respawn_count"];
  } else if(_id_2F3A4ADEC7E3D091.type == "wait") {
    _id_2F3A4ADEC7E3D091._id_2E5FCB10BC997907 = [];
    _id_2F3A4ADEC7E3D091._id_4A6135863D603D11 = 0;
    _id_B5303A96C5DBDD51 = _id_C544317B9CF651C5[1];

    if(_id_B5303A96C5DBDD51 == "count")
      _id_2F3A4ADEC7E3D091._id_2E5FCB10BC997907["count"] = int(_id_BD07421FDD5B1635[1]);
    else if(_id_B5303A96C5DBDD51 == "time")
      _id_2F3A4ADEC7E3D091._id_2E5FCB10BC997907["time"] = int(_id_BD07421FDD5B1635[1]);
    else if(_id_B5303A96C5DBDD51 == "flag")
      _id_2F3A4ADEC7E3D091._id_2E5FCB10BC997907["flag"] = _id_BD07421FDD5B1635[1];
    else {}

    _id_2F3A4ADEC7E3D091._id_2E5FCB10BC997907["type"] = _id_B5303A96C5DBDD51;
  } else {}

  return _id_2F3A4ADEC7E3D091;
}

_id_21F390EBBED7CF10(_id_18450DF604D5360C) {
  return 4;
}

_id_935E889B03463E47(_id_8DAA7EF0C0F67DC1, _id_C0BDB2F1D9CFC100) {
  _id_6A3CC2111E30D71D = squared(level._id_83E3E911DD5933D8);
  _id_6025F24941184817 = squared(level._id_7F1455ABAB6DBA36);
  _id_CE23F11A9CBEC73F = [];

  foreach(spawner in _id_8DAA7EF0C0F67DC1) {
    spawner._id_C2AD398974E5B932 = 0;

    foreach(player in level.players) {
      _id_ABD9EE4725B96FC2 = distancesquared(player.origin, spawner.origin);

      if(_id_ABD9EE4725B96FC2 < _id_6A3CC2111E30D71D || _id_ABD9EE4725B96FC2 > _id_6025F24941184817) {
        continue;
      }
      if(sighttracepassed(player getEye(), spawner.origin + (0, 0, 40), 1, player, 1)) {
        continue;
      }
      if(!isDefined(spawner._id_06C489D22B9C9BC5))
        spawner._id_06C489D22B9C9BC5 = 0;

      spawner._id_06C489D22B9C9BC5 = spawner._id_06C489D22B9C9BC5 + _id_ABD9EE4725B96FC2;
      _id_CE23F11A9CBEC73F[_id_CE23F11A9CBEC73F.size] = spawner;
    }
  }

  _id_C4D787D65F03B828 = scripts\engine\utility::array_sort_with_func(_id_CE23F11A9CBEC73F, ::_id_72C31F6709ED164E);

  if(isDefined(_id_C0BDB2F1D9CFC100) && _id_C0BDB2F1D9CFC100 > 1) {
    _id_91B5238BB63C780C = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C0BDB2F1D9CFC100; _id_AC0E594AC96AA3A8++) {
      if(isDefined(_id_C4D787D65F03B828[_id_AC0E594AC96AA3A8])) {
        _id_91B5238BB63C780C[_id_91B5238BB63C780C.size] = _id_C4D787D65F03B828[_id_AC0E594AC96AA3A8];
        continue;
      }

      _id_91B5238BB63C780C[_id_91B5238BB63C780C.size] = scripts\engine\utility::random(_id_C4D787D65F03B828);
    }

    return _id_91B5238BB63C780C;
  } else
    return _id_C4D787D65F03B828[0];
}

_id_72C31F6709ED164E(a, b) {
  return b._id_06C489D22B9C9BC5 > a._id_06C489D22B9C9BC5;
}

_id_DF6AB2F88FE0914D() {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  for(timeout = 15; level.players.size < 2 && timeout > 0; timeout--)
    wait 1;
}