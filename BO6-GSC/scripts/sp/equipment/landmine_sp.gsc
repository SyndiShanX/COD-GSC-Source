/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\equipment\landmine_sp.gsc
************************************************/

#using script_f3a280c3232484d;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\player\cursor_hint;
#namespace landmine_sp;

function private autoexec __init__system__() {
  system::register("\x1b\xec\xdfG\xd3\xcfIh\x90\xa3\xf8\xa7\x82\x8b", undefined, &pre_main, &post_main);
}

function pre_main() {
  offhands::registerprecachefunc("\xbbU~\xf5\x82\xb9\xad\xa3E\xe3\xbd!N\xddL", &precache);
  utility::registersharedfunc("\x1b\xec\xdfG\xd3\xcfIh\x90\xa3\xf8\xa7\x82\x8b", #"hash_ff42655615376475", &function_2e69843e282f5839);
  utility::registersharedfunc("\x1b\xec\xdfG\xd3\xcfIh\x90\xa3\xf8\xa7\x82\x8b", #"getweaponname", &function_ec2a01113b08c840);
  utility::registersharedfunc("\x1b\xec\xdfG\xd3\xcfIh\x90\xa3\xf8\xa7\x82\x8b", #"hash_68160ecc80207080", &function_1fbdfc3934ccd535);
}

function private precache(offhand) {
  offhands::registeroffhandfirefunc(offhand, &function_c7e8c6e4cb75dd33);
  offhands::overrideweaponoffhandtype(offhand, 1);
}

function post_main() {
  landmine::landmine_init();
}

function private function_c7e8c6e4cb75dd33(grenade, weapon) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(grenade.owner)) {
    grenade.owner = self;
  }

  if(!isDefined(grenade.equipmentref)) {
    grenade.equipmentref = "\x1b\xec\xdfG\xd3\xcfIh\x90\xa3\xf8\xa7\x82\x8b";
  }

  thread function_4700ddef95eac96f(grenade, weapon);
  landmine::landmine_use(grenade);
}

function private function_4700ddef95eac96f(grenade, weapon) {
  self endon("\x1e\xfd\xd1\xa2\a");
  grenade endon("\x1e\xfd\xd1\xa2\a");
  grenade waittill("d\xd9b~\xf2\x9f\x15\x93T\xd1\x04\x1a\x18", stuckto, hitent, surfacetype, velocity, position, normal);
  thread offhands::function_1ddd67f9826838b(grenade, weapon, &"hash_3bd611c6d1d5f1db", "\xa0\xdehdu\xb7\xb0\xff\x94\x1d\xaa\x7f\xc3\xa3");
  thread function_7bc53cdc8eeb37f6(grenade);
  grenade thread utility::navrepulsorremoveondeath(120, "O\x15\x1b\xad\x9ff");
}

function private function_7bc53cdc8eeb37f6(grenade) {
  self endon("\x1e\xfd\xd1\xa2\a");
  assert(isDefined(grenade.cursor_hint_ent));
  grenade.cursor_hint_ent endon("\x1e\xfd\xd1\xa2\a");
  grenade utility::waittill_any("u\xd6\x19Nt\xe34(%\xf07\xb6O;", "@(\x9c\xb6\xb6\xf2\xd3\xcb\x96\x1fn\x86\xb5N");
  grenade cursor_hint::remove_cursor_hint();
}

function private function_2e69843e282f5839(ent) {
  if(isactor(ent) && isalive(ent)) {
    return true;
  }

  return false;
}

function private function_ec2a01113b08c840() {
  return "\xbbU~\xf5\x82\xb9\xad\xa3E\xe3\xbd!N\xddL";
}

function private function_1fbdfc3934ccd535() {
  self endon("@(\x9c\xb6\xb6\xf2\xd3\xcb\x96\x1fn\x86\xb5N");
  self endon("d\xd9b~\xf2\x9f\x15\x93T\xd1\x04\x1a\x18");
  self endon("\x1e\xfd\xd1\xa2\a");
  start_time = gettime();
  start_pos = self.origin;

  while(true) {
    if(distance(self.origin, start_pos) > 2) {
      start_time = gettime();
    }

    start_pos = self.origin;

    if(gettime() - start_time > 3000) {
      break;
    }

    waitframe();
  }

  iprintln("<dev string:x24>");

  thread landmine::landmine_destroy();
}