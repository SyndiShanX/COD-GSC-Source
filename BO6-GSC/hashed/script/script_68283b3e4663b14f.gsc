/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_68283b3e4663b14f.gsc
*****************************************************/

#using script_4db4e7f305ce5a21;
#using script_7a5f832593a7dde9;
#using scripts\common\callbacks;
#using scripts\engine\scriptable;
#namespace managed_reward_cache;

function function_a46929d7049f2611(rewardcachesettings, rewardcachebehaviorsettings, playergroups, placementstruct, func_openlootablecontainer, var_c89efc2a897f1a75, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_bdc4a6e0bc8a3b96) {
  thread function_eae4a2bd1fa13980(rewardcachesettings, rewardcachebehaviorsettings, playergroups, placementstruct, func_openlootablecontainer, var_c89efc2a897f1a75, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_bdc4a6e0bc8a3b96);
}

function function_ab982cc153be88ec(var_74459050ad50d390) {
  if(function_46122d01e13d79c8(var_74459050ad50d390)) {
    reward_cache::function_8abc48b08a4b4075("Z\x18R1\xd5(M\xf9\xb9X)E`^\\\xd6\x16]\x9a\xf3\xf6g\b;\xf8\x89m\x97`\xcb\\\xd7R\x99f`^l\x88\xba\xf9X\xe9\xa42\\\\\x02P\x18O\xb5\xc6\xe8X;{M<\xd6sT\xde\xd7S\x1cGuU<I\xf9|LlC\xf3\xcc\r\x1f\x10\\O;\xe6\xaf\by\xf9I<\x1a1\xe2]\x96\x13\r\x8f0V.\t\xa8}\n/e`\xdc\xde\x17\x02\x9d\x1e`\x87m\x8c\xbc\xf8\x8d\xaf\xd7q\xc4");
    return;
  }

  thread function_46944cb00fcdd1ff(var_74459050ad50d390);
}

function function_810a1ed1ecebd37e(var_74459050ad50d390, player, lootcontents) {
  rewardcache = function_1331ae66090676bd(var_74459050ad50d390);
  reward_cache::function_da773cefdd47d8cb(rewardcache, player, lootcontents);
}

function function_f61dbff460c1ec09(var_74459050ad50d390, player) {
  rewardcache = function_1331ae66090676bd(var_74459050ad50d390);
  return reward_cache::function_f78413a01c89a330(rewardcache, player);
}

function function_ef980e55e3f0874c(var_74459050ad50d390, player, reservedslotindex, item) {
  rewardcache = function_1331ae66090676bd(var_74459050ad50d390);
  reward_cache::function_fd58ce4d52e1698f(rewardcache, player, reservedslotindex, item);
}

function function_3a2d55317ba81b35(var_74459050ad50d390) {
  if(isDefined(var_74459050ad50d390) && istrue(var_74459050ad50d390.var_914a5f8de83cc3dc)) {
    var_74459050ad50d390.allowdespawn = 0;
    rewardcacheinfostring = reward_cache::function_e4709712a8e63645(var_74459050ad50d390.rewardcache);
    reward_cache::function_fb99cbbd062c7471("Nu\x9a\xaf\b\t\xe3hJ\xf7Y\xe0\xe3b_\xc5\xf7J\x92_\xb1\xfa\xe3ZX\xafs\xf8\x13\xbe\aF\xe8e\x1e1y\xc3Kh\x80\xab\x81p_f<" + rewardcacheinfostring + "\xa0");
  }
}

function function_e38587302679cd50(var_74459050ad50d390) {
  if(!isDefined(var_74459050ad50d390) || !istrue(var_74459050ad50d390.var_914a5f8de83cc3dc)) {
    return;
  }

  if(istrue(var_74459050ad50d390.allowdespawn)) {
    return;
  }

  var_74459050ad50d390.allowdespawn = 1;
  var_74459050ad50d390 notify("\xf3\xb6n\x98\xf5/V\xa1\xe0\xbdot\xfe");
  rewardcacheinfostring = reward_cache::function_e4709712a8e63645(var_74459050ad50d390.rewardcache);
  reward_cache::function_fb99cbbd062c7471("\x14zcpl\x05\xd4\xed\xa1\x82\xe9.9\x93\x04l\x9f\x88B\x88S\xfdAB\xc0\xa3\x9ag5\x82\xb6\xeb\xce\xc3\x87\xea\xe60\x83\xa2fH" + rewardcacheinfostring + "\xa0");
}

