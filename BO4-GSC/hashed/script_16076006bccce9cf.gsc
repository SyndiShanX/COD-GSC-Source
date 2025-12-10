/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_16076006bccce9cf.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;
#namespace namespace_c30ca5c1;

autoexec __init__system__() {
  system::register(#"hash_5e3c6106d1627261", &__init__, undefined, # "character_unlock");
}

__init__() {
  character_unlock::register_character_unlock(#"hash_aac0796b2253387", # "hash_3b21afad4de26df7", # "warmachine_wz_item", undefined, # "hash_6d676c33e9df57d4");
}