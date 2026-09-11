/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\perks\cp_perk_utility.gsc
************************************************/

function perk_getmeleescalar() {
  if(isDefined(self.perk_data["melee_scalar"])) {
    return self.perk_data["melee_scalar"];
  }

  return self.perk_data["health"].melee_scalar;
}

function perk_getmaxhealth() {
  if(isDefined(self.perk_data["max_health"])) {
    return self.perk_data["max_health"];
  }

  return self.perk_data["health"].max_health;
}

function perk_getbulletdamagescalar() {
  if(isDefined(self.perk_data["bullet_damage_scalar"])) {
    return self.perk_data["bullet_damage_scalar"];
  }

  return self.perk_data["impact"].bullet_damage_scalar;
}

function perk_getrevivetimescalar() {
  if(isDefined(self.perk_data["revive_time_scalar"])) {
    return self.perk_data["revive_time_scalar"];
  }

  return self.perk_data["medic"].revive_time_scalar;
}

function perk_getmovespeedscalar() {
  if(isDefined(self.perk_data["move_speed_scalar"])) {
    return self.perk_data["move_speed_scalar"];
  }

  return self.perk_data["medic"].move_speed_scalar;
}

function perk_getrevivedamagescalar() {
  if(isDefined(self.perk_data["revive_damage_scalar"])) {
    return self.perk_data["revive_damage_scalar"];
  }

  return self.perk_data["medic"].revive_damage_scalar;
}

function perk_getexplosivedamagescalar() {
  if(isDefined(self.perk_data["explosive_damage_scalar"])) {
    return self.perk_data["explosive_damage_scalar"];
  }

  return self.perk_data["demolition"].explosive_damage_scalar;
}

function perk_getoffhandcount() {
  if(isDefined(self.perk_data["offhand_count"])) {
    return self.perk_data["offhand_count"];
  }

  return self.perk_data["demolition"].offhand_count;
}