function function_46122d01e13d79c8(var_74459050ad50d390) {
  assert(isDefined(var_74459050ad50d390));
  assert(istrue(var_74459050ad50d390.var_914a5f8de83cc3dc));
  return !istrue(var_74459050ad50d390.allowdespawn);
}

function private function_e0bb75a64166e36d(var_74459050ad50d390) {
  if(function_46122d01e13d79c8(var_74459050ad50d390)) {
    var_74459050ad50d390 waittill("\xf3\xb6n\x98\xf5/V\xa1\xe0\xbdot\xfe");
  }
}

function private function_30d7ee5b338e6d58(var_74459050ad50d390, durationseconds) {
  rewardcache = var_74459050ad50d390.rewardcache;
  rewardcache endon("~\x12\xb1w\x8eC\x80");
  function_3a2d55317ba81b35(var_74459050ad50d390);
  wait durationseconds;
  function_e38587302679cd50(var_74459050ad50d390);
}

function private function_eae4a2bd1fa13980(rewardcachesettings, rewardcachebehaviorsettings, playergroups, placementstruct, func_openlootablecontainer, var_c89efc2a897f1a75, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_bdc4a6e0bc8a3b96) {
  if(!function_92705a7cf8a5db0a()) {
    function_9fcee73e6706206c();
  }

  if(!isDefined(rewardcachesettings) || !isstruct(rewardcachesettings) || !istrue(rewardcachesettings.var_d0b574cdce921bac)) {
    function_a48905eff8b9563a(var_bdc4a6e0bc8a3b96);
    reward_cache::function_d12ff4393ce6a5b("\x89 E`\xfa\xae\x8e\xd3\x92\x99\x0f\xcb\xfb\x97l\x13\xc5Z\xc0\xdfO\\X\x0e\xaa\xec\v\xe7q[/UU\x8d\x97\xbdn\xd4\xd4w`\xfd\x90.LOF\x97\x8c\xcaF\xf7q\tg\xea~>\x19>\xef\xdf\t\x14\xa6v\xfb\x1ay\x14\xf6\xf9p\x97\vy\x7f\xae\\J\xe6\xd0\xa6\xf9xc\vNK\xe6D\xc1\xf74\x8c\xa9\xa3\x9c\xb2\xee\xbf\x18=\xe3\x19%\x90\x196kz\xce{\x02");
    return;
  }

  if(!isDefined(rewardcachebehaviorsettings) || !isstruct(rewardcachesettings) || !istrue(rewardcachebehaviorsettings.var_9c3dada8c6954f92)) {
    function_a48905eff8b9563a(var_bdc4a6e0bc8a3b96);
    reward_cache::function_d12ff4393ce6a5b("qN\xbd\xd8}\rHb8\xca\x16\xcc\xcdf'\xed\xb1\xf3\xe4?\xb3}\xa9\x9bH\xc8\xa6v\x18\x13\xa4H\"j12aC\xa9\x1dI\xc6\x1b~o\xda\xc3\xd6\xb0\xe7\xf3\x19Q\x84*\xda\xf4\x95\xa74\xe0B\x1d\xe6.\xe8kNY\xab\xd1x\xa3\xc3\xa5n\xb6cP\xc2\xaa\xbe8O]\xd4\x14\xba\xb3\xd8\xe5}\xf8EP\xb0\x05\xc2\xc2|y\xa8i_(\xd8\x80\xdb\xc3sD\xe5|\x8e\x94 ,\x93\x01\xb8\xab\xfd");
    return;
  }

  function_315f346081cb91b3(rewardcachesettings, rewardcachebehaviorsettings);
  spawndelayseconds = namespace_a7ab1233794fcbbb::getspawndelayseconds(rewardcachebehaviorsettings);

  if(spawndelayseconds > 0) {
    wait spawndelayseconds;
  }

  var_88139f5ee3da55c4 = rewardcachesettings;
  thread function_e5f1ca325fbdd18d(var_88139f5ee3da55c4, var_bdc4a6e0bc8a3b96, rewardcachebehaviorsettings);
  reward_cache::spawnrewardcache(rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_c89efc2a897f1a75, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_88139f5ee3da55c4);
}

