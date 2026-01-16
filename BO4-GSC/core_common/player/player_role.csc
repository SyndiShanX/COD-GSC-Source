/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\player\player_role.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;

#namespace player_role;

autoexec __init__system__() {
  system::register(#"player_role", undefined, &__postload_init__, undefined);
}

__postload_init__() {}

is_valid(index) {
  if(!isDefined(index)) {
    return false;
  }

  if(getdvarint(#"allowdebugcharacter", 0) == 1) {
    return (index >= 0 && index < getplayerroletemplatecount(currentsessionmode()));
  }

    return index > 0 && index < getplayerroletemplatecount(currentsessionmode());
}