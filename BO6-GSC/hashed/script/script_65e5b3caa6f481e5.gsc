/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_65e5b3caa6f481e5.gsc
*****************************************************/

#using script_7a5f832593a7dde9;
#using scripts\common\system;
#using scripts\engine\utility;
#namespace reward_cache_sp;

function private autoexec __init__system__() {
  system::register(#"reward_cache_sp", undefined, &function_45dadecf325f5759, undefined);
}

function private function_45dadecf325f5759() {
  utility::registersharedfunc(#"reward_cache", #"showrewardcachemarkertoplayer", &function_88c8b071569649e9);
  utility::registersharedfunc(#"reward_cache", #"hiderewardcachemarkerfromplayer", &function_5e4f07093edecdf);
  utility::registersharedfunc(#"reward_cache", #"updaterewardcachemarkerposition", &function_6e57cb99c9eb37be);
  utility::registersharedfunc(#"reward_cache", #"createrewardcacheobjectivemarker", &function_521ede498b26dfbb);
  utility::registersharedfunc(#"reward_cache", #"destroyrewardcacheobjectivemarker", &function_4ad8a7940550e1f9);
}

function private function_521ede498b26dfbb(rewardcachesettings, origin) {
  reward_cache::function_d12ff4393ce6a5b("O\x98\xd4\xdd\xaa\x9eS\xf85r\xb8V\x19\x9a\x9c\x94\x81`W\x12\x12\x8a\x06\xf9\xc1\x1dY`\xd8\xbf|\\/2\f\xef%\xef\xa7+Q\xe2\xd9)\xee\xb7;\x04/fMw\xd1Z\xa23\a \x1a");
}

function private function_88c8b071569649e9(rewardcache, player) {
  reward_cache::function_d12ff4393ce6a5b("\x93\n^\x95{\x01\xf8f_\x13B&\xab&\x02\x0e\x10x\xaf_\xb9\x19\xd5\xab:{\x87\xa2\xf9\xfe#\xbb\xab\x10,\xf6\x8f\x9c-\xf7\x8d\xd1\xc8\x8c\xdd\\\xdc\xa0\xc4\x85\x0f\xde\x95\x91\xe7\xf0o");
}

function private function_5e4f07093edecdf(rewardcache, player) {
  reward_cache::function_d12ff4393ce6a5b("\xe3)g\xe0\xcd\x01\xa7?;3\x88s\xec?\x98\xc2\x1d9\x98\xc0\xf8\xa4\xb6\xb6\x1an\x01\xcab\x95\xe1\xa0\x87`E\t\xfd\xf8\x92b.\xb4\x1f|\xdf\x90\xf4\x7f\xe3q!\xf8\xfb\xb94\xdcd");
}

function private function_6e57cb99c9eb37be(rewardcache) {
  reward_cache::function_d12ff4393ce6a5b("7\xaa\x1c\x10\x93\x05\x7f\xe35\a\x19\x94\x81\x9c.;j\xe4]\x12\xd0\x94\x02\xb4\x83ND\xdb\xe0\xd8\xe9;\xf2\xed\xcc\x11P\xd8?\x8aw\xe2\x1c\x14\x81L\xe1>\xb6+\x1dT\x81\x06\x94&\xea\x03\xcf");
}

function private function_4ad8a7940550e1f9(rewardcache) {
  reward_cache::function_d12ff4393ce6a5b("?\xae\x1bp\x9d\xaeY\xbby_m\xdf;^\x89\xf1t\x1d\x90q\x1c-\x8b\xbf\xf4\xcc\xad\x8e\xbb\x1bh0\xb2\xe9\x9f\xe0\x1f/\xcd\xb66\nt\xdeuZ\x1d\xfar\xcdY\xb2Z|\x159\xae\x85\xe1\r");
}