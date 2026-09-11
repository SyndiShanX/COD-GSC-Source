/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: behaviortree\dog.gsc
***********************************************/

function dogfn0(var0) {
  return scripts\aitypes\common::isvariabledefined(var0, self.enemy);
}

function bindactionscripts() {
  if(isDefined(level._btactions["dog"])) {
    return;
  }

  var0 = spawnStruct();
  var0.actionfn = [];
  var0.actionfn[0] = &scripts\aitypes\dog\combat::updateeveryframe;
  var0.actionfn[1] = &scripts\aitypes\stealth::ifinstealth;
  var0.actionfn[2] = &scripts\aitypes\dog\combat::updateeveryframe_stealth;
  var0.actionfn[3] = &scripts\aitypes\stealth::stealth_shouldinvestigate;
  var0.actionfn[4] = &scripts\aitypes\dog\combat::dog_investigate;
  var0.actionfn[5] = &scripts\aitypes\dog\combat::dog_investigate_init_task;
  var0.actionfn[6] = &scripts\aitypes\dog\combat::dog_investigate_terminate_task;
  var0.actionfn[7] = &scripts\aitypes\dog\combat::dog_idle;
  var0.actionfn[8] = &scripts\aitypes\dog\combat::dog_idle_init_task;
  var0.actionfn[9] = &scripts\aitypes\dog\combat::dog_idle_terminate_task;
  var0.actionfn[10] = &dogfn0;
  var0.actionfn[11] = &scripts\aitypes\melee::shouldmelee;
  var0.actionfn[12] = &scripts\aitypes\melee::melee_init;
  var0.actionfn[13] = &scripts\aitypes\melee::meleecharge_update;
  var0.actionfn[14] = &scripts\aitypes\melee::meleecharge_init;
  var0.actionfn[15] = &scripts\aitypes\melee::meleecharge_terminate;
  var0.actionfn[16] = &scripts\aitypes\melee::domeleeaction;
  var0.actionfn[17] = &scripts\aitypes\melee::initmeleeaction;
  var0.actionfn[18] = &scripts\aitypes\melee::clearmeleeaction;
  var0.actionfn[19] = &scripts\aitypes\dog\combat::dog_followenemy;
  var0.actionfn[20] = &scripts\aitypes\dog\combat::dog_followenemy_init;
  var0.actionfn[21] = &scripts\aitypes\dog\combat::dog_followenemy_terminate;
  var0.actionfn[22] = &scripts\aitypes\dog\combat::dog_init;
  level._btactions["dog"] = var0;
}

function registerbehaviortree() {
  bindactionscripts();
  btregistertree("dog");
}