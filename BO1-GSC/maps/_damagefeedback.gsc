/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_damagefeedback.gsc
**************************************/

precache() {
  precacheShader("damage_feedback");
}
init() {
  if(getDvar(#"scr_damagefeedback") == "") {
    setDvar("scr_damagefeedback", "1");
  }
  if(!GetDvarInt(#"scr_damagefeedback")) {
    return;
  }
  self.hud_damagefeedback = newclientHudElem(self);
  self.hud_damagefeedback.horzAlign = "center";
  self.hud_damagefeedback.vertAlign = "middle";
  self.hud_damagefeedback.x = -12;
  self.hud_damagefeedback.y = -12;
  self.hud_damagefeedback.alpha = 0;
  self.hud_damagefeedback.archived = true;
  self.hud_damagefeedback setShader("damage_feedback", 24, 48);
}
doDamageFeedback(sWeapon, eInflictor) {
  switch (sWeapon) {
    case "artillery_mp":
    case "airstrike_mp":
    case "napalm_mp":
    case "mortar_mp":
      return false;
  }
  if(isDefined(eInflictor)) {
    if(IsAI(eInflictor)) {
      return false;
    }
    if(isDefined(level.chopper) && level.chopper == eInflictor) {
      return false;
    }
  }
  return true;
}
monitorDamage() {
  if(!GetDvarInt(#"scr_damagefeedback")) {
    return;
  }
}
updateDamageFeedback() {
  if(!GetDvarInt(#"scr_damagefeedback")) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  self playlocalsound("SP_hit_alert");
  self.hud_damagefeedback.alpha = 1;
  self.hud_damagefeedback fadeOverTime(1);
  self.hud_damagefeedback.alpha = 0;
}