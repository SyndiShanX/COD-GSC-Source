/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6583f4b140661f35.gsc
*************************************************/

#using script_2b85a88a1d543a;
#using script_713ccfa3a01d4d19;
#using scripts\common\callbacks;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_dev;
#namespace namespace_c79c976ae904fa16;

function autoexec main() {
  iprintln("<dev string:x1c>" + "<dev string:x33>" + "<dev string:x3b>");

  registermission("cash", &init, &function_42abf8c3f5614a65);

  scripts\mp\gametypes\br_dev::registerhandlecommand(&function_3195d135ced85ef8);
}

function private init(scriptbundle, var_26a9ecbcb0d7e5e2, xpbonus) {
  assert(scriptbundle.scriptid == "<dev string:x33>");

  iprintln("<dev string:x51>" + var_26a9ecbcb0d7e5e2 + "<dev string:x88>" + xpbonus + "<dev string:x91>");

  level.secondaryvictory.var_f5eb9b1ad1613bca = &function_f5eb9b1ad1613bca;
  level.secondaryvictory.var_228bbb92952e5f9f = &function_228bbb92952e5f9f;
  level.secondaryvictory.onkioskpurchase = &onkioskpurchase;
  function_33bb17d027e6a631(level.secondaryvictory.var_5fc0bb331fcc1784);
  function_7d3329c47fbe47f1(1);
  function_906084f03cbe16da(1);
  function_3b015b3d933c20ef(var_26a9ecbcb0d7e5e2);
  level thread function_426b2a60c569a757();
}

function private function_426b2a60c569a757() {
  level endon("game_ended");
  level waittill("gulag_closed");
  function_906084f03cbe16da(0);
}

function private function_f5eb9b1ad1613bca() {
  function_d19de726f751683d("cash", self.team);
}

function private function_42abf8c3f5614a65() {
  if(isDefined(self.plundercount)) {
    return self.plundercount;
  }

  return 0;
}

function private function_33bb17d027e6a631(count) {
  assert(isDefined(count) && count > 0);
  level.secondaryvictory.inventorycount = count;
  function_358c488f5ac3aff0(level.secondaryvictory.inventorycount);
}

function private function_6914ed4b05188c76() {
  assert(isDefined(level.secondaryvictory.inventorycount) && level.secondaryvictory.inventorycount > 0);
  level.secondaryvictory.inventorycount--;
  function_358c488f5ac3aff0(level.secondaryvictory.inventorycount);
}

function private function_228bbb92952e5f9f() {
  response = namespace_3460310ddf4d9cfa::function_70ee001b7b3a1bd0();

  if(isDefined(level.gulag) && istrue(level.gulag.shutdown)) {
    iprintln("<dev string:x98>" + self.name + "<dev string:xb6>");

    response = 0;
  }

  if(response != 2) {
    function_a9b4c3bb4abb4a01(response, self.origin);
  }

  return response;
}

function private onkioskpurchase(cost) {
  player = self;
  scripts\mp\gametypes\br_armory_kiosk::function_3cb66deb101988ce("br_sv_exfil", 1);
  player function_a10e1586d7ecf252(cost, level.secondaryvictory.inventorycount);
  function_6914ed4b05188c76();
  player function_2aa9a736450d87ce();
}

function private function_3b015b3d933c20ef(cost) {
  function_cae7fc3d806ab9ce(cost);
  scripts\mp\gametypes\br_armory_kiosk::function_6ce8d88dab67a185("br_sv_exfil", cost);
}

function function_3195d135ced85ef8(command, args) {
  switch (command) {
    case #"hash_a9ea817c60179bbf":
      function_7d3329c47fbe47f1(int(args[0]));
      break;
    case #"hash_22f1a0a6299aa80":
      function_906084f03cbe16da(int(args[0]));
      break;
    case #"hash_b3134eabc9b4c82":
      function_3b015b3d933c20ef(int(args[0]));
      break;
    case #"hash_d14dd86d102e2aa":
      function_33bb17d027e6a631(int(args[0]));
      break;
  }
}

# /