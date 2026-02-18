/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\annihilator.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#namespace annihilator;

function private autoexec __init__system__() {
  system::register(#"annihilator", &__init__, undefined, undefined, #"killstreaks");
}

function __init__() {
  if(!sessionmodeiscampaigngame()) {
    killstreaks::register_killstreak("killstreak_annihilator", &killstreaks::function_fc82c544);
  }
}