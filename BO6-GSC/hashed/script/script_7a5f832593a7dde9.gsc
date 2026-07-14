/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_7a5f832593a7dde9.gsc
*****************************************************/

#using script_4db4e7f305ce5a21;
#using script_507576ed5f2c7201;
#using script_7c98336d01c2aba2;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace reward_cache;

function spawnrewardcache(rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_c89efc2a897f1a75, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_bdc4a6e0bc8a3b96) {
  if(getdvarint(@ "hash_f5047643143a3941", 0) == 1) {
    thread function_5fe47ebf63509279(rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_c89efc2a897f1a75, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_bdc4a6e0bc8a3b96);
    return;
  }

  var_1eeed4482021783c = function_6baceacf2557b678(rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_c89efc2a897f1a75, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_bdc4a6e0bc8a3b96);

  if(!var_1eeed4482021783c.success) {
    function_77c2ab55612625d(var_bdc4a6e0bc8a3b96, 1);
    return;
  }

  lootfunctionargs = var_1eeed4482021783c.lootfunctionargs;
  func_oncacheitemtaken = var_1eeed4482021783c.func_oncacheitemtaken;
  func_onitemadded = var_1eeed4482021783c.func_onitemadded;
  thread function_892c4e9d803fbcfc(rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_c89efc2a897f1a75, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_bdc4a6e0bc8a3b96);
}

function cleanuprewardcache(rewardcache) {
  function_d6a466a74da70586(rewardcache);
}

function function_da773cefdd47d8cb(rewardcache, player, lootcontents) {
  if(!isrewardcache(rewardcache)) {
    function_d12ff4393ce6a5b("\xd0\xde\xab\x8d\x8c\x01\x9bo:@a\xc82\bl\xb7\xb7t\b\xd1\xde\b\x83\x1b\x85y\x95\x93\x9c\xdc\x01\x9d\xc9\xdeW8\x10\x9c\xacwa\x93#\x8b\x02R\xdcgalK\xc8 9\xb2wa\x93\xc8C\x85\x8dh\xcaH", undefined, player);
    return;
  }

  if(!isPlayer(player)) {
    function_d12ff4393ce6a5b("\xf8\xe7\xbbP\x85\x9a)\x03\x81;\x1d\x94,OF\nH\x13V\xf4\xf5\xd1\xb9C\f\xcdO\x7f\xa3?\x05\xf0\xa5\xf7\x9c\xd8\xf2,-\bco\x9f4\xbc>\xad\xe1x\x02\xe7(\x14Q\xaaQ\x04\x84\xa5\xbc", rewardcache, undefined);
    return;
  }

  if(!function_d7b6326ec20326d9(lootcontents)) {
    function_d12ff4393ce6a5b("+\x18{N\x04)$\xbe\xb7\xed\xf0v\v\xff\xecR\x90\xcb{\xd2\xf1QM\xe6t|\xe8D/y\xe9Kj\xe5z\x18\xb1\x1eA\x97\x94\xfa**\x84\x15}\xff9\x80\x1b]\xabj\x95\x14\xf2\xcbP\xea\x0e\xfc\xdf\x8f\x1d\xabg", rewardcache, player);
    return;
  }

  grouprewardcache = function_c3e653d72cd09688(rewardcache, player);

  if(isDefined(grouprewardcache)) {
    function_71acb65b7be2353a(grouprewardcache, lootcontents);
    return;
  }
}

function function_f78413a01c89a330(rewardcache, player) {
  if(!isrewardcache(rewardcache)) {
    function_d12ff4393ce6a5b("\xd92\x9b\x11AR\xb6h\xdd\xd0\x7f\x89\xd9\x16\v\x10\xd0\n\xf2m9;\xe0c\xd5m\x979\xbfmb\x10\xa2\xf6D\xe5\x93\a\xc4{\xc5 \x83\xd9O\x96\xdb\bA\x9af!\x89\xde", rewardcache, player);
    return -1;
  }

  if(!isPlayer(player)) {
    function_d12ff4393ce6a5b("{7h\x95vg\xa0\xed\xf7\xdc\x84n\xaf4\x85\x85\xf5XpU#\xc4\x9d\xf0\vmH\xf8``\x8c\xf3@\xa9|\xc0W_G<\xb0#\ap3\xd8u\x02\xa5", rewardcache, player);
    return -1;
  }

  grouprewardcache = function_c3e653d72cd09688(rewardcache, player);

  if(!isDefined(grouprewardcache)) {
    function_8abc48b08a4b4075("\xa2\xa2)a\xf2\x18\x94\xbf\x1b; \x97RO\xa7\x87\xd9\xc5\xccnu\xdd9u\x16\xed\x90\xf8\x16|\x82t\xb5\xe7E\x1a\xbe\xf18fq+\xce29\xd03ZP\xe5|\x06\xe8k\x98\xbd\x0eh\xb8\xef#\x1f\xb0W!A\xd8\x10\x9cp\xcd\xf1\xbbZR\x85\x93\xd8\x93\xbc8b\xa5\xe6b\xff.\xe1\x80hn\xdf=");
    return -1;
  }

  return function_f1af8fab65285552(grouprewardcache);
}

function function_fd58ce4d52e1698f(rewardcache, player, reservedslotindex, item) {
  if(!isrewardcache(rewardcache)) {
    function_d12ff4393ce6a5b(":\xb5\x1a\f\x9a\r\x99z\xe2D\xd5,px\t6\x8aU\x01Bx\xcb\xce\xa2\xd8_\x14\xb5\xa0\xa7\xda\x88\xca\xab\xf7\x1c\xc71?\xd9\x1b\xb1\xe6+\xc1\x829\x14\xc1\x91\xbcE\xcdW\xcd\xbb\x96Ob\x9e\x04\xb7\xe5/\xed\x9f\xadP\xb8\x98\x7f\x99", rewardcache, player);
    return;
  }

  if(!isPlayer(player)) {
    function_d12ff4393ce6a5b("\xd5H&(\xb5\xac(`gN\xd8\xc9\xc90\t\x03(V\x9d\x96\xc5\xbeC)\x9cse4\x1c\x06\xf1\xde\xd3\xb4\x19\x8f\xe9$\x0f\x19\xa1\x1a\xc1\xf3\xc0\\&St\xc5`\xc3u\xb6k\xc8Y$m\xdc'\x0e\xf3]\xcc\xef0", rewardcache, player);
    return;
  }

  if(!isint(reservedslotindex)) {
    function_d12ff4393ce6a5b("Q#)\xb7/\xf7\xf4\xbb\\\xc8\xfe\xe8\xdba\xf6\xe6!\xafS4n\xaeavq\xf7\xc8\xa3\x12\xc7\x92\x16\xab\xe0\xfb\xae\"\xccd\x02\xf0$s\xfe\xb7~Y\xd5V4!p\xddV \xe3\v\xb6f\x84Z\x8c\xd3=W(\xd7lN\f\"\xc6\b\x85\x8e\xf7\x94\x01\xbc\x8a\xaf\xf6\x0e\rP\v\x80\x17_<", rewardcache, player);
    return;
  }

  if(!function_d7b6326ec20326d9([item])) {
    function_d12ff4393ce6a5b("\x16\x91\x93\x8a\xfd\xdf$\xc4H\xa6\xaf\xbf\xee\xb9\xbd\xbd\x15\xb4\xbdnd\xd7\x16J\xc3\x16wM\xf0\xd4k\xa8\r\xee\xdaz\xdd\xd5>\xc2\xc2\x12\x1d7\xce\xb9\x88\x91p\x86x\xcc\xd4.\n\xcaE\"\x17\xdf\x82\xb3\x84\x01\xa7", rewardcache, player);
    return;
  }

  grouprewardcache = function_c3e653d72cd09688(rewardcache, player);

  if(!isDefined(grouprewardcache)) {
    function_8abc48b08a4b4075("\x81'\xed\x18Y\x8e\x1d\xc8Mfr\x91\xc1`\x97\x808\xb7\xd0S\x17\xb6\x82\xb1\xdf\bj\xc5\x01\x8f\x03\xd0 \xaboKA\xfb\xef6\xd5\xa2s#1\xb0\xafPx\x03\x8ei\xa5\xf2\xc6$f\xfd\xbbQqJo\xbbp\xf3\x9c\xb1\xbb\xab\xbc&m\xd2\xc6\xb5\xc0\x92\x12\xe0\xb07p\xf3qB\xa0\x15v\xfe\n\x9d\xe1\xfc\x8b\x80\xf0\x8a\xda\xe9\x0fj\x8a\x9dW\x06b\xcf\x90Uz", rewardcache, player);
    return;
  }

  if(reservedslotindex >= grouprewardcache.contents.size) {
    function_d12ff4393ce6a5b("\xd1\xb2\x1f\xe1\xc9\xec%GQ\xfe\xa1\xc8\xaa%\xe0\xf7~\x17\xef\x86\x1a\xd8\xfe\x1a\xf5f\xb1\xa8\xe16DP,W\xa2&^\x17\a7\xaf\xd3&\x96\xa4\x8aGj\x05\xc1=\xf8^e\x19o\x89\xa6\xaa\xd2q\x8b\x11=\xdd5\xbd\xec^\x85\xe1\x1d" + reservedslotindex + "\x9a\xc0\xe8.\xf4\xbe?\x12\xb4\xe6\x8c\xcecm\xee\x13&\x0e\xb3Tj\x0f\xad6Dkt\xef!\xbd\xce\"Lk\xe2t\xd7\x9fR)\x8c\xf4", rewardcache, player);
    return;
  }

  reserveditem = grouprewardcache.contents[reservedslotindex];

  if(!istrue(reserveditem.var_bf8bcee2ba8aed90)) {
    function_d12ff4393ce6a5b("}\xdf0\xc2\xf0\x10\x7f\x10\x7f;\xd3am\xea\xe3\x12\x89}\xef\x9a\xc20%GE\x91\xab\xb0\xfd\xe4\xd7\xf3\xc5\x1a\xb5\xfc\xba&\xb7\x99RF\xea\x05:\x97:\vs\x97\xab\xdb\x94Hqo\xc4" + reservedslotindex + "\xa3\x82F\xcaj\x12\xdb$F\xff\xd5\xd8\xcf?\xb3f\"", rewardcache, player);
    return;
  }

  item.var_bf8bcee2ba8aed90 = 1;
  function_38b3fdeb4f74aace(grouprewardcache, item, reservedslotindex);
}

function isrewardcache(rewardcache) {
  return isstruct(rewardcache) && istrue(rewardcache.isrewardcache);
}

function function_56f2dad98bf8e9f6(grouprewardcache) {
  rewardcache = grouprewardcache.rewardcacheowner;
  nonplayerfound = 0;

  foreach(player in grouprewardcache.playerowners) {
    if(isPlayer(player)) {
      function_d6cfb7ea6ca28112(rewardcache, player, 2);
      function_9436bdc9b2451d05(rewardcache, player);
      continue;
    }

    nonplayerfound = 1;
  }

  if(nonplayerfound) {
    function_bef06080f8281ae0(rewardcache);
  }
}

function function_bad4853cae01ad96(rewardcache) {
  foreach(grouprewardcache in rewardcache.grouprewardcaches) {
    function_56f2dad98bf8e9f6(grouprewardcache);
  }
}

function function_e01e29652e3ee256(instance, part, state, player, bautouse, usestring) {
  if(!istrue(instance.var_e0646ec9a7d23f5b)) {
    return;
  }

  interactionpoint = instance;
  rewardcache = interactionpoint.rewardcacheowner;
  assert(isDefined(rewardcache));
  function_d9719e541a78e886(rewardcache, player);
}

function function_e9acfa9658d6d32a(rewardcache, connectedplayer) {
  function_9c7d4b4cf3d50680(rewardcache, connectedplayer);
}

