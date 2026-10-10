/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4f713a4a76d23d64.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\engine\utility;
#namespace namespace_463c541c6afd19ee;

function function_bcfbb1093d28dce6(taskid, params) {
  if(self function_1fde453596ea559c() < 2000) {
    return anim.failure;
  }

  self.abom_crawlers = function_fdc9d5557c53078e(self.abom_crawlers);

  if(self.abom_crawlers.size < 5) {
    return anim.success;
  }

  return anim.failure;
}

function function_5ccebaad82aa8913() {
  self.abom_crawlers = [];
  thread function_f944303a35b8b27b();
}

function private function_f944303a35b8b27b() {
  self endon("death");

  while(true) {
    self waittill("start_crawler_deploy");

    if(isDefined(self.enemy)) {
      self getenemyinfo(self.enemy);
    }

    thread function_7674186f5ca25b0c();
  }
}

function private function_7674186f5ca25b0c() {
  self endon("death");
  self endon("start_crawler_deploy");

  while(true) {
    self waittill("spawn_crawler");

    if(self.abom_crawlers.size < 5) {
      abom_spawn_crawler();
    }

    waitframe();
  }
}

function private abom_spawn_crawler() {
  aitypes = get_aitype_by_subclass_sharedfunc(self.zombieaisettings.var_e58a65b7a8f5973c.var_a50ee2b67d1afeb9);
  assert(isDefined(aitypes) && aitypes.size > 0);
  base_aitype = undefined;

  foreach(aitype in aitypes) {
    strlen = aitype.size;

    if(!isDefined(base_aitype) || base_aitype.size > strlen) {
      base_aitype = aitype;
    }
  }

  crawler_aitype = base_aitype;
  crawler = spawnnewaitype_sharedfunc(crawler_aitype, self.origin, self.angles, self.team);

  if(isDefined(crawler)) {
    crawler thread animscripted_sharedfunc("spawn_abom_crawler", "spawn_end", undefined, undefined, "spawn_animating");
    crawler.var_c383683308e840a7 = self;
    self.abom_crawlers = array_add(self.abom_crawlers, crawler);

    if(flag("level_stealth_initialized") && isDefined(self.enemy)) {
      crawler aieventlistenerevent("attack", self.enemy, self.enemy.origin);
    }
  }
}