/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_562e137d2ba1344.gsc
****************************************************/

#using scripts\common\system;
#using scripts\engine\sp\utility;
#using scripts\sp\audio;
#namespace namespace_37f619c3bc0cdc7c;

function private autoexec __init__system__() {
  system::register(#"hash_4974b391ba52b617", undefined, &function_9482ba65c9214245, undefined);
}

function private function_9482ba65c9214245() {
  if(function_9c44e6874f16932e(1 | 64 | 2 | 4 | 8 | 16 | 32)) {
    return;
  }

  if(getdvarint(@ "hash_3dc92a01d0eae9c1", 1) == 0) {
    return;
  }

  function_d2fb225dba59bd13();
  level.player function_9b84d83172b8e70c();
}

function function_9b84d83172b8e70c() {
  if(!isPlayer(self)) {
    assertmsg("<dev string:x24>");
    return;
  }

  if(function_b87f881d06366076()) {
    thread function_7180dd683e81167();
  }
}

function function_9165ca673c5c49ab() {
  if(!isPlayer(self)) {
    assertmsg("<dev string:x5e>");
    return;
  }

  self notify("o\xa8\xb8?6\xd2\x15\xdb\xd7\xbcaU\xab\xf1\x1c!\xee\xee\xdd\xa0\xe1");
}

function function_e6d3a993bb3f9926(setenabled) {
  assert(isDefined(setenabled), "<dev string:x99>");

  if(function_b87f881d06366076()) {
    level.var_ad755f7d86f45702.var_e63e673b7fd537de = setenabled;
  }
}

function function_b05818e2fc996a8c(scale) {
  if(function_b87f881d06366076()) {
    level.var_ad755f7d86f45702.pitch_scale = scale;
  }
}

function function_10a54b36bb5f685(scale) {
  if(function_b87f881d06366076()) {
    level.var_ad755f7d86f45702.yaw_scale = scale;
  }
}

function function_ce00a961fd1e33(speed) {
  if(function_b87f881d06366076()) {
    level.var_ad755f7d86f45702.speed_norm = speed;
  }
}

function function_5eb315f1731e7e18(speed) {
  if(function_b87f881d06366076()) {
    level.var_ad755f7d86f45702.speed_slow = speed;
  }
}

function function_ce2a4de8703dea7e(time) {
  if(function_b87f881d06366076()) {
    level.var_ad755f7d86f45702.var_820cde5e368ed3a7 = time;
  }
}

function function_7cbd6a7b1e9a39d3(time) {
  if(function_b87f881d06366076()) {
    level.var_ad755f7d86f45702.var_86b692b244f1c7c0 = time;
  }
}

function private function_d2fb225dba59bd13() {
  level.var_ad755f7d86f45702 = spawnStruct();
  function_e6d3a993bb3f9926(1);
  function_b05818e2fc996a8c(0.5);
  function_10a54b36bb5f685(0.5);
  function_ce00a961fd1e33(1);
  function_5eb315f1731e7e18(0.25);
  function_ce2a4de8703dea7e(1);
  function_7cbd6a7b1e9a39d3(1);
}

function private function_7180dd683e81167() {
  self notify("o\xa8\xb8?6\xd2\x15\xdb\xd7\xbcaU\xab\xf1\x1c!\xee\xee\xdd\xa0\xe1");
  self endon("o\xa8\xb8?6\xd2\x15\xdb\xd7\xbcaU\xab\xf1\x1c!\xee\xee\xdd\xa0\xe1");

  while(true) {
    function_c6c0d642370777c7();
    function_d0ecc3f71ea566b4();
    function_384a4db605877129();
    function_bee83ac1c5973543();
  }
}

function private function_c6c0d642370777c7() {
  while(true) {
    if(!self isholdingbreath()) {
      waitframe();
      continue;
    }

    if(!function_f2c093d88c3c2d05()) {
      waitframe();
      continue;
    }

    return;
  }
}

function private function_384a4db605877129() {
  while(self isholdingbreath()) {
    waitframe();
  }
}

function private function_f2c093d88c3c2d05() {
  if(istrue(level.var_ad755f7d86f45702.var_e63e673b7fd537de)) {
    gun = self getcurrentprimaryweapon();

    if(gun.classname != "\xff\x12\x9a\xbe.a") {
      return false;
    }
  }

  return true;
}

function private function_d0ecc3f71ea566b4() {
  self enableslowaim(level.var_ad755f7d86f45702.pitch_scale, level.var_ad755f7d86f45702.yaw_scale);
  audio::set_slowmo_sniper_breath_start();
  assert(level.var_ad755f7d86f45702.speed_norm == 1);
  utility_sp::function_712369ee845f814c("\xaf\xbd\xca\xa8\x90\xb2a\x87p\r6\x02Ny}o\xab\xb3\xab\x8f", level.var_ad755f7d86f45702.speed_slow, level.var_ad755f7d86f45702.var_820cde5e368ed3a7);
}

function private function_bee83ac1c5973543() {
  self disableslowaim();
  audio::set_slowmo_sniper_breath_end();
  utility_sp::function_2853d8d2bf2b2f5("\xaf\xbd\xca\xa8\x90\xb2a\x87p\r6\x02Ny}o\xab\xb3\xab\x8f", level.var_ad755f7d86f45702.var_86b692b244f1c7c0);
}

function private function_b87f881d06366076(var_ec4104b602de169c = 1) {
  if(isDefined(level.var_ad755f7d86f45702)) {
    return true;
  }

  if(var_ec4104b602de169c) {
    assertmsg("<dev string:xf7>");
  }

  return false;
}