function function_5bad590251669794(rewardcache, disconnectedplayer) {
  if(!arraycontains(rewardcache.playerowners, disconnectedplayer)) {
    return;
  }

  function_6ee50b259c7debf(rewardcache, disconnectedplayer);
  function_5c0c4141a4c76e4e(rewardcache, disconnectedplayer);

  foreach(grouprewardcache in rewardcache.grouprewardcaches) {
    if(arraycontains(grouprewardcache.playerowners, disconnectedplayer)) {
      grouprewardcache.playerowners = arrayremove(grouprewardcache.playerowners, disconnectedplayer);
    }
  }

  var_e14f28f796112100 = [];
  var_3cb2347c8c6a8ca3 = undefined;

  foreach(var_1f595f0d12f0b1ad in rewardcache.var_5c377808b1a78e60) {
    if(var_1f595f0d12f0b1ad.playerowner == disconnectedplayer) {
      var_3cb2347c8c6a8ca3 = var_1f595f0d12f0b1ad;
      continue;
    }

    var_e14f28f796112100[var_e14f28f796112100.size] = var_1f595f0d12f0b1ad;
  }

  rewardcache.var_5c377808b1a78e60 = var_e14f28f796112100;
  function_1faba11864781e36(var_3cb2347c8c6a8ca3);
}

function function_bef06080f8281ae0(rewardcache) {
  function_1ea59d95de38d63e(rewardcache);
  var_e14f28f796112100 = [];
  var_3cb2347c8c6a8ca3 = undefined;

  foreach(var_1f595f0d12f0b1ad in rewardcache.var_5c377808b1a78e60) {
    if(!isDefined(var_1f595f0d12f0b1ad.playerowner)) {
      function_1faba11864781e36(var_3cb2347c8c6a8ca3);
      continue;
    }

    var_e14f28f796112100[var_e14f28f796112100.size] = var_1f595f0d12f0b1ad;
  }

  rewardcache.var_5c377808b1a78e60 = var_e14f28f796112100;
}

function function_c3e653d72cd09688(rewardcache, player) {
  foreach(grouprewardcache in rewardcache.grouprewardcaches) {
    if(arraycontains(grouprewardcache.playerowners, player)) {
      return grouprewardcache;
    }
  }

  return undefined;
}

function isempty(rewardcache) {
  foreach(grouprewardcache in rewardcache.grouprewardcaches) {
    if(!function_b575f2dfe9d3381c(grouprewardcache)) {
      return false;
    }
  }

  return true;
}

function function_b575f2dfe9d3381c(grouprewardcache) {
  contents = grouprewardcache.contents ?? [];
  items_remaining = 0;

  foreach(item in contents) {
    items_remaining += item.quantity;
  }

  return items_remaining == 0;
}

function function_eeafe24608676e0c(rewardcache) {
  return rewardcache.interactionpoint.origin;
}

function function_5ee21549446ee9f2(rewardcache) {
  return rewardcache.interactionpoint.angles;
}

function function_ae0a5833f0326cac(rewardcache) {
  return utility::array_difference(level.players, getplayerowners(rewardcache));
}

function getplayerowners(rewardcache) {
  return rewardcache.playerowners;
}

function function_f2d992ce8d009f2e(rewardcache) {
  return utility::array_difference(getplayerowners(rewardcache), function_b2ea99bb349f5ae3(rewardcache));
}

function function_b2ea99bb349f5ae3(rewardcache) {
  return rewardcache.var_cd245e2ddcc26bf4;
}

function private function_5fe47ebf63509279(rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_c89efc2a897f1a75, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_bdc4a6e0bc8a3b96) {
  var_7d717392f7e879b9 = 0;

  if(!isDefined(playergroups) || !isarray(playergroups)) {
    function_77c2ab55612625d(var_bdc4a6e0bc8a3b96, !var_7d717392f7e879b9);
    function_d12ff4393ce6a5b("\xaa\xb2\x99\a{7\xdb\xcdx\xbcl:\xa8\x93\xfcN\x8d\x0f\xc9\x80Q\xed\xbdF\xb4W}\xd3\n\x1f\xc9\xf2R\xbbZO\x97\xdbv\x10\a\xcd\xae\x1c\xe0\xaf\x83\xa1\xb7\xdb\xa9\x17\xa6\xb9&\xa7\x89-\x16`\v'\a=4\v\xc2\x13\xf7\xe0\xd5\x18");
    return;
  }

  if(!function_a061b6ec6e3d1a77(placementstruct)) {
    function_77c2ab55612625d(var_bdc4a6e0bc8a3b96, !var_7d717392f7e879b9);
    function_d12ff4393ce6a5b("\xf3\x1fv\x9e\x14$\xea\xfcP\xb4\\\xd1\xb2\xfa\xb0\x1an9\x84w\x80x\xd1\xc0t$t\xa9\x97\x16%Ql\xd0\xfd^`\xbc\xf9\xa8@e\xa0\xcd\xdf7P\xd0{Iq\x15~\xd6\xa6@\xc5\x13\x88Y\x91\xf2\xf3\xe9\xb0\xb7*\xa1l\xd6\x10\xf0.\xa6\xe3\xc95\xa1(\xbdQ\x86\x17\x85T\xdc\xb8/\xf4A$\xba[O@J\xc6\x8c\xbd\x0e\xebY\xc0F\xfc\x94\n\x15\xe47!Q\xb4(\x12si\xd6n\x8b\x90 \v");
    return;
  }

  if(!isDefined(func_openlootablecontainer) || !isfunction(func_openlootablecontainer)) {
    function_77c2ab55612625d(var_bdc4a6e0bc8a3b96, !var_7d717392f7e879b9);
    function_d12ff4393ce6a5b("\x11\xb9\x05%\xb3BA\n\x06J\xf1\x9f/\x80\xd1\x8dh\xbd\x9d\x18\xb7\x81C\n\x1aA\x1d\xdb%\xd8TMH\xd4\x85\xe9\x8fU\f\":+\xd0\xb7`\xa8\x95\xe9\xe5P\xdc&\x83\xe1J\x8e:x\xea\xbf\x05\xbc\xb9\x91\xd8\xb5\xd0\x19\xb7\xe8d::O\xf5\xc7#\xd8U\xc9M\xb5\xd8\x18\x9f\xc1C>vAi\xa7q\x85\xe9[A9\xbc-\xcbu|6;");
    return;
  }

  if(!isDefined(var_c89efc2a897f1a75) || !isfunction(var_c89efc2a897f1a75)) {
    function_77c2ab55612625d(var_bdc4a6e0bc8a3b96, !var_7d717392f7e879b9);
    function_d12ff4393ce6a5b("\xf8$u\x93\xf1a\xde\x18\x04y)\xd5\x91[4\xb6\x8c>\xde-\xc3A\xbe\x81\x8d\xdf?\xf7sp&\x9e\x9c\xa6\xde\xd5\xd1;x\x9b\x9b\v\xe9\xd3{rf\x8a\xb2\x12\x1d\x0f\xc71u\x19/x\xa9\xd9;A0\x84\xbe(A\x11\xcfO\xdf/\x1bv\x13\xd7\x83C \xa440z\xf1\xc97\x97\x05\x85\xdfu\xf1-\\\x02\xa6\xaa6\xc6");
    return;
  }

  if(!isDefined(lootfunctionargs)) {
    lootfunctionargs = spawnStruct();
  } else if(!isstruct(lootfunctionargs)) {
    function_77c2ab55612625d(var_bdc4a6e0bc8a3b96, !var_7d717392f7e879b9);
    function_d12ff4393ce6a5b("#\x97\x92\xc7\xddL\x14\xae\xba\x10\xc1z\xc3J\x1a\x12tX=yf`\xa4\x1d2_\x8cc\xe7\x93\x14q\xcc\r.\x92\xe5\xb27}\xc9.\xfb\xe1_\xc5Y8\xba\xa1\t\xdd\xa9\xde\x84\xa77\xc1\xeaG\xb806R>>^\x83O\xf0b\xdd\xb5u\xc3\xae");
    return;
  }

  if(isDefined(func_oncacheitemtaken) && !isfunction(func_oncacheitemtaken)) {
    function_79db779671b9ca27("B\x1bm[\xc5\"\xa1\xd8\x98\xdb\fO:\xc7\x10\x8a5\xa1|\xfb\xd8L\x0f\x98\r:s6H\xd1\x11\x85f\x05^\xf1\xa5\x13\x1bB\x8b\x05l\tvR\x02k\x1dXd\x83}\x01\xe6\n\x8dyZA\xa5\xde\x1a(\xb9\xc0\x8ce\xfcZq\xa3\x01\x17,\xf8t\xcf\xe1\xb5\xb4\xc0>\xb7\xe9\x8c\xd9\xef#\xfd\x9c?\x8e$\xc5\x910\x82\xfa4mT\xeb\xcdV\xf4\n\xd6\x12\x87X}\x9f\x80\xf0\xf3-\xe5\xa1^g\xc5\xd5\x87\xeb\xda\a\xe4Q\x04\xe1J");
    func_oncacheitemtaken = undefined;
  }

  if(isDefined(func_onitemadded) && !isfunction(func_onitemadded)) {
    function_79db779671b9ca27("\x99W7\xc6\xf5\xf6\x9b\x94t\xac[\nd\x8cY\x8c\x02in 2\xac3ZnY\x19\x01&u\xe8 \xb4\xcd\x02s\xf6\x8e\x02\v\bf\xea\x9b\x1b\xe8Z\xbd\xcd$\x01\x15\x86\xca\x10\x93e\xee\xc2\x9cd@\x1b\v\xb1\xd0\xac\x10\xbbZ\x8dc\b\xdctZ\xb1\xc6\x02\x9b8\xb0w\xe6\x80Lu\x8e\x04w-t\xd0\xbd\xd5\xa3 \x16ny\x10\xbd\xdc)\x1de\xad(2FV2\x01\x99\xd5\xcd\x8d\xa3K\xbd\xdc\x166K\x8e\xcb\xb8");
    func_onitemadded = undefined;
  }

  playergrouplootstructs = [];
  spawnorigin = namespace_25b52ebe6ab1a0c8::getplacementorigin(placementstruct);
  spawnangles = namespace_25b52ebe6ab1a0c8::function_96779bd79cb870df(placementstruct);

  foreach(playergroup in playergroups) {
    if(!isarray(playergroup)) {
      function_79db779671b9ca27("\xba\x9f\xbcrp\"\x89\x15\n\xa6\xdc\xc9\xc4\x7f\x85\xa1u\xe3\xed\x87\xd0]h\x17\x82\x01\xee9Y\xfb0\x1bks\x9f\x97\v\xb1\x85\x80a\xba\x9f\xec\x9e\xa6\xb43qU7\xe4\xfdt\x15q#g\xadF\xcd\xfeL\xff<\x8a\xc8\xb3\xee\x17K`#\xfc\xbb3\xc1\xd7\xe0y\x82\xfb\x7f\xf8\x93\xbcj\x10\x80\x19uR\xca\xc3g\x9e\xbc\xf0\xdf\xa2BGN\x14\x12g\x9bJ8\xfba{\xef\x8ab\xf8tlE\xe5<|\x03\xb9&I\x8c\xd5\xea\x0f\xc7\xc7\xc6\x98I\x80\x86\xef\xb9pX\xf9b\x8f\xd9\x806\x18\xb8\xb7h\x81\x9e\x99\xfd\xf4\x93\x96\"\xf5;\x93\xc7\xd7\x12\x14");
      continue;
    }

    if(playergroup.size == 0) {
      continue;
    }

    lootfunctionargs.reward_group = playergroup;
    lootcontents = [[var_c89efc2a897f1a75]](lootfunctionargs);
    playergrouplootstructs[playergrouplootstructs.size] = {
      #lootcontents: lootcontents, #playergroup: playergroup
    };
  }

  if(playergrouplootstructs.size == 0) {
    function_77c2ab55612625d(var_bdc4a6e0bc8a3b96, !var_7d717392f7e879b9);
    function_79db779671b9ca27("\xa2:[y{\x93H/v \xf0\x02\x9a\xf5\xa6\xcb\x1b}\x16\x19\xc1T\xc4\xe6`\xc4Q\xce\x02S4\xf2T\x0f\xb4Z\xe3\xc3Nh\x0e\xaf\xf49[\x1e\x9cg\x1f0f\xe3\x06\x19\xba\xc3\x81-8\xe40\xc10\xef\x90\xe8\"a\xa6\xde*5\xf1\t\xfa\t\xa0\xc84\x9e\xa4\x83\t\xb0\xfe\x04\xf4");
    return;
  }

  var_c8dc13cf9f45833a = namespace_25b52ebe6ab1a0c8::function_dec88be3feef4980(placementstruct);

  if(istrue(var_c8dc13cf9f45833a)) {
    function_c982c3c12e42353(playergroups, placementstruct, placementstruct);
    placementstruct waittill("Z\x0e\xc8\x1cL\xdb0\f\x9d1\xba\xde\xffyUdV\xa5\xeb\xeawi\x80\xd2t\xf1\xc6|\xfcV\xc8)\xeds\x9f", spawnorigin);
    playergrouplootstructs = function_51f5d54f157ed5d2(playergrouplootstructs);
    var_7d717392f7e879b9 = 1;
  }

  if(playergrouplootstructs.size == 0) {
    function_77c2ab55612625d(var_bdc4a6e0bc8a3b96, !var_7d717392f7e879b9);
    function_79db779671b9ca27("\xbdt\x90\x9dF\xad\xf4\xbbb\xe1\xd6\x84\"\xbb\x81\x167\xd3\xe5D\xaf\xf5|z\xf0\xa0\x03\xe3\xc6(v\x15\xce\xc3:a\x94{X\x111:m(\xa4o9T\xbc\x17u3\x91s\t\xfe\a\x12\x1f$-\x80\xe2\x8e\xdc\xa8}\x04F\v\xf9\xb2BP\xf7'\x0f\xdc\xf1\x84\xc3K\xe8\x1a>s\xea\v\xad\xd5S\x96\xc3\x8a\x1f%\x90~@)\x01\x0f\xd8\xb5N<\xf0_\xa9\xd4TV\xf0\x88\x18\x95\xb3\xac\x817\xd0V6]\xd2^&]\xd6M\x18\xddM\xf9\x1d\x12\x01oFp\x93D{FA\xe5\xaa5j\xb6\xa9\xd7w\x9c\xbd{\x93Jc-N\xd0\xe9E\x7f\xa9\f/F\xec=:\x02\b\xb6\x89\"M\x86\xf28\xb7\x99\x88+\x0e\x81\xa7\"\x92k\xba\x80\xa1{\xf6V\x97\xb1.\a\xdd\xaf7\xde\xc9;V\xa8\xf8x\xde\x14G\xdeq\xd0\x9dx\r\xa9\x10$\xf2\xa2ykj\x13:\xf5\xea@F{4\x85,(\xe0\xcc\x1a\xd2\xfd");
    return;
  }

  rewardcache = function_b8ff59c95dc8ecde(rewardcachesettings, spawnorigin, spawnangles, func_openlootablecontainer, func_oncacheitemtaken, func_onitemadded);

  if(!isDefined(rewardcache)) {
    function_77c2ab55612625d(var_bdc4a6e0bc8a3b96, !var_7d717392f7e879b9);
    function_d12ff4393ce6a5b("G\xa9\xf7\a\x8cQ+\x17\x8e\x85\x01\x93\xc0\xc0n:\x80y\xce\xc1Xb\v\xa4\x809\x84\xe6y\x04\x85\x84\x7fU\\\xfeC\x99\xbb\xcbX\xa5B\xdcN\xcd\xa8\xe2Bcf\xd1\x83\x15T'\x11\xb8\xd9\xcf\x89l@\xf5]\xdf%\xb0\v\xb8\xd0l\xe0\xcf\xbcK\x8d\x1f\xceR\xac\xa5\xf5\xc5\x04^{y540\x19i\x10$\xc7\x89#Zb6");
    return;
  }

  success = function_de8961de89f6a8ef(rewardcache, playergrouplootstructs);

  if(!success) {
    cleanuprewardcache(rewardcache);
    function_d12ff4393ce6a5b("|\xa8]\xa3=E\x94p\xde3\xa9\x96\x83\x93\xec\xb8\xda\xc8\xdcE\x84t89f\x14\x96~\xad\xd1O\x1a08DR>S\x0fec\xe2\xec\xb6\xe3\xf6\xcf*\xf8\xaeP\x85,\xde\xc8\x8d\xbf\xa6\x99u\xa7\xd5`\x01\x16\xca\x93\xbb\x1f\xf0{\xdcL7\x0f\x7f\x05\x90o\x982hX\xb2_R\xf0\xech\xc1E\xb5\x14b\xc1\xaf+i\xd8\x06\xe2\v\xf6\x1f(\xe3|\xd0#N\x8f\xc3Z.;mj\xbe\xa0\xcb\xa05I\xb0\x9e?\xec\b\x03:\xcb\x9b\xf4Y\x9e\xc4_q\\t:\xc9q\xc9z\x8fFZ\xbbG\x94\xe2\xab\x9f\x1c\xc7\r\xa0\xcd\x02\x86\x02\x11c\xa6\xfb\xc9i\x1e\x8bVU\xa2\x9e\x18\xef\xb3\xf4\x05Tz\x99\x88\x87\f\xd4\xd1\x11'\xe0w\xb9\x7f\x92D\xc2f\f\a(\xbe\"\xd9\x13!\x1f^\x1e\xe7/%\xbf\xe2\b$\x88\x04\xb3\xc9\xc6\x1f");
    return;
  }

  function_37a7d562ba46a6c1(rewardcache);

  if(isDefined(var_bdc4a6e0bc8a3b96)) {
    if(!var_7d717392f7e879b9) {
      waitframe();
    }

    var_bdc4a6e0bc8a3b96 notify("\xbf\x8e|;\a\xbc\xa44\x15}\xa8\x86\x13|\x9a|e\xa6\xb9ee\xfex", rewardcache);
  }

  function_8275179abb54a926(rewardcache);
}