function private function_e5f1ca325fbdd18d(var_88139f5ee3da55c4, var_bdc4a6e0bc8a3b96, rewardcachebehaviorsettings) {
  var_88139f5ee3da55c4 waittill("\xbf\x8e|;\a\xbc\xa44\x15}\xa8\x86\x13|\x9a|e\xa6\xb9ee\xfex", rewardcache);

  if(!isDefined(rewardcache)) {
    function_a48905eff8b9563a(var_bdc4a6e0bc8a3b96);
    reward_cache::function_79db779671b9ca27("_a$\xc3H\xa2M\xd8\x12+I\xc8#?\xfc\xad\x9a\xb3*G\xbf\naMn4\xe3\xfe{\xe2\xb9,.\x89}TFb\xe0\xe5\x87\xee*\xc7\x9biw.\x8c\xf3\x15\xd8Jt\xcbM\xb6\x82\xb6@\xf8|z\xa9\x1b\x95\xc2=\x8f,&\x18\xd1A\xe2G\f\xe5\xbc\xb0t\xb4Xd=c\x8fE\xd95<\xfd\xaf\x9b;");
    return;
  }

  var_74459050ad50d390 = function_787e6ba7f05935d(rewardcache, rewardcachebehaviorsettings);
  function_964fd3931cfb9c41(var_74459050ad50d390);
  function_f04400f20e1974a8(var_74459050ad50d390);

  if(isDefined(var_bdc4a6e0bc8a3b96)) {
    var_bdc4a6e0bc8a3b96 notify("\x8a\xc6\xa7\x17o\xc5U\x1c\x8c=\xfbY\xa7\xe9`\xd8\xc3t\x19\bG\x83v\xef\xf9\xfaF\x1d\xc1UR", var_74459050ad50d390);
  }
}

function private function_787e6ba7f05935d(rewardcache, rewardcachebehaviorsettings) {
  if(!isDefined(level.var_7cec14c5efd7a3b4)) {
    level.var_7cec14c5efd7a3b4 = 0;
  } else {
    level.var_7cec14c5efd7a3b4++;
  }

  var_74459050ad50d390 = spawnStruct();
  var_74459050ad50d390.rewardcache = rewardcache;
  var_74459050ad50d390.behaviorsettings = rewardcachebehaviorsettings;
  var_74459050ad50d390.allowdespawn = 1;
  var_74459050ad50d390.id = level.var_7cec14c5efd7a3b4;
  var_74459050ad50d390.var_914a5f8de83cc3dc = 1;
  return var_74459050ad50d390;
}

function private function_92705a7cf8a5db0a() {
  return isDefined(level.var_b97cb0b1b58a96e7);
}

