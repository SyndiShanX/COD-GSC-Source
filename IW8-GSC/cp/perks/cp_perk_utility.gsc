/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\perks\cp_perk_utility.gsc
***********************************************/

perk_getmeleescalar() {
  if(isDefined(self.perk_data["_encstr_86FA0DB595C6592B7D9B1B853658E4"]))
    return self.perk_data["_encstr_86FA0DB595C6592B7D9B1B853658E4"];
  else
    return self.perk_data["_encstr_91B50734CA58631D1A"].melee_scalar;
}

perk_getmaxhealth() {
  if(isDefined(self.perk_data["_encstr_9B180BCD938A68FB62D1C27B20"]))
    return self.perk_data["_encstr_9B180BCD938A68FB62D1C27B20"];
  else
    return self.perk_data["_encstr_91B50734CA58631D1A"].max_health;
}

perk_getbulletdamagescalar() {
  if(isDefined(self.perk_data["_encstr_866A1598EAD8C6598EF58C0BADB0EC95FACDD885B1B04E"]))
    return self.perk_data["_encstr_866A1598EAD8C6598EF58C0BADB0EC95FACDD885B1B04E"];
  else
    return self.perk_data["_encstr_878807108A42A309BB"].bullet_damage_scalar;
}

perk_getrevivetimescalar() {
  if(isDefined(self.perk_data["_encstr_8C5B1339CAECB49DACD71D96B62BFAB98DB08D859C"]))
    return self.perk_data["_encstr_8C5B1339CAECB49DACD71D96B62BFAB98DB08D859C"];
  else
    return self.perk_data["_encstr_A6C7065BAC91D28D"].revive_time_scalar;
}

perk_getmovespeedscalar() {
  if(isDefined(self.perk_data["_encstr_9A9B12677FDB97EF32F74DF3577FCB60B1C0D960"]))
    return self.perk_data["_encstr_9A9B12677FDB97EF32F74DF3577FCB60B1C0D960"];
  else
    return self.perk_data["_encstr_A6C7065BAC91D28D"].move_speed_scalar;
}

perk_getrevivedamagescalar() {
  if(isDefined(self.perk_data["_encstr_8D92153956CEA59DACD746C2DA0B9D95FA37D8161B1693"]))
    return self.perk_data["_encstr_8D92153956CEA59DACD746C2DA0B9D95FA37D8161B1693"];
  else
    return self.perk_data["_encstr_A6C7065BAC91D28D"].revive_damage_scalar;
}

perk_getexplosivedamagescalar() {
  if(isDefined(self.perk_data["_encstr_9A7818ACF0831BF6E6A5B359FAC8B0B60BEC59AFDCC685C6C227"]))
    return self.perk_data["_encstr_9A7818ACF0831BF6E6A5B359FAC8B0B60BEC59AFDCC685C6C227"];
  else
    return self.perk_data["_encstr_95350BC8CA5BBD1B4B8E2D7B37"].explosive_damage_scalar;
}

perk_getoffhandcount() {
  if(isDefined(self.perk_data["_encstr_A33E0ED0FF02B17136C3B1588745E8F1"]))
    return self.perk_data["_encstr_A33E0ED0FF02B17136C3B1588745E8F1"];
  else
    return self.perk_data["_encstr_95350BC8CA5BBD1B4B8E2D7B37"].offhand_count;
}