function private function_892c4e9d803fbcfc(rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_c89efc2a897f1a75, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_bdc4a6e0bc8a3b96) {
  var_7d717392f7e879b9 = 0;
  spawnangles = namespace_25b52ebe6ab1a0c8::function_96779bd79cb870df(placementstruct);
  spawnoriginworkresult = function_d2c20f0610e0512();
  var_524ae6d901137add = function_d2c20f0610e0512();
  thread function_ce40517588db34f5(spawnoriginworkresult, playergroups, placementstruct);
  thread function_ee2a15e809d48cd2(var_524ae6d901137add, playergroups, var_c89efc2a897f1a75, lootfunctionargs);
  workresults = [spawnoriginworkresult, var_524ae6d901137add];
  frameswaited = 0;

  while(!function_284b0bcdb1969fd9(workresults)) {
    waitframe();
    var_7d717392f7e879b9 = 1;
    frameswaited++;

    if(getdvarint(@ "hash_94f4c6adf1621cb4", 0) != 1) {
      function_fb99cbbd062c7471("9y\xd0d\xe5\xb4s\xb9oO\xb4\xef\xec|\xf1\xf27\x97\xd1\xffz\xa4\x898)\x04\xcf>\xbdn\x06^t\x8a\x81Y.$\xbf\x1c\xa8S\xf4I\xf7\xfc^\xbb\xed\r\xf9\x9b\x01\xa1eg\x02\xa8\x85\xf6rJs\xc5\xfb\x05X\xd6\t\x9b6/\xb99<\xb1\xe1Gk\x97!" + frameswaited + "Wk\xe8y\xf0\xc6\xd5\xd1;Wr\x01q\xa9\xca");
    }
  }

  function_fb99cbbd062c7471("?^\xcc\xeeV\xe1X\x97'D|P\xc48B\xd7\xe8\xcc\x94\x98\x92\\\xd6N\x94/Ot\tF\xd0\xc4\f\xebp!G\x17R\x13\x1a\xdc\xc7\xc1\xd6\xee\xb4\xf1\x83\x06\x1c4\xd1\xf4" + frameswaited + ";\xec\x04*OH\x1b\x18I\xec\x1a\xef\x17\xe8");

  if(function_5f9ba008503137f0(workresults)) {
    function_77c2ab55612625d(var_bdc4a6e0bc8a3b96, !var_7d717392f7e879b9);
    return;
  }

  playergrouplootstructs = var_524ae6d901137add.resultobject;
  spawnorigin = spawnoriginworkresult.resultobject;
  playergrouplootstructs = function_51f5d54f157ed5d2(playergrouplootstructs);

  if(playergrouplootstructs.size == 0) {
    function_77c2ab55612625d(var_bdc4a6e0bc8a3b96, !var_7d717392f7e879b9);
    function_79db779671b9ca27("\xbd\xcd\x89F-\x91\xaa\xec\xe5x\xc5\xde\xb2!\x86\x85\xe6\xef\x17\x82\x06\xed\xab\x8a%\xee\xed\xbe\xf3\x1b\x81\xa7\xaf\\M\xdd%\xc8\xa8\x81\x03\x84\xd9\xfe\x87m\x02\x7frT:\xe4\xb4g\xbb\x01\x95\xe8\"#\xf7\xb0\xd5\xadE\xe9\xe4Z\xb8\xff\xc9\xa7\xd9N\xb6/h\x92\xea\xb2\xefbd\xfa\x82\x80k\x82\x8bC\xf7F'G\xbd\xefO\x14\x86\x95\x9b\x96a\xf0@\xe5\xfc\x98\xe8\x15k\xfb\xe5.N\xe4\x18IG\x1e\\\xb2\xc7\xcf\xdb\x1e\x1a\xe5\xb7\xd6F\xca\xf7\x03\x02\xcb<\x9d,\x89\f`\xf3I\x8aV\xf4\xc2\x87\x84 f\xa8\x81K\xef\xcd\x88N_\xf1\x94U\xdd\x87\xee\xb4\x847\x0e\x1a\x80\x12\x8eo\x0e\x12\xd0\x1b``w\xc4\xc2\xe1\xb0\x93w\x89\xa1.\x89\xc2\xc8^$%\xd1\xa8\x8aV\xd8\xbc\xf9U\xd9\xb6\xac\x13\xa1\r\xa72(\x1e\xa57(\xe9\x95A\x85\xed\x8cE\xf3.\xfee\x1aM\n>(\xca\xe9\xff\xe3\x15A\a\xa2\\\xbe\xcf\x8b\x02\x9f\xbb\xad\x1f");
    return;
  }

  rewardcache = function_b8ff59c95dc8ecde(rewardcachesettings, spawnorigin, spawnangles, func_openlootablecontainer, func_oncacheitemtaken, func_onitemadded);

  if(!isDefined(rewardcache)) {
    function_77c2ab55612625d(var_bdc4a6e0bc8a3b96, !var_7d717392f7e879b9);
    function_d12ff4393ce6a5b("G\xa9\xf7\a\x8cQ+\x17\x8e\x85\x01\x93\xc0\xc0n:\x80y\xce\xc1Xb\v\xa4\x809\x84\xe6y\x04\x85\x84\x7fU\\\xfeC\x99\xbb\xcbX\xa5B\xdcN\xcd\xa8\xe2Bcf\xd1\x83\x15T'\x11\xb8\xd9\xcf\x89l@\xf5]\xdf%\xb0\v\xb8\xd0l\xe0\xcf\xbcK\x8d\x1f\xceR\xac\xa5\xf5\xc5\x04^{y540\x19i\x10$\xc7\x89#Zb6");
    return;
  }

  success = function_de8961de89f6a8ef(rewardcache, playergrouplootstructs);

  if(!success) {
    cleanuprewardcache(rewardcache);
    function_d12ff4393ce6a5b("|\xa8]\xa3=E\x94p\xde3\xa9\x96\x83\x93\xec\xb8\xda\xc8\xdcE\x84t89f\x14\x96~\xad\xd1O\x1a08DR>S\x0fec\xe2\xec\xb6\xe3\xf6\xcf*\xf8\xaeP\x85,\xde\xc8\x8d\xbf\xa6\x99u\xa7\xd5`\x01\x16\xca\x93\xbb\x1f\xf0{\xdcL7\x0f\x7f\x05\x90o\x982hX\xb2_R\xf0\xech\xc1E\xb5\x14b\xc1\xaf+i\xd8\x06\xe2\v\xf6\x1f(\xe3|\xd0#N\x8f\xc3Z.;mj\xbe\xa0\xcb\xa05I\xb0\x9e?\xec\b\x03:\xcb\x9b\xf4Y\x9e\xc4_q\\t:\xc9q\xc9z\x8fFZ\xbbG\x94\xe2\xab\x9f\x1c\xc7\r\xa0\xcd\x02\x86\x02\x11c\xa6\xfb\xc9i\x1e\x8bVU\xa2\x9e\x18\xef\xb3\xf4\x05Tz\x99\x88\x87\f\xd4\xd1\x11'\xe0w\xb9\x7f\x92D\xc2f\f\a(\xbe\"\xd9\x13!\x1f^\x1e\xe7/%\xbf\xe2\b$\x88\x04\xb3\xc9\xc6\x1f");
    return;
  }

  function_37a7d562ba46a6c1(rewardcache);
  function_cc9aa8db9d0a3913(var_bdc4a6e0bc8a3b96, rewardcache, !var_7d717392f7e879b9);
  function_8275179abb54a926(rewardcache);
}

