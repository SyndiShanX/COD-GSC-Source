/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\perks\perk_mark_targets.gsc
***********************************************/

marktarget_init() {}

marktarget_run(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::isbulletdamage(var_1) && isPlayer(var_0) && var_0.team != self.team && !var_0 scripts\mp\utility\perk::_hasperk("_encstr_B66B146E0E95B12D16C6A3977DCA6B83965BDA57E6CA") && !isDefined(var_0.ismarkedtarget))
    thread marktarget_execute(var_0);
}

marktarget_execute(var_0) {
  var_0.ismarkedtarget = 1;
  var_0.healthregendisabled = 1;
  wait 0.1;
  tagmarkedplayer(var_0);
  wait 0.1;

  if(isDefined(var_0))
    var_0 removemarkfromtarget();
}

tagmarkedplayer(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = gettime() + 3500;

  while(isalive(var_0) && gettime() < var_1)
    wait 1.1;
}

removemarkfromtarget() {
  self.ismarkedtarget = undefined;
  self.healthregendisabled = undefined;
}