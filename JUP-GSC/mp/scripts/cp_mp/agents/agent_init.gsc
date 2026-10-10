/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\agents\agent_init.gsc
**************************************************/

#using scripts\anim\face;
#using scripts\anim\shared;
#using scripts\asm\asm_mp;
#using scripts\asm\shared\mp\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\vehicles\vehicle_anim;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#namespace agent_init;

function agent_init() {
  if(isDefined(anim.notfirsttime)) {
    return;
  }

  anim.notfirsttime = 1;
  initanimvars();
  function_a2b8f8b0891ee7fe();
  initmeleecharges();
  initwindowtraverse();
  setuprandomtable();
  init_squadmanager();
  setupgrenades();
  initanimcallbacks();
  function_5fa77e68e934eda2();
  initstealthfuncsmp();
  scripts\anim\face::initlevelface();
  scripts\cp_mp\vehicles\vehicle_anim::vehicleaniminit();
}

function setupgrenades() {
  function_b4ebe6632d7e8efe(undefined, "lethal", randomintrange(0, 20000));
  function_b4ebe6632d7e8efe(undefined, "tactical", randomintrange(0, 20000));
}

function initanimcallbacks() {
  if(!isDefined(anim.callbacks)) {
    anim.callbacks = [];
  }

  anim.callbacks["PlaySoundAtViewHeight"] = &play_sound_at_viewheightmp;
}

function function_5fa77e68e934eda2() {
  registersharedfunc("ai", "onHumanoidAgentKilledCommon_SharedFunc", &scripts\mp\mp_agent::on_humanoid_agent_killed_common);
  registersharedfunc("ai", "spawnNewAIType_SharedFunc", &scripts\mp\mp_agent::spawnnewagentaitype);
  registersharedfunc("ai", "Animscripted_SharedFunc", &scripts\asm\shared\mp\utility::animscriptedagent);
  registersharedfunc("ai", "get_aitype_by_subclass_SharedFunc", &scripts\cp_mp\agents\agent_utils::function_3290e192ac188e2d);
  registersharedfunc("ai", "GetFreeAICount", &function_2df8a33395b87f);
}

function private function_2df8a33395b87f() {
  return getfreeagentcount();
}

function play_sound_at_viewheightmp(aliasname, notification_string, var_a68adbd3eefe9282) {
  if(!isDefined(aliasname)) {
    return;
  }

  if(!soundexists(aliasname)) {
    return;
  }

  self playsoundatviewheight(aliasname);

  if(isDefined(notification_string)) {
    wait lookupsoundlength(aliasname) / 1000;
    self notify(notification_string);
  }
}

function initstealthfuncsmp() {
  level.stealthinit = &initstealthmp;
}

function getcorpsearraymp() {
  return [];
}

function setcorpseremovetimerfuncmp() {}

function initstealthmp() {
  level.fngetcorpsearrayfunc = &getcorpsearraymp;
  level.fnsetcorpseremovetimerfunc = &setcorpseremovetimerfuncmp;
}