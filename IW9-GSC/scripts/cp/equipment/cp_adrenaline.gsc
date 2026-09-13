/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_adrenaline.gsc
**************************************************/

init() {}

listen_for_adrenaline_use() {
  for(;;) {
    self waittill("power_used equip_adrenaline");

    if(istrue(self.being_revived)) {
      continue;
    }
    thread useadrenaline();
    wait 0.1;
  }
}

onequipmenttaken(equipmentref, slot) {
  removeadrenaline();
}

onequipmentfired(equipmentref, slot, objweapon) {
  thread useadrenaline();
}

useadrenaline() {
  self endon("disconnect");
  self endon("removeAdrenaline");
  self.adrenalinepoweractive = 1;
  self notify("force_regeneration");
  self refreshsprinttime();
  childthread adrenaline_removeonplayernotifies();
  childthread adrenaline_removeondamage();
  childthread adrenaline_removeongameend();
  self setscriptablepartstate("healing", "active", 0);
  return 1;
}

removeadrenaline() {
  if(istrue(self.adrenalinepoweractive)) {
    self notify("removeAdrenaline");
    self.adrenalinepoweractive = undefined;
  }
}

gethealthperframe() {
  return 8;
}

adrenaline_removeonplayernotifies() {
  scripts\engine\utility::waittill_any_2("death", "healed");
  thread removeadrenaline();
}

adrenaline_removeondamage() {
  for(;;) {
    self waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, _id_9E834FE6754A9C98, _id_1D3F20A69CED2DD5, _id_920FF4456CE9A2FC, idflags, objweapon);

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && (smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_UNKNOWN")) {
      continue;
    }
    thread removeadrenaline();
    return;
  }
}

adrenaline_removeongameend() {
  level waittill("game_ended");
  thread removeadrenaline();
}