/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1557.gsc
**************************************/

perks_preload() {}

perks_init() {}

give_perk(var_0) {
  if(self hasperk(var_0, 1)) {
    return 1;
  }
  self clearperks();

  switch (var_0) {
    case "specialty_stalker":
      thread give_perk_stalker();
      break;
    case "specialty_longersprint":
      thread give_perk_longersprint();
      break;
    case "specialty_fastreload":
      thread give_perk_fastreload();
      break;
    case "specialty_quickdraw":
      thread give_perk_quickdraw();
      break;
    case "specialty_detectexplosive":
      thread give_perk_detectexplosive();
      break;
    case "specialty_bulletaccuracy":
      thread give_perk_bulletaccuracy();
      break;
    default:
      thread give_perk_dummy();
      break;
  }

  self notify("give_perk", var_0);
  return 1;
}

take_perk(var_0) {
  if(!self hasperk(var_0, 1)) {
    return;
  }
  switch (var_0) {
    case "specialty_stalker":
      thread take_perk_stalker();
      break;
    case "specialty_longersprint":
      thread take_perk_longersprint();
      break;
    case "specialty_fastreload":
      thread take_perk_fastreload();
      break;
    case "specialty_quickdraw":
      thread take_perk_quickdraw();
      break;
    case "specialty_detectexplosive":
      thread take_perk_detectexplosive();
      break;
    case "specialty_bulletaccuracy":
      thread take_perk_bulletaccuracy();
      break;
    default:
      thread take_perk_dummy();
      break;
  }

  self notify("take_perk", var_0);
}

give_perk_dummy() {}

take_perk_dummy() {}

give_perk_longersprint() {
  self setperk("specialty_longersprint", 1, 0);
}

take_perk_longersprint() {
  self unsetperk("specialty_longersprint", 1);
}

give_perk_fastreload() {
  self setperk("specialty_fastreload", 1, 0);
}

take_perk_fastreload() {
  self unsetperk("specialty_fastreload", 1);
}

give_perk_quickdraw() {
  self setperk("specialty_quickdraw", 1, 0);
}

take_perk_quickdraw() {
  self unsetperk("specialty_quickdraw", 1);
}

give_perk_detectexplosive() {
  self setperk("specialty_detectexplosive", 1, 0);
}

take_perk_detectexplosive() {
  self unsetperk("specialty_detectexplosive", 1);
}

give_perk_bulletaccuracy() {
  self setperk("specialty_bulletaccuracy", 1, 0);
}

take_perk_bulletaccuracy() {
  self unsetperk("specialty_bulletaccuracy", 1);
}

give_perk_stalker() {
  self setperk("specialty_stalker", 1, 0);
}

take_perk_stalker() {
  self unsetperk("specialty_stalker", 1);
}

perk_hud() {
  common_scripts\utility::flag_init("HUD_giving_perk");
  common_scripts\utility::flag_init("HUD_taking_perk");
  thread update_on_give_perk();
  thread update_on_take_perk();
}

update_on_give_perk() {
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

update_on_take_perk() {
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