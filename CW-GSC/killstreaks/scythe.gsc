/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\scythe.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#namespace scythe;

function private autoexec __init__system__() {
  system::register(#"scythe", &__init__, undefined, undefined, #"killstreaks");
}

function __init__() {
  if(!sessionmodeiscampaigngame()) {
    killstreaks::register_killstreak("killstreak_scythe", &killstreaks::function_fc82c544);
  }
}