function private function_cc9aa8db9d0a3913(var_9def8da7ba5fcf6f, rewardcache, var_5b7ace59c9f25888) {
  if(isDefined(var_9def8da7ba5fcf6f)) {
    if(var_5b7ace59c9f25888) {
      waitframe();
    }

    var_9def8da7ba5fcf6f notify("\xbf\x8e|;\a\xbc\xa44\x15}\xa8\x86\x13|\x9a|e\xa6\xb9ee\xfex", rewardcache);
  }
}

function private function_77c2ab55612625d(var_9def8da7ba5fcf6f, var_5b7ace59c9f25888) {
  if(isDefined(var_9def8da7ba5fcf6f)) {
    if(istrue(var_5b7ace59c9f25888)) {
      waitframe();
    }

    var_9def8da7ba5fcf6f notify("\xbf\x8e|;\a\xbc\xa44\x15}\xa8\x86\x13|\x9a|e\xa6\xb9ee\xfex", undefined);
  }
}

function private function_83ded3ca56ba9428(rewardcache, players, contents) {
  if(!function_cc81398e149c94b3(players)) {
    function_79db779671b9ca27("\x90\xa9z\x7f\xd3 \x8f\xcf\xed\xb2 J\xa1\xe4\xf7z\x7fH]\xad\xae\xd06v\xef\xe1\x19yuoaf@b\x88\xf0\xc8\x84\x02G\xc2\xccX\xc0\x93\xb6\xc8\xa7\x7f\x87tF\xe1\xbe\x8f\xbe\xe0sb6?\xfc\x19b\xf9\\Vuh\x1c\x1e\xf0\xa0\xa9b\x82`Y;\x7f\xc8\xa2\xba\n\xb4\xc0m\xa0\x9c\x18\x02\x81\xe8Fr\x90\xe7\xee\xf8\x8a\xaa\x1c\x90\xe3\xd88\xc2@9\x88\xed\xbe\xe9\x8d\x933");
    return 0;
  }

  if(!function_d7b6326ec20326d9(contents)) {
    function_79db779671b9ca27("\xe3\xdc\x15\x9e\xbf\x865\xec<\x93\xfc\xc5A\xd0\xadB]4nfS\x9d\xea\x88\x98\xd5M_A\xbc`\xa3L4\xab\x7f3\x80\xb3\xe4\x96\x04\xaeU\xa2\x04\xfa\xe9-u;,zI\xbb\xa5\xca\x05\x19\xa0\x9c\xe1?\xde@[;\x9a\xa2m\x88\x8a\x8f^\x7fi\xc4\xe9\x81\x8e\x0euF4\xf9?\xd0)\xe0\x9b\xbe\xbf!\x16\t\xea\x0e3\x1c\xdb\xfb-\x1b4Y\xe1%Yg1Y\xc8\x05~\xda6\xa9O\xdc\xe7UR\x1d:\x17\x8d\xfel\t\x9d\xc4\xf3\xf4,\xb5u\xa8+\xfb\xcc\x83\x99\xcc\xa0\xbfY\xd9\x10d\xaa.d!\xd3\a\x1b!.Tk\xd8\xee\xa9\x02\xbeS\xfe\xe3V\xe87\xdb+;\xdfL\x93!\xae\x14\xbe\xa0n\xa81\x96\x0f\x9b\xcd.\xe2\xa8U1'\xb4\xcb\xab\x9e\xc0X\x052\xa3\xf70\v\x80\xf7\xea\f\xc3\xd4\xf2\xf7~\x99\x95E\xb8fW\x9f\xd5\x8fmT\x9a%N");
    return 0;
  }

  grouprewardcache = function_ba3730cdb31ecaf(rewardcache, players, contents);

  if(isDefined(grouprewardcache)) {
    rewardcache.grouprewardcaches[rewardcache.grouprewardcaches.size] = grouprewardcache;
  } else {
    function_79db779671b9ca27("\xb3\xc4\xaf>\x9dJs\a\xbd\xae\t\xbf-k\xb5L\xe6\xe5\xa5\x83\xc2\x18V\xf1-Y\xc9\xf3\x05\x9f\xdeR\x89l\\\xe9O\x84\xbc\f\x97\xdfu_C\x06\xf2Y\xa1\xf1\x8f\x8f\b\x19T;\xf4z\a\x1b\n\fi\xab\x8c\xebVA\xac\x8e\xfb\xdd$8\xfd\xfd\xe0\xfa\x01\xe1\\\xb1}.\xa6^b\xed*\xdc\xc8\xaa\xaa\xcbB\xfe-\xc6\b\xdaU\x14Q\xc5]\x02\xff\xfa\x8a\x8aF\xd7\x8dj\xf0\xf8\x9c\xe8e+C\x9d\xbc]t\x10\\2\x05\x9f\x8f\xfe\xf0\x86\x9b\xc10q\x80D\xd7\xae\xb0\a\x9f%\x01\xe3\t\x1a-\x1dC2Dv\xa89\x92");
    return 0;
  }

  var_4f2746e5b8e34d4 = 1;

  foreach(player in grouprewardcache.playerowners) {
    function_b85a62838a77cb7a(rewardcache, player);
    success = function_e18148dcf1bbbc8f(rewardcache, player);

    if(!success) {
      function_79db779671b9ca27("@\xc8XK\x1b+\xc8 \xd1\xf6\x04\x1b\x93+\xb0\x1dV\x01ll\xd2\xb2n\x1d@\x9di\xb9\xd5\xb0\xc6\x04l\x16\x1bh\xb2\x10\x99\xedN\x80\xc2\x04\xc1\x8da\x97+'\b\x96\xb9@t\xa1\xca\x80\x93+\xee\vN\xc8\x02gr\xf6\xd5\x83\xc5@\xa9\x95V\x02\xd8\xde\xd9@fo\xc9\x012Vta\xb4c\xe6\xe2");
      var_4f2746e5b8e34d4 = 0;
    }
  }

  return var_4f2746e5b8e34d4;
}

function private function_de8961de89f6a8ef(rewardcache, playergrouplootstructs) {
  foreach(playergrouplootstruct in playergrouplootstructs) {
    playergroup = playergrouplootstruct.playergroup;
    lootcontents = playergrouplootstruct.lootcontents;
    success = function_83ded3ca56ba9428(rewardcache, playergroup, lootcontents);

    if(!success) {
      return false;
    }
  }

  return true;
}

function private function_c982c3c12e42353(playergroups, placementstruct, var_267490340405a50f) {
  spawnposition = namespace_25b52ebe6ab1a0c8::getplacementorigin(placementstruct);
  searchradius = namespace_25b52ebe6ab1a0c8::function_9006e8a2256e2f54(placementstruct);
  var_4e78b8644aad0cbd = namespace_25b52ebe6ab1a0c8::function_acd62d73fa67e5bf(placementstruct);
  var_176c18bddf4deb06 = namespace_25b52ebe6ab1a0c8::function_845160e4c149a4cb(placementstruct);
  var_47856fd2e5c89145 = function_785d766fcaeac6ff(playergroups);
  var_89e629a4080e8a5b = namespace_632cf895a7d667a5::function_8c21aa55f6e4f01d(var_4e78b8644aad0cbd, var_176c18bddf4deb06, var_47856fd2e5c89145);
  var_53343ce06ccd06e2 = namespace_632cf895a7d667a5::function_7d57ce11714befd7();
  namespace_632cf895a7d667a5::findnearbyspawnpointguaranteed(spawnposition, searchradius, var_89e629a4080e8a5b, var_53343ce06ccd06e2, var_267490340405a50f);
}

function private function_785d766fcaeac6ff(playergroups) {
  var_d7e8080b4b77325c = utility::array_random(playergroups);
  var_47856fd2e5c89145 = utility::array_random(var_d7e8080b4b77325c);
  return var_47856fd2e5c89145;
}

function private function_369c21f167d92bb0(rewardcache, parent, offset, angles, var_c7486fcdaf73e80e) {
  if(var_c7486fcdaf73e80e ?? 1) {
    thread function_75983688d4bf6624(rewardcache);
  }

  allscriptables = function_b67916468e6fd66a(rewardcache);

  foreach(scriptable in allscriptables) {
    scriptable utility::function_86840030292e0bcf(parent, offset, angles);
  }
}

function private function_b67916468e6fd66a(rewardcache) {
  scriptables = [rewardcache.interactionpoint];

  foreach(grouprewardcache in rewardcache.grouprewardcaches) {
    scriptables[scriptables.size] = grouprewardcache;
  }

  foreach(var_1f595f0d12f0b1ad in rewardcache.var_5c377808b1a78e60) {
    scriptables[scriptables.size] = var_1f595f0d12f0b1ad;
  }

  return scriptables;
}

function private function_b85a62838a77cb7a(rewardcache, player) {
  rewardcache.playerowners = utility::function_e86d2ca144f6bde8(rewardcache.playerowners, player);
}

function private function_6ee50b259c7debf(rewardcache, player) {
  rewardcache.playerowners = arrayremove(rewardcache.playerowners, player);
}

function private function_1ea59d95de38d63e(rewardcache) {
  rewardcache.playerowners = utility::array_removeundefined(rewardcache.playerowners);
  rewardcache.var_cd245e2ddcc26bf4 = utility::array_removeundefined(rewardcache.var_cd245e2ddcc26bf4);
}

function private function_9436bdc9b2451d05(rewardcache, player) {
  rewardcache.var_cd245e2ddcc26bf4[rewardcache.var_cd245e2ddcc26bf4.size] = player;
}

function private function_5c0c4141a4c76e4e(rewardcache, player) {
  rewardcache.var_cd245e2ddcc26bf4 = arrayremove(rewardcache.var_cd245e2ddcc26bf4, player);
}

function private function_b8ff59c95dc8ecde(rewardcachesettings, origin, angles, func_openlootablecontainer, func_oncacheitemtaken, func_onitemadded) {
  rewardcache = spawnStruct();
  rewardcache.isrewardcache = 1;
  rewardcache.settings = rewardcachesettings;
  rewardcache.func_openlootablecontainer = func_openlootablecontainer;
  rewardcache.func_oncacheitemtaken = func_oncacheitemtaken;
  rewardcache.func_onitemadded = func_onitemadded;
  rewardcache.objectivemarkerid = function_521ede498b26dfbb(rewardcachesettings, origin);
  rewardcache.interactionpoint = function_1d36260bf51187db(rewardcache, origin, angles);

  if(!isDefined(rewardcache.interactionpoint)) {
    function_79db779671b9ca27("\xbbh\x9b0X\xf4\xe3c\xa2\x87\xef\x04\x80\x98\x10\xf2Rz\xb0\xd3\x96\xa1P(\x95\"\xe2r\xe6\xef\xaf\xa0\xec\x90\x83\x83\xc5`Y?\x12,\xa8\xb7\xaf&\r\xbe\xc6\x96\v7\xff|\xedSFlN\xab@\xec<65h70\xdc\x91q\xbb\xb74=\x03\xc8\x9c\xf5\xfe\xc2/\xf8>:\x17\xfe\xdc\x96\xff\x0e\xa7\xba\x1a\x9c\x1c\x9d Q6p");
    return undefined;
  }

  rewardcache.grouprewardcaches = [];
  rewardcache.var_5c377808b1a78e60 = [];
  rewardcache.playerowners = [];
  rewardcache.var_cd245e2ddcc26bf4 = [];
  return rewardcache;
}

function private function_d6a466a74da70586(rewardcache) {
  rewardcache notify("\xc0Z'\v\x9eS\xce");
  rewardcache endon("\xc0Z'\v\x9eS\xce");

  foreach(grouprewardcache in rewardcache.grouprewardcaches) {
    function_6e87febb113824f7(grouprewardcache);
  }

  foreach(var_1f595f0d12f0b1ad in rewardcache.var_5c377808b1a78e60) {
    function_1faba11864781e36(var_1f595f0d12f0b1ad);
  }

  function_1bfc5a9155e2e1e3(rewardcache.interactionpoint);
  function_4ad8a7940550e1f9(rewardcache);
}

