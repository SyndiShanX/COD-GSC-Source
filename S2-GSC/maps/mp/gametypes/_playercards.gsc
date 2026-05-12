/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_playercards.gsc
**********************************************/

func_00D5() {
  level thread func_6B6C();
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    if(!isai(var_00)) {}
  }
}