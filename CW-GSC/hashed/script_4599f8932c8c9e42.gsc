/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4599f8932c8c9e42.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#namespace ray_gun;

function private autoexec __init__system__() {
  system::register(#"ray_gun", &__init__, undefined, undefined, #"killstreaks");
}

function __init__() {
  if(!sessionmodeiscampaigngame() && !sessionmodeiszombiesgame()) {
    killstreaks::register_killstreak("killstreak_ray_gun", &killstreaks::function_fc82c544);
  }
}