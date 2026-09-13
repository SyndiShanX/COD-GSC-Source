/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\perks\cp_perk_utility.gsc
************************************************/

perk_getmeleescalar() {
  if(isDefined(self.perk_data["melee_scalar"]))
    return self.perk_data["melee_scalar"];
  else
    return self.perk_data["health"].melee_scalar;
}

perk_getmaxhealth() {
  if(isDefined(self.perk_data["max_health"]))
    return self.perk_data["max_health"];
  else
    return self.perk_data["health"].max_health;
}

perk_getbulletdamagescalar() {
  if(isDefined(self.perk_data["bullet_damage_scalar"]))
    return self.perk_data["bullet_damage_scalar"];
  else
    return self.perk_data["impact"].bullet_damage_scalar;
}

perk_getrevivetimescalar() {
  if(isDefined(self.perk_data["revive_time_scalar"]))
    return self.perk_data["revive_time_scalar"];
  else
    return self.perk_data["medic"].revive_time_scalar;
}

perk_getmovespeedscalar() {
  if(isDefined(self.perk_data["move_speed_scalar"]))
    return self.perk_data["move_speed_scalar"];
  else
    return self.perk_data["medic"].move_speed_scalar;
}

perk_getrevivedamagescalar() {
  if(isDefined(self.perk_data["revive_damage_scalar"]))
    return self.perk_data["revive_damage_scalar"];
  else
    return self.perk_data["medic"].revive_damage_scalar;
}

perk_getexplosivedamagescalar() {
  if(isDefined(self.perk_data["explosive_damage_scalar"]))
    return self.perk_data["explosive_damage_scalar"];
  else
    return self.perk_data["demolition"].explosive_damage_scalar;
}

perk_getoffhandcount() {
  if(isDefined(self.perk_data["offhand_count"]))
    return self.perk_data["offhand_count"];
  else
    return self.perk_data["demolition"].offhand_count;
}