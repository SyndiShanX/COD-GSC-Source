/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\emp_debuff_mp.gsc
***********************************************/

emp_debuff_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8B1804DF2043", "_encstr_88D513EC563A05D8582FB24EA8A6A052B55BAB372B", ::getplayerempimmune);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8B1804DF2043", "_encstr_871F133A5501E99CD93097C339B478A09BF903F5CD", ::setplayerempimmune);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8B1804DF2043", "_encstr_95C70E4738C17168230FD2A5E9AB1D21", ::onplayeremped);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8B1804DF2043", "_encstr_A1900FD7807F27B47BB85AC2A11B62FFD1", ::onvehicleemped);
}

getplayerempimmune() {
  return scripts\mp\utility\perk::_hasperk("_encstr_B66B146E0E95B12D16C6A3977DCA6B83965BDA57E6CA");
}

setplayerempimmune(var_0) {
  if(var_0)
    scripts\mp\utility\perk::giveperk("_encstr_B66B146E0E95B12D16C6A3977DCA6B83965BDA57E6CA");
  else
    scripts\mp\utility\perk::removeperk("_encstr_B66B146E0E95B12D16C6A3977DCA6B83965BDA57E6CA");
}

onplayeremped(var_0) {
  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self, var_1)))
    var_1 thread scripts\mp\killstreaks\killstreaks::givescoreforempedplayer();
}

onvehicleemped(var_0) {
  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1)))
    var_1 scripts\mp\killstreaks\killstreaks::givescoreforempedvehicle();
}