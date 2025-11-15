/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_damagefeedback.gsc
**************************************/

precache() {
  precacheshader("damage_feedback");
  precacheshader("damage_feedback_glow");
  precacheshader("damage_feedback_glow_blue");
  precacheshader("damage_feedback_glow_orange");
}

init(fadetime) {
  setdvar("scr_damagefeedback", "1");
  self.hud_damagefeedback = newdamageindicatorhudelem(self);
  self.hud_damagefeedback.horzalign = "center";
  self.hud_damagefeedback.vertalign = "middle";
  self.hud_damagefeedback.x = -12;
  self.hud_damagefeedback.y = -12;
  self.hud_damagefeedback.alpha = 0;
  self.hud_damagefeedback.archived = 1;
  self.hud_damagefeedback setshader("damage_feedback_glow", 24, 48);

  if(!(isDefined(level.era) && (level.era == "twentytwenty" || level.era == "")))
    self.hud_damagefeedback setshader("damage_feedback", 24, 48);

  self.hud_damagefeedback_blue = newdamageindicatorhudelem(self);
  self.hud_damagefeedback_blue.horzalign = "center";
  self.hud_damagefeedback_blue.vertalign = "middle";
  self.hud_damagefeedback_blue.x = -12;
  self.hud_damagefeedback_blue.y = -12;
  self.hud_damagefeedback_blue.alpha = 0;
  self.hud_damagefeedback_blue.archived = 1;
  self.hud_damagefeedback_blue setshader("damage_feedback_glow_blue", 24, 48);
  self.hud_damagefeedback_orange = newdamageindicatorhudelem(self);
  self.hud_damagefeedback_orange.horzalign = "center";
  self.hud_damagefeedback_orange.vertalign = "middle";
  self.hud_damagefeedback_orange.x = -12;
  self.hud_damagefeedback_orange.y = -12;
  self.hud_damagefeedback_orange.alpha = 0;
  self.hud_damagefeedback_orange.archived = 1;
  self.hud_damagefeedback_orange setshader("damage_feedback_glow_orange", 24, 48);

  if(isDefined(fadetime)) {
    self.hud_damagefeedback.fadetime = fadetime;
    self.hud_damagefeedback_blue.fadetime = fadetime;
    self.hud_damagefeedback_orange.fadetime = fadetime;
  } else {
    self.hud_damagefeedback.fadetime = 1;
    self.hud_damagefeedback_blue.fadetime = 1;
    self.hud_damagefeedback_orange.fadetime = 1;
  }
}

updatedamagefeedback() {
  if(!getdvarint(#"_id_C50FF950")) {
    return;
  }
  if(!isplayer(self) || !isDefined(self.hud_damagefeedback)) {
    return;
  }
  self playlocalsound("spl_hit_alert");
  self.hud_damagefeedback.alpha = 1;
  self.hud_damagefeedback fadeovertime(self.hud_damagefeedback.fadetime);
  self.hud_damagefeedback.alpha = 0;
}

updatevechicledamagefeedback(weapon) {
  if(!getdvarint(#"_id_C50FF950")) {
    return;
  }
  if(!isplayer(self) || !isDefined(self.hud_damagefeedback) || !isDefined(self.hud_damagefeedback_blue) || !isDefined(self.hud_damagefeedback_orange)) {
    return;
  }
  self playlocalsound("spl_hit_alert");

  if(!isDefined(weapon)) {
    self.hud_damagefeedback.alpha = 1;
    self.hud_damagefeedback fadeovertime(self.hud_damagefeedback.fadetime);
    self.hud_damagefeedback.alpha = 0;
    return;
  }

  switch (weapon) {
    case "f35_death_blossom":
    case "f35_missile_turret_player":
    case "f35_side_minigun_player":
      self.hud_damagefeedback_blue.alpha = 1;
      self.hud_damagefeedback_blue fadeovertime(self.hud_damagefeedback_blue.fadetime);
      self.hud_damagefeedback_blue.alpha = 0;
      break;
    case "sam_turret_player_sp":
      self.hud_damagefeedback_orange.alpha = 1;
      self.hud_damagefeedback_orange fadeovertime(self.hud_damagefeedback_orange.fadetime);
      self.hud_damagefeedback_orange.alpha = 0;
      break;
    default:
      self.hud_damagefeedback.alpha = 1;
      self.hud_damagefeedback fadeovertime(self.hud_damagefeedback.fadetime);
      self.hud_damagefeedback.alpha = 0;
      break;
  }
}