function private function_9fcee73e6706206c() {
  level.var_b97cb0b1b58a96e7 = [];
  callback::add(#"player_connect", &function_7bc04bea7f6afc7c);
  callback::add(#"player_disconnect", &function_5d5ee49e6df85c00);
  scriptable::scriptable_addusedcallback(&reward_cache::function_e01e29652e3ee256);
}

function private function_f04400f20e1974a8(var_74459050ad50d390) {
  level.var_b97cb0b1b58a96e7[level.var_b97cb0b1b58a96e7.size] = var_74459050ad50d390;
}

function private function_cedc6d61411d2269(var_74459050ad50d390) {
  level.var_b97cb0b1b58a96e7 = arrayremove(level.var_b97cb0b1b58a96e7, var_74459050ad50d390);
}

function private function_315f346081cb91b3(rewardcachesettings, rewardcachebehaviorsettings) {
  if(namespace_a7ab1233794fcbbb::function_c10d9e882f218b09(rewardcachebehaviorsettings)) {
    reward_cache_settings::function_32e3a2ffcaf700fc(rewardcachesettings, 0);
  }
}

function private function_964fd3931cfb9c41(var_74459050ad50d390) {
  rewardcache = var_74459050ad50d390.rewardcache;
  var_a144e2627df0b66f = namespace_a7ab1233794fcbbb::function_c10d9e882f218b09(var_74459050ad50d390.behaviorsettings);

  if(istrue(var_a144e2627df0b66f)) {
    foreach(grouprewardcache in rewardcache.grouprewardcaches) {
      thread function_d81ee766576e4c8a(var_74459050ad50d390, grouprewardcache);
    }
  }

  thread function_80f934e22f06c555(var_74459050ad50d390);
  thread function_8a0ce399988ff275(var_74459050ad50d390);
  thread function_70cd682ae5395e0c(var_74459050ad50d390);
}

function private function_d81ee766576e4c8a(var_74459050ad50d390, grouprewardcache) {
  rewardcache = grouprewardcache.rewardcacheowner;
  rewardcache endon("~\x12\xb1w\x8eC\x80");

  while(true) {
    grouprewardcache waittill("\xdd}S\xf2<\xe9");
    function_e0bb75a64166e36d(var_74459050ad50d390);

    if(reward_cache::function_b575f2dfe9d3381c(grouprewardcache)) {
      reward_cache::function_56f2dad98bf8e9f6(grouprewardcache);
    }

    function_1b8117694b13e92(var_74459050ad50d390);
  }
}

function private function_80f934e22f06c555(var_74459050ad50d390) {
  despawntimerseconds = namespace_a7ab1233794fcbbb::function_bc5e72275cc071c8(var_74459050ad50d390.behaviorsettings);
  rewardcache = var_74459050ad50d390.rewardcache;
  rewardcache endon("~\x12\xb1w\x8eC\x80");
  wait despawntimerseconds;
  function_db5e480257f4468e(var_74459050ad50d390.rewardcache, "\xec\xee\xf9\xa2\xe0\x0e\xfad\xfa\x14}\xbe\x04");
  function_e0bb75a64166e36d(var_74459050ad50d390);
  function_ab982cc153be88ec(var_74459050ad50d390);
}

function private function_8a0ce399988ff275(var_74459050ad50d390) {
  rewardcache = var_74459050ad50d390.rewardcache;
  rewardcache endon("~\x12\xb1w\x8eC\x80");
  despawndistance = namespace_a7ab1233794fcbbb::getdespawndistance(var_74459050ad50d390.behaviorsettings);
  despawndistancesquared = despawndistance * despawndistance;

  while(true) {
    function_e0bb75a64166e36d(var_74459050ad50d390);
    playerowners = reward_cache::getplayerowners(rewardcache);

    if(function_db57b1409c757850(playerowners, reward_cache::function_eeafe24608676e0c(rewardcache), despawndistancesquared)) {
      function_db5e480257f4468e(var_74459050ad50d390.rewardcache, "\x91+\xb4\x8d\xcb\xbd\x1e\x1c\xc4\xc0\xd3\xe1\x8f7");
      function_ab982cc153be88ec(var_74459050ad50d390);
    }

    wait 3;
  }
}

function private function_70cd682ae5395e0c(var_74459050ad50d390) {
  rewardcache = var_74459050ad50d390.rewardcache;
  rewardcache endon("~\x12\xb1w\x8eC\x80");
  visibilitydistance = namespace_a7ab1233794fcbbb::function_7364a2546df6f9ea(var_74459050ad50d390.behaviorsettings);
  visibilitydistancesquared = visibilitydistance * visibilitydistance;

  while(true) {
    var_254c2a7f90e2af47 = 0;

    foreach(player in reward_cache::function_f2d992ce8d009f2e(rewardcache)) {
      if(!isPlayer(player)) {
        if(!var_254c2a7f90e2af47) {
          reward_cache::function_bef06080f8281ae0(rewardcache);
          var_254c2a7f90e2af47 = 1;
        }

        continue;
      }

      if(distance2dsquared(player.origin, reward_cache::function_eeafe24608676e0c(rewardcache)) > visibilitydistancesquared) {
        reward_cache::function_1828e12b19a61ffb(rewardcache, player);
        continue;
      }

      reward_cache::function_1e24c906931fbc0f(rewardcache, player);
    }

    wait 0.5;
  }
}

function private function_46944cb00fcdd1ff(var_74459050ad50d390) {
  rewardcache = var_74459050ad50d390.rewardcache;
  rewardcache notify("~\x12\xb1w\x8eC\x80");
  var_74459050ad50d390 notify("\xf1\x9d\xb0\xd3x\x84t\x03-\xd3 *`\x94\xdb\xee\xb7|\xcfq\xff\xa2;\x05\x96\x80\x15-\x15c");
  rewardcache endon("~\x12\xb1w\x8eC\x80");
  var_d0cf07857479e35a = namespace_a7ab1233794fcbbb::function_7615e5975e523bf8(var_74459050ad50d390.behaviorsettings);
  reward_cache::function_bad4853cae01ad96(rewardcache);
  wait var_d0cf07857479e35a;
  reward_cache::cleanuprewardcache(rewardcache);
  function_cedc6d61411d2269(var_74459050ad50d390);
}

function private function_1331ae66090676bd(rewardcachevariant) {
  if(!isstruct(rewardcachevariant)) {
    return undefined;
  }

  if(istrue(rewardcachevariant.isrewardcache)) {
    return rewardcachevariant;
  }

  if(istrue(rewardcachevariant.var_914a5f8de83cc3dc)) {
    return rewardcachevariant.rewardcache;
  }

  return undefined;
}

function private function_1b8117694b13e92(var_74459050ad50d390) {
  if(reward_cache::isempty(var_74459050ad50d390.rewardcache)) {
    function_db5e480257f4468e(var_74459050ad50d390.rewardcache, "!\xd8o\x12\x1e\x15H\x03yf\xfc\xc2\x8c\xa7.l\xde\xfe");
    function_ab982cc153be88ec(var_74459050ad50d390);
  }
}

function private function_7bc04bea7f6afc7c(params) {
  connectedplayer = self;

  foreach(var_74459050ad50d390 in level.var_b97cb0b1b58a96e7 ?? []) {
    reward_cache::function_e9acfa9658d6d32a(var_74459050ad50d390.rewardcache, connectedplayer);
  }
}

function private function_5d5ee49e6df85c00(params) {
  disconnectedplayer = self;

  foreach(var_74459050ad50d390 in level.var_b97cb0b1b58a96e7 ?? []) {
    reward_cache::function_5bad590251669794(var_74459050ad50d390.rewardcache, disconnectedplayer);
  }
}

function private function_a48905eff8b9563a(var_9def8da7ba5fcf6f) {
  if(isDefined(var_9def8da7ba5fcf6f)) {
    var_9def8da7ba5fcf6f notify("\x8a\xc6\xa7\x17o\xc5U\x1c\x8c=\xfbY\xa7\xe9`\xd8\xc3t\x19\bG\x83v\xef\xf9\xfaF\x1d\xc1UR", undefined);
  }
}

function private function_db57b1409c757850(players, origin, var_bbebc1e05a305ff2) {
  foreach(player in players) {
    if(isPlayer(player) && distance2dsquared(player.origin, origin) <= var_bbebc1e05a305ff2) {
      return false;
    }
  }

  return true;
}

function private function_db5e480257f4468e(rewardcache, despawnreasonstring) {
  if(istrue(getdvarint(@ "hash_c81336f4624077f5", 0))) {
    return;
  }

  var_683b43c97efcbf65 = !istrue(getdvarint(@ "hash_6d8a08730dfb4052", 0));
  infostring = reward_cache::function_e4709712a8e63645(rewardcache, var_683b43c97efcbf65);
  prefix = "\xf6\x7f9\xd0\xacg\xd1\xbcY\xa8";

  if(isDefined(despawnreasonstring)) {
    prefix += "\x99\xbdr\b'VX7{\xe6\b\x82" + despawnreasonstring + "\x8a\xc6";
  }

  reward_cache::function_fb99cbbd062c7471(prefix + infostring);
}