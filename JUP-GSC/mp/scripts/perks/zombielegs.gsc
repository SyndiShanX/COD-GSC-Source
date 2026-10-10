/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\perks\zombielegs.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\engine\utility;
#namespace zombielegs;

function autoexec main() {
  level callback::add(#"register_perk", &perk_register);
}

function perk_register(params) {
  bundle = level.perkbundles["specialty_zombie_legs"];

  if(!isDefined(bundle)) {
    return;
  }

  if(isDefined(params.var_65863a18b3d1ad87)) {
    level[[params.var_65863a18b3d1ad87]]("specialty_zombie_legs", &perk_set, &perk_unset, ["specialty_sprintreload", "specialty_sprintmelee"]);
  }
}

function perk_set() {
  thread function_c6668bb917e966b2();
}

function perk_unset() {
  self lerpfovbypreset("default_2seconds");
  self notify("zombie_legs_unset");
  self.falldamageprotection = 0;
  function_b87b3a7ec17c52ba();
}

function function_c6668bb917e966b2() {
  self endon("death_or_disconnect");
  self endon("zombie_legs_unset");
  self refreshsprinttime();
  self lerpfovbypreset("zombiedefault");
  self.falldamageprotection = 1;
  function_74ef4a883340b273();

  while(true) {
    if(self issupersprinting()) {
      self refreshsprinttime();
    }

    wait 0.1;
  }
}

function function_74ef4a883340b273() {
  bundle = level.perkbundles["specialty_zombie_legs"];
  speedmod = isDefined(bundle.var_ac707f58a9f3b733) ? bundle.var_ac707f58a9f3b733 : 0.1;
  self.var_7e94104134f2f40b = speedmod;

  if(utility::issharedfuncdefined("player", "updateMoveSpeed")) {
    utility::function_f3bb4f4911a1beb2("player", "updateMoveSpeed");
  }
}

function function_b87b3a7ec17c52ba() {
  self.var_7e94104134f2f40b = undefined;

  if(utility::issharedfuncdefined("player", "updateMoveSpeed")) {
    utility::function_f3bb4f4911a1beb2("player", "updateMoveSpeed");
  }
}