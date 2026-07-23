/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1557.gsc
**************************************/

_id_3C51() {}

_id_3C52() {}

_id_3C53(var_0) {
  if(self hasperk(var_0, 1)) {
    return 1;
  }
  self clearperks();

  switch (var_0) {
    case "specialty_stalker":
      thread _id_3C61();
      break;
    case "specialty_longersprint":
      thread _id_3C57();
      break;
    case "specialty_fastreload":
      thread _id_3C59();
      break;
    case "specialty_quickdraw":
      thread _id_3C5B();
      break;
    case "specialty_detectexplosive":
      thread _id_3C5D();
      break;
    case "specialty_bulletaccuracy":
      thread _id_3C5F();
      break;
    default:
      thread _id_3C55();
      break;
  }

  self notify("give_perk", var_0);
  return 1;
}

_id_3C54(var_0) {
  if(!self hasperk(var_0, 1)) {
    return;
  }
  switch (var_0) {
    case "specialty_stalker":
      thread _id_3C62();
      break;
    case "specialty_longersprint":
      thread _id_3C58();
      break;
    case "specialty_fastreload":
      thread _id_3C5A();
      break;
    case "specialty_quickdraw":
      thread _id_3C5C();
      break;
    case "specialty_detectexplosive":
      thread _id_3C5E();
      break;
    case "specialty_bulletaccuracy":
      thread _id_3C60();
      break;
    default:
      thread _id_3C56();
      break;
  }

  self notify("take_perk", var_0);
}

_id_3C55() {}

_id_3C56() {}

_id_3C57() {
  self setperk("specialty_longersprint", 1, 0);
}

_id_3C58() {
  self unsetperk("specialty_longersprint", 1);
}

_id_3C59() {
  self setperk("specialty_fastreload", 1, 0);
}

_id_3C5A() {
  self unsetperk("specialty_fastreload", 1);
}

_id_3C5B() {
  self setperk("specialty_quickdraw", 1, 0);
}

_id_3C5C() {
  self unsetperk("specialty_quickdraw", 1);
}

_id_3C5D() {
  self setperk("specialty_detectexplosive", 1, 0);
}

_id_3C5E() {
  self unsetperk("specialty_detectexplosive", 1);
}

_id_3C5F() {
  self setperk("specialty_bulletaccuracy", 1, 0);
}

_id_3C60() {
  self unsetperk("specialty_bulletaccuracy", 1);
}

_id_3C61() {
  self setperk("specialty_stalker", 1, 0);
}

_id_3C62() {
  self unsetperk("specialty_stalker", 1);
}

_id_3C63() {
  common_scripts\utility::flag_init("HUD_giving_perk");
  common_scripts\utility::flag_init("HUD_taking_perk");
  thread _id_3C64();
  thread _id_3C65();
}

_id_3C64() {
  self endon("death");

  for(;;) {
    self waittill("give_perk", var_0);
    common_scripts\utility::flag_set("HUD_giving_perk");

    while(common_scripts\utility::flag("HUD_taking_perk")) {
      wait 0.05;
    }
    wait 1;
    common_scripts\utility::flag_clear("HUD_giving_perk");
  }
}

_id_3C65() {
  self endon("death");

  for(;;) {
    self waittill("take_perk", var_0);
    common_scripts\utility::flag_set("HUD_taking_perk");

    while(common_scripts\utility::flag("HUD_giving_perk")) {
      wait 0.05;
    }
    wait 1;
    common_scripts\utility::flag_clear("HUD_taking_perk");
  }
}