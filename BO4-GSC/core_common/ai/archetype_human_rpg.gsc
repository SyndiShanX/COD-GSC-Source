/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_human_rpg.gsc
**************************************************/

#include scripts\core_common\ai\archetype_human_rpg_interface;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai_shared;
#include scripts\core_common\spawner_shared;

#namespace archetype_human_rpg;

autoexec main() {
  spawner::add_archetype_spawn_function(#"human_rpg", &humanrpgbehavior::archetypehumanrpgblackboardinit);
  spawner::add_archetype_spawn_function(#"human", &humanrpgbehavior::function_daf99f58);
  humanrpgbehavior::registerbehaviorscriptfunctions();
  humanrpginterface::registerhumanrpginterfaceattributes();
}

#namespace humanrpgbehavior;

registerbehaviorscriptfunctions() {}

private archetypehumanrpgblackboardinit() {
  entity = self;
  blackboard::createblackboardforentity(entity);
  ai::createinterfaceforentity(entity);
  self.___archetypeonanimscriptedcallback = &archetypehumanrpgonanimscriptedcallback;
  entity asmchangeanimmappingtable(1);
}

private archetypehumanrpgonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity archetypehumanrpgblackboardinit();
}

private function_daf99f58() {
  if(self.subarchetype === #"human_rpg") {
    self.var_b3aacd00 = getweapon(#"hash_3b5610f58856b4ea");
    self.var_2fcec084 = getweapon(#"hash_1d8ec79043d16eb");
    self.var_b999a026 = 0;
    self thread function_567e5a33();
  }
}

private function_567e5a33() {
  self endon(#"death");
  self ai::gun_remove();
  self ai::gun_switchto(self.var_b3aacd00, "right");

  while(self.weapon !== self.var_b3aacd00) {
    waitframe(1);
  }

  while(isalive(self)) {
    var_70a33a38 = self ai::function_63734291(self.enemy);

    if(isDefined(var_70a33a38) && var_70a33a38 && !(isDefined(self.var_b999a026) && self.var_b999a026)) {
      self ai::gun_remove();
      self ai::gun_switchto(self.var_2fcec084, "right");

      while(self.weapon !== self.var_2fcec084) {
        waitframe(1);
      }

      self.var_b999a026 = 1;
      self waittill(#"weapon_fired", #"enemy", #"missile_fire");
    }

    if(!(isDefined(var_70a33a38) && var_70a33a38) && isDefined(self.var_b999a026) && self.var_b999a026) {
      self ai::gun_remove();
      self ai::gun_switchto(self.var_b3aacd00, "right");

      while(self.weapon !== self.var_b3aacd00) {
        waitframe(1);
      }

      self.var_b999a026 = 0;
    }

    waitframe(1);
  }
}