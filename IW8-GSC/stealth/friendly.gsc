/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: stealth\friendly.gsc
***********************************************/

main() {
  if(!isDefined(level.stealth))
    scripts\stealth\manager::main();

  init_settings();
  thread spotted_thread();
  thread visibility_thread();
}

init_settings() {
  self.stealth = spawnStruct();
  self.stealth.spotted_list = [];
  self.stealth.funcs = [];
  scripts\engine\utility::ent_flag_init("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
  scripts\engine\utility::ent_flag_init("_encstr_860D1653EBD5EF75D0A9DFE77DB03A7B0B418A1911B8A72D");
  scripts\engine\utility::ent_flag_set("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
  scripts\engine\utility::ent_flag_init("_encstr_B2D4126BD3EDE77DC8A127E95569420B07492293");
  scripts\stealth\utility::group_flag_init("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");
  scripts\stealth\utility::group_add();
  self.stealth.bsmstate = 0;
}

spotted_thread() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_A6C70FDC0EBDE8D1B2917D3A43E4CAB091");
  self endon("_encstr_A6C70FDC0EBDE8D1B2917D3A43E4CAB091");

  for(;;) {
    scripts\engine\utility::ent_flag_wait("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
    scripts\stealth\utility::group_flag_waitopen("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");

    if(!scripts\engine\utility::ent_flag("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46"))
      scripts\engine\utility::ent_flag_wait("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");

    thread state_hidden();
    scripts\engine\utility::ent_flag_wait("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
    scripts\stealth\utility::group_flag_wait("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");

    if(!scripts\engine\utility::ent_flag("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46"))
      scripts\engine\utility::ent_flag_wait("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");

    thread state_spotted();
  }
}

state_hidden() {
  thread scripts\stealth\utility::setbattlechatter(0);
  self.stealth.oldgrenadeammo = self.grenadeammo;
  self.grenadeammo = 0;
  self.forcesidearm = 0;
  self.dontevershoot = 1;
  self.dontattackme = 1;

  if(isDefined(self.stealth.funcs["_encstr_95DF070DD22319CA9B"]))
    scripts\stealth\callbacks::stealth_call_thread("_encstr_95DF070DD22319CA9B");
}

state_spotted() {
  thread scripts\stealth\utility::setbattlechatter(1);

  if(isDefined(self.stealth.oldgrenadeammo))
    self.grenadeammo = self.stealth.oldgrenadeammo;
  else
    self.grenadeammo = 3;

  self.dontevershoot = 0;
  self.dontattackme = 0;
  self pushplayer(0);

  if(isDefined(self.stealth.funcs["_encstr_8ADA089BC1B78EE8B246"]))
    scripts\stealth\callbacks::stealth_call_thread("_encstr_8ADA089BC1B78EE8B246");
}

getup_from_prone() {
  self endon("_encstr_AD75063D571AE108");
}

visibility_thread() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_93530B91C713410FAFEAC86852");

  for(;;) {
    scripts\engine\utility::ent_flag_wait("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");

    if(!isDefined(self.stealth.ignore_visibility))
      self.maxvisibledist = get_detect_range();

    wait 0.05;
  }
}

get_detect_range() {
  var_0 = self.currentpose;

  if(var_0 == "_encstr_B69B0589C236B6")
    var_0 = "_encstr_922406F1A6FD5E05";

  if(scripts\stealth\utility::group_spotted_flag())
    var_1 = "_encstr_8ADA089BC1B78EE8B246";
  else
    var_1 = "_encstr_95DF070DD22319CA9B";

  var_2 = level.stealth.detect.range[var_1][var_0];

  if(scripts\engine\utility::ent_flag("_encstr_B2D4126BD3EDE77DC8A127E95569420B07492293"))
    var_2 = max(level.stealth.detect.range["_encstr_95DF070DD22319CA9B"]["_encstr_922406F1A6FD5E05"], var_2 * 0.5);

  return var_2;
}