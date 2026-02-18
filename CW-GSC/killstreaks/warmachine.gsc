/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\warmachine.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#namespace warmachine;

function private autoexec __init__system__() {
  system::register(#"warmachine", &__init__, undefined, undefined, #"killstreaks");
}

function __init__() {
  if(!sessionmodeiscampaigngame()) {
    killstreaks::register_killstreak("killstreak_warmachine", &killstreaks::function_fc82c544);
  }
}