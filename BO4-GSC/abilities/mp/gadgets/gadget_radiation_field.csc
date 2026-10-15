/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\mp\gadgets\gadget_radiation_field.csc
***********************************************************/

#include scripts\abilities\gadgets\gadget_radiation_field;
#include scripts\core_common\system_shared;

#namespace gadget_radiation_field;

autoexec __init__system__() {
  system::register(#"gadget_radiation_field", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}