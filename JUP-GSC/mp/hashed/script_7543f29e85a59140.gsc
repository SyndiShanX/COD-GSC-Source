/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7543f29e85a59140.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\engine\utility;
#namespace namespace_c423e7ace4707941;

function autoexec main() {
  level callback::add(#"register_perk", &perk_register);
}

function perk_register(params) {
  bundle = level.perkbundles["specialty_tac_sprint_boots"];

  if(!isDefined(bundle)) {
    return;
  }

  if(isDefined(params.var_65863a18b3d1ad87)) {
    level[[params.var_65863a18b3d1ad87]]("specialty_tac_sprint_boots", &perk_set, &perk_unset, ["specialty_sprintmelee"]);
  }
}

function perk_set() {
  thread function_c6668bb917e966b2();
  self setclientomnvar("ui_tac_sprint_boots_equipped", 1);
}

function perk_unset() {
  self notify("tac_sprint_boots_unset");
  self setclientomnvar("ui_tac_sprint_boots_equipped", 0);
  function_b87b3a7ec17c52ba();
}

function function_c6668bb917e966b2() {
  self endon("death_or_disconnect");
  self endon("tac_sprint_boots_unset");
  self refreshsprinttime();
  function_74ef4a883340b273();

  while(true) {
    if(self issupersprinting()) {
      self refreshsprinttime();
    }

    wait 0.1;
  }
}

function function_74ef4a883340b273() {
  bundle = level.perkbundles["specialty_tac_sprint_boots"];
  speedmod = getdvarint(@ "hash_281481ccb17dbf14", 0.1);
  self.perkzombielegsspeedmod = speedmod;

  if(utility::issharedfuncdefined("player", "updateMoveSpeed")) {
    utility::callsharedfunc("player", "updateMoveSpeed");
  }
}

function function_b87b3a7ec17c52ba() {
  self.perkzombielegsspeedmod = undefined;

  if(utility::issharedfuncdefined("player", "updateMoveSpeed")) {
    utility::callsharedfunc("player", "updateMoveSpeed");
  }
}