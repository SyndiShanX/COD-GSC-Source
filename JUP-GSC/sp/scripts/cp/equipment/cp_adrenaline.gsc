/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_adrenaline.gsc
**************************************************/



#using scripts\common\utility;
#using scripts\cp\utility\player;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#namespace cp_adrenaline;

function init() {}

function listen_for_adrenaline_use() {
  while(true) {
    self waittill("power_used equip_adrenaline");

    if(istrue(self.being_revived)) {
      continue;
    }

    thread useadrenaline();
    wait 0.1;
  }
}

function onequipmenttaken(equipmentref, slot) {
  removeadrenaline();
}

function onequipmentfired(equipmentref, slot, objweapon) {
  thread useadrenaline();
}

function useadrenaline() {
  self endon("disconnect");
  self endon("removeAdrenaline");
  self.adrenalinepoweractive = 1;
  self notify("force_regeneration");
  self refreshsprinttime();
  childthread adrenaline_removeonplayernotifies();
  childthread adrenaline_removeondamage();
  childthread adrenaline_removeongameend();
  self setscriptablepartstate("healing", "active", 0);
  return true;
}

function removeadrenaline() {
  if(istrue(self.adrenalinepoweractive)) {
    self notify("removeAdrenaline");
    self.adrenalinepoweractive = undefined;
  }
}

function gethealthperframe() {
  return 8;
}

function adrenaline_removeonplayernotifies() {
  waittill_any_2("death", "healed");
  thread removeadrenaline();
}

function adrenaline_removeondamage() {
  while(true) {
    self waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon);

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && (smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_UNKNOWN")) {
      continue;
    }

    thread removeadrenaline();
    return;
  }
}

function adrenaline_removeongameend() {
  level waittill("game_ended");
  thread removeadrenaline();
}