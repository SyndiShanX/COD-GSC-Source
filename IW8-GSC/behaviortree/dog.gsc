/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: behaviortree\dog.gsc
***********************************************/

function dogfn0(var_0) {
  return scripts\aitypes\common::isvariabledefined(var_0, self.enemy);
}

function bindactionscripts() {
  if(isDefined(level._btactions["dog"])) {
    return;
  }

  var_0 = spawnStruct();
  var_0.actionfn = [];
  var_0.actionfn[0] = &scripts\aitypes\dog\combat::updateeveryframe;
  var_0.actionfn[1] = &scripts\aitypes\stealth::ifinstealth;
  var_0.actionfn[2] = &scripts\aitypes\dog\combat::updateeveryframe_stealth;
  var_0.actionfn[3] = &scripts\aitypes\stealth::stealth_shouldinvestigate;
  var_0.actionfn[4] = &scripts\aitypes\dog\combat::dog_investigate;
  var_0.actionfn[5] = &scripts\aitypes\dog\combat::dog_investigate_init_task;
  var_0.actionfn[6] = &scripts\aitypes\dog\combat::dog_investigate_terminate_task;
  var_0.actionfn[7] = &scripts\aitypes\dog\combat::dog_idle;
  var_0.actionfn[8] = &scripts\aitypes\dog\combat::dog_idle_init_task;
  var_0.actionfn[9] = &scripts\aitypes\dog\combat::dog_idle_terminate_task;
  var_0.actionfn[10] = &dogfn0;
  var_0.actionfn[11] = &scripts\aitypes\melee::shouldmelee;
  var_0.actionfn[12] = &scripts\aitypes\melee::melee_init;
  var_0.actionfn[13] = &scripts\aitypes\melee::meleecharge_update;
  var_0.actionfn[14] = &scripts\aitypes\melee::meleecharge_init;
  var_0.actionfn[15] = &scripts\aitypes\melee::meleecharge_terminate;
  var_0.actionfn[16] = &scripts\aitypes\melee::domeleeaction;
  var_0.actionfn[17] = &scripts\aitypes\melee::initmeleeaction;
  var_0.actionfn[18] = &scripts\aitypes\melee::clearmeleeaction;
  var_0.actionfn[19] = &scripts\aitypes\dog\combat::dog_followenemy;
  var_0.actionfn[20] = &scripts\aitypes\dog\combat::dog_followenemy_init;
  var_0.actionfn[21] = &scripts\aitypes\dog\combat::dog_followenemy_terminate;
  var_0.actionfn[22] = &scripts\aitypes\dog\combat::dog_init;
  level._btactions["dog"] = var_0;
}

function registerbehaviortree() {
  bindactionscripts();
  btregistertree("dog");
}