function private function_ba3730cdb31ecaf(rewardcacheowner, players, cachecontents) {
  var_14432df023f04570 = reward_cache_settings::function_736ba1d975721ace(rewardcacheowner.settings);
  origin = function_eeafe24608676e0c(rewardcacheowner);
  angles = function_5ee21549446ee9f2(rewardcacheowner);
  var_14432df023f04570 = function_b63166b2b617c9c6(var_14432df023f04570, origin, angles);

  if(!function_9236ad0becdf48c2(var_14432df023f04570, 2, 1)) {
    function_79db779671b9ca27("<dev string:x24>");
    function_e39811bcc83ed2b9(var_14432df023f04570);
    return undefined;
  }

  grouprewardcache = var_14432df023f04570;
  grouprewardcache.var_e2db921a91474522 = 1;
  grouprewardcache.rewardcacheowner = rewardcacheowner;
  grouprewardcache.contents = [];
  grouprewardcache.func_oncacheitemtaken = rewardcacheowner.func_oncacheitemtaken;
  grouprewardcache.onitemtaken = &function_8d4f015a1db7d9e3;
  grouprewardcache.func_onitemadded = rewardcacheowner.func_onitemadded;
  grouprewardcache.playerowners = players;
  grouprewardcache.currentopener = undefined;
  function_71acb65b7be2353a(grouprewardcache, cachecontents, 1);
  thread function_6fdc55d3e579ba5c(grouprewardcache);
  return grouprewardcache;
}

function private function_6e87febb113824f7(grouprewardcache) {
  grouprewardcache notify("\xc0Z'\v\x9eS\xce");
  function_e39811bcc83ed2b9(grouprewardcache);
}

function private function_d9719e541a78e886(rewardcache, player) {
  grouprewardcache = function_c3e653d72cd09688(rewardcache, player);

  if(isDefined(grouprewardcache)) {
    function_97379baba5811bb0(grouprewardcache, player);
    argsstruct = spawnStruct();
    argsstruct.cache = grouprewardcache;
    argsstruct.player = player;
    [[rewardcache.func_openlootablecontainer]](argsstruct);
  }
}

function private function_71acb65b7be2353a(grouprewardcache, newcontents, var_4e036ccf539f37f0 = 0) {
  if(isDefined(newcontents) && isarray(newcontents)) {
    foreach(item in newcontents) {
      containerindex = grouprewardcache.contents.size;
      function_38b3fdeb4f74aace(grouprewardcache, item, containerindex, var_4e036ccf539f37f0);
    }
  }
}

function private function_f1af8fab65285552(grouprewardcache) {
  newcontents = [];
  reserveditem = spawnStruct();
  reserveditem.var_bf8bcee2ba8aed90 = 1;
  reserveditem.lootid = 0;
  reserveditem.quantity = 0;
  reserveditemslotindex = grouprewardcache.contents.size;
  grouprewardcache.contents[reserveditemslotindex] = reserveditem;
  return reserveditemslotindex;
}

function private function_38b3fdeb4f74aace(grouprewardcache, item, index, var_4e036ccf539f37f0 = 0) {
  grouprewardcache.contents[index] = item;

  if(!var_4e036ccf539f37f0 && isDefined(grouprewardcache.func_onitemadded)) {
    argsstruct = function_4cb10bbb450da9d5(grouprewardcache, item.lootid, item.quantity, index, grouprewardcache.currentopener);
    [[grouprewardcache.func_onitemadded]](argsstruct);
  }
}

function private function_4cb10bbb450da9d5(grouprewardcache, lootid, quantity, containerindex, currentopener) {
  return {
    #currentopener: currentopener, #containerindex: containerindex, #quantity: quantity, #lootid: lootid, #grouprewardcache: grouprewardcache
  };
}

function private function_49f152906d03ec45(grouprewardcache) {
  newcontents = [];

  foreach(item in grouprewardcache.contents) {
    var_18faaef8dff9df8d = isDefined(item) && item.lootid != 0;
    var_75bd9c223278977f = isDefined(item.quantity) && item.quantity != 0;

    if(var_18faaef8dff9df8d && var_75bd9c223278977f) {
      newcontents[newcontents.size] = item;
    }
  }

  grouprewardcache.contents = newcontents;
}

function private function_6fdc55d3e579ba5c(grouprewardcache) {
  grouprewardcache endon("\xc0Z'\v\x9eS\xce");

  while(true) {
    grouprewardcache waittill("\xdd}S\xf2<\xe9");
    function_a6e3e01f06c782c1(grouprewardcache);
  }
}

function private function_97379baba5811bb0(grouprewardcache, player) {
  function_30e775478df864e8(grouprewardcache);
  rewardcache = grouprewardcache.rewardcacheowner;
  var_2dcd20aa6ffbaeb = function_7dc00dedbf6face1(rewardcache, player);
  function_c9d86c1ab3a4981(var_2dcd20aa6ffbaeb);
  grouprewardcache.currentopener = player;
}

function private function_a6e3e01f06c782c1(grouprewardcache) {
  function_c0264aaebade02a2(grouprewardcache);
  function_be2bdde89b5d5e5b(grouprewardcache);
  grouprewardcache.currentopener = undefined;
}

function private function_8d4f015a1db7d9e3(grouprewardcache, player) {
  rewardcache = grouprewardcache.rewardcacheowner;

  foreach(player in grouprewardcache.playerowners) {
    var_2dcd20aa6ffbaeb = function_7dc00dedbf6face1(rewardcache, player);
    function_aae7abb6a192ff28(var_2dcd20aa6ffbaeb);
  }

  if(isDefined(grouprewardcache.func_oncacheitemtaken)) {
    [[grouprewardcache.func_oncacheitemtaken]](grouprewardcache, player);
  }
}

function private function_be2bdde89b5d5e5b(grouprewardcache) {
  if(function_31373288494b928e(grouprewardcache)) {
    currentopener = grouprewardcache.currentopener;
    rewardcache = grouprewardcache.rewardcacheowner;
    var_2dcd20aa6ffbaeb = function_7dc00dedbf6face1(rewardcache, currentopener);
    function_d4837ee0fcfaaf9c(var_2dcd20aa6ffbaeb);
  }
}

function private function_31373288494b928e(grouprewardcache) {
  currentopener = grouprewardcache.currentopener;

  if(!isPlayer(currentopener)) {
    return false;
  }

  rewardcache = grouprewardcache.rewardcacheowner;
  var_ed844e0d02a8fd1d = reward_cache_settings::function_39e6a3ea3837fc28(rewardcache.settings);

  if(!istrue(var_ed844e0d02a8fd1d)) {
    if(function_b575f2dfe9d3381c(grouprewardcache)) {
      return false;
    }
  }

  return true;
}

function private function_30e775478df864e8(grouprewardcache) {
  rewardcache = grouprewardcache.rewardcacheowner;

  foreach(player in grouprewardcache.playerowners) {
    if(function_80f3abdcf9b44de6(rewardcache, player) == 0) {
      function_6584753a0ad1ff0c(rewardcache, player);
    }
  }
}

function private function_c0264aaebade02a2(grouprewardcache) {
  rewardcache = grouprewardcache.rewardcacheowner;

  foreach(player in grouprewardcache.playerowners) {
    if(function_80f3abdcf9b44de6(rewardcache, player) == 0) {
      function_23a43ad0c8c13215(rewardcache, player);
    }
  }
}

function private function_1d36260bf51187db(rewardcacheowner, origin, angles) {
  var_24cf838052cdffc0 = reward_cache_settings::function_674b646615680cde(rewardcacheowner.settings);
  scriptable_interactionpoint = function_b63166b2b617c9c6(var_24cf838052cdffc0, origin, angles);

  if(!function_9236ad0becdf48c2(scriptable_interactionpoint, 1, 1)) {
    function_e39811bcc83ed2b9(scriptable_interactionpoint);
    function_79db779671b9ca27("<dev string:x85>");
    return undefined;
  }

  interactionpoint = scriptable_interactionpoint;
  interactionpoint.var_e0646ec9a7d23f5b = 1;
  interactionpoint.rewardcacheowner = rewardcacheowner;
  return interactionpoint;
}

function private function_1bfc5a9155e2e1e3(interactionpoint) {
  function_e39811bcc83ed2b9(interactionpoint);
}

function private function_7baf20bd76419dde(rewardcacheowner, playerowner) {
  var_f7e52fe99cee5c4f = reward_cache_settings::function_d5c8876ac47d4c25(rewardcacheowner.settings);
  origin = function_eeafe24608676e0c(rewardcacheowner);
  angles = function_5ee21549446ee9f2(rewardcacheowner);
  var_2dcd20aa6ffbaeb = function_b63166b2b617c9c6(var_f7e52fe99cee5c4f, origin, angles, playerowner);

  if(!function_9236ad0becdf48c2(var_2dcd20aa6ffbaeb, 0, 1)) {
    function_e39811bcc83ed2b9(var_2dcd20aa6ffbaeb);
    function_79db779671b9ca27("<dev string:xe4>");
    return undefined;
  }

  var_1f595f0d12f0b1ad = var_2dcd20aa6ffbaeb;
  var_1f595f0d12f0b1ad.rewardcacheowner = rewardcacheowner;
  var_1f595f0d12f0b1ad.playerowner = playerowner;
  return var_1f595f0d12f0b1ad;
}

function private function_1faba11864781e36(var_1f595f0d12f0b1ad) {
  function_e39811bcc83ed2b9(var_1f595f0d12f0b1ad);
}

function private function_e18148dcf1bbbc8f(rewardcache, player) {
  var_1f595f0d12f0b1ad = function_7baf20bd76419dde(rewardcache, player);

  if(!isDefined(var_1f595f0d12f0b1ad)) {
    return false;
  }

  rewardcache.var_5c377808b1a78e60[rewardcache.var_5c377808b1a78e60.size] = var_1f595f0d12f0b1ad;
  return true;
}

function private function_bb8587da920e800d(rewardcache, player, rewardcachestate) {
  var_2dcd20aa6ffbaeb = function_7dc00dedbf6face1(rewardcache, player);
  var_f7e52fe99cee5c4f = reward_cache_settings::function_d5c8876ac47d4c25(rewardcache.settings);

  if(isDefined(var_2dcd20aa6ffbaeb)) {
    function_d89a65b0cf45dfb6(var_2dcd20aa6ffbaeb, var_f7e52fe99cee5c4f, rewardcachestate);
  }
}

function private function_7dc00dedbf6face1(rewardcache, player) {
  foreach(var_1f595f0d12f0b1ad in rewardcache.var_5c377808b1a78e60) {
    if(var_1f595f0d12f0b1ad.playerowner == player) {
      return var_1f595f0d12f0b1ad;
    }
  }
}

function function_1e24c906931fbc0f(rewardcache, player) {
  utility::callsharedfunc(#"reward_cache", #"showrewardcachemarkertoplayer", rewardcache, player);
}

function function_1828e12b19a61ffb(rewardcache, player) {
  utility::callsharedfunc(#"reward_cache", #"hiderewardcachemarkerfromplayer", rewardcache, player);
}

function private function_75983688d4bf6624(rewardcache) {
  rewardcache endon("\xc0Z'\v\x9eS\xce");

  while(true) {
    waitframe();
    utility::callsharedfunc(#"reward_cache", #"updaterewardcachemarkerposition", rewardcache);
  }
}

function private function_521ede498b26dfbb(rewardcachesettings, origin) {
  return utility::callsharedfunc(#"reward_cache", #"createrewardcacheobjectivemarker", rewardcachesettings, origin);
}

function private function_4ad8a7940550e1f9(rewardcache) {
  return utility::callsharedfunc(#"reward_cache", #"destroyrewardcacheobjectivemarker", rewardcache);
}

function private function_37a7d562ba46a6c1(rewardcache) {
  inactiveplayers = function_ae0a5833f0326cac(rewardcache);

  foreach(player in inactiveplayers) {
    function_d6cfb7ea6ca28112(rewardcache, player, 1);
  }

  activeplayers = function_f2d992ce8d009f2e(rewardcache);

  foreach(player in activeplayers) {
    function_d6cfb7ea6ca28112(rewardcache, player, 0);
  }

  var_2caba2f35d7b3b6f = function_b2ea99bb349f5ae3(rewardcache);

  foreach(player in var_2caba2f35d7b3b6f) {
    function_d6cfb7ea6ca28112(rewardcache, player, 2);
  }
}

function function_9c7d4b4cf3d50680(rewardcache, player) {
  state = function_80f3abdcf9b44de6(rewardcache, player);
  function_d6cfb7ea6ca28112(rewardcache, player, state);
}

function private function_80f3abdcf9b44de6(rewardcache, player) {
  if(arraycontains(function_b2ea99bb349f5ae3(rewardcache), player)) {
    return 2;
  }

  if(arraycontains(getplayerowners(rewardcache), player)) {
    return 0;
  }

  return 1;
}

function private function_23a43ad0c8c13215(rewardcache, player) {
  rewardcache.interactionpoint enablescriptableplayeruse(player);
}

function private function_6584753a0ad1ff0c(rewardcache, player) {
  rewardcache.interactionpoint disablescriptableplayeruse(player);
}

function private function_d6cfb7ea6ca28112(rewardcache, player, rewardcachestate) {
  if(rewardcachestate == 0) {
    function_23a43ad0c8c13215(rewardcache, player);
    function_1e24c906931fbc0f(rewardcache, player);
  } else {
    function_6584753a0ad1ff0c(rewardcache, player);
    function_1828e12b19a61ffb(rewardcache, player);
  }

  function_bb8587da920e800d(rewardcache, player, rewardcachestate);
}

function function_8ecbb0faf9d65732(scriptableassetname, var_f64098209f2084de) {
  if(!isDefined(scriptableassetname)) {
    function_79db779671b9ca27("\xc4i\x110\xbf\x98H\x873/\xa0<H\x1b\xb6L7\fMwG=V%.\xa3\x9f\x93\xd9r3\x92w&\xa7-SE\xc6\xdd\x02D\xfb\xf9\n\x01\xea\x96?\xdd\x10\x92\xa5w\xda)hrfgC\xf5\x85G\xa7Yc\xca\xe5\xa4\xea\x8c1T\xab`\xb3\xca\xb0\x15\xbd\x1e\x95\x95\t\xd9\xdbR\xe7J\xd6\\\xb1zot\xc3\xd60\xaf\xfd>\x95\xc5\x82" + (var_f64098209f2084de ?? "\xed\x1d\va\x1e\xf6\xe5\x88\x8a"));
    return;
  }

  scriptableinfo = function_2ba6c06988b773d1(scriptableassetname);
  function_a86924df228aea25(scriptableinfo, var_f64098209f2084de);
  return scriptableinfo;
}

function function_2ba6c06988b773d1(scriptable_assetname, scriptablepartname, var_2dfb1899549e3536, var_3a929f6b29f5af5c, var_edc5d0b4fa0ab158) {
  scriptableinfo = spawnStruct();
  scriptableinfo.assetname = scriptable_assetname;
  scriptableinfo.scriptablepartname = scriptablepartname;
  scriptableinfo.var_2dfb1899549e3536 = var_2dfb1899549e3536;
  scriptableinfo.var_3a929f6b29f5af5c = var_3a929f6b29f5af5c;
  scriptableinfo.var_edc5d0b4fa0ab158 = var_edc5d0b4fa0ab158;
  return scriptableinfo;
}

function private function_a86924df228aea25(scriptableinfo, var_f64098209f2084de) {
  switch (var_f64098209f2084de) {
    case 0:
      function_39d841f7ce23efe2(scriptableinfo);
      break;
    case 1:
      function_138d8c3e4e8b52ef(scriptableinfo);
      break;
    case 2:
      function_338ec7c8abb9aedd(scriptableinfo);
      break;
    default:
      function_79db779671b9ca27("\xafR\xf2z\x1e\xdeu'\x94\xa9\xbc\xb8\xa9C\x9d\xb3\x99O/\x90\x94\xbei\x81X\x81\n\\\xd5\x98\xca\x95]\xb0\x91\xff\xd9g\xd3_-\xa7\xad\x15\xe5V\xa7\xb8w\xba\xa8(R\xc9" + (scriptableinfo.scriptableassetname ?? "\xed\x1d\va\x1e\xf6\xe5\x88\x8a") + "\xc4\x1f\x8b\x94\xe5y\x04`\aqk\xb20\xbc\xd3\xcd\xe1{\x1e\t\xdb3q\xb6\xdc\xe0cx\xd2\xdabP\xf8\x186q" + var_f64098209f2084de + "\b\xe6\xb7\xe8\x02'Y6o\xec\x9bKz\xac\x19\xc5");
      return undefined;
  }
}

function private function_138d8c3e4e8b52ef(scriptableinfo) {
  scriptableinfo.scriptablepartname = "\xb7\x1bs\xf8";
  scriptableinfo.var_2dfb1899549e3536 = "\x9c\x95\xbb\v\x9cF6a\xd8\xa1e\xbe-\xe6\xd1\xb2\xc9\vc\x1dK\xf6\x9b\x1c\xed\xd2n:";
  scriptableinfo.var_3a929f6b29f5af5c = undefined;
  scriptableinfo.var_edc5d0b4fa0ab158 = undefined;
}

function private function_338ec7c8abb9aedd(scriptableinfo) {
  scriptableinfo.scriptablepartname = "\xb7\x1bs\xf8";
  scriptableinfo.var_2dfb1899549e3536 = "\xfb\xd0\x91\x0eS\xe2\xa9VS0\x89\xbc\xfbW\xca\xab\xd7\x0f\x914\xfb";
  scriptableinfo.var_3a929f6b29f5af5c = undefined;
  scriptableinfo.var_edc5d0b4fa0ab158 = undefined;
}

function private function_39d841f7ce23efe2(scriptableinfo) {
  scriptableinfo.scriptablepartname = "\xb7\x1bs\xf8";
  scriptableinfo.var_2dfb1899549e3536 = "\x94%\xc6\xe1\xdc\x98\xcf\xaf\xff\xda\xbe\xb4\xcf\xabK\x06Y\xbb";
  scriptableinfo.var_3a929f6b29f5af5c = "\x97\xa1\xf6\nV\xb7)\x11B\x84\x8f\xb8&\xed\x8d\x9buZ\x97b";
  scriptableinfo.var_edc5d0b4fa0ab158 = "rew\x16\xc9\x8c\xb1\xc2l\xa1\xb2\xebdY\xcd\x0ea\xbb\xe6";
}

function private function_b63166b2b617c9c6(scriptableinfo, origin, angles, playerowner) {
  assetname = scriptableinfo.assetname;
  scriptable = undefined;

  if(isDefined(playerowner)) {
    payload = [#"teamselect", playerowner getentitynumber()];
    scriptable = spawnscriptable(assetname, origin, angles, undefined, payload);
  } else {
    scriptable = spawnscriptable(assetname, origin, angles);
  }

  if(!isDefined(scriptable)) {
    function_79db779671b9ca27(" \xae\xcd\x16&\xc6\xb2\x10\xd1\xb7\x80\xb98\xc2\xdd\xcd\x01'\xca\xdd\xc2r\xc8\x02\xc6a\xb1\xa1\xac\x01\xb9\x1b9i\xc1\x8e\xc2\x98\x8d\xca\x04\xdd\x96t\x86\x10\xdc\xb0\xadY\x10" + (assetname ?? "\xed\x1d\va\x1e\xf6\xe5\x88\x8a") + "\xe2\x02\xa09\xb2\b\x97\xf6u\x80\xdc\xbaN\x95\b\xd1C\xd2s \xb9lN\xd28\x8e\xc2&\xc6V\x01\xb2\xf0\xa5\xcdt\xcd\b\v\xe6d\x80h,\xb9\x011ee\xe6 8'\xac6X\xc6\rYd~");
    return undefined;
  }

  function_d89a65b0cf45dfb6(scriptable, scriptableinfo, 0);
  return scriptable;
}

function private function_e39811bcc83ed2b9(rewardcachescriptable) {
  if(!isDefined(rewardcachescriptable)) {
    return;
  }

  if(isent(rewardcachescriptable)) {
    rewardcachescriptable delete();
    return;
  }

  rewardcachescriptable freescriptable();
}

function private function_d89a65b0cf45dfb6(scriptable, scriptableinfo, rewardcachestate) {
  scriptablepartname = scriptableinfo.scriptablepartname;
  scriptablestatename = undefined;

  switch (rewardcachestate) {
    case 0:
      scriptablestatename = scriptableinfo.var_2dfb1899549e3536;
      break;
    case 1:
      scriptablestatename = scriptableinfo.var_bab7df40be0cc449;
      break;
    case 2:
      scriptablestatename = scriptableinfo.var_edc5d0b4fa0ab158;
      break;
    default:
      assertmsg("<dev string:x146>" + rewardcachestate + "<dev string:x15d>");
      return;
  }

  function_a9b66770881d1eb8(scriptable, scriptablepartname, scriptablestatename);
}

function private function_a9b66770881d1eb8(scriptable, scriptablepartname, scriptablestatename) {
  if(scriptable getscriptableparthasstate(scriptablepartname, scriptablestatename)) {
    scriptable setscriptablepartstate(scriptablepartname, scriptablestatename);
    return;
  }

  function_d12ff4393ce6a5b("\xad\xcfZ5\x02\x1eHw\xfa\x9f\xba\a\xb7\xda\xcc\xbc:\xcc\xdd\xb1 6?\xf9\xfa\x8f" + scriptablepartname + "\x8b\x1a\x8a\x06\x9b\xf2\xa9bn\xf4v" + scriptablestatename + "K\xc0\n\xed\x04\xba\xc69w\xa8(\xa9\xf2\xfbJ\x95i\x02\xa3;\x85\xea@\xdb\xe2\xbb\xf0\x95");
}

function private function_12723376751bfdd(scriptable, scriptablepartname, var_be8bac015b27c5d, var_ec53883c168e40e4) {
  scriptable notify(scriptablepartname);
  scriptable endon(scriptablepartname);
  var_71819e6c0675a63f = scriptable getscriptableparthasstate(scriptablepartname, var_be8bac015b27c5d);
  var_49540cc26722f5c2 = scriptable getscriptableparthasstate(scriptablepartname, var_ec53883c168e40e4);

  if(var_71819e6c0675a63f && var_49540cc26722f5c2) {
    function_a9b66770881d1eb8(scriptable, scriptablepartname, var_be8bac015b27c5d);
    waitframe();

    if(isDefined(scriptable)) {
      function_a9b66770881d1eb8(scriptable, scriptablepartname, var_ec53883c168e40e4);
    }

    return;
  }

  if(var_71819e6c0675a63f && !var_49540cc26722f5c2) {
    function_8abc48b08a4b4075("\nzI\xbc\xdaV\xaa1\xf1\xefn\xce3m\xff\xc8\x8e>-u\xddx\xfa3\xb2\xaaS\x1e\x7f\x9d\xb85\xcc~\xcc\xbfS\x03\xac\xb0\xb0\xfeU\x9eq\xe9hn\x8f;\xa9\xb2\xc6A" + scriptablepartname + "\xf8\x01" + var_be8bac015b27c5d + "\x80b]t\x01\x9b{\x02in\xc26\xa3\x96\xd9Y\x80\x9b\xe8\vG\xb2@w\xd2\xd14\x04G\r\xb2\b\xdc\x16mV\x10" + var_ec53883c168e40e4 + "\x89\x16\x17\xe7\x11x*+\xfd\x96\xa5\xb1\xfbcm?\x8c\x9f\xa0\xafb\x96\xa8\xf3<\x9e\xe5\xbaI9j}!\xb0&p\tup\xf1A\xad\xf9\fmU\xd3\xe1S\x1dW\xc6\x8a\xe0h\x8b\x11\xaf:F\xe4]\x03*>\x8c\x12\x7fE\xcf\xbd\x97\xc8\xc9\x12\xc1\x1e\xbeB\xad");
  }
}

function private function_aae7abb6a192ff28(scriptable) {
  thread function_12723376751bfdd(scriptable, "\x9d\xcb\x9a1\x97^\x10\xba\xfb\b\xfb", "\xcbu\xbe\x855\xa0~\x87mx\xe8\xa7r\xef9\x0f.\x04\x8d\xd8,\xef\xbc", "\x97\xa1\xf6\nV\xb7)\x11B\x84\x8f\xb8&\xed\x8d\x9buZ\x97b");
}

function private function_d4837ee0fcfaaf9c(scriptable) {
  thread function_12723376751bfdd(scriptable, "*\x1b\xae:A$\xc6D", "g\xfd\xc6s\xcd`\xed\x8c|\xd7w\x19\xb0\\\x8b\x80\xb3&\xfbN", "\x97\xa1\xf6\nV\xb7)\x11B\x84\x8f\xb8&\xed\x8d\x9buZ\x97b");
}

function private function_c9d86c1ab3a4981(scriptable) {
  thread function_12723376751bfdd(scriptable, "?\xca\xa0\x13\r|\xa1\x9c", "\xf1\xb2G\xde\xab\xd0\x87eW\xcbP{\x1e9\x9brf\x99\xc3\xae", "\x97\xa1\xf6\nV\xb7)\x11B\x84\x8f\xb8&\xed\x8d\x9buZ\x97b");
}

function function_88bbf9604e772900() {
  if(!isDefined(level.var_e1a6e291aa734e3f)) {
    level.var_e1a6e291aa734e3f = playtest_logger::function_b89c03b46070f714(@ "hash_9a8fd13708d50583", @ "hash_9d0c095771c6026d", @ "hash_813ebb2dc2b30d1c", @ "hash_693c22d6aae40d2e", @ "hash_176196b9a9745584", @ "hash_56641085422a272c", @ "hash_bd0e9311e61ffefa", ":2+\x1be\xdaa\xd4\xf0\x18\xaa\xc1,\xe8O\x7fF");
  }

  return level.var_e1a6e291aa734e3f;
}

function function_d12ff4393ce6a5b(assertmessage, rewardcache, relevantplayers) {
  assertmessage = function_d959e76f74061917(assertmessage, rewardcache, relevantplayers);
  playtest_logger::logassert(assertmessage, function_88bbf9604e772900());
}

function function_79db779671b9ca27(msg, rewardcache, relevantplayers) {
  msg = function_d959e76f74061917(msg, rewardcache, relevantplayers);
  playtest_logger::logerror(msg, function_88bbf9604e772900());
}

function function_8abc48b08a4b4075(msg, rewardcache, relevantplayers) {
  msg = function_d959e76f74061917(msg, rewardcache, relevantplayers);
  playtest_logger::logwarning(msg, function_88bbf9604e772900());
}

function function_fb99cbbd062c7471(msg, rewardcache, relevantplayers) {
  msg = function_d959e76f74061917(msg, rewardcache, relevantplayers);
  playtest_logger::loginfo(msg, function_88bbf9604e772900());
}

function private function_d959e76f74061917(msg, rewardcache, relevantplayers) {
  var_df4ba22710b4c829 = msg;

  if(isrewardcache(rewardcache)) {
    var_df4ba22710b4c829 += "\xab\x9d\xa7L]m\x16a\xb6\xb4k\x13\x16\x8e\xedH\x13" + function_e4709712a8e63645(rewardcache) + "\b5\x04";
  }

  if(isPlayer(relevantplayers) || isarray(relevantplayers)) {
    var_df4ba22710b4c829 += "\xd0k\xf2|\x88[\xe5[\xffU\xe5\xcd~\x8f\xfaX\xc9\xb4\xd7\x80\x94" + function_298690ea789d9d40(relevantplayers) + "\b5\x04";
  }

  return var_df4ba22710b4c829;
}

function private function_8275179abb54a926(rewardcache) {
  if(istrue(getdvarint(@ "hash_c81336f4624077f5", 0))) {
    return;
  }

  var_683b43c97efcbf65 = !istrue(getdvarint(@ "hash_6d8a08730dfb4052", 0));
  infostring = function_e4709712a8e63645(rewardcache, var_683b43c97efcbf65);
  function_fb99cbbd062c7471("\x9a8\x85\xbb\x9b\xca2\b" + infostring);
}

function private function_8465cea250f71252(scriptableassetname, missingstates, var_3f833eeeef92556) {
  return "M\x9d\xf6z\x90\f\xc7\xfd}\x9a\tp\xd3( \x12\x9d9\xaa\xa2l\xb4\xab\xe4q\xfc\xd7\xefY\xa0" + scriptableassetname + "\xb0W\x8f\xc4\xa8KQ\xfd\xcf\xe0n\x02\x95M\xa6\xa4\xff\xd3\xb4*\f\xeaA\xfe\xbf\b\xe5\xf5?\x89\xab]/\xd7|" + function_43734668ca51504("\x16", missingstates) + "\xa5\x1a\xa9\xc4\xdf3K\xcbr\xf0\xfc-\xe8\xa7" + (var_3f833eeeef92556 ?? "\xed\x1d\va\x1e\xf6\xe5\x88\x8a") + "\x982!\x15\xd4\xa0\x1cP\x12=\x81\xdf\xd8\xdeo\x04z\xa7*F\xa5\xf2\xc6J\xd5\x17-\\\xeb\x8f@\xa2\x85:X\x9e\xd8#\x18\xf3w\xa0\x87\xaaj\xfe\b\x1cB\xd5iz\xbd\xec\x88b?\x15\xaa";
}

function function_e4709712a8e63645(rewardcache, var_683b43c97efcbf65 = 1) {
  grouprewardcaches = rewardcache.grouprewardcaches;

  if(!var_683b43c97efcbf65) {
    return ("\xe5g\r>\xca\t`\xbc\xfd\xef\x9d\x8c\xfc3E\xc6\xbe\xacJU\xd5F\"" + function_eeafe24608676e0c(rewardcache) + "\xe4\xe3\xb6\xd5\x01\xc5" + grouprewardcaches.size + "^H*G\xb1\xa7T\xed3\xcb\xb0\xf6\xa2\xf6\xfe");
  }

  i = 0;
  var_a256f23ad9676125 = "";

  foreach(grouprewardcache in rewardcache.grouprewardcaches) {
    i++;
    playergroup = grouprewardcache.playerowners;
    lootcontents = grouprewardcache.contents;
    playernamesstring = function_298690ea789d9d40(playergroup);

    if(lootcontents.size > 0) {
      var_cbac6233e7347e55 = [];

      foreach(lootstruct in lootcontents) {
        var_cbac6233e7347e55[var_cbac6233e7347e55.size] = lootstruct.lootid + "\xb0" + lootstruct.quantity;
      }

      lootinfostring = function_43734668ca51504("\xf8\x01", var_cbac6233e7347e55);
    } else {
      lootinfostring = "";
    }

    var_a256f23ad9676125 += "\xe6\xb0\xcf\xcb\xbb!9" + i + "\xe6\xbf9\xabo5\xce\xa3\\\xbfP\xc9\x84" + playernamesstring + "\xac\x1cR\xc9\xe1L~{\xab" + lootcontents.size + ":\"/q\xcfB^pDc\x12\"i\x9d\xd8\x9c\xf3\xde\x0f\x93\x02\xd0}.b\x1dCyz" + lootinfostring + "\xa2V";
  }

  infostring = "\xa5g\r>\xca\t`\xbc\xfd\xef\x9d\x8c\xfc3E\xc6\xbe\xacJU\xd5F\"" + function_eeafe24608676e0c(rewardcache) + "\xe4\xe3\xb6\xd5\x01\xc5" + grouprewardcaches.size + "^H*G\xb1\xa7T\xed3\xcb\xb0\xf6\xa2\xf6\xfe";
  infostring += var_a256f23ad9676125;
  return infostring;
}

function function_298690ea789d9d40(playerarray) {
  if(!isarray(playerarray)) {
    playerarray = [playerarray];
  }

  playernames = [];

  foreach(player in playerarray) {
    if(isPlayer(player)) {
      playernames[playernames.size] = player.name;
    }
  }

  playernamesstring = playernames.size > 0 ? function_43734668ca51504("\xf8\x01", playernames) : "";
  return playernamesstring;
}

function private function_6baceacf2557b678(rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_c89efc2a897f1a75, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_bdc4a6e0bc8a3b96) {
  result = {
    #func_onitemadded: func_onitemadded, #func_oncacheitemtaken: func_oncacheitemtaken, #lootfunctionargs: lootfunctionargs, #success: 1
  };

  if(!isDefined(playergroups) || !isarray(playergroups)) {
    function_d12ff4393ce6a5b("\xaa\xb2\x99\a{7\xdb\xcdx\xbcl:\xa8\x93\xfcN\x8d\x0f\xc9\x80Q\xed\xbdF\xb4W}\xd3\n\x1f\xc9\xf2R\xbbZO\x97\xdbv\x10\a\xcd\xae\x1c\xe0\xaf\x83\xa1\xb7\xdb\xa9\x17\xa6\xb9&\xa7\x89-\x16`\v'\a=4\v\xc2\x13\xf7\xe0\xd5\x18");
    result.success = 0;
  } else if(playergroups.size == 0) {
    function_79db779671b9ca27("\xa2:[y{\x93H/v \xf0\x02\x9a\xf5\xa6\xcb\x1b}\x16\x19\xc1T\xc4\xe6`\xc4Q\xce\x02S4\xf2T\x0f\xb4Z\xe3\xc3Nh\x0e\xaf\xf49[\x1e\x9cg\x1f0f\xe3\x06\x19\xba\xc3\x81-8\xe40\xc10\xef\x90\xe8\"a\xa6\xde*5\xf1\t\xfa\t\xa0\xc84\x9e\xa4\x83\t\xb0\xfe\x04\xf4");
    result.success = 0;
  }

  if(!function_a061b6ec6e3d1a77(placementstruct)) {
    function_d12ff4393ce6a5b("\xf3\x1fv\x9e\x14$\xea\xfcP\xb4\\\xd1\xb2\xfa\xb0\x1an9\x84w\x80x\xd1\xc0t$t\xa9\x97\x16%Ql\xd0\xfd^`\xbc\xf9\xa8@e\xa0\xcd\xdf7P\xd0{Iq\x15~\xd6\xa6@\xc5\x13\x88Y\x91\xf2\xf3\xe9\xb0\xb7*\xa1l\xd6\x10\xf0.\xa6\xe3\xc95\xa1(\xbdQ\x86\x17\x85T\xdc\xb8/\xf4A$\xba[O@J\xc6\x8c\xbd\x0e\xebY\xc0F\xfc\x94\n\x15\xe47!Q\xb4(\x12si\xd6n\x8b\x90 \v");
    result.success = 0;
  }

  if(!isDefined(func_openlootablecontainer) || !isfunction(func_openlootablecontainer)) {
    function_d12ff4393ce6a5b("\x11\xb9\x05%\xb3BA\n\x06J\xf1\x9f/\x80\xd1\x8dh\xbd\x9d\x18\xb7\x81C\n\x1aA\x1d\xdb%\xd8TMH\xd4\x85\xe9\x8fU\f\":+\xd0\xb7`\xa8\x95\xe9\xe5P\xdc&\x83\xe1J\x8e:x\xea\xbf\x05\xbc\xb9\x91\xd8\xb5\xd0\x19\xb7\xe8d::O\xf5\xc7#\xd8U\xc9M\xb5\xd8\x18\x9f\xc1C>vAi\xa7q\x85\xe9[A9\xbc-\xcbu|6;");
    result.success = 0;
  }

  if(!isDefined(var_c89efc2a897f1a75) || !isfunction(var_c89efc2a897f1a75)) {
    function_d12ff4393ce6a5b("\xf8$u\x93\xf1a\xde\x18\x04y)\xd5\x91[4\xb6\x8c>\xde-\xc3A\xbe\x81\x8d\xdf?\xf7sp&\x9e\x9c\xa6\xde\xd5\xd1;x\x9b\x9b\v\xe9\xd3{rf\x8a\xb2\x12\x1d\x0f\xc71u\x19/x\xa9\xd9;A0\x84\xbe(A\x11\xcfO\xdf/\x1bv\x13\xd7\x83C \xa440z\xf1\xc97\x97\x05\x85\xdfu\xf1-\\\x02\xa6\xaa6\xc6");
    result.success = 0;
  }

  if(!isDefined(lootfunctionargs)) {
    result.lootfunctionargs = spawnStruct();
  } else if(!isstruct(lootfunctionargs)) {
    function_d12ff4393ce6a5b("#\x97\x92\xc7\xddL\x14\xae\xba\x10\xc1z\xc3J\x1a\x12tX=yf`\xa4\x1d2_\x8cc\xe7\x93\x14q\xcc\r.\x92\xe5\xb27}\xc9.\xfb\xe1_\xc5Y8\xba\xa1\t\xdd\xa9\xde\x84\xa77\xc1\xeaG\xb806R>>^\x83O\xf0b\xdd\xb5u\xc3\xae");
    result.success = 0;
  }

  if(isDefined(func_oncacheitemtaken) && !isfunction(func_oncacheitemtaken)) {
    function_79db779671b9ca27("B\x1bm[\xc5\"\xa1\xd8\x98\xdb\fO:\xc7\x10\x8a5\xa1|\xfb\xd8L\x0f\x98\r:s6H\xd1\x11\x85f\x05^\xf1\xa5\x13\x1bB\x8b\x05l\tvR\x02k\x1dXd\x83}\x01\xe6\n\x8dyZA\xa5\xde\x1a(\xb9\xc0\x8ce\xfcZq\xa3\x01\x17,\xf8t\xcf\xe1\xb5\xb4\xc0>\xb7\xe9\x8c\xd9\xef#\xfd\x9c?\x8e$\xc5\x910\x82\xfa4mT\xeb\xcdV\xf4\n\xd6\x12\x87X}\x9f\x80\xf0\xf3-\xe5\xa1^g\xc5\xd5\x87\xeb\xda\a\xe4Q\x04\xe1J");
    result.func_oncacheitemtaken = undefined;
  }

  if(isDefined(func_onitemadded) && !isfunction(func_onitemadded)) {
    function_79db779671b9ca27("\x99W7\xc6\xf5\xf6\x9b\x94t\xac[\nd\x8cY\x8c\x02in 2\xac3ZnY\x19\x01&u\xe8 \xb4\xcd\x02s\xf6\x8e\x02\v\bf\xea\x9b\x1b\xe8Z\xbd\xcd$\x01\x15\x86\xca\x10\x93e\xee\xc2\x9cd@\x1b\v\xb1\xd0\xac\x10\xbbZ\x8dc\b\xdctZ\xb1\xc6\x02\x9b8\xb0w\xe6\x80Lu\x8e\x04w-t\xd0\xbd\xd5\xa3 \x16ny\x10\xbd\xdc)\x1de\xad(2FV2\x01\x99\xd5\xcd\x8d\xa3K\xbd\xdc\x166K\x8e\xcb\xb8");
    result.func_onitemadded = undefined;
  }

  return result;
}

function function_d7b6326ec20326d9(var_d9dd002d838796d) {
  if(!isDefined(var_d9dd002d838796d) || !isarray(var_d9dd002d838796d)) {
    return false;
  }

  foreach(lootitem in var_d9dd002d838796d) {
    if(!isstruct(lootitem) || !(isDefined(lootitem.lootid) && isDefined(lootitem.quantity))) {
      return false;
    }
  }

  return true;
}

function function_a061b6ec6e3d1a77(var_d17c656571018a01) {
  return isDefined(var_d17c656571018a01) && isstruct(var_d17c656571018a01) && isDefined(var_d17c656571018a01.origin) && isDefined(var_d17c656571018a01.angles);
}

function function_cc81398e149c94b3(rewardgroup) {
  if(!isDefined(rewardgroup) || !isarray(rewardgroup)) {
    return false;
  }

  foreach(player in rewardgroup) {
    if(!isPlayer(player)) {
      return false;
    }
  }

  return true;
}

function private function_51f5d54f157ed5d2(playergrouplootstructs) {
  var_23e4379efe5256e8 = [];

  foreach(grouplootstruct in playergrouplootstructs) {
    validplayers = function_527d244640365bf(grouplootstruct.playergroup);

    if(validplayers.size > 0) {
      grouplootstruct.playergroup = validplayers;
      var_23e4379efe5256e8[var_23e4379efe5256e8.size] = grouplootstruct;
    }
  }

  return var_23e4379efe5256e8;
}

function private function_527d244640365bf(array) {
  validplayers = [];

  foreach(player in array) {
    if(isPlayer(player)) {
      validplayers[validplayers.size] = player;
    }
  }

  return validplayers;
}

function private function_9236ad0becdf48c2(scriptableinstance, var_f64098209f2084de, logerrors = 0) {
  if(!isDefined(scriptableinstance)) {
    return false;
  }

  scriptableinfo = spawnStruct();
  function_a86924df228aea25(scriptableinstance, var_f64098209f2084de);
  missingstates = function_17672a79da406ce0(scriptableinstance, scriptableinfo);

  if(missingstates.size != 0) {
    if(logerrors) {
      errormsg = function_8465cea250f71252(scriptableinfo.assetname, missingstates, scriptableinfo.scriptablepartname);
      function_79db779671b9ca27(errormsg);
    }

    return false;
  }

  return true;
}

function private function_17672a79da406ce0(scriptableinstance, scriptableinfo) {
  requiredstates = [scriptableinfo.var_2dfb1899549e3536, scriptableinfo.var_3a929f6b29f5af5c, scriptableinfo.var_edc5d0b4fa0ab158];
  requiredstates = utility::array_removeundefined(requiredstates);
  return function_99be77073ad78f14(scriptableinstance, scriptableinfo.scriptablepartname, requiredstates);
}

function private function_99be77073ad78f14(scriptableinstance, partnametocheck, var_7f01900d6f0f00b8) {
  missingstates = [];

  foreach(statename in var_7f01900d6f0f00b8) {
    if(!scriptableinstance getscriptableparthasstate(partnametocheck, statename)) {
      missingstates[missingstates.size] = statename;
    }
  }

  return missingstates;
}

function private function_d2c20f0610e0512() {
  return {
    #resultstatus: 0, #resultobject: undefined
  };
}

function private function_284b0bcdb1969fd9(workresults) {
  foreach(workresult in workresults) {
    if(workresult.resultstatus == 0) {
      return false;
    }
  }

  return true;
}

function private function_5f9ba008503137f0(workresults) {
  foreach(workresult in workresults) {
    if(workresult.resultstatus == 2) {
      return true;
    }
  }

  return false;
}

function private function_99b393d80770c0d5() {
  return max(1, getdvarint(@ "hash_4e2904a76ce33e39", 8));
}

function private function_ce40517588db34f5(spawnoriginworkresult, playergroups, placementstruct) {
  var_c8dc13cf9f45833a = namespace_25b52ebe6ab1a0c8::function_dec88be3feef4980(placementstruct);

  if(istrue(var_c8dc13cf9f45833a)) {
    if(getdvarint(@ "hash_94f4c6adf1621cb4", 0) == 0) {
      function_fb99cbbd062c7471("\xc7\xfaG)\b\x8aiM\xa4,\xb0\x10\xe4\r\x1e\xe6\xd6\xd5\xdd\xfd\n\x17\x8fv\x87\xeb\x7fQA\xd1\xca\x97<\xb6ji\x91M\xd2\x86\xb2\xa5`\r^Kq\xf4R])\xf8\xf1\xc1V\xa1X\x1c\xbdq\xe1e\x92" + namespace_25b52ebe6ab1a0c8::getplacementorigin(placementstruct));
    }

    var_267490340405a50f = spawnStruct();
    function_c982c3c12e42353(playergroups, placementstruct, var_267490340405a50f);
    var_267490340405a50f waittill("Z\x0e\xc8\x1cL\xdb0\f\x9d1\xba\xde\xffyUdV\xa5\xeb\xeawi\x80\xd2t\xf1\xc6|\xfcV\xc8)\xeds\x9f", spawnorigin);

    if(getdvarint(@ "hash_94f4c6adf1621cb4", 0) == 0) {
      function_fb99cbbd062c7471("\x1boj\xf0\x8bY\xf6\x98%\\\x95F\xf6\xe6\x9d\xe7d\xe5\xf3\xde\xd3\x1cE\x14\x06B\x7f\x15sZLD\xe28\xc3\xf9\x1f\xdb\xcd?\x06J\x17\xe3\xfc\xce" + spawnorigin);
    }
  } else {
    spawnorigin = namespace_25b52ebe6ab1a0c8::getplacementorigin(placementstruct);
  }

  spawnoriginworkresult.resultobject = spawnorigin;
  spawnoriginworkresult.resultstatus = 1;
}

function private function_ee2a15e809d48cd2(var_524ae6d901137add, playergroups, var_c89efc2a897f1a75, lootfunctionargs) {
  playergrouplootstructs = [];
  var_b54982791aac2fda = function_99b393d80770c0d5();
  var_3fc2f51eaf047b7f = ceil(playergroups.size / var_b54982791aac2fda);
  var_3f9c077d14b476ac = 0;
  var_7d3a68bb0b4092ea = 0;
  function_fb99cbbd062c7471("=yn\x0f[B,\xd5I\x1aeY\xb7J\x9e\xf8[\xafi\xb9\xf0\xe1\x03`x\x14@\x91\x8c$)T\xb2/\n$\xc9FJ" + playergroups.size + "u\xe4\x95,\xb6W=D\x0f\t" + var_3fc2f51eaf047b7f + "\xccS\xd3\a\x7f\x85G\x19\bK\xcf7Q\xca@,A\xf7\x8b");

  foreach(playergroup in playergroups) {
    if(var_3f9c077d14b476ac == var_3fc2f51eaf047b7f) {
      waitframe();
      var_3f9c077d14b476ac = 0;
    }

    if(!isarray(playergroup)) {
      function_79db779671b9ca27("\xba\x9f\xbcrp\"\x89\x15\n\xa6\xdc\xc9\xc4\x7f\x85\xa1u\xe3\xed\x87\xd0]h\x17\x82\x01\xee9Y\xfb0\x1bks\x9f\x97\v\xb1\x85\x80a\xba\x9f\xec\x9e\xa6\xb43qU7\xe4\xfdt\x15q#g\xadF\xcd\xfeL\xff<\x8a\xc8\xb3\xee\x17K`#\xfc\xbb3\xc1\xd7\xe0y\x82\xfb\x7f\xf8\x93\xbcj\x10\x80\x19uR\xca\xc3g\x9e\xbc\xf0\xdf\xa2BGN\x14\x12g\x9bJ8\xfba{\xef\x8ab\xf8tlE\xe5<|\x03\xb9&I\x8c\xd5\xea\x0f\xc7\xc7\xc6\x98I\x80\x86\xef\xb9pX\xf9b\x8f\xd9\x806\x18\xb8\xb7h\x81\x9e\x99\xfd\xf4\x93\x96\"\xf5;\x93\xc7\xd7\x12\x14");
      continue;
    }

    validplayersingroup = function_527d244640365bf(playergroup);

    if(validplayersingroup.size == 0) {
      function_8abc48b08a4b4075("\a\xfe\x8c\xf0\x9f\xa3\xe6\xf6\xe8\xb4:\xbb\x99\xc8\xc6\\Mj\xc1\xec\x14\x84\xae\xcd\x89\x83\xfd\x89}\x9f\xe0l\b\xeb\x19\x95\xc5z,\xd5\xb2\x84P\xe9\x98\xa7C9\xef0\xe9\xa7c\x91\xf93\xfeA0l\xfb\xc5u\x8f\xdd%\t\xf1\xe4\x99\xa0#\x1f*\xba}\x02\xa6\xf5\xa5^\xb9lW\xcf\x89{\xf3N\x9e\xa4P.d\xd3\x85\x05\xb2\xafq\f\xe5\x14i\x18Qb\x85\xf4g");
      continue;
    }

    lootfunctionargs.reward_group = validplayersingroup;
    lootcontents = [[var_c89efc2a897f1a75]](lootfunctionargs);
    playergrouplootstructs[playergrouplootstructs.size] = {
      #lootcontents: lootcontents, #playergroup: validplayersingroup
    };
    var_3f9c077d14b476ac++;
    var_7d3a68bb0b4092ea++;

    if(getdvarint(@ "hash_94f4c6adf1621cb4", 0) != 1) {
      function_fb99cbbd062c7471("\xcf\x8c\xbf\xd80\x82$\x1fdY\"\xaa`\x1c\xd0\xbe\xafLk[>\xc3\x1b\x84\xc6\xd1\a9\xbdb\xef\xe7v@\x16(\xaaV" + var_7d3a68bb0b4092ea + "\xb6" + playergroups.size + "\xb98C\xcdh\xbd\xf7\xb7\xd4\x86`Y^\b");
    }
  }

  function_fb99cbbd062c7471("\xce\v+\x9b\x06\xdc\xb9\xf1\xab>{L]h\xb1z\x1e>\xcb\xb0,^mpY.\x7fd\x9a\xde\xc4k|wG\x1bE\xf4ViL~T\x92" + playergroups.size + "\xd5\x14\x8c\xe3\x8cf\x1b");
  var_524ae6d901137add.resultobject = playergrouplootstructs;
  var_524ae6d901137add.resultstatus